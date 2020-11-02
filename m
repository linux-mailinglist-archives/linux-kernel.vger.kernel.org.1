Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8742A2611
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgKBIZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgKBIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:25:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD6C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 00:25:52 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kZV9w-0001hy-0o; Mon, 02 Nov 2020 09:25:48 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1kZV9v-0008WE-KY; Mon, 02 Nov 2020 09:25:47 +0100
Date:   Mon, 2 Nov 2020 09:25:47 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] ARM: dts: imx7-mba7: add default SPI-NOR flash
 partition layout
Message-ID: <20201102082547.qbo2pu2lgjzf43bp@pengutronix.de>
References: <20201030102636.16476-1-matthias.schiffer@ew.tq-group.com>
 <20201030102636.16476-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030102636.16476-2-matthias.schiffer@ew.tq-group.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:24:57 up 352 days, 23:43, 378 users,  load average: 0.25, 0.09,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 20-10-30 11:26, Matthias Schiffer wrote:
> Add the partition layout also used by the bootloader.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  arch/arm/boot/dts/imx7-mba7.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> v2: no changes
> 
> 
> diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
> index c6d1c63f7905..3683f97f946f 100644
> --- a/arch/arm/boot/dts/imx7-mba7.dtsi
> +++ b/arch/arm/boot/dts/imx7-mba7.dtsi
> @@ -237,6 +237,38 @@
>  	};
>  };
>  
> +&flash0 {

Please see my other email about how to add paritions nowadays.

Regards,
  Marco

> +	uboot@0 {
> +		label = "U-Boot";
> +		reg = <0x0 0xd0000>;
> +	};
> +
> +	env1@d0000 {
> +		label = "ENV1";
> +		reg = <0xd0000 0x10000>;
> +	};
> +
> +	env2@e0000 {
> +		label = "ENV2";
> +		reg = <0xe0000 0x10000>;
> +	};
> +
> +	dtb@f0000 {
> +		label = "DTB";
> +		reg = <0xf0000 0x10000>;
> +	};
> +
> +	linux@100000 {
> +		label = "Linux";
> +		reg = <0x100000 0x700000>;
> +	};
> +
> +	rootfs@800000 {
> +		label = "RootFS";
> +		reg = <0x800000 0x3800000>;
> +	};
> +};
> +
>  &flexcan1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan1>;
> -- 
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
