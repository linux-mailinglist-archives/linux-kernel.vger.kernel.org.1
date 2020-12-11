Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548002D7294
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437273AbgLKJEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:04:32 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34427 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437181AbgLKJEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:04:22 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 919B15C00F8;
        Fri, 11 Dec 2020 04:03:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 11 Dec 2020 04:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=r8zaeCBSKZRPwIsgOSEYoCgXWUd
        YYNsh9tfgFaM/8tk=; b=lcKIYnwl7T/NM/FbTOyWqym3FHxymgaia/sKXEve6vx
        lND7w6lePyjP94QmB7MGt+gNXOkmoMpXNAoTznDv/GS4r7tje8mqMt7ue5F7o696
        mwojGBX5rnp2LrTOy3FaWFceydg8s2lYcm6siNc0jGWGNRf1gYgvdaXmDD/rhc7s
        CAaxu+cIHiwXkdD9u4Gu2dwYKBn/Z+V8avo1UbOlTgl+XWB9nFSQeKNhwmonS+MW
        HuZmhIRdXPLpaCHDz+YuU9yKt1vdmORvI4C/A90sU3rSfDzh2pr/CHwsdQJ/WFmf
        glMe9UR5lPvUrBwiw6CghC2lRLEGPpdN6W34jk8Dsgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=r8zaeC
        BSKZRPwIsgOSEYoCgXWUdYYNsh9tfgFaM/8tk=; b=j6F8vOBE37WZeSlI1MEms+
        GEjMfDdX/XFUEQcvALInL37ocPdhmhgM4g7jjtj/vL0//pJlyUHdcPQinqN4jEA9
        Kh6ZSw7zlXPQ2d6SdZNu3K81gf+BxK6x4my7KjmKdasRYZpoaIP/3uACbQywOWjB
        4mjD4lyDSjmN4716Jw6zJbkAhdIMPfHUOPU0CgjoTXxy0rAJUCcpsaw4mv1pasKl
        yH8Yqd2YLbwOomB1cPLkZKMtxQA5Ass4uAJ/rALsC1LqvbC736slCmsAv58t08zK
        S/2m0KWCbIzKju1otfcK+sjpXo1rFuioaJRSVY+qXQX9JMPC9XqhsC8GkgENew+Q
        ==
X-ME-Sender: <xms:0jXTX77meg9LocayTWtwAiARwFoowF33bUBsxEo9AxM7TZRYqOYTJw>
    <xme:0jXTXw4PwcUtl8KKdbeu1fXleTulTiRpCftvOIYIcGYaY1Y4FR0G5ocoA38BEf_9z
    9rwxvqC81VA91Grb_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0jXTXydVAqPDzwSa3GJK42QmjhwZ6fLY15KThpxuc4vK3KcLzur13Q>
    <xmx:0jXTX8K3VhfOfAbaq89mlEfUj3U989VIiQ_VwnYJPG0JjAQgLxgK4A>
    <xmx:0jXTX_JNILhuN08-E29Q459Rgin3AaeK2643VmbPKuWShSVzxLfOxg>
    <xmx:0zXTX1g97ojXqyzkruzI7zDStYqZEgY7G26lzJ3a1Qg-eXFNsyETtA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 470DC24005D;
        Fri, 11 Dec 2020 04:03:14 -0500 (EST)
Date:   Fri, 11 Dec 2020 10:03:12 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v4 2/2] hwspinlock: add sun8i hardware spinlock support
Message-ID: <20201211090312.6vo74loepi2avmy7@gilmour>
References: <cover.1607674518.git.wilken.gottwalt@posteo.net>
 <e374bc4212fa316a68b88bd17f5722387f88f332.1607674518.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ik7o7qzlkstnvdsp"
Content-Disposition: inline
In-Reply-To: <e374bc4212fa316a68b88bd17f5722387f88f332.1607674518.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ik7o7qzlkstnvdsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 11, 2020 at 09:24:15AM +0100, Wilken Gottwalt wrote:
> Adds the sun8i_hwspinlock driver for the hardware spinlock unit found in
> most of the sun8i compatible SoCs.
>=20
> This unit provides at least 32 spinlocks in hardware. The implementation
> supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> reading a register and released by writing a 0 to it. This driver
> supports all 4 spinlock setups, but for now only the first setup (32
> locks) seem to exist in available devices. This spinlock unit is shared
> between all ARM cores and the embedded OpenRisc AR100 core. All of them
> can take/release a lock with a single cycle operation. It can be used to
> sync access to devices shared by the ARM cores and the OpenRisc core.
>=20
> There are two ways to check if a lock is taken. The first way is to read
> a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> is returned, the caller has to try again. Which means the lock is taken.
> The second way is to read a 32bit wide status register where every bit
> represents one of the 32 first locks. According to the datasheets this
> status register supports only the 32 first locks. This is the reason the
> first way (lock read/write) approach is used to be able to cover all 256
> locks in future devices. The driver also reports the amount of supported
> locks via debugfs.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v4:
>   - further simplified driver
>   - fixed an add_action_and_reset_ function issue
>   - changed bindings from sun8i-hwspinlock to sun8i-a33-hwspinlock
>=20
> Changes in v3:
>   - moved test description to cover letter
>   - changed name and symbols from sunxi to sun8i
>   - improved driver description
>   - further simplified driver
>   - fully switched to devm_* and devm_add_action_* functions
>=20
> Changes in v2:
>   - added suggestions from Bjorn Andersson and Maxime Ripard
>   - provided better driver and test description
> ---
>  MAINTAINERS                           |   6 +
>  drivers/hwspinlock/Kconfig            |   9 ++
>  drivers/hwspinlock/Makefile           |   1 +
>  drivers/hwspinlock/sun8i_hwspinlock.c | 197 ++++++++++++++++++++++++++
>  4 files changed, 213 insertions(+)
>  create mode 100644 drivers/hwspinlock/sun8i_hwspinlock.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebe4829cdd4d..46846113f1eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -722,6 +722,12 @@ L:	linux-crypto@vger.kernel.org
>  S:	Maintained
>  F:	drivers/crypto/allwinner/
> =20
> +ALLWINNER HARDWARE SPINLOCK SUPPORT
> +M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> +F:	drivers/hwspinlock/sun8i_hwspinlock.c
> +
>  ALLWINNER THERMAL DRIVER
>  M:	Vasily Khoruzhick <anarsoul@gmail.com>
>  M:	Yangtao Li <tiny.windzz@gmail.com>
> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> index 32cd26352f38..b03fd99aab32 100644
> --- a/drivers/hwspinlock/Kconfig
> +++ b/drivers/hwspinlock/Kconfig
> @@ -55,6 +55,15 @@ config HWSPINLOCK_STM32
> =20
>  	  If unsure, say N.
> =20
> +config HWSPINLOCK_SUN8I
> +	tristate "SUN8I Hardware Spinlock device"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	help
> +	  Say y here to support the SUN8I Hardware Spinlock device which can be
> +	  found in most of the sun8i compatible Allwinner SoCs.
> +
> +	  If unsure, say N.
> +
>  config HSEM_U8500
>  	tristate "STE Hardware Semaphore functionality"
>  	depends on ARCH_U8500 || COMPILE_TEST
> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
> index ed053e3f02be..3496648d9257 100644
> --- a/drivers/hwspinlock/Makefile
> +++ b/drivers/hwspinlock/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+=3D qcom_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SIRF)		+=3D sirf_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SPRD)		+=3D sprd_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_STM32)		+=3D stm32_hwspinlock.o
> +obj-$(CONFIG_HWSPINLOCK_SUN8I)		+=3D sun8i_hwspinlock.o
>  obj-$(CONFIG_HSEM_U8500)		+=3D u8500_hsem.o
> diff --git a/drivers/hwspinlock/sun8i_hwspinlock.c b/drivers/hwspinlock/s=
un8i_hwspinlock.c
> new file mode 100644
> index 000000000000..878dae6f1763
> --- /dev/null
> +++ b/drivers/hwspinlock/sun8i_hwspinlock.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * sun8i_hwspinlock.c - hardware spinlock driver for sun8i compatible Al=
lwinner SoCs
> + * Copyright (C) 2020 Wilken Gottwalt <wilken.gottwalt@posteo.net>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/errno.h>
> +#include <linux/hwspinlock.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "hwspinlock_internal.h"
> +
> +#define DRIVER_NAME		"sun8i_hwspinlock"
> +
> +#define SPINLOCK_BASE_ID	0 /* there is only one hwspinlock device per So=
C */
> +#define SPINLOCK_SYSSTATUS_REG	0x0000
> +#define SPINLOCK_LOCK_REGN	0x0100
> +#define SPINLOCK_NOTTAKEN	0
> +
> +struct sun8i_hwspinlock_data {
> +	struct hwspinlock_device *bank;
> +	struct reset_control *reset;
> +	struct clk *ahb_clk;
> +	struct dentry *debugfs;
> +	int nlocks;
> +};
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static int hwlocks_supported_show(struct seq_file *seqf, void *unused)
> +{
> +	struct sun8i_hwspinlock_data *priv =3D seqf->private;
> +
> +	seq_printf(seqf, "%d\n", priv->nlocks);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(hwlocks_supported);
> +
> +static void sun8i_hwspinlock_debugfs_init(struct sun8i_hwspinlock_data *=
priv)
> +{
> +	priv->debugfs =3D debugfs_create_dir(DRIVER_NAME, NULL);

debugfs_create_dir can return an error pointer, you should check that
and return the error code if it does

> +	debugfs_create_file("supported", 0444, priv->debugfs, priv, &hwlocks_su=
pported_fops);

And debugfs_create_file can fail as well

> +}
> +
> +#else
> +
> +static void sun8i_hwspinlock_debugfs_init(struct sun8i_hwspinlock_data *=
priv)
> +{
> +}
> +
> +#endif
> +
> +static int sun8i_hwspinlock_trylock(struct hwspinlock *lock)
> +{
> +	void __iomem *lock_addr =3D lock->priv;
> +
> +	return (readl(lock_addr) =3D=3D SPINLOCK_NOTTAKEN);
> +}
> +
> +static void sun8i_hwspinlock_unlock(struct hwspinlock *lock)
> +{
> +	void __iomem *lock_addr =3D lock->priv;
> +
> +	writel(SPINLOCK_NOTTAKEN, lock_addr);
> +}
> +
> +static const struct hwspinlock_ops sun8i_hwspinlock_ops =3D {
> +	.trylock	=3D sun8i_hwspinlock_trylock,
> +	.unlock		=3D sun8i_hwspinlock_unlock,
> +};
> +
> +static void sun8i_hwspinlock_disable(void *data)
> +{
> +	struct sun8i_hwspinlock_data *priv =3D data;
> +
> +	debugfs_remove_recursive(priv->debugfs);
> +	reset_control_assert(priv->reset);
> +	clk_disable_unprepare(priv->ahb_clk);
> +}
> +
> +static int sun8i_hwspinlock_probe(struct platform_device *pdev)
> +{
> +	struct sun8i_hwspinlock_data *priv;
> +	struct hwspinlock *hwlock;
> +	void __iomem *io_base;
> +	u32 num_banks;
> +	int err, i;
> +
> +	io_base =3D devm_platform_ioremap_resource(pdev, SPINLOCK_BASE_ID);
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->ahb_clk =3D devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(priv->ahb_clk)) {
> +		err =3D PTR_ERR(priv->ahb_clk);
> +		dev_err(&pdev->dev, "unable to get AHB clock (%d)\n", err);
> +		return err;
> +	}
> +
> +	priv->reset =3D devm_reset_control_get(&pdev->dev, "ahb");
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->reset),
> +				     "unable to get reset control\n");
> +
> +	err =3D reset_control_deassert(priv->reset);
> +	if (err) {
> +		dev_err(&pdev->dev, "deassert reset control failure (%d)\n", err);
> +		return err;
> +	}
> +
> +	err =3D clk_prepare_enable(priv->ahb_clk);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to prepare AHB clk (%d)\n", err);
> +		return err;
> +	}
> +
> +	sun8i_hwspinlock_debugfs_init(priv);
> +
> +	err =3D devm_add_action_or_reset(&pdev->dev, sun8i_hwspinlock_disable, =
priv);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to add disable action\n");
> +		return err;
> +	}

That part still doesn't really work: if clk_prepare_enable fails, you'll
end up removing the debugfs files that haven't been added yet, and
you'll disable the clock that hasn't been enabled.

I'm not sure you need to be that smart: just add a label and a goto to
the proper cleaning stuff

Maxime

--ik7o7qzlkstnvdsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9M10AAKCRDj7w1vZxhR
xcQsAQDN0iHWmue1X4QqO9tctrRjNKZeka8KF/9E5HOKsgzkyAD9GUfRaRHzow8E
obzW14nZes+1Gx+Wmsvu2TTI2pNesAA=
=ubQj
-----END PGP SIGNATURE-----

--ik7o7qzlkstnvdsp--
