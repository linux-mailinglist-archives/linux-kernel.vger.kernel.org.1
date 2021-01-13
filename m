Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C82F4CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAMOPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbhAMOPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:15:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F52423382;
        Wed, 13 Jan 2021 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610547263;
        bh=KinOGg4lYC7JiS+C8xi7VLcYNovCNiAnNVUNQ8Co1JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z80Gr+ndh4rI8ubn9528SocoZhPoAfJStmr8+b2cuvc8anVEIc8GqbmgQPGcuqmrW
         1nX7EoUMNWhgw0hvsbowht0bL7qUHhBSLcnU0z7azltPvmTUc0AengD64bzQS1SiNq
         erHb3rmDHiaXC3f7CCba0zX8NygU7LcmR29SYH90YAF4NO2gmswABhvlsfziQabkh5
         YvKwLs7pN7Xcsdw+vIOI+2N5CEPbAqXRiJWJLHBU9FOvlr7d8BwluA08kyOX5msKTG
         TtktOXp4o6CMts3QF0Pm2QtGfEW4Fg43rDTWIAaNzbwHFdQu9A6ygl7JtDvZR3Mj4o
         aTXFFrw+MZmPw==
Date:   Wed, 13 Jan 2021 19:44:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, kishon@ti.com, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] phy: mediatek: Mark mtk_mipi_tx_driver with static
 keyword
Message-ID: <20210113141417.GR2771@vkoul-mobl>
References: <1610415484-92497-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610415484-92497-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-01-21, 09:38, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/phy/mediatek/phy-mtk-mipi-dsi.c:237:24: warning: symbol 'mtk_mipi_tx_driver' was not declared. Should it be static?

Applied, thanks

-- 
~Vinod
