Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C233C256C80
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgH3HLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 03:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgH3HLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:11:25 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF1232071B;
        Sun, 30 Aug 2020 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598771485;
        bh=z26ZIjjrgIWGgAHN91oGteRaMSFoellnggM3wQYuVMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfko7D3jLQJDizxGNK74O+ZG7yNe1hpIkNLAaB4Q7NsWyyOz7bReCbSAc5ALf/HEW
         p1f89qj/G0GdTHulSLl8HJpBwuSiWxnhmbdqw2e82T8lu/fpDlCShUX8o2PudnuZA6
         UIf492muLhohHX6Hz5RKGxkt5MJ/5UFcOvE0JcVc=
Date:   Sun, 30 Aug 2020 15:11:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] arm64: dts: imx8mm-beacon-som: Fix atmel,24c64
 EEPROM compatible
Message-ID: <20200830071119.GJ32096@dragon>
References: <20200823172019.18606-1-krzk@kernel.org>
 <20200823172019.18606-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823172019.18606-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 07:20:18PM +0200, Krzysztof Kozlowski wrote:
> Correct the EEPROM node compatible to match device tree schema (invalid
> space, unknown ID) to fix dtbs_check warnings:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: eeprom@50:
>     compatible: ['microchip, at24c64d', 'atmel,24c64'] is not valid under any of the given schemas
>   arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: eeprom@50:
>     compatible:0: 'microchip, at24c64d' does not match '^[a-zA-Z][a-zA-Z0-9,+\\-._]+$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
