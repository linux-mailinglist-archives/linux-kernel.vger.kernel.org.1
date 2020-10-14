Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4828DE13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgJNJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgJNJ4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:56:51 -0400
Received: from coco.lan (ip5f5ad5dc.dynamic.kabel-deutschland.de [95.90.213.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B911520757;
        Wed, 14 Oct 2020 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602669409;
        bh=tkml7oPuVnn0Zm+DK/2abyti4mnRmDpxNYyklln/seU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NDvCjtt7sxilhVgeQj5SxmVLIF1qA2nfc0qhx6Yz5AgHzyZpz4LiatK5Pb5bpJB5i
         mTR1IxZ1Oli4Oh2iIICfrZNEZRxl7ercxS9HIywEYe1CIP+vbIPdB2ECfNhCmgFcwi
         eErPGZdUQeWyFs91ALbS53K+n08TwQGxZHyOfehc=
Date:   Wed, 14 Oct 2020 11:56:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: [PATCH v2 5/5] docs: automarkup.py: Allow automatic
 cross-reference inside C namespace
Message-ID: <20201014115644.7bda9918@coco.lan>
In-Reply-To: <20201013231218.2750109-6-nfraprado@protonmail.com>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
        <20201013231218.2750109-6-nfraprado@protonmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 13 Oct 2020 23:13:40 +0000
N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> escreveu:

> Sphinx 3.1 introduced namespaces for C cross-references. With this,
> each C domain type/function declaration is put inside the namespace that
> was active at the time of its declaration.
>=20
> To support automatic cross-reference inside C namespaces:
> - Save the C namespace used in each doc file (if any) at the source-read
>   phase, in the beginning of the Sphinx process.
> - When making the automarkup, if any namespace was used in the current
>   file, try to cross-reference to the symbol inside of it before trying
>   in the global namespace.
>=20
> To make the first step possible, disable the parallel_read_safe option
> in Sphinx, since the dictionary that maps the files to the C namespaces
> can't be concurrently updated. This unfortunately increases the build
> time of the documentation.

Disabling parallel_read_safe will make performance very poor.
Doesn't the C domain store the current namespace somewhere?
If so, then, instead of using the source-read phase, something
else could be used instead.

>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
> ---
>  Documentation/sphinx/automarkup.py | 130 ++++++++++++++++++-----------
>  1 file changed, 82 insertions(+), 48 deletions(-)
>=20
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/au=
tomarkup.py
> index 409dbc4100de..bca8cf5f519d 100644
> --- a/Documentation/sphinx/automarkup.py
> +++ b/Documentation/sphinx/automarkup.py
> @@ -45,6 +45,8 @@ RE_typedef =3D re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+=
)', flags=3Dre.ASCII)
>  #
>  RE_doc =3D re.compile(r'\bDocumentation(/[\w\-_/]+)(\.\w+)*')
> =20
> +RE_namespace =3D re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
> +
>  #
>  # Reserved C words that we should skip when cross-referencing
>  #
> @@ -62,6 +64,8 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcnt=
l', 'mmap',
>                'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
>                'socket' ]
> =20
> +c_namespace =3D {}
> +
>  def markup_refs(docname, app, node):
>      t =3D node.astext()
>      done =3D 0
> @@ -120,30 +124,42 @@ def markup_func_ref_sphinx3(docname, app, match):
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
> -
> -            if xref:
> -                return xref
> +    possible_targets =3D [base_target]
> +    # Check if this document has a namespace, and if so, try
> +    # cross-referencing inside it first.
> +    try:
> +        namespace =3D c_namespace[docname]
> +    except KeyError:
> +        pass
> +    else:
> +        possible_targets.insert(0, namespace + "." + base_target)
> +
> +    if base_target not in Skipnames:
> +        for target in possible_targets:
> +            if target not in Skipfuncs:
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
> @@ -171,34 +187,43 @@ def markup_c_ref(docname, app, match):
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
> +    possible_targets =3D [base_target]
> +    # Check if this document has a namespace, and if so, try
> +    # cross-referencing inside it first.
> +    try:
> +        namespace =3D c_namespace[docname]
> +    except KeyError:
> +        pass
>      else:
> -        return target_text
> +        possible_targets.insert(0, namespace + "." + base_target)
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
> @@ -246,9 +271,18 @@ def auto_markup(app, doctree, name):
>              if not isinstance(node.parent, nodes.literal):
>                  node.parent.replace(node, markup_refs(name, app, node))
> =20
> +def save_c_namespace(app, docname, source):
> +    lines =3D iter(source[0].splitlines(True))
> +    for l in lines:
> +        match =3D RE_namespace.search(l)
> +        if match:
> +            c_namespace[docname] =3D match.group(1)
> +            return
> +
>  def setup(app):
> +    app.connect('source-read', save_c_namespace)
>      app.connect('doctree-resolved', auto_markup)
>      return {
> -        'parallel_read_safe': True,
> +        'parallel_read_safe': False,
>          'parallel_write_safe': True,
>          }



Thanks,
Mauro
