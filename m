Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3525B276AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgIXHVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgIXHVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:21:51 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D615D20936;
        Thu, 24 Sep 2020 07:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600932111;
        bh=W1NfV1FgfIFdZ3K8fB/iejX92dIlIxZUGzm5wcEBF+w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OGe7NtqiNMrINJ96/ctoDHZWHsZ1OGR3lt3x5r7lWfXNogogUE0/3HLzOXJT87bgR
         GILaPiAL6NjqQxiYaC2tY0cJY0RzaFyumYQtK6Zf8PzdEUmg2f9Sa6COru15TWAnMo
         Pko4c0L+W1/q8YSK7xDIaoSqLLEhuI9Tv9YBukCs=
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, matthias.bgg@gmail.com,
        swboyd@chromium.org, linux-arm-kernel@lists.infradead.org,
        alcooperx@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Add entry for Broadcom BDC driver
In-Reply-To: <20200917073831.GB3217334@kroah.com>
References: <20200710034806.15650-1-f.fainelli@gmail.com>
 <830cd104-87de-4246-35ff-47a0ed5b05a9@gmail.com>
 <1600325394.20109.16.camel@mhfsdcap03>
 <20200917073831.GB3217334@kroah.com>
Date:   Thu, 24 Sep 2020 10:21:43 +0300
Message-ID: <87r1qrej20.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Sep 17, 2020 at 02:49:54PM +0800, Chunfeng Yun wrote:
>> On Sun, 2020-09-06 at 12:55 -0700, Florian Fainelli wrote:
>> >=20
>> > On 7/9/2020 8:48 PM, Florian Fainelli wrote:
>> > > The Broadcom BDC driver did not have a MAINTAINERS entry which made =
it
>> > > escape review from Al and myself, add an entry so the relevant maili=
ng
>> > > lists and people are copied.
>> > >=20
>> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> >=20
>> > This patch still does not seem to have been picked up (not seeing it i=
n=20
>> > linux-next), can this be applied so we have an accurate maintainer=20
>> > information for this driver?
>> Ping
>
> Felipe should have picked this up.
>
> If not, please resend it again and I can.

Applied

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9sSQcRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbtrBAAnGn2VhbYEHze9q3C2pjrsP81tErRRDSf
AS9/7J9KLCJwxuuDKmbIRdibCFbXReYcc976Qp7qeo2LyHt5H09eMKligfZGdMvR
8QnWImnQWqpYVi9jpg3sw1+gReCgpLHnTwjVppmaLr/yDZ5pwY9JYxdAd5NnNDY4
uJNyzt2sdTh2gmPk2MJwTKnCaocmqArnZ0RD+TJDbJNRUH//frg51EsblwbknHnC
/Bi4fMVX3ljOOEBv4kCltbo/SB4i0cDAQa7Z0SpA6sOVqrOjejMTwc+9DTkFmeZv
o2E1MttSuVoFKoboCv7HwVo9FwHxwsg42a07trIYuVWs7uW3mrv+CpY111xYAJ2M
z4KPkHQIbDARfWb7KFMamsoRFXt26pjEJqPuAuos34erft3FkechQV8lkuCjqWUx
IT38VnLHgpEqLPlMQQwrMZuOlM2CxiK2ZDNIeymMBxUBMndyx9FG5JqTlLiQrmDl
7i8Huyd57bNq03i0G91YLitr1Q6xopmTNDA9jTy6Ebf2FTczLcPHVAneYmBHhAw5
yYzZoLQneEn9uwi2YTJy6U6D+s5H5IcFWVohJ4saI0o/6yzB7tMfcacSP/ZB9Rh+
l4HSNmTrk5tygK6xeZe4KyYIJKPnoQMH+27+Gvcc8rbkum+MZLdIQxlw1ZsZoRC3
Q2F0jq/b1qo=
=cBgr
-----END PGP SIGNATURE-----
--=-=-=--
