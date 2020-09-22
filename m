Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0E273B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgIVGmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgIVGmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:42:46 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A7F622574;
        Tue, 22 Sep 2020 06:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600756966;
        bh=TcwjS0gIeYfzWZ2jhdKwHpOurpIu5QsxB1wZVZCTl64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSCuIO+Sc9eIcJt7nX0HE2t+xttbmPP3iuBTu9pzhLAvXWTLBx1YhSpkU5rTDAeYq
         x9tHxLQTrCyxv5cDvh+Lafoy9H2BnSBOxroFB1UXSXDVxG2zK8nto+E6Vpl/9wWY8k
         OvoGG3Ha2Ur0G3SZTQgDtPCrYkVs2H0dIq1EQtMw=
Date:   Tue, 22 Sep 2020 14:42:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-var-som-symphony: Drop wake-up source
 from RTC
Message-ID: <20200922064232.GF25109@dragon>
References: <20200919140647.4373-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919140647.4373-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 04:06:47PM +0200, Krzysztof Kozlowski wrote:
> The RTC on Symphony board does not have its interrupt pin connected to
> the SoC, therefore it is not capable of waking up.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
