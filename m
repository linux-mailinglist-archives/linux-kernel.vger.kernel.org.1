Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8193A29DF08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbgJ2A6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731590AbgJ1WRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:33 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D75982474E;
        Wed, 28 Oct 2020 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603893431;
        bh=ou8YkSujVcJoedLOVi8IVrmAZ5xwL3bKWujQtDKeyiM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dd1rBAslmKgbRiMx/reW2ex4P2fRiyTOVjYGfjceUBLuVa0ONJmlCkjmqOJkDppJ/
         K7ph6zBAc7Ln+K+u4/ZmSGYYwqRWsC4UK1iLz6neiKjuIHad8L0sSlVY/EtX5g6yn8
         NllpkpKsWOdGfAxalsey1FD/la5y0YVEzVhhow+Q=
From:   Felipe Balbi <balbi@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3] usb: dwc3: core: fix a issue about clear connect state
In-Reply-To: <20201028125812.GA59692@nuc8i5>
References: <20201020135806.30268-1-zhengdejin5@gmail.com>
 <875z6wdq62.fsf@kernel.org> <20201028125812.GA59692@nuc8i5>
Date:   Wed, 28 Oct 2020 15:57:03 +0200
Message-ID: <87y2jqlahc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Dejin Zheng <zhengdejin5@gmail.com> writes:
>> Dejin Zheng <zhengdejin5@gmail.com> writes:
>> > According to Synopsys Programming Guide chapter 2.2 Register Resets,
>> > it cannot reset the DCTL register by setting DCTL.CSFTRST for core soft
>> > reset, if DWC3 controller as a slave device and stay connected with a =
usb
>> > host, then, while rebooting linux, it will fail to reinitialize dwc3 a=
s a
>> > slave device when the DWC3 controller did not power off. because the
>> > connection status is incorrect, so we also need to clear DCTL.RUN_STOP
>> > bit for disabling connect when doing core soft reset. There will still
>> > be other stale configuration in DCTL, so reset the other fields of DCTL
>> > to the default value 0.
>>=20
>> This commit log is a bit hard to understand. When does this problem
>> actually happen? It seems like it's in the case of, perhaps, kexecing
>> into a new kernel, is that right?
>>=20
> It happens when entering the kernel for the second time after the reboot
> command.
>
>> At the time dwc3_core_soft_reset() is called, the assumption is that
>> we're starting with a clean core, from power up. If we have stale
>> configuration from a previous run, we should fix this on the exit
>> path. Note that if we're reaching probe with pull up connected, we
>> already have issues elsewhere.
>>=20
>> I think this is not the right fix for the problem.
>>
> I think you are right, Thinh also suggested me fix it on the exit path
> in the previous patch v2. Do you think I can do these cleanups in the
> shutdown hook of this driver? Balbi, is there a more suitable place to
> do this by your rich experience? Thanks!

I don't think shutdown is called during removal, I'm not sure. I think
we had some fixes done in shutdown time, though. Test it out, but make
sure there are no issues with a regular modprobe cycle.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+ZeK8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQaO9g/+O6gSiZU19vBa6Mw0v0MrGc7xMoZ0HAXa
DLrp0A/GeQSgDyDu7v7gFpFMlnZBI4e4kPxXMqo7fazBXfKQ77jvqZA7Wg+NFPFQ
uFnY1sjcRsCdkpe7O5gzTINqlfpYdmRtRdHlJb4+c4MP0p+jwS+8AyLhe6fQJRcs
fS6+uZucHbWhzz/UmSjtZEbNLdkQYcgXkmzsdiq0Wge0oOoaTTTRcLz+CbhmjnqH
8dKc5I7EohpbbcwaDu7Jeyhz2qZAVM/0z/1geKcQRAw9044RFr8U44yQAVkp+lnm
zhsysWF3bkLKkeZpG2jT90SjOPTCH6Mf7YkVNqiiFW3FoVqx9Ri2EgxvXMmOtwE6
S9IvNvY+LmLlPVOkqfIb0Xva4WQLXZo9vNKzg+njCbAxvzYCNi2Xho7pY42jlaCZ
ZrZLZLYP9mjrUHn4pyAcVe+2KwCc3W+cJVoNgdWzgxXyBAI9WoUk1F2npLU3u9bH
teAhZGWtBaDcQMC6NAeaCmAEDLtVaLp4MgF8JMN5LFs0E/2XtgJ411DpYKs5K1Xc
ng7vvrQe3rRj94rFeyoRniJBeGQ9HqW6b47d9tAHAbAqXJKcTbxHfwUCOPCJrIoq
nCVL7CxzJ9cHRUHJz6fWoMSaBa7i/CqqZ64ENwXaTIo7iUQnQFUFDjkaJR/A6PIz
h+hIwvCwSCo=
=8K1m
-----END PGP SIGNATURE-----
--=-=-=--
