Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA592B5F21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgKQMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:30:23 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:53256 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKQMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:30:23 -0500
Date:   Tue, 17 Nov 2020 12:30:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605616215;
        bh=06BgIOoEEroTgmZJiDSnMWNZioW1WLMKbN1RoU+41CE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=RJ3Z2dHRxoAJ2Y66BNB1Xda07B+fCCKmqZPXkPxZIs4MtZSOuT54/tvhoHesHCS3Z
         b+3fjVr0/gs0UHWEVFPw/FeBRBgBVd//sGqncjyduxVZy0w7us+xpBPYHDWke28tWu
         dAN2wcvLJ0e6l0SzHAN3J5K9p5qjm9KrBoXPhTMM=
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: [PATCH v2] docs: automarkup.py: Allow automatic cross-reference inside C namespace
Message-ID: <C75JFDOJJFBC.1FPM3DRBNPIKC@ArchWay>
In-Reply-To: <20201117064759.0c03e7cf@coco.lan>
References: <20201117021107.214704-1-nfraprado@protonmail.com> <20201117064759.0c03e7cf@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,URIBL_BLACK
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 17, 2020 at 2:47 AM -03, Mauro Carvalho Chehab wrote:
>
> Em Tue, 17 Nov 2020 02:12:01 +0000
> N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> escreveu:
>
> > Sphinx 3.1 introduced namespaces for C cross-references. With this,
> > each C domain type/function declaration is put inside the namespace tha=
t
> > was active at the time of its declaration.
> >
> > Add support for automatic cross-referencing inside C namespaces by
> > checking whether the corresponding source file had a C namespace Sphinx
> > directive, and if so, try cross-referencing inside of it before going t=
o
> > the global scope.
> >
> > This assumes there's only one namespace (if any) per rst file.
> >
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
> > ---
> >
> > To those following from v1:
> >
> > I ended up doing the simplest solution possible, which is to just direc=
tly read
> > the rst source corresponding to the doc page right before doing the aut=
omarkup.
> > It's not very efficient in the sense that the source is being read
> > twice (first by Sphinx, then by this), but it sidesteps the "data shari=
ng
> > between processes" issue, so parallel_read_safe can be reenabled, and I=
 didn't
> > notice any performance hit from this patch (as opposed to the big hit f=
rom v1).
> > Works with both Sphinx 2 and 3.
> >
> > Changes in v2:
> > - Get C namespace from reading the corresponding source at the time of =
doing
> >   automarkup instead of storing all namespaces beforehand at the source=
-read
> >   phase
> >     - Add get_c_namespace()
> >     - Remove save_c_namespace()
> > - Reenabled Sphinx's parallel_read_safe
> >
> > v1: https://lore.kernel.org/linux-doc/20201013231218.2750109-6-nfraprad=
o@protonmail.com/
> >
> >  Documentation/sphinx/automarkup.py | 122 ++++++++++++++++++-----------
> >  1 file changed, 75 insertions(+), 47 deletions(-)
> >
> > diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/=
automarkup.py
> > index 3e81ebab26ed..953b24b6e2b4 100644
> > --- a/Documentation/sphinx/automarkup.py
> > +++ b/Documentation/sphinx/automarkup.py
> > @@ -53,6 +53,8 @@ RE_typedef =3D re.compile(r'\b(typedef)\s+([a-zA-Z_]\=
w+)', flags=3Dascii_p3)
> >  #
> >  RE_doc =3D re.compile(r'\bDocumentation(/[\w\-_/]+)(\.\w+)*')
> >
> > +RE_namespace =3D re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
> > +
> >  #
> >  # Reserved C words that we should skip when cross-referencing
> >  #
> > @@ -70,6 +72,8 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fc=
ntl', 'mmap',
> >                'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
> >                'socket' ]
> >
> > +c_namespace =3D ''
> > +
> >  def markup_refs(docname, app, node):
> >      t =3D node.astext()
> >      done =3D 0
> > @@ -128,30 +132,38 @@ def markup_func_ref_sphinx3(docname, app, match):
> >      #
> >      # Go through the dance of getting an xref out of the C domain
> >      #
> > -    target =3D match.group(2)
> > +    base_target =3D match.group(2)
> >      target_text =3D nodes.Text(match.group(0))
> >      xref =3D None
> > -    if not (target in Skipfuncs or target in Skipnames):
> > -        for class_s, reftype_s in zip(class_str, reftype_str):
> > -            lit_text =3D nodes.literal(classes=3D['xref', 'c', class_s=
])
> > -            lit_text +=3D target_text
> > -            pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
> > -                                          reftype =3D reftype_s,
> > -                                          reftarget =3D target, modnam=
e =3D None,
> > -                                          classname =3D None)
> > -            #
> > -            # XXX The Latex builder will throw NoUri exceptions here,
> > -            # work around that by ignoring them.
> > -            #
> > -            try:
> > -                xref =3D cdom.resolve_xref(app.env, docname, app.build=
er,
> > -                                         reftype_s, target, pxref,
> > -                                         lit_text)
> > -            except NoUri:
> > -                xref =3D None
> > +    possible_targets =3D [base_target]
> > +    # Check if this document has a namespace, and if so, try
> > +    # cross-referencing inside it first.
> > +    if c_namespace:
> > +        possible_targets.insert(0, c_namespace + "." + base_target)
> >
> > -            if xref:
> > -                return xref
> > +    if base_target not in Skipnames:
> > +        for target in possible_targets:
> > +            if target not in Skipfuncs:
>
> Hmm... do we still need to skip syscalls?

Yeah, I see what you mean. Since you moved the syscalls in the docs inside
namespaces, there shouldn't be any syscall definitions in the global scope
anymore and therefore we don't need to skip them any longer.

I tried it out here and indeed it works fine without skipping them.

But I wonder if it would be a good safety measure to leave it there anyway.=
 We
never want to cross-reference to syscalls in the global scope, so if we con=
tinue
doing that skip, even if someone accidentally adds a syscall definition out=
side
a c:namespace, this will prevent cross-references to it anyway.

What do you think?

>
> > +                for class_s, reftype_s in zip(class_str, reftype_str):
> > +                    lit_text =3D nodes.literal(classes=3D['xref', 'c',=
 class_s])
> > +                    lit_text +=3D target_text
> > +                    pxref =3D addnodes.pending_xref('', refdomain =3D =
'c',
> > +                                                  reftype =3D reftype_=
s,
> > +                                                  reftarget =3D target=
, modname =3D None,
> > +                                                  classname =3D None)
> > +                    #
> > +                    # XXX The Latex builder will throw NoUri exception=
s here,
> > +                    # work around that by ignoring them.
> > +                    #
> > +                    try:
> > +                        xref =3D cdom.resolve_xref(app.env, docname, a=
pp.builder,
> > +                                                 reftype_s, target, px=
ref,
> > +                                                 lit_text)
> > +                    except NoUri:
> > +                        xref =3D None
> > +
> > +                    if xref:
> > +                        return xref
> >
> >      return target_text
> >
> > @@ -179,34 +191,39 @@ def markup_c_ref(docname, app, match):
> >      #
> >      # Go through the dance of getting an xref out of the C domain
> >      #
> > -    target =3D match.group(2)
> > +    base_target =3D match.group(2)
> >      target_text =3D nodes.Text(match.group(0))
> >      xref =3D None
> > -    if not ((match.re =3D=3D RE_function and target in Skipfuncs)
> > -            or (target in Skipnames)):
> > -        lit_text =3D nodes.literal(classes=3D['xref', 'c', class_str[m=
atch.re]])
> > -        lit_text +=3D target_text
> > -        pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
> > -                                      reftype =3D reftype_str[match.re=
],
> > -                                      reftarget =3D target, modname =
=3D None,
> > -                                      classname =3D None)
> > -        #
> > -        # XXX The Latex builder will throw NoUri exceptions here,
> > -        # work around that by ignoring them.
> > -        #
> > -        try:
> > -            xref =3D cdom.resolve_xref(app.env, docname, app.builder,
> > -                                     reftype_str[match.re], target, px=
ref,
> > -                                     lit_text)
> > -        except NoUri:
> > -            xref =3D None
> > -    #
> > -    # Return the xref if we got it; otherwise just return the plain te=
xt.
> > -    #
> > -    if xref:
> > -        return xref
> > -    else:
> > -        return target_text
> > +    possible_targets =3D [base_target]
> > +    # Check if this document has a namespace, and if so, try
> > +    # cross-referencing inside it first.
> > +    if c_namespace:
> > +        possible_targets.insert(0, c_namespace + "." + base_target)
> > +
> > +    if base_target not in Skipnames:
> > +        for target in possible_targets:
> > +            if not (match.re =3D=3D RE_function and target in Skipfunc=
s):
> > +                lit_text =3D nodes.literal(classes=3D['xref', 'c', cla=
ss_str[match.re]])
> > +                lit_text +=3D target_text
> > +                pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
> > +                                              reftype =3D reftype_str[=
match.re],
> > +                                              reftarget =3D target, mo=
dname =3D None,
> > +                                              classname =3D None)
> > +                #
> > +                # XXX The Latex builder will throw NoUri exceptions he=
re,
> > +                # work around that by ignoring them.
> > +                #
> > +                try:
> > +                    xref =3D cdom.resolve_xref(app.env, docname, app.b=
uilder,
> > +                                             reftype_str[match.re], ta=
rget, pxref,
> > +                                             lit_text)
> > +                except NoUri:
> > +                    xref =3D None
> > +
> > +                if xref:
> > +                    return xref
> > +
> > +    return target_text
> >
> >  #
> >  # Try to replace a documentation reference of the form Documentation/.=
.. with a
> > @@ -239,7 +256,18 @@ def markup_doc_ref(docname, app, match):
> >      else:
> >          return nodes.Text(match.group(0))
> >
> > +def get_c_namespace(app, docname):
> > +    source =3D app.env.doc2path(docname)
> > +    with open(source) as f:
> > +        for l in f:
> > +            match =3D RE_namespace.search(l)
> > +            if match:
> > +                return match.group(1)
> > +    return ''
> > +
> >  def auto_markup(app, doctree, name):
> > +    global c_namespace
> > +    c_namespace =3D get_c_namespace(app, name)
> >      #
> >      # This loop could eventually be improved on.  Someday maybe we
> >      # want a proper tree traversal with a lot of awareness of which
>
>
>
> Thanks,
> Mauro

Thanks,
N=C3=ADcolas

