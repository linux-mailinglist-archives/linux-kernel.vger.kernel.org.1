Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711325E5A7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 08:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgIEGCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 02:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgIEGCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 02:02:06 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5190A208DB;
        Sat,  5 Sep 2020 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599285725;
        bh=Baa+vCVEDyUV7eOx+FInEWcsp0zp8TLXiBCsCiQ2+LI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4yabjZ9UashSqLcV2bYmUclpYFvRCHHve59hAcTbNLFiu9oTIKZ0YCtw6HM5spE2
         Qi67m6oMcysjJRCES+Z4Dq05Clh6NA+kkiwv3Xn2W0Hx6M5iNDf3FYxFKzKc0+eTTe
         MYisn8n0ZCjhPrep8J7Stg80DHIDihOvrtAwSJA0=
Date:   Sat, 5 Sep 2020 14:02:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] ARM: dts: imx23: Align GPMI NAND node name with
 schema
Message-ID: <20200905060158.GE7508@dragon>
References: <20200828192037.22897-1-krzk@kernel.org>
 <20200828192037.22897-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828192037.22897-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 09:20:35PM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects NAND controller to be named
> "nand-controller", otherwise dtbs_check complain with a warning like:
> 
>     arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dt.yaml: gpmi-nand@8000c000:
>         $nodename:0: 'gpmi-nand@8000c000' does not match '^nand-controller(@.*)?'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I already applied one patch from Anson [1].

Shawn

[1] https://lkml.org/lkml/2020/7/30/610
