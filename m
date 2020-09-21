Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FB327251A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgIUNKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgIUNJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:09:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6BA21789;
        Mon, 21 Sep 2020 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600693794;
        bh=X8+eZkPCO0dSMkwRqVfpCHg1hSL3BOtJFo3Gz3AeHag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPB+2wuYh52uMUPyI5KZ6Rh461pqaGhZC/UqnAEEugCFp8h7VNjMdFM+pGAqn2LHT
         RX/kUkndIRbikpr9qvbw81pUY4fNfE0v7u8VpXaTpUb5Gj/56rDLlJBFppOzMPdtC8
         NifQCRdVbtsMqvB3Eg1CD4rf3Pt8VgZ1Q4njtn1k=
Date:   Mon, 21 Sep 2020 21:09:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/13] dt-bindings: arm: fsl: Fix matching Purism Librem5
 phones
Message-ID: <20200921130945.GB25428@dragon>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:53:02PM +0200, Krzysztof Kozlowski wrote:
> All Purism Librem5 phones have three compatibles so they need their own
> entry to fix dbts_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: /:
>     compatible: ['purism,librem5r2', 'purism,librem5', 'fsl,imx8mq'] is not valid under any of the given schemas
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: /:
>     compatible: ['purism,librem5r2', 'purism,librem5', 'fsl,imx8mq'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
