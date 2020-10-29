Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3829EE21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgJ2OZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgJ2OXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:23:44 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3CC20780;
        Thu, 29 Oct 2020 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603981423;
        bh=n7Vzz7DHGJA92jHFCsr1m3bLut8N3L+AitzjBOxMqUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcHcQdsE/HW73c5doL7xKii042thmFwirZKPhg7ruozNUR9DzhDJqVui+DREIg0M3
         Ec4f2TxvVN/pGViyORKdUUCfuYwDaBVY6fyT7GJd6feG3zohrmUFM6xAUjf/y+MANf
         9dULdsmCVCBXh6RMwb+Vvz5xSBOEk8w2/IeLE+M0=
Date:   Thu, 29 Oct 2020 22:23:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add Protonic WD3 board
Message-ID: <20201029142337.GN28755@dragon>
References: <20200924045706.23496-1-o.rempel@pengutronix.de>
 <20200924045706.23496-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924045706.23496-2-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 06:57:05AM +0200, Oleksij Rempel wrote:
> Add Protonic Holland WD3 iMX6qp based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

It doesn't seem to apply to v5.10-rc1.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index e94a455eeab9..57dcd061d4c9 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -161,6 +161,7 @@ properties:
>            - enum:
>                - fsl,imx6qp-sabreauto      # i.MX6 Quad Plus SABRE Automotive Board
>                - fsl,imx6qp-sabresd        # i.MX6 Quad Plus SABRE Smart Device Board
> +              - prt,prtwd3                # Protonic WD3 board
>            - const: fsl,imx6qp
>  
>        - description: i.MX6DL based Boards
> -- 
> 2.28.0
> 
