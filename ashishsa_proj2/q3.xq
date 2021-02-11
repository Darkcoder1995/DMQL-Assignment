xquery version "3.1";
let $star:=(
    let $bk:=doc("books.xml")
    for $b in $bk/biblio/author/book
    where $b/price<=1000
    order by $b/price/number() ascending
    return $b)
return <result>{$star}</result>