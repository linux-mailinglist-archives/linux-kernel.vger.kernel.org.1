Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81B82FBCC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbhASQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbhASQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:40:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16DBC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:40:05 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1l1u2Y-0005Fo-8U; Tue, 19 Jan 2021 17:39:34 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1l1u2X-0006I4-9p; Tue, 19 Jan 2021 17:39:33 +0100
Date:   Tue, 19 Jan 2021 17:39:33 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Manish Narani <manish.narani@xilinx.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Message-ID: <20210119163933.GG12316@pengutronix.de>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
 <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
 <20210118134223.GE12316@pengutronix.de>
 <87r1miuv2h.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <87r1miuv2h.fsf@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:35:27 up 48 days,  5:02, 89 users,  load average: 0.15, 0.23,
 0.19
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 05:24:38PM +0200, Felipe Balbi wrote:
>
>Hi,
>
>Michael Grzeschik <mgr@pengutronix.de> writes:
>> On Tue, Dec 15, 2020 at 12:24:51PM +0530, Manish Narani wrote:
>>>Add a new driver for supporting Xilinx platforms. This driver is used
>>>for some sequence of operations required for Xilinx USB controllers.
>>>This driver is also used to choose between PIPE clock coming from SerDes
>>>and the Suspend Clock. Before the controller is out of reset, the clock
>>>selection should be changed to PIPE clock in order to make the USB
>>>controller work. There is a register added in Xilinx USB controller
>>>register space for the same.
>>
>> I tried out this driver with the vanilla kernel on an zynqmp. Without
>> this patch the USB-Gadget is already acting buggy. In the gadget mode,
>> some iterations of plug/unplug results to an stalled gadget which will
>> never come back without a reboot.
>>
>> With the corresponding code of this driver (reset assert, clk modify,
>> reset deassert) in the downstream kernels phy driver we found out it is
>> totaly stable. But using this exact glue driver which should do the same
>> as the downstream code, the gadget still was buggy the way described
>> above.
>>
>> I suspect the difference lays in the different order of operations.
>> While the downstream code is runing the resets inside the phy driver
>> which is powered and initialized in the dwc3-core itself. With this glue
>> layser approach of this patch the whole phy init is done before even
>> touching dwc3-core in any way. It seems not to have the same effect,
>> though.
>>
>> If really the order of operations is limiting us, we probably need
>> another solution than this glue layer. Any Ideas?
>
>might be a good idea to collect dwc3 trace events. Can you do that?

I already did that. In case the port is not working properly, the port
was producing several "Erratic Errors" between the plug/unplug events.

This was not the case until the reset_assert, pll configure,
reset_deassert sequence was applied like in the downstream kernels
phy driver on phy_init.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmAHCz8ACgkQC+njFXoe
LGSODxAAxydcsZuiOW+cXJH7OETTYOD83zHcdXo2Y3fWuKeUHaZoiZ+YZTXX3HeL
rgVC/aSf2+ONKW6kxuUmnxKCrcDRv52y2TAbXEic9MstbxfPHUMae5gxWtTmdX62
LxZ1YxebJ85wXVukcjUfA9ABOmHe0ZE9m3WxvDW15lwhRuJAx3vCmVQm/VgcyVCM
pTFOdQ4pIxSXp+I0AHUUi1yteA51tzEToXOJiSgWCGd+mN5NAA19okhzQZlbhJ4G
Gs78Ca6elF9F6DGSZVZ41ry/dcyrQfIQ5mnXWZuUF5BlpAW9zLl/FQBB3Wnjijx9
8LFcpHrfJJlxU10UqptLeEc28zYx7uouSYdtXghv+kzlxm67qWEUV7cht+PXJ69y
1rlNclKk7roqJNZnc9nnzmwa7AdFqCSWtN5c/ZmohhSNUDe4xFiUEyorkNRFVIe7
gyBalT21ho83I5jar0u6FJ99ZCKCbi++yC2V0zoDKXxbpfdHf5MbcrLBRHzXuiXj
chIXOsVpM07gDCwMNBUhZqy9FFZERzY3xxoHYnhhDZ4tgy1crtfFxfMnaPro+u1M
b/j4UCjWcSb0AJ0uvzJuMVEy4JDFb/feaNJCGLqFeG97DaChgYJm5uy6yhj434yk
ExLqsU4gk4lSpCTesHqcas2r2IoM231ew/Ma7ni3CSWhRUp4tgA=
=DxJJ
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
