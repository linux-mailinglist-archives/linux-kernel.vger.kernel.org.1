Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16729A6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895000AbgJ0Iht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894957AbgJ0Iht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:37:49 -0400
Received: from coco.lan (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D9121556;
        Tue, 27 Oct 2020 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603787867;
        bh=lkiwEawc+TxmjSVpOpey8tJBySVltFZYq6R6cKzfXzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eldRcZW2OSzX+3KHCBhryq5msVCv3rYrWLaah8JfyqUNIs4OJoDM79yqoaKGMoD7C
         o+3KOKvyrYZ/pC0FVL65eCb3dbQLOnLrA88ZDb/T6nc33pj4AIAck53O/s5hBvvcxx
         9/1yo3LR46oH390RV8fEbLbATF0/BKnvNM9Cbyxg=
Date:   Tue, 27 Oct 2020 09:37:43 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/56] scripts: kernel-doc: fix typedef parsing
Message-ID: <20201027093743.5ecaaf7b@coco.lan>
In-Reply-To: <0b1436d7f3f4267d518013919edd351dba4bcc92.camel@perches.com>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <d0b2146c4ced3121342583bb3d962628fc96759b.1603469755.git.mchehab+huawei@kernel.org>
        <20201023112226.4035e3f7@lwn.net>
        <c0210eade81060382884e1f38ca7f71742d02b61.camel@perches.com>
        <20201026080322.4d0b26f5@coco.lan>
        <0b1436d7f3f4267d518013919edd351dba4bcc92.camel@perches.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 26 Oct 2020 20:55:35 -0700
Joe Perches <joe@perches.com> escreveu:

> On Mon, 2020-10-26 at 08:03 +0100, Mauro Carvalho Chehab wrote:
> []
> > Well, this can help:
> > 	my $typedef_type =3D qr { ((?:\w+\s+){1,}) }x; =20
>=20
> unbounded captures are generally bad, I suggest a limit like {1,5}

Ok. 5 is likely too low, if "*" starts to be counted as part of the type.
Maybe 8 would be ok.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0if ($x =3D~ /typedef\s+((?:\w+\s+){1,})\(\*?\s*=
(\w\S+)\s*\)\s*\((.*)\);/ ||
> > 	$x =3D~ /typedef\s+((?:\w+\s+){1,})\s*\*?(\w\S+)\s*\s*\((.*)\);/) { =20
> []
> > Fix the regex in order to accept composite types when
> > defining a typedef for a function pointer. =20
> []=20
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc =20
> []
> > @@ -1438,13 +1438,14 @@ sub dump_typedef($$) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$x =3D~ s@/\*.*?\*/@@gos;	# strip comment=
s.
> > =C2=A0
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Parse function prototypes
> > -    if ($x =3D~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
> > -	$x =3D~ /typedef\s+(\w+)\s*(\w\S+)\s*\s*\((.*)\);/) {
> > +    if ($x =3D~ /typedef\s+((?:\w+\s+){1,})\(\*?\s*(\w\S+)\s*\)\s*\((.=
*)\);/ ||
> > +	$x =3D~ /typedef\s+((?:\w+\s+){1,})\s*\*?(\w\S+)\s*\s*\((.*)\);/) { =
=20
>=20
> This typedef does not allow * returns=C2=A0like
>=20
> 	const unsigned char *(*string)(args...);
> or
> 	unsigned char *const(*fn)(args...);
> or
> 	void *(*alloc)(args...);

Supporting those shouldn't be hard. See enclosed.

>=20
> (not to mention the truly unusual stuff like the typedefs in
>  tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c)
>=20
> typedef void (* (*signal_t)(int, void (*)(int)))(int);
> typedef char * (*fn_ptr_arr1_t[10])(int **);
> typedef char * (* const (* const fn_ptr_arr2_t[5])())(char * (*)(int));

Parsing those using a single regex, though, is a lot more complex.
The logic would likely require some loop or a real lexical
analyzer in order to properly parse it.

In the specific case of userspace tools (and, in special, selftests),
it is probably not worth the effort to add support for C expressions
that only exists there, as those won't likely gain kernel-doc entries
for their source code to become part of the Kernel documentation.

Thanks,
Mauro

[PATH] scripts: kernel-doc: fix typedef parsing

The include/linux/genalloc.h file defined this typedef:

        typedef unsigned long (*genpool_algo_t)(unsigned long *map,unsigned=
 long size,unsigned long start,unsigned int nr,void *data, struct gen_pool =
*pool, unsigned long start_addr);

Because it has a type composite of two words (unsigned long),
the parser gets the typedef name wrong:

.. c:macro:: long

   **Typedef**: Allocation callback function type definition

Fix the regex in order to accept composite types when
defining a typedef for a function pointer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 99cd8418ff8a..f699cf05d409 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1431,20 +1431,25 @@ sub dump_enum($$) {
     }
 }
=20
+my $typedef_type =3D qr { ((?:\s+[\w\*]+){1,8})\s* }x;
+my $typedef_ident =3D qr { \*?\s*(\w\S+)\s* }x;
+my $typedef_args =3D qr { \s*\((.*)\); }x;
+
+my $typedef1 =3D qr { typedef$typedef_type\($typedef_ident\)$typedef_args =
}x;
+my $typedef2 =3D qr { typedef$typedef_type$typedef_ident$typedef_args }x;
+
 sub dump_typedef($$) {
     my $x =3D shift;
     my $file =3D shift;
=20
     $x =3D~ s@/\*.*?\*/@@gos;	# strip comments.
=20
-    # Parse function prototypes
-    if ($x =3D~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
-	$x =3D~ /typedef\s+(\w+)\s*(\w\S+)\s*\s*\((.*)\);/) {
-
-	# Function typedefs
+    # Parse function typedef prototypes
+    if ($x =3D~ $typedef1 || $x =3D~ $typedef2) {
 	$return_type =3D $1;
 	$declaration_name =3D $2;
 	my $args =3D $3;
+	$return_type =3D~ s/^\s+//;
=20
 	create_parameterlist($args, ',', $file, $declaration_name);
=20


