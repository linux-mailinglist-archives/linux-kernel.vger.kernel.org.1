Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C751A2C8248
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgK3KfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgK3KfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:35:06 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1B320708;
        Mon, 30 Nov 2020 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606732466;
        bh=cd7xzSNXU4GZ6Gqay09NnkHkMf3Per69FTphsUamKNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gL41pa0T8tfuA6jEkcmcf5863usEzbgjoNyoy4QCfSPq8IlTI1eLuYGWBunii+YN7
         CX+JJOiUPFp8h9TrFoo5HvK4bebXJz86csJ9pzAMgRAOXRcFz0u0T5M9NH3j2jUmhJ
         DxnGMXjGqekR98uLejLgbmBsdaNspMLdATJYPgIs=
Date:   Mon, 30 Nov 2020 16:04:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [RESEND PATCH 2/3] phy: mediatek: Move mtk_mipi_dsi_phy driver
 into drivers/phy/mediatek folder
Message-ID: <20201130103411.GN8403@vkoul-mobl>
References: <20201116231407.94-1-chunkuang.hu@kernel.org>
 <20201116231407.94-3-chunkuang.hu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116231407.94-3-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-20, 07:14, Chun-Kuang Hu wrote:
> mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, but it's
> more suitable to place a phy driver into phy driver folder, so move
> mtk_mipi_dsi_phy driver into phy driver folder.

Acked-By: Vinod Koul <vkoul@kernel.org>

I am thinking this would go thru drm-tree, if not let me know I would
apply this

-- 
~Vinod
