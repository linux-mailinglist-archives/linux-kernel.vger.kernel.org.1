Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD22B5978
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 06:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKQFsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 00:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQFsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 00:48:06 -0500
Received: from coco.lan (ip5f5ad5cc.dynamic.kabel-deutschland.de [95.90.213.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD77E24248;
        Tue, 17 Nov 2020 05:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605592084;
        bh=p/YObpsRVWEXyHQFQeNTubJTpJf5VQkcyZirfMUYtV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Z5QkWGs67JHMJ8AimA483tniC/IKIv0js4TmQ2LsLZ5elHAIkkeL3k6JxjuB7XhZ
         z4JjM/xmk5L7mnD02G3ovy0Oy46sSrGLi7m2ylT1imBXAz5ZDp9iu8iu6huzb9THGO
         YqnRbTLN/TaaHtPHTemU2E1rNetniRJGezo+9ekg=
Date:   Tue, 17 Nov 2020 06:47:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: [PATCH v2] docs: automarkup.py: Allow automatic cross-reference
 inside C namespace
Message-ID: <20201117064759.0c03e7cf@coco.lan>
In-Reply-To: <20201117021107.214704-1-nfraprado@protonmail.com>
References: <20201117021107.214704-1-nfraprado@protonmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 17 Nov 2020 02:12:01 +0000
N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> escreveu:

> Sphinx 3.1 introduced namespaces for C cross-references. With this,
> each C domain type/function declaration is put inside the namespace that
> was active at the time of its declaration.
>=20
> Add support for automatic cross-referencing inside C namespaces by
> checking whether the corresponding source file had a C namespace Sphinx
> directive, and if so, try cross-referencing inside of it before going to
> the global scope.
>=20
> This assumes there's only one namespace (if any) per rst file.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
> ---
>=20
> To those following from v1:
>=20
> I ended up doing the simplest solution possible, which is to just directl=
y read
> the rst source corresponding to the doc page right before doing the autom=
arkup.
> It's not very efficient in the sense that the source is being read
> twice (first by Sphinx, then by this), but it sidesteps the "data sharing
> between processes" issue, so parallel_read_safe can be reenabled, and I d=
idn't
> notice any performance hit from this patch (as opposed to the big hit fro=
m v1).
> Works with both Sphinx 2 and 3.
>=20
> Changes in v2:
> - Get C namespace from reading the corresponding source at the time of do=
ing
>   automarkup instead of storing all namespaces beforehand at the source-r=
ead
>   phase
>     - Add get_c_namespace()
>     - Remove save_c_namespace()
> - Reenabled Sphinx's parallel_read_safe
>=20
> v1: https://lore.kernel.org/linux-doc/20201013231218.2750109-6-nfraprado@=
protonmail.com/
>=20
>  Documentation/sphinx/automarkup.py | 122 ++++++++++++++++++-----------
>  1 file changed, 75 insertions(+), 47 deletions(-)
>=20
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/au=
tomarkup.py
> index 3e81ebab26ed..953b24b6e2b4 100644
> --- a/Documentation/sphinx/automarkup.py
> +++ b/Documentation/sphinx/automarkup.py
> @@ -53,6 +53,8 @@ RE_typedef =3D re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+=
)', flags=3Dascii_p3)
>  #
>  RE_doc =3D re.compile(r'\bDocumentation(/[\w\-_/]+)(\.\w+)*')
> =20
> +RE_namespace =3D re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
> +
>  #
>  # Reserved C words that we should skip when cross-referencing
>  #
> @@ -70,6 +72,8 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcnt=
l', 'mmap',
>                'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
>                'socket' ]
> =20
> +c_namespace =3D ''
> +
>  def markup_refs(docname, app, node):
>      t =3D node.astext()
>      done =3D 0
> @@ -128,30 +132,38 @@ def markup_func_ref_sphinx3(docname, app, match):
>      #
>      # Go through the dance of getting an xref out of the C domain
>      #
> -    target =3D match.group(2)
> +    base_target =3D match.group(2)
>      target_text =3D nodes.Text(match.group(0))
>      xref =3D None
> -    if not (target in Skipfuncs or target in Skipnames):
> -        for class_s, reftype_s in zip(class_str, reftype_str):
> -            lit_text =3D nodes.literal(classes=3D['xref', 'c', class_s])
> -            lit_text +=3D target_text
> -            pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
> -                                          reftype =3D reftype_s,
> -                                          reftarget =3D target, modname =
=3D None,
> -                                          classname =3D None)
> -            #
> -            # XXX The Latex builder will throw NoUri exceptions here,
> -            # work around that by ignoring them.
> -            #
> -            try:
> -                xref =3D cdom.resolve_xref(app.env, docname, app.builder,
> -                                         reftype_s, target, pxref,
> -                                         lit_text)
> -            except NoUri:
> -                xref =3D None
> +    possible_targets =3D [base_target]
> +    # Check if this document has a namespace, and if so, try
> +    # cross-referencing inside it first.
> +    if c_namespace:
> +        possible_targets.insert(0, c_namespace + "." + base_target)
> =20
> -            if xref:
> -                return xref
> +    if base_target not in Skipnames:
> +        for target in possible_targets:
> +            if target not in Skipfuncs:

Hmm... do we still need to skip syscalls?

> +                for class_s, reftype_s in zip(class_str, reftype_str):
> +                    lit_text =3D nodes.literal(classes=3D['xref', 'c', c=
lass_s])
> +                    lit_text +=3D target_text
> +                    pxref =3D addnodes.pending_xref('', refdomain =3D 'c=
',
> +                                                  reftype =3D reftype_s,
> +                                                  reftarget =3D target, =
modname =3D None,
> +                                                  classname =3D None)
> +                    #
> +                    # XXX The Latex builder will throw NoUri exceptions =
here,
> +                    # work around that by ignoring them.
> +                    #
> +                    try:
> +                        xref =3D cdom.resolve_xref(app.env, docname, app=
.builder,
> +                                                 reftype_s, target, pxre=
f,
> +                                                 lit_text)
> +                    except NoUri:
> +                        xref =3D None
> +
> +                    if xref:
> +                        return xref
> =20
>      return target_text
> =20
> @@ -179,34 +191,39 @@ def markup_c_ref(docname, app, match):
>      #
>      # Go through the dance of getting an xref out of the C domain
>      #
> -    target =3D match.group(2)
> +    base_target =3D match.group(2)
>      target_text =3D nodes.Text(match.group(0))
>      xref =3D None
> -    if not ((match.re =3D=3D RE_function and target in Skipfuncs)
> -            or (target in Skipnames)):
> -        lit_text =3D nodes.literal(classes=3D['xref', 'c', class_str[mat=
ch.re]])
> -        lit_text +=3D target_text
> -        pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
> -                                      reftype =3D reftype_str[match.re],
> -                                      reftarget =3D target, modname =3D =
None,
> -                                      classname =3D None)
> -        #
> -        # XXX The Latex builder will throw NoUri exceptions here,
> -        # work around that by ignoring them.
> -        #
> -        try:
> -            xref =3D cdom.resolve_xref(app.env, docname, app.builder,
> -                                     reftype_str[match.re], target, pxre=
f,
> -                                     lit_text)
> -        except NoUri:
> -            xref =3D None
> -    #
> -    # Return the xref if we got it; otherwise just return the plain text.
> -    #
> -    if xref:
> -        return xref
> -    else:
> -        return target_text
> +    possible_targets =3D [base_target]
> +    # Check if this document has a namespace, and if so, try
> +    # cross-referencing inside it first.
> +    if c_namespace:
> +        possible_targets.insert(0, c_namespace + "." + base_target)
> +
> +    if base_target not in Skipnames:
> +        for target in possible_targets:
> +            if not (match.re =3D=3D RE_function and target in Skipfuncs):
> +                lit_text =3D nodes.literal(classes=3D['xref', 'c', class=
_str[match.re]])
> +                lit_text +=3D target_text
> +                pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
> +                                              reftype =3D reftype_str[ma=
tch.re],
> +                                              reftarget =3D target, modn=
ame =3D None,
> +                                              classname =3D None)
> +                #
> +                # XXX The Latex builder will throw NoUri exceptions here,
> +                # work around that by ignoring them.
> +                #
> +                try:
> +                    xref =3D cdom.resolve_xref(app.env, docname, app.bui=
lder,
> +                                             reftype_str[match.re], targ=
et, pxref,
> +                                             lit_text)
> +                except NoUri:
> +                    xref =3D None
> +
> +                if xref:
> +                    return xref
> +
> +    return target_text
> =20
>  #
>  # Try to replace a documentation reference of the form Documentation/...=
 with a
> @@ -239,7 +256,18 @@ def markup_doc_ref(docname, app, match):
>      else:
>          return nodes.Text(match.group(0))
> =20
> +def get_c_namespace(app, docname):
> +    source =3D app.env.doc2path(docname)
> +    with open(source) as f:
> +        for l in f:
> +            match =3D RE_namespace.search(l)
> +            if match:
> +                return match.group(1)
> +    return ''
> +
>  def auto_markup(app, doctree, name):
> +    global c_namespace
> +    c_namespace =3D get_c_namespace(app, name)
>      #
>      # This loop could eventually be improved on.  Someday maybe we
>      # want a proper tree traversal with a lot of awareness of which



Thanks,
Mauro
