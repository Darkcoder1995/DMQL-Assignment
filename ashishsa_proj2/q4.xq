xquery version "3.1";
let $king:=(
let $root:= doc('books.xml')/biblio
for $title1 in $root/author[name='Jeff']/book/title, $a2 in $root/author
where $a2/name != 'Jeff'
and $title1 = $a2/book/title
return <book>{$title1}{$root/author[name='Jeff']/name}{$a2/name}</book>)
return <results>{$king}</results>