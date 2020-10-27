Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA91529A77E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895521AbgJ0JNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895512AbgJ0JNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:13:23 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E9DB20735;
        Tue, 27 Oct 2020 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603790002;
        bh=B11T/jxpX4uwNSFHjuTvEjy9dCdyt60clvJzRvW3FGE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ii8rBDo5LUmokkIjCnLeNFqTVuJtFJLzKB+aC647ZrsEclPNhX9suc2ZNMvITHWnl
         uBsgtL1Al85oT9AazTsL2qtQeldC2Fz2g01zvN/uwoImOeRimhpL+rCOZuznzQIjR4
         LVSJKnc+VmkZqAMPCDu+crXFc9AEZFGxvK1mCf5I=
From:   Felipe Balbi <balbi@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        David Cohen <david.a.cohen@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: dwc3: ulpi: Fix UPLI registers read/write ops
In-Reply-To: <20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru>
References: <20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru>
Date:   Tue, 27 Oct 2020 11:13:14 +0200
Message-ID: <87mu08c9qt.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Serge Semin <Sergey.Semin@baikalelectronics.ru> writes:

> Our Baikal-T1 SoC is equipped with DWC USB3 IP core as a USB2.0 bus
> controller. In general the DWC USB3 driver is working well for it except
> the ULPI-bus part. We've found out that the DWC USB3 ULPI-bus driver dete=
cted
> PHY with VID:PID tuple as 0x0000:0x0000, which of course wasn't true since
> it was supposed to be 0x0424:0x0006. After a short digging inside the
> ulpi.c code and studying the DWC USB3 documentation, it has been
> discovered that the ULPI bus IO ops didn't work quite correct. The
> busy-loop had stopped waiting before the actual operation was finished. We
> found out that the problem was caused by several bugs hidden in the DWC
> USB3 ULPI-bus IO implementation.
>
> First of all in accordance with the DWC USB3 databook [1] the ULPI IO
> busy-loop is supposed to use the GUSB2PHYACCn.VStsDone flag as an
> indication of the PHY vendor control access completion. Instead it polled
> the GUSB2PHYACCn.VStsBsy flag, which as we discovered can be cleared a
> bit before the VStsDone flag.
>
> Secondly having the simple counter-based loop in the modern kernel is
> really a weak design of the busy-looping pattern especially seeing the
> ULPI operations delay can be easily estimated [2], since the bus clock is
> fixed to 60MHz.
>
> Finally the root cause of the denoted in the prologue problem was due to
> the Suspend PHY DWC USB3 feature perception. The commit e0082698b689
> ("usb: dwc3: ulpi: conditionally resume ULPI PHY") introduced the Suspend
> USB2.0 HS/FS/LS PHY regression as the Low-power consumption mode would be
> disable after a first attempt to read/write from the ULPI PHY control
> registers, and still didn't fix the problem it was originally intended for
> since the very first attempt of the ULPI PHY control registers IO would
> need much more time than the busy-loop provided. So instead of disabling
> the Suspend USB2.0 HS/FS/LS PHY feature we suggest to just extend the
> busy-loop delay in case if the GUSB2PHYCFGn.SusPHY flag set to 1. By doing
> so we'll eliminate the regression and the fix the false busy-loop timeout
> problem.
>
> [1] Synopsys DesignWare Cores SuperSpeed USB 3.0 xHCI Host Controller
>     Databook, 2.70a, December 2013, p.388
>
> [1] UTMI+ Low Pin Interface (ULPI) Specification, Revision 1.1,
>     October 20, 2004, pp. 30 - 36.
>
> Fixes: e0082698b689 ("usb: dwc3: ulpi: conditionally resume ULPI PHY")
> Fixes: 88bc9d194ff6 ("usb: dwc3: add ULPI interface support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

these should go in the relevant commits instead.

> Serge Semin (3):
>   usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion
>   usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
>   usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression

make sure fixes don't depend on other rework otherwise they can't be
taken during the -rc cycle.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+X5KoRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYpxg//c4FquGHYJbblctk4cOqti54DqjXDLvPZ
9oa6qkIp3TLXuOYkNxmqKBCKV3cLnDvCh3W8l4lPdsNJuRoKnn8qatEO0nQ2wjNM
xDuPjTiG0i0ce14i+TGGWAOxN9T7YccJNenOvs19hBP5NgK+meUoJnf/JTE92KGs
6wM+1Cf3MbYpz4a1R7VH3CjXND8GRY1Q/l+oHpyQPrBa8D3ecmeqE2dblj7hkfL3
Q5nYZaS8xDt9ud1eHnZthAKPOZJwY9hHEQPfR2xD01yqSMdaXVedreWwAjW3ddWF
ofw/Fy+E0DxHEj9BEiH1Rw2yzFu9YaB9PWGMMR4HYWmu9YyKZam7h6Hw/tPcDC/1
3V390t5q4ysgP5jfcC0nfyfGWMdJHbJyXP8yPoe/JScqqfHGzVOPsx6UP4RMwnCw
EsdurLVo11T8RNB/bu3IutFTuJTJ9++7t2DtepywDNAUU3dm9/u/wibbK+3kP/DB
6Po4SxyEV2Qr2GS8y37sEywyEhK5gdD+5zKdg+POv22RqNKhrLsfU+Ik6ViFgFkG
mpyItADD0PvBIlXryFseu+IJC8fYrS5I7xBgzzm202t57Cpfw00s0zo+JzDkbqRI
uAeYJ2vtCC1/KHO0KcSGV4z9ZrBNkkLqJWKeNpAkf3r2AeoxKn0OkDko5Xx5Y4R9
iR5Dkmo2GOw=
=thJo
-----END PGP SIGNATURE-----
--=-=-=--
