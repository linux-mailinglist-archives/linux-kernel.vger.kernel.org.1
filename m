Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8582B4C07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbgKPRCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbgKPRCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:02:10 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A00D20773;
        Mon, 16 Nov 2020 17:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605546129;
        bh=sjsgvMvmWPSA42bGQv2E5V5KDnWxlKmweJPO9rn0BZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUa0YacAvfU0kutshUvy9FewSasPp6e2WQohFGcTY9mdgAnplDHwyEuGxl2k6btHK
         eHUX57VzyTaL1l/fRJBh1KmDXpbKtr7b/l8RFOq0GNV2ZJ/WqQfDmXBMvdiDP2+k6a
         N5GdV9zFBHROLPcs/fVuNby5Pe/m6CV4rEy0ttAc=
Date:   Mon, 16 Nov 2020 22:32:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 2/3] phy: mediatek: Move mtk_mipi_dsi_phy driver into
 drivers/phy/mediatek folder
Message-ID: <20201116170205.GV7499@vkoul-mobl>
References: <20201029152702.533-1-chunkuang.hu@kernel.org>
 <20201029152702.533-3-chunkuang.hu@kernel.org>
 <1604039049.31607.13.camel@mhfsdcap03>
 <CAAOTY_8Nf=Lh_JDojKY3oHdTigO=i+BHuvVA+9hYXCzgu-2Cfg@mail.gmail.com>
 <20201116072554.GH7499@vkoul-mobl>
 <CAAOTY_8SyT87bSAmdrhwnEzRO_Yt0BQtDWnPrPahg4qTrUq1zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOTY_8SyT87bSAmdrhwnEzRO_Yt0BQtDWnPrPahg4qTrUq1zQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-20, 00:17, Chun-Kuang Hu wrote:
> Hi, Vinod:
> 
> Vinod Koul <vkoul@kernel.org> 於 2020年11月16日 週一 下午3:25寫道：
> >
> > On 02-11-20, 07:08, Chun-Kuang Hu wrote:
> > > + Vinod:
> > >
> > > Hi, Chunfeng:
> > >
> > > Chunfeng Yun <chunfeng.yun@mediatek.com> 於 2020年10月30日 週五 下午2:24寫道：
> > > >
> > > > On Thu, 2020-10-29 at 23:27 +0800, Chun-Kuang Hu wrote:
> > > > > mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, but it's
> > > > > more suitable to place a phy driver into phy driver folder, so move
> > > > > mtk_mipi_dsi_phy driver into phy driver folder.
> > > > >
> > > > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > > ---
> > > > >  drivers/gpu/drm/mediatek/Kconfig                           | 7 -------
> > > > >  drivers/gpu/drm/mediatek/Makefile                          | 6 ------
> > > > >  drivers/phy/mediatek/Kconfig                               | 7 +++++++
> > > > >  drivers/phy/mediatek/Makefile                              | 5 +++++
> > > > >  .../mediatek/phy-mtk-mipi-dsi-mt8173.c}                    | 2 +-
> > > > >  .../mediatek/phy-mtk-mipi-dsi-mt8183.c}                    | 2 +-
> > > > >  .../mtk_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi.c}      | 2 +-
> > > > >  .../mtk_mipi_tx.h => phy/mediatek/phy-mtk-mipi-dsi.h}      | 0
> > > > >  8 files changed, 15 insertions(+), 16 deletions(-)
> > > > >  rename drivers/{gpu/drm/mediatek/mtk_mt8173_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi-mt8173.c} (99%)
> > > > >  rename drivers/{gpu/drm/mediatek/mtk_mt8183_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi-mt8183.c} (99%)
> > > > >  rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.c => phy/mediatek/phy-mtk-mipi-dsi.c} (99%)
> > > > >  rename drivers/{gpu/drm/mediatek/mtk_mipi_tx.h => phy/mediatek/phy-mtk-mipi-dsi.h} (100%)
> > > >
> > > > Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > >
> > > I would like to apply the whole series into my tree, would you please
> > > give an acked-by tag on this patch, so I could apply this patch into
> > > my tree.
> >
> > I would prefer this to go thru phy tree, unless there are dependencies,
> > which I am not clear looking at above
> >
> 
> Please apply this series to phy tree, and I would drop this series
> from my tree, thanks.

Okay sure, just realized I dont have this in my inbox, can you please
repost

-- 
~Vinod
