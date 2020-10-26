Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA9298739
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770280AbgJZHD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770188AbgJZHD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:03:27 -0400
Received: from coco.lan (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF522087C;
        Mon, 26 Oct 2020 07:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603695806;
        bh=2Xa2LNj1UxVTXRfHt20km3lyu+9+44qIrrqa/k+9HxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tFgnSi576f5hF10ydqKK9SGHQ6ezZKC//WjDID8TFVMovZwhIxScYKgrwP8uzkrHQ
         EGYcv3w9rBHG+Ne8Yew6T7g/cSARjIgVDKPqTJyNfiryWX3nSdkkKhSppViOZeNnTP
         i06nYnsD8d5algFIkqoq/KAUpROjT9a+QqYUYlMw=
Date:   Mon, 26 Oct 2020 08:03:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/56] scripts: kernel-doc: fix typedef parsing
Message-ID: <20201026080322.4d0b26f5@coco.lan>
In-Reply-To: <c0210eade81060382884e1f38ca7f71742d02b61.camel@perches.com>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <d0b2146c4ced3121342583bb3d962628fc96759b.1603469755.git.mchehab+huawei@kernel.org>
        <20201023112226.4035e3f7@lwn.net>
        <c0210eade81060382884e1f38ca7f71742d02b61.camel@perches.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 23 Oct 2020 11:01:35 -0700
Joe Perches <joe@perches.com> escreveu:

> On Fri, 2020-10-23 at 11:22 -0600, Jonathan Corbet wrote:
> > On Fri, 23 Oct 2020 18:32:48 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >  =20
> > > The include/linux/genalloc.h file defined this typedef:
> > >=20
> > > 	typedef unsigned long (*genpool_algo_t)(unsigned long *map,unsigned =
long size,unsigned long start,unsigned int nr,void *data, struct gen_pool *=
pool, unsigned long start_addr); =20
> []
> > > diff --git a/scripts/kernel-doc b/scripts/kernel-doc =20
> []
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Parse function prototypes
> > > -    if ($x =3D~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ =
||
> > > +    if ($x =3D~ /typedef\s+(\w+\s*){1,}\(\*\s*(\w\S+)\s*\)\s*\((.*)\=
);/ || =20
> >=20
> > I sure wish we could find a way to make all these regexes more
> > understandable and maintainable.  Reviewing a change like this is ... f=
un. =20
>=20
> Perhaps using some of the checkpatch regex definitions like:
>=20
> $Type
> $Ident
> $balanced_parens
>=20
> would help improve readability.

Well, this can help:


	my $typedef_type =3D qr { ((?:\w+\s+){1,}) }x;
	my $typedef_ident =3D qr { \*?\s*(\w\S+)\s* }x;
	my $typedef_args =3D qr { \s*\((.*)\); }x;

	my $typedef1 =3D qr { typedef\s+$typedef_type\($typedef_ident\)$typedef_ar=
gs }x;
	my $typedef2 =3D qr { typedef\s+$typedef_type$typedef_ident$typedef_args }=
x;

	# Parse function typedef prototypes
	if ($x =3D~ $typedef1 || $x =3D~ $typedef2) {
		...

But, IMHO, this is as complicated as before, and makes harder
to test the regex outside kernel_doc (like using regex101).

A good thing is that it is easier to see the difference between
the two typedef regexes.

I'll place such optimization on a separate patch. This way, it
should be easier to decide later if this is worth or not.

Also, if we're willing to take such direction, it could make
sense to use the same regexes for matching type, identifier
and arguments inside the functions parser.

> And the regex above doesn't quite work for spacing after typedef.
> The regex should allow space between the open parenthesis and the *
>=20
> 	typedef <Type> ( * <Ident> ) (args...);
>=20
> And this regex does not find typedefs that use another typedef as <Ident>=
 like:
>=20
> arch/s390/include/asm/debug.h:typedef int (debug_header_proc_t) (debug_in=
fo_t *id,

True. I guess that, in order to properly handle it, we should use this:

    if ($x =3D~ /typedef\s+((?:\w+\s+){1,})\(\*?\s*(\w\S+)\s*\)\s*\((.*)\);=
/ ||
	$x =3D~ /typedef\s+((?:\w+\s+){1,})\s*\*?(\w\S+)\s*\s*\((.*)\);/) {

The first check should now parse everything properly:

	https://regex101.com/r/bPTm18/5

And the second regex should also get multi-word types when parenthesis
is not used, like:

	typedef unsigned int debug_header_proc_t (debug_info_t *id, struct debug_v=
iew *view, int area,debug_entry_t *entry, char *out_buf);
	typedef unsigned int *debug_header_proc_t (debug_info_t *id, struct debug_=
view *view, int area,debug_entry_t *entry, char *out_buf);


https://regex101.com/r/Y56X1X/1

Thanks,
Mauro

[PATCH] scripts: kernel-doc: fix typedef parsing

The include/linux/genalloc.h file defined this typedef:

	typedef unsigned long (*genpool_algo_t)(unsigned long *map,unsigned long s=
ize,unsigned long start,unsigned int nr,void *data, struct gen_pool *pool, =
unsigned long start_addr);

Because it has a type composite of two words (unsigned long),
the parser gets the typedef name wrong:

.. c:macro:: long

   **Typedef**: Allocation callback function type definition

Fix the regex in order to accept composite types when
defining a typedef for a function pointer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 99cd8418ff8a..54832618eea0 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1438,13 +1438,14 @@ sub dump_typedef($$) {
     $x =3D~ s@/\*.*?\*/@@gos;	# strip comments.
=20
     # Parse function prototypes
-    if ($x =3D~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
-	$x =3D~ /typedef\s+(\w+)\s*(\w\S+)\s*\s*\((.*)\);/) {
+    if ($x =3D~ /typedef\s+((?:\w+\s+){1,})\(\*?\s*(\w\S+)\s*\)\s*\((.*)\)=
;/ ||
+	$x =3D~ /typedef\s+((?:\w+\s+){1,})\s*\*?(\w\S+)\s*\s*\((.*)\);/) {
=20
 	# Function typedefs
 	$return_type =3D $1;
 	$declaration_name =3D $2;
 	my $args =3D $3;
+	$return_type =3D~ s/\s+$//;
=20
 	create_parameterlist($args, ',', $file, $declaration_name);
=20




