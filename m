Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA32F4C38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAMN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:29:24 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351BAC061575;
        Wed, 13 Jan 2021 05:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fDTzPVsusqqNb+UjQ3U/650zEJNlqvyc2aW80fen0XM=; b=VTytTywWCHvBpiQYsW3AwNLBZS
        aZKTx9c8oaURxLoQm1jtgK/hxaO0qWKO5qbNZOS5RYyt1mlu3ZyWsAXH9H0bp2a0HmQYJBLfMjsyW
        a5CmngI+WIPUTER7tjdxfjCyZ/3pOCb4bySdye33HN6wcLq87aySM1hjVXiQLE7mFfNU=;
Received: from p200300ccff0ba2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:a200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kzgCP-0005hK-8h; Wed, 13 Jan 2021 14:28:33 +0100
Date:   Wed, 13 Jan 2021 14:28:32 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 3/4] ARM: dts: imx6sl-tolino-shine2hd: correct console
 uart pinmux
Message-ID: <20210113142832.02a0184f@aktux>
In-Reply-To: <20210112231549.29957-4-andreas@kemnade.info>
References: <20210112231549.29957-1-andreas@kemnade.info>
        <20210112231549.29957-4-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore, that was accidentially sent.

On Wed, 13 Jan 2021 00:15:47 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> Configuration was correct enough to work with the pre-configuration done by
> uboot. While at it, also document the location.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> index 27143ea0f0f1..62d2ebda04ff 100644
> --- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> @@ -156,7 +156,7 @@
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
> -			MX6SL_PAD_UART1_RXD__UART1_TX_DATA 0x1b0b1
> +			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
>  		>;  
>  	};
>  

