Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D467926DD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgIQOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:02:46 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59305 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbgIQN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:56:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 49219816;
        Thu, 17 Sep 2020 09:19:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 09:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7XBxbS5q9mrJ5uRh7p4jNqpBH0T
        21r9xds0Td4Kktpo=; b=D7ayp9EMBYWHk2Gh0QzA/gOGVijBO4NrLa/pYTmpt1s
        /LAyTelAIj8vvf+TuqH9amgzey1zR9wAuDfXV6uCSX/NknXVbwF85rHhGuLfrHUg
        YgDiiSoQH8MqYt2t9FgY+T0Ctcx9A9p9BKZuuFSwwnO8wwCahwbwro4Pow/4pv99
        eP+km6O2d+usBn0h2M3VpK9eyGFR9tGahv5NVIwVaEFNdNHN9sjtPxX4sEAmv7fg
        uMsaGeTotnfKzpr7xwhemXRvLw3ac2MP5M6KumL6RhlZTFUhBvY+HUlzM7gmqc5P
        wBlysIfgAUt/xdoQsLDhjt8UujpMjwt48tL4U3H3Whg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7XBxbS
        5q9mrJ5uRh7p4jNqpBH0T21r9xds0Td4Kktpo=; b=CxHIcZ4NtJ9jU34n3Bz+EG
        R2Z7gTMbBrL3vM/d8OHqCA7gQc7AMHjkOJhfrBwOSNvpeDf0gOHvOvFZw+KB3r3N
        DyenRjqdT+RKTUjsFHE2ido+kV5uT5IddCJFIpBZ++JSZIzsOljE/OLpvk7G5xKx
        1AHPqx5kPwIR9siMJYsbnZwCZXisHlh4JJUBTxuBVfe2PI5tBVJ0StTcBNvuWqVy
        w1bqcnJrVXY+SoF+nI9XjA+gn7ta35mp6TPezJpD6tcuzUe4DsvgX/QEsoygP0vp
        D4FPyz43XEToeRjoM1YGKStG0iY2PhIBSTWJ+OuNkfQkqerPj95hndhjrqXp88SA
        ==
X-ME-Sender: <xms:SmJjX_5W0ldIybj2slfWNP_EAhcx_b67FxQP4Kka9WQW7SYSYzGaqw>
    <xme:SmJjX05a1RzBafPV4fBiLn6VrpAAdI_Ez8_2uSbDazWhzaes5v7pcrgWKpRPbIaSw
    og6CBL_QkyfyHW_b8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SmJjX2ffQdE6sRFnjl9DSPjlF_UOfeTjKP1IvjkIrO1N4dwaqLbZEw>
    <xmx:SmJjXwIVmtF7TipnZcrL44ZGQkxQugJZ5-FAPbQXKHi2bgOpWrQkUA>
    <xmx:SmJjXzKClgOjhOoXDFm4oy6clxBAkjsfWyOFOYSCBDkKq7GBZhvYdQ>
    <xmx:S2JjX700qqX8Poh1d0_M-EyEzaYJnxUyZYxSMNUnctNKJF_YZoU01A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3EA703280065;
        Thu, 17 Sep 2020 09:19:06 -0400 (EDT)
Date:   Thu, 17 Sep 2020 15:19:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: sun4i-gpadc: Interrupt numbers should start from 1
Message-ID: <20200917131904.d7yqpa2sucerg2nm@gilmour.lan>
References: <20200912112200.226530-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5ppbdvii7xprh4y"
Content-Disposition: inline
In-Reply-To: <20200912112200.226530-1-megous@megous.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5ppbdvii7xprh4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 12, 2020 at 01:22:00PM +0200, Ondrej Jirman wrote:
> mfd: sun4i-gpadc: Interrupt numbers should start from 1

Why? An hwirq with 0 is totally fine

> This avoids a warning:
>=20
> [    2.891592] ------------[ cut here ]------------
> [    2.895052] WARNING: CPU: 0 PID: 149 at drivers/base/platform.c:317 __=
platform_get_irq_byname+0x7c/0x8c
> [    2.903212] usb 1-1: new high-speed USB device number 2 using ehci-pla=
tform
> [    2.908930] 0 is an invalid IRQ number
> [    2.911425] Modules linked in: sun4i_gpadc_iio(+) r8188eu(C) lib80211 =
ohci_platform ohci_hcd ehci_platform ehci_hcd cyttsp4_i2c cyttsp_i2c_common=
 cyttsp4_core g_cdc usb_f_acm u_serial usb_f_ecm u_ether libcomposite sunxi=
 phy_generic musb_hdrc udc_core usbcore sun5ieink
> [    2.934048] CPU: 0 PID: 149 Comm: tablet-init Tainted: G         C    =
    5.8.0-rc2-00316-gc6a5213fdeba-dirty #8
> [    2.943027] Hardware name: Allwinner sun4i/sun5i Families
> [    2.947204] [<c010c080>] (unwind_backtrace) from [<c0109ee4>] (show_st=
ack+0x10/0x14)
> [    2.953714] [<c0109ee4>] (show_stack) from [<c012cd04>] (__warn+0xc0/0=
xd8)
> [    2.959364] [<c012cd04>] (__warn) from [<c012cda0>] (warn_slowpath_fmt=
+0x84/0x94)
> [    2.965599] [<c012cda0>] (warn_slowpath_fmt) from [<c0592a60>] (__plat=
form_get_irq_byname+0x7c/0x8c)
> [    2.973480] [<c0592a60>] (__platform_get_irq_byname) from [<c0592a80>]=
 (platform_get_irq_byname+0x10/0x48)
> [    2.981896] [<c0592a80>] (platform_get_irq_byname) from [<bf1142f0>] (=
sun4i_irq_init+0x38/0xe0 [sun4i_gpadc_iio])
> [    2.990923] [<bf1142f0>] (sun4i_irq_init [sun4i_gpadc_iio]) from [<bf1=
145cc>] (sun4i_gpadc_probe+0x234/0x308 [sun4i_gpadc_iio])
> [    3.001152] [<bf1145cc>] (sun4i_gpadc_probe [sun4i_gpadc_iio]) from [<=
c0592edc>] (platform_drv_probe+0x48/0x98)
> [    3.010051] [<c0592edc>] (platform_drv_probe) from [<c0591074>] (reall=
y_probe+0x1e0/0x348)
> [    3.017152] [<c0591074>] (really_probe) from [<c05912e8>] (driver_prob=
e_device+0x5c/0xb4)
> [    3.024081] [<c05912e8>] (driver_probe_device) from [<c05914e0>] (devi=
ce_driver_attach+0x58/0x60)
> [    3.031696] [<c05914e0>] (device_driver_attach) from [<c0591540>] (__d=
river_attach+0x58/0xcc)
> [    3.038966] [<c0591540>] (__driver_attach) from [<c058f418>] (bus_for_=
each_dev+0x64/0x90)
> [    3.045886] [<c058f418>] (bus_for_each_dev) from [<c0590490>] (bus_add=
_driver+0x15c/0x1e0)
> [    3.052892] [<c0590490>] (bus_add_driver) from [<c0591dc4>] (driver_re=
gister+0x7c/0x114)
> [    3.059731] [<c0591dc4>] (driver_register) from [<c0101674>] (do_one_i=
nitcall+0x44/0x194)
> [    3.066696] [<c0101674>] (do_one_initcall) from [<c01946e8>] (do_init_=
module+0x5c/0x220)
> [    3.073568] [<c01946e8>] (do_init_module) from [<c0196a3c>] (load_modu=
le+0x20ec/0x2380)
> [    3.080340] [<c0196a3c>] (load_module) from [<c0196e04>] (sys_init_mod=
ule+0x134/0x154)
> [    3.087020] [<c0196e04>] (sys_init_module) from [<c0100060>] (ret_fast=
_syscall+0x0/0x54)
> [    3.093852] Exception stack(0xc8ea7fa8 to 0xc8ea7ff0)
> [    3.097649] 7fa0:                   00000000 00000000 b6fe2000 00003b1=
4 00031284 00000005
> [    3.104596] 7fc0: 00000000 00000000 b6fe2000 00000080 00052220 be9fd94=
0 00052246 0000002e
> [    3.111626] 7fe0: be9fd79c be9fd780 00015bd0 0001dcf4
> [    3.115468] ---[ end trace df4dd47fb61bf5a4 ]---

In which situation?

> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  include/linux/mfd/sun4i-gpadc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gp=
adc.h
> index ea0ccf33a459..021f820f9d52 100644
> --- a/include/linux/mfd/sun4i-gpadc.h
> +++ b/include/linux/mfd/sun4i-gpadc.h
> @@ -81,8 +81,8 @@
>  #define SUN4I_GPADC_TEMP_DATA				0x20
>  #define SUN4I_GPADC_DATA				0x24
> =20
> -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> +#define SUN4I_GPADC_IRQ_TEMP_DATA			2

Where is it coming from, and why is it the proper fix?

Maxime

--r5ppbdvii7xprh4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX2NiSAAKCRDj7w1vZxhR
xSD8AP9bpGPWJqh8pnE6t5HnhBVupAXPS1emRq7lKK9tb0K1VQEAl3zOD6hInURb
nx2KpOHwex5MPaQetrwQxR6awAbVUww=
=FEwr
-----END PGP SIGNATURE-----

--r5ppbdvii7xprh4y--
