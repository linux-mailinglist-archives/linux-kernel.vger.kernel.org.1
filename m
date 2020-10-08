Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1A28757E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgJHNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:55:15 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:46610 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgJHNzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:55:15 -0400
X-Greylist: delayed 52954 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2020 09:55:12 EDT
Date:   Thu, 08 Oct 2020 13:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602165309;
        bh=Y/pPK1issXvupXK1vEfd+jHpkeY03DvRwMZK/5N2xdA=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Lsru1v6BAh883F25hycvK7ZnIFVXKIua4VxmXCywBKZmW3gP+3LTTBTQH1efA+qwF
         QH7iO+XogLxOINpMOANlpJqU3xduO9Sdaf/G/4YLc8/hxKXG5eIeBYHkApA/D6r43H
         IGxZZ7nag6VI9Y8aXFQHyRU+JaqAgJteggLxp69o=
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: [PATCH] docs: Make automarkup ready for Sphinx 3.1+
Message-ID: <C67JVCS5C9NG.LIAW4RFKE6A9@ArchWay>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 8, 2020 at 2:27 AM -03, Mauro Carvalho Chehab wrote:
>
> Hi N=C3=ADcolas,
>
> Em Wed, 07 Oct 2020 23:12:25 +0000
> N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> escreveu:
>
> > While Sphinx 2 used a single c:type role for struct, union, enum and
> > typedef, Sphinx 3 uses a specific role for each one.
> > To keep backward compatibility, detect the Sphinx version and use the
> > correct roles for that version.
> >
> > Also, Sphinx 3 is more strict with its C domain and generated warnings,
> > exposing issues in the parsing.
> > To fix the warnings, make the C regexes use ASCII, ensure the
> > expressions only match the beginning of words and skip trying to
> > cross-reference C reserved words.
> >
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
> > ---
> >
> > Hi,
> >
> > after Mauro's series making everything ready for Sphinx 3.1, only the a=
utomarkup
> > was left to be ported.
> > This patch makes the needed changes to automarkup so that we can soon f=
lip the
> > switch to Sphinx 3.1.
> >
> > This change was tested both with Sphinx 2.4.4 and Sphinx 3.1.
> >
> > This change doesn't add any warnings to the Documentation build.
> > I tested it with Mauro's series but later rebased it to docs-next, and =
it can be
> > accepted independently of that series.
> >
> > I ended up doing more than one thing in this single patch, but since it=
 was all
> > changing the same lines and for the same purpose, I felt it would be be=
tter to
> > keep it as a single commit.
> >
>
> Thanks for doing this! That was the last missing part on fully
> supporting
> Sphinx 3.1+.
>
> > Mauro,
> > if this patch is ok, the 3rd patch in your series, which disables autom=
arkup for
> > sphinx 3, should be dropped.
>
> Yeah, sure.
>
> > Although I'm not sure what the implications of your patches adding name=
spaces
> > and using the c:macro for functions are.
>
> With regards to namespaces:
>
> Currently, only the media docs use namespaces, and it declares it at the
> beginning of each file that needs it, without overriding it later[1].
>
> [1] btw, the cdomain.py backward compat code doesn't support namespace
> changes - as it parses namespaces before handling the C domain tags.
> I doubt that we'll need to have a single .rst file using more than
> one namespace anyway.
>
> The main usage is to avoid conflicts for uAPI documentation for
> syscalls - actually for libc userspace wrappers to syscalls. It
> documents
> things like: open, close, read, write, ioctl, poll, select.

If it's mainly for that, I think automarkup could skip handling namespaces.
From automarkup.py:

#
# Many places in the docs refer to common system calls.  It is
# pointless to try to cross-reference them and, as has been known
# to happen, somebody defining a function by these names can lead
# to the creation of incorrect and confusing cross references.  So
# just don't even try with these names.
#
Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap',
              'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
=09      'socket' ]

So unless I'm confusing things and the namespaces actually sidestep that is=
sue,
the namespace handling could be left out of automarkup.

>
> I'm not sure if the automarkup should be aware of it, or if the c.py
> code
> at Sphinx 3.x will add the namespace automatically, but I suspect that
> automarkup will need to handle it as well.
>
> One file you could use for checking it is this one:
>
> Documentation/userspace-api/media/v4l/hist-v4l2.rst
>
> It contains a namespace directive and documents what changed without
> using any explicit reference (after my patch series + linux-next).
>
> With regards to c:macro vs c:function:
>
> I suspect that automarkup should test both when trying to do
> cross-references for function-like calls. E. g. test first if
> there is a :c:function, falling back to check for :c:macro.
>
> I would add a "sphinx3_c_func_ref" function that would handle
> such special case, e. g. something like:
>
> markup_func_sphinx3 =3D {RE_doc: markup_doc_ref,
> RE_function: sphinx3_c_func_ref,
> RE_struct: markup_c_ref,
> RE_union: markup_c_ref,
> RE_enum: markup_c_ref,
> RE_typedef: markup_c_ref}

Sounds good.

I'll make this patch into a series and add that function/macro handling as =
a new
patch, and the namespace handling depending on your answer on the above com=
ment,
for v2.

>
> > All I did here was use the specific roles for sphinx 3 and fix the warn=
ings, but
> > that was enough to get correct cross-references even after your series.
> >
> > Thanks,
> > N=C3=ADcolas
>
> >
> >
> >  Documentation/sphinx/automarkup.py | 69 ++++++++++++++++++++++++++----
> >  1 file changed, 60 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/=
automarkup.py
> > index a1b0f554cd82..fd1e927408ad 100644
> > --- a/Documentation/sphinx/automarkup.py
> > +++ b/Documentation/sphinx/automarkup.py
> > @@ -22,13 +22,34 @@ from itertools import chain
> >  # :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
> >  # bit tries to restrict matches to things that won't create trouble.
> >  #
> > -RE_function =3D re.compile(r'(([\w_][\w\d_]+)\(\))')
> > -RE_type =3D re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)=
')
> > +RE_function =3D re.compile(r'\b(([a-zA-Z_]\w+)\(\))', flags=3Dre.ASCII=
)
> > +
> > +#
> > +# Sphinx 2 uses the same :c:type role for struct, union, enum and type=
def
> > +#
> > +RE_generic_type =3D re.compile(r'\b(struct|union|enum|typedef)\s+([a-z=
A-Z_]\w+)',
> > +                             flags=3Dre.ASCII)
> > +
> > +#
> > +# Sphinx 3 uses a different C role for each one of struct, union, enum=
 and
> > +# typedef
> > +#
> > +RE_struct =3D re.compile(r'\b(struct)\s+([a-zA-Z_]\w+)', flags=3Dre.AS=
CII)
> > +RE_union =3D re.compile(r'\b(union)\s+([a-zA-Z_]\w+)', flags=3Dre.ASCI=
I)
> > +RE_enum =3D re.compile(r'\b(enum)\s+([a-zA-Z_]\w+)', flags=3Dre.ASCII)
> > +RE_typedef =3D re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+)', flags=3Dre.=
ASCII)
> > +
> >  #
> >  # Detects a reference to a documentation page of the form Documentatio=
n/... with
> >  # an optional extension
> >  #
> > -RE_doc =3D re.compile(r'Documentation(/[\w\-_/]+)(\.\w+)*')
> > +RE_doc =3D re.compile(r'\bDocumentation(/[\w\-_/]+)(\.\w+)*')
> > +
> > +#
> > +# Reserved C words that we should skip when cross-referencing
> > +#
> > +Skipnames =3D [ 'for', 'if', 'register', 'sizeof', 'struct', 'unsigned=
' ]
> > +
> >
> >  #
> >  # Many places in the docs refer to common system calls.  It is
> > @@ -48,9 +69,22 @@ def markup_refs(docname, app, node):
> >      #
> >      # Associate each regex with the function that will markup its matc=
hes
> >      #
> > -    markup_func =3D {RE_type: markup_c_ref,
> > -                   RE_function: markup_c_ref,
> > -                   RE_doc: markup_doc_ref}
> > +    markup_func_sphinx2 =3D {RE_doc: markup_doc_ref,
> > +                           RE_function: markup_c_ref,
> > +                           RE_generic_type: markup_c_ref}
> > +
> > +    markup_func_sphinx3 =3D {RE_doc: markup_doc_ref,
> > +                           RE_function: markup_c_ref,
> > +                           RE_struct: markup_c_ref,
> > +                           RE_union: markup_c_ref,
> > +                           RE_enum: markup_c_ref,
> > +                           RE_typedef: markup_c_ref}
> > +
> > +    if sphinx.__version__[0] =3D=3D '3':
> > +        markup_func =3D markup_func_sphinx3
> > +    else:
> > +        markup_func =3D markup_func_sphinx2
> > +
> >      match_iterators =3D [regex.finditer(t) for regex in markup_func]
> >      #
> >      # Sort all references by the starting position in text
> > @@ -79,8 +113,24 @@ def markup_refs(docname, app, node):
> >  # type_name) with an appropriate cross reference.
> >  #
> >  def markup_c_ref(docname, app, match):
> > -    class_str =3D {RE_function: 'c-func', RE_type: 'c-type'}
> > -    reftype_str =3D {RE_function: 'function', RE_type: 'type'}
> > +    class_str =3D {RE_function: 'c-func',
> > +                 # Sphinx 2 only
> > +                 RE_generic_type: 'c-type',
> > +                 # Sphinx 3+ only
> > +                 RE_struct: 'c-struct',
> > +                 RE_union: 'c-union',
> > +                 RE_enum: 'c-enum',
> > +                 RE_typedef: 'c-type',
> > +                 }
> > +    reftype_str =3D {RE_function: 'function',
> > +                   # Sphinx 2 only
> > +                   RE_generic_type: 'type',
> > +                   # Sphinx 3+ only
> > +                   RE_struct: 'struct',
> > +                   RE_union: 'union',
> > +                   RE_enum: 'enum',
> > +                   RE_typedef: 'type',
> > +                   }
> >
> >      cdom =3D app.env.domains['c']
> >      #
> > @@ -89,7 +139,8 @@ def markup_c_ref(docname, app, match):
> >      target =3D match.group(2)
> >      target_text =3D nodes.Text(match.group(0))
> >      xref =3D None
> > -    if not (match.re =3D=3D RE_function and target in Skipfuncs):
> > +    if not ((match.re =3D=3D RE_function and target in Skipfuncs)
> > +            or (target in Skipnames)):
> >          lit_text =3D nodes.literal(classes=3D['xref', 'c', class_str[m=
atch.re]])
> >          lit_text +=3D target_text
> >          pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
>
>
>
> Thanks,
> Mauro

Thanks,
N=C3=ADcolas

