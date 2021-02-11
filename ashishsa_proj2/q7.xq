xquery version "3.1";
let $root:=doc("books.xml")/biblio
let $distinct_book_list:=distinct-values($root/author/book/title)

let $book_details:=
for $book_names in $distinct_book_list
let $price:=distinct-values($root/author/book[./title eq $book_names]/price)
let $year:=distinct-values($root/author/book[./title eq $book_names]/@year)
return <book year = "{$year}"><title>{$book_names}</title><price>{$price}</price></book>

let $author_names:=
    for $books in $book_details
        let $book_names:=$books//title/text()
        let $Author_names_list:=
            for $author in $root/author
                let $author_nodes:=
                for $books_from_Author in $author/book/title/text()
                    return if ($books_from_Author eq $book_names)
                    then <author>{$author/name}</author>
                    else()
                return $author_nodes
            return <book year="{$books/@year}">
                    {$Author_names_list}
                    <title>{$books/title/text()}</title>
                    <price>{$books/price/text()}</price>
                    </book>
return
  <biblio>{$author_names}</biblio>

