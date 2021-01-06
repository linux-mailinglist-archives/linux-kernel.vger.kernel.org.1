Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522892EBAC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbhAFHwK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jan 2021 02:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbhAFHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:52:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E25BC061358
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 23:51:28 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kx3bJ-0008WM-Ld; Wed, 06 Jan 2021 08:51:25 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1kx3bI-0006db-0A; Wed, 06 Jan 2021 08:51:24 +0100
Date:   Wed, 6 Jan 2021 08:51:23 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] ARM: dts: add Protonic MVT board
Message-ID: <20210106075123.dkutuzcycokox2xr@pengutronix.de>
References: <20201201074125.11806-1-o.rempel@pengutronix.de>
 <20201201074125.11806-3-o.rempel@pengutronix.de>
 <20210105023515.GH4142@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210105023515.GH4142@dragon>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:32:25 up 34 days, 21:38, 28 users,  load average: 0.07, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Tue, Jan 05, 2021 at 10:35:17AM +0800, Shawn Guo wrote:
> On Tue, Dec 01, 2020 at 08:41:25AM +0100, Oleksij Rempel wrote:
> > PRTMVT is the reference platform for Protonic industrial touchscreen terminals.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

> > ---
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpiokeys>;
> > +		autorepeat;
> > +
> > +		power {
> > +			label = "Power Button";
> > +			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
> > +			linux,code = <116>; /* KEY_POWER */
> 
> Why not just using defines?

Uff, I didn't noticed there are existing defines. Thx, done.

> > +			wakeup-source;
> > +		};
> > +

> > +	panel {
> > +		compatible = "kyo,tcg070wvlq", "lg,lb070wv8";
> 
> Why do you need two compatibles for a panel?  The first one seems
> undocumented.

kyo,tcg070wvlq seems to be compatible with lg,lb070wv8. Currently there
is no need for driver modification.
The kyo,tcg070wvlq documentation should be added with the patch:
"dt-bindings: display: simple: Add Kyocera tcg070wvlq panel"
https://lkml.org/lkml/2020/12/7/591

> > +		backlight = <&backlight>;
> > +		power-supply = <&reg_3v3>;
> > +	video@5c {
> > +		compatible = "ti,tvp5150";
> > +		reg = <0x5c>;
> > +
> 
> Unnecessary newline.

done

> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		port@0 {
> > +			reg = <0>;
> 
> Have a newline between properties and child node.

done

> > +			tvp5150_comp0_in: endpoint {
> > +				remote-endpoint = <&comp0_out>;
> > +			};
> > +		};
> > +
> > +		/* Output port 2 is video output pad */
> > +		port@2 {
> > +			reg = <2>;
> > +			tvp5151_to_ipu1_csi0_mux: endpoint {
> > +				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
> > +			};
> > +		};
> > +	};
> > +
> > +	gpio_pca: gpio@74 {
> > +		#gpio-cells = <2>;
> 
> We usually begin with 'compatible'.  Can you move this line after
> 'gpio-controller' maybe?

done

Regards,
Oleksij

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
