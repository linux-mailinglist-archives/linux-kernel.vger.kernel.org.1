Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C239256C7C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 09:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgH3HLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 03:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgH3HLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:11:09 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219772071B;
        Sun, 30 Aug 2020 07:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598771468;
        bh=3Xp04fQCBetDseOhp7PqyHKiJ9V1Wco1ds3yyNForcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddsuNnL96JPPGZz6yEh+Q0RmwY9Hikl/B5/94oUhtO8GTPgfV28LzPqZ/9rGPQaHZ
         bpuLcjd47X/3QOsVU3QISuqAM6d4kMK+PKEL3GRqstfix/DMxERU7AckBjYC7iGn2d
         32qqeOtJlaWnSIGp8RBqfowq9JEiX4EN8G0wGCIM=
Date:   Sun, 30 Aug 2020 15:11:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] arm64: dts: imx8mm-beacon-som: Align regulator names
 with schema
Message-ID: <20200830071103.GI32096@dragon>
References: <20200823172019.18606-1-krzk@kernel.org>
 <20200823172019.18606-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823172019.18606-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 07:20:17PM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects regulator names to be lowercase.  This fixes
> dtbs_check warnings like:
> 
>     pmic@4b: regulators:LDO1:regulator-name:0: 'LDO1' does not match '^ldo[1-6]$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
