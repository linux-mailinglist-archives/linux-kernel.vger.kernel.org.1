Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6122D25E5AD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 08:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgIEGLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 02:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEGLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 02:11:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194A8208DB;
        Sat,  5 Sep 2020 06:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599286311;
        bh=CxoKGPqi4I54vbqLyfl1P1Xqg+kyx71MdFE6vDLG0/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrhoEUWFDIw9aRg6gJ43K36qpVmy9VKehFeQoejeMp3cnUjC8U2vqEgNBhyZnWOWV
         blOe2hDbTa6yJdhCqtCJZveZ6EaqCYrNYUEe23WYkJW3a8EbUoOdReaVtowYZVFvxb
         2295tMd6Nj6DyHz//hGMqR+JWlmL91PRkg3lyqEg=
Date:   Sat, 5 Sep 2020 14:11:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/19] arm64: dts: imx8mm-evk: Add 32.768 kHz clock to
 PMIC
Message-ID: <20200905061144.GB9261@dragon>
References: <20200828164750.10377-1-krzk@kernel.org>
 <20200828164750.10377-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828164750.10377-9-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:47:39PM +0200, Krzysztof Kozlowski wrote:
> The ROHM BD71847 PMIC has a 32.768 kHz clock.  Adding necessary parent
> allows to probe the bd718x7 clock driver fixing boot errors:
> 
>     bd718xx-clk bd71847-clk.1.auto: No parent clk found
>     bd718xx-clk: probe of bd71847-clk.1.auto failed with error -22
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
