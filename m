Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6998D2D2C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgLHNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:35:58 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:57249 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLHNf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:35:57 -0500
Date:   Tue, 08 Dec 2020 13:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1607434515;
        bh=Vrw+2+y13OInDneCYRDJSdbZRXAGFGkPu5XrP7lZRBQ=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=vO5tmDF2zv4rgc8iwoVaUYbGlTzgTPGCy0kNWFH45x/daNlsdfsgrfjeEJEsPT+p4
         +qCFavjAPFdqaWT7EGXk+R2l7KpzscGsw1kJ0h0SGbtnJThL9JASSiUvn5xOdcw59s
         jTg6KvEeO5gk5nOUVjs5TnnRvJcUyWgt3Szvt6sg=
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: [PATCH v2 08/39] scripts: get_abi.pl: prevent duplicated file names
Message-ID: <20201208133424.yrdzbb3bzqqtygtm@ArchWay.local>
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

On Fri, Oct 30, 2020 at 08:40:27AM +0100, Mauro Carvalho Chehab wrote:
> The same filename may exist on multiple directories within
> ABI. Create separate entries at the internal database for
> each of them.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/get_abi.pl | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
> index e5a5588a8639..5612f019fae0 100755
> --- a/scripts/get_abi.pl
> +++ b/scripts/get_abi.pl
> @@ -65,7 +65,10 @@ sub parse_abi {
>  =09my $name =3D $file;
>  =09$name =3D~ s,.*/,,;
> =20
> -=09my $nametag =3D "File $name";
> +=09my $fn =3D $file;
> +=09$fn =3D~ s,Documentation/ABI/,,;
> +
> +=09my $nametag =3D "File $fn";
>  =09$data{$nametag}->{what} =3D "File $name";
>  =09$data{$nametag}->{type} =3D "File";
>  =09$data{$nametag}->{file} =3D $name;
> @@ -320,16 +323,18 @@ sub output_rest {
>  =09=09=09my $fileref =3D "abi_file_".$path;
> =20
>  =09=09=09if ($type eq "File") {
> -=09=09=09=09my $bar =3D $w;
> -=09=09=09=09$bar =3D~ s/./-/g;
> -
>  =09=09=09=09print ".. _$fileref:\n\n";
> -=09=09=09=09print "$w\n$bar\n\n";
>  =09=09=09} else {
>  =09=09=09=09print "Defined on file :ref:`$f <$fileref>`\n\n";
>  =09=09=09}
>  =09=09}
> =20
> +=09=09if ($type eq "File") {
> +=09=09=09my $bar =3D $w;
> +=09=09=09$bar =3D~ s/./-/g;
> +=09=09=09print "$w\n$bar\n\n";
> +=09=09}
> +
>  =09=09my $desc =3D "";
>  =09=09$desc =3D $data{$what}->{description} if (defined($data{$what}->{d=
escription}));
>  =09=09$desc =3D~ s/\s+$/\n/;
> --=20
> 2.26.2
>=20

Hey Mauro,

just a heads-up.

It seems the ABI page is showing the full file names as shown in [1], like =
"File
/srv/docbuild/lib/git/linux/stable/firewire-cdev", while only the file name
would be enough, like "File firewire-cdev".

By reverting this patch I got exactly the intended behavior, but it seems y=
ou
were fixing other things with this, so perhaps just reverting is breaking
something that I can't see.

Could you look into what would be the right fix for this? :)

Thanks,
N=C3=ADcolas

[1] https://www.kernel.org/doc/html/latest/admin-guide/abi.html

