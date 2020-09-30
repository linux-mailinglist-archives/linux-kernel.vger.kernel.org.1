Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0A27EAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgI3OdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:33:18 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46003 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgI3OdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:33:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 628635C018F;
        Wed, 30 Sep 2020 10:33:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 30 Sep 2020 10:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GWP7u+kWdv1v5NzhLEU2DDKql+A
        ucpwhmRs4k+Rbdm8=; b=eEqwifmyON1I6q+pnnmNLYVufp7leD6y4SfFywAioTo
        Pe6CgMOEZo5Byjw7+5A9cRQVM0XgxuJqKsin7KSgtOArXdrTUh+OE15T6wONViCB
        X1DIUiTHvjLxBYhQ4JiOVnHPhn6EK95sUUweNRu+KHzhX8b/Dq1Crgem1C11+YP3
        q6JtbqH4/yh6hlzhOHAo2VhdHzqOSSZJLnFcqoaD/xQCe5TuMPPbswVC0HJ5TNfg
        jtrimikFhIu8iFs3sQ7WunwPKM/ZeEJ6UO5O5sy5qxsEkszNwcLtNA4NSa0pmhmB
        9atH8r40ny9x1i2jxk5pBKZrKvvZ+0zYt47Ynj3B+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GWP7u+
        kWdv1v5NzhLEU2DDKql+AucpwhmRs4k+Rbdm8=; b=BnNRMpXedjAmZA1JPNxJ4M
        QpKF2g81tw2BNWt7YJrYqyEbx2uAK1X+u8Exoayoiqs8DBy56Lk9DS+DXwzBRVdi
        FvdS2tu3sSZrB9u7Y1mtmVwTUCn540OglzF8Ym4H73xhfpK0odKxKkZybkk+AHnb
        5svdmeXSSUWtx1CVioh7Oyr2Vz5+/3sH6Lr5B46UcgeDjhXlJYdvVFWe3xiGMpbT
        ZPqoAEAVSgYgSKH+lckHnwS/6c/qrX8Oxe6BJat6pjiDMajDoddYFLE8EzLtOggu
        RxKKX54G+Qen1ZONUMH7JnxGQkWAAAwi32VEYm6NPYCwLHerkdoSteBjsfWXt5fQ
        ==
X-ME-Sender: <xms:K5d0X8iUofvl1PkyYqOVdMD8541rdQDoJ83npJauweHP3vGPLw1OmQ>
    <xme:K5d0X1Alzi-78g_6g8M1Q46HUyNSgidMXcvJ4rQ5cxTatAnzii1vKvOyFKwW1v_FQ
    2IHxyDRXimZzty1_rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeejtddukeelffetveffuddvkeffffefvddtueevfffgfeeftdelteeuleegfeel
    teenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:K5d0X0EbbE0-iOMQhXXJuuwLBF0NSbuoIYlZty44Ujo7v2uWB1QuPg>
    <xmx:K5d0X9RsU9qBA2Q4fWLUrC2dnR0pYqba785FMY2usc7QeBV-Bo0qfA>
    <xmx:K5d0X5yS_1Boz8rjkEnEhiA5NaFYEvQo5CiF9Ryo2TldzeqmIzts6w>
    <xmx:LJd0Xx-wqkT5C5dVwb5D-p6g_I2jrG-InaMmFlp2l9wre1m8VKIKNw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D353328005E;
        Wed, 30 Sep 2020 10:33:15 -0400 (EDT)
Date:   Wed, 30 Sep 2020 16:33:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: sun4i-gpadc: Interrupt numbers should start from 1
Message-ID: <20200930143313.2zmugpupappqowwg@gilmour.lan>
References: <20200912112200.226530-1-megous@megous.com>
 <20200917131904.d7yqpa2sucerg2nm@gilmour.lan>
 <20200917140117.jowpyurs5pjyr2if@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h4kcnesjnnadqwmg"
Content-Disposition: inline
In-Reply-To: <20200917140117.jowpyurs5pjyr2if@core.my.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h4kcnesjnnadqwmg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 04:01:17PM +0200, Ond=C5=99ej Jirman wrote:
> Hello Maxime,
>=20
> On Thu, Sep 17, 2020 at 03:19:04PM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Sat, Sep 12, 2020 at 01:22:00PM +0200, Ondrej Jirman wrote:
> > > mfd: sun4i-gpadc: Interrupt numbers should start from 1
> >=20
> > Why? An hwirq with 0 is totally fine
> >=20
> > > This avoids a warning:
> > >=20
> > > [    2.891592] ------------[ cut here ]------------
> > > [    2.895052] WARNING: CPU: 0 PID: 149 at drivers/base/platform.c:31=
7 __platform_get_irq_byname+0x7c/0x8c
> > > [    2.903212] usb 1-1: new high-speed USB device number 2 using ehci=
-platform
> > > [    2.908930] 0 is an invalid IRQ number
> > > [    2.911425] Modules linked in: sun4i_gpadc_iio(+) r8188eu(C) lib80=
211 ohci_platform ohci_hcd ehci_platform ehci_hcd cyttsp4_i2c cyttsp_i2c_co=
mmon cyttsp4_core g_cdc usb_f_acm u_serial usb_f_ecm u_ether libcomposite s=
unxi phy_generic musb_hdrc udc_core usbcore sun5ieink
> > > [    2.934048] CPU: 0 PID: 149 Comm: tablet-init Tainted: G         C=
        5.8.0-rc2-00316-gc6a5213fdeba-dirty #8
> > > [    2.943027] Hardware name: Allwinner sun4i/sun5i Families
> > > [    2.947204] [<c010c080>] (unwind_backtrace) from [<c0109ee4>] (sho=
w_stack+0x10/0x14)
> > > [    2.953714] [<c0109ee4>] (show_stack) from [<c012cd04>] (__warn+0x=
c0/0xd8)
> > > [    2.959364] [<c012cd04>] (__warn) from [<c012cda0>] (warn_slowpath=
_fmt+0x84/0x94)
> > > [    2.965599] [<c012cda0>] (warn_slowpath_fmt) from [<c0592a60>] (__=
platform_get_irq_byname+0x7c/0x8c)
> > > [    2.973480] [<c0592a60>] (__platform_get_irq_byname) from [<c0592a=
80>] (platform_get_irq_byname+0x10/0x48)
> > > [    2.981896] [<c0592a80>] (platform_get_irq_byname) from [<bf1142f0=
>] (sun4i_irq_init+0x38/0xe0 [sun4i_gpadc_iio])
> > > [    2.990923] [<bf1142f0>] (sun4i_irq_init [sun4i_gpadc_iio]) from [=
<bf1145cc>] (sun4i_gpadc_probe+0x234/0x308 [sun4i_gpadc_iio])
> > > [    3.001152] [<bf1145cc>] (sun4i_gpadc_probe [sun4i_gpadc_iio]) fro=
m [<c0592edc>] (platform_drv_probe+0x48/0x98)
> > > [    3.010051] [<c0592edc>] (platform_drv_probe) from [<c0591074>] (r=
eally_probe+0x1e0/0x348)
> > > [    3.017152] [<c0591074>] (really_probe) from [<c05912e8>] (driver_=
probe_device+0x5c/0xb4)
> > > [    3.024081] [<c05912e8>] (driver_probe_device) from [<c05914e0>] (=
device_driver_attach+0x58/0x60)
> > > [    3.031696] [<c05914e0>] (device_driver_attach) from [<c0591540>] =
(__driver_attach+0x58/0xcc)
> > > [    3.038966] [<c0591540>] (__driver_attach) from [<c058f418>] (bus_=
for_each_dev+0x64/0x90)
> > > [    3.045886] [<c058f418>] (bus_for_each_dev) from [<c0590490>] (bus=
_add_driver+0x15c/0x1e0)
> > > [    3.052892] [<c0590490>] (bus_add_driver) from [<c0591dc4>] (drive=
r_register+0x7c/0x114)
> > > [    3.059731] [<c0591dc4>] (driver_register) from [<c0101674>] (do_o=
ne_initcall+0x44/0x194)
> > > [    3.066696] [<c0101674>] (do_one_initcall) from [<c01946e8>] (do_i=
nit_module+0x5c/0x220)
> > > [    3.073568] [<c01946e8>] (do_init_module) from [<c0196a3c>] (load_=
module+0x20ec/0x2380)
> > > [    3.080340] [<c0196a3c>] (load_module) from [<c0196e04>] (sys_init=
_module+0x134/0x154)
> > > [    3.087020] [<c0196e04>] (sys_init_module) from [<c0100060>] (ret_=
fast_syscall+0x0/0x54)
> > > [    3.093852] Exception stack(0xc8ea7fa8 to 0xc8ea7ff0)
> > > [    3.097649] 7fa0:                   00000000 00000000 b6fe2000 000=
03b14 00031284 00000005
> > > [    3.104596] 7fc0: 00000000 00000000 b6fe2000 00000080 00052220 be9=
fd940 00052246 0000002e
> > > [    3.111626] 7fe0: be9fd79c be9fd780 00015bd0 0001dcf4
> > > [    3.115468] ---[ end trace df4dd47fb61bf5a4 ]---
> >=20
> > In which situation?
>=20
> During boot.
>=20
> It's a new check added in Linux 5.8. https://elixir.bootlin.com/linux/lat=
est/source/drivers/base/platform.c#L317
>=20
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > ---
> > >  include/linux/mfd/sun4i-gpadc.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4=
i-gpadc.h
> > > index ea0ccf33a459..021f820f9d52 100644
> > > --- a/include/linux/mfd/sun4i-gpadc.h
> > > +++ b/include/linux/mfd/sun4i-gpadc.h
> > > @@ -81,8 +81,8 @@
> > >  #define SUN4I_GPADC_TEMP_DATA				0x20
> > >  #define SUN4I_GPADC_DATA				0x24
> > > =20
> > > -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> > > -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> > > +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> > > +#define SUN4I_GPADC_IRQ_TEMP_DATA			2
> >=20
> > Where is it coming from, and why is it the proper fix?
>=20
> Actual numbers seem irrelevant. It's just an index into this array:
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/mfd/sun4i-gpadc.c#=
L27
>=20
> The array will get sparse, but that doesn't seem like an issue to me,
> because the irq code handles the holes in the list if mask is 0.
>=20
> Not sure it's the best fix.

Explaining all that in the commit log would be great, especially if
you're not sure.

Maxime

--h4kcnesjnnadqwmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3SXKQAKCRDj7w1vZxhR
xRC3AQC73fSoAgVWubv9FUKHBNVqXuEcxqweOKujR6xbEXMnFAEAv63TBysz1CTT
fgAZHC7HKj5gCkIFtGs7jCCZ/Dwnrwg=
=NLAj
-----END PGP SIGNATURE-----

--h4kcnesjnnadqwmg--
