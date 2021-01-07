Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625862EC876
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbhAGDAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbhAGDAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:00:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54E54230F9;
        Thu,  7 Jan 2021 02:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609988380;
        bh=OsnvSSsdTdrxzJjwLSUTOlqtS0pJP+3VWb4gcyzgqNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcSt8GW9BgzM3/AhYj28ls235QGX+2zc0qANZYNHtXzTMJ4bX+7CjSyItES6xxlwB
         Ue4xajhKZ8oC2NzwAf/PX8YtNrw9iHokPoRR99yiqnx9WDqmP8Zs5qw+aEGXaFbcZJ
         1H7RKrp1YmPjQmx2JDDc0HLiOpFrhiQgCH/13LjqTD6Mu54aBT7RBotVT7MjHBbLfB
         tF8qpXXx12IplWHTqzCrpkMb9+f1NCJaqTc6bnWeHqh9gIcqF8dLMDVVevxaO+/0oi
         qwvXbohNfdZX3TAs+ERYSWF+1zlYdmnKO7+ZoUhcIttrvWORh3IgZ68C/QZlZFZsUZ
         VSpPaYi/G+YIQ==
Date:   Thu, 7 Jan 2021 10:59:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Message-ID: <20210107025933.GP4142@dragon>
References: <1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:53:24PM +0800, Shengjiu Wang wrote:
> Error log:
> sysfs: cannot create duplicate filename '/bus/platform/devices/30000000.bus'
> 
> The spba bus name is duplicate with aips bus name.
> Refine spba bus name to fix this issue.
> 
> Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
