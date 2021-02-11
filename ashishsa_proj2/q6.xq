xquery version "3.1";
let $root:=doc("books.xml")/biblio
let $root1:=doc("books.xml")/biblio
let $title := doc("books.xml")/biblio/author
let $distinct_book_list:=distinct-values($root/author/book/title)

let $distinct_prices:=
for $book_names in $distinct_book_list
let $price:=distinct-values($root/author/book[./title eq $book_names]/price)
return <prices>{$price}</prices>

let $globalAverage:=avg($distinct_prices/number())

let $distinct_categories:=distinct-values($root/author/book/category)

let $CategoriesAboveAverage := (
  for $category1 in $distinct_categories
  return 
  if (avg(distinct-values($root/author/book[category=$category1]/price)) > $globalAverage) then(<category>{$category1}</category>) else())

let $result := (
  for $c in $CategoriesAboveAverage, $temp in $root
  let $name:=($temp/author/book[category=$c and price=(max(distinct-values($temp/author/book[category=$c]/price)))]/title)[1]
  let $year:=distinct-values($root/author/book[./title eq $name]/@year)
  return
  <category id="{data($c)}">
  <category_average>{round((avg(distinct-values($root/author/book[category=$c]/price))))}</category_average>
  <book year="{$year}">
  {$name}
  <price>{max(distinct-values($temp/author/book[category=$c]/price))} </price>
  </book>
  </category>)
return <result><global_average>{$globalAverage}</global_average>{$result}</result>
