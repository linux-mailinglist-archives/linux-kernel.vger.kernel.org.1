Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D152FE4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbhAUI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:26:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbhAUITz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:19:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65E1723976;
        Thu, 21 Jan 2021 08:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611217141;
        bh=hhhptWrujcElAbSl2ou/FOxBVarF2/4ZICpA78koQKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOSdaqmeY7neZr1NBdUhHGAUKUpB/zX8/VLMLHq0RUKZrQm5L/GslnlEd/F0MmgDs
         KmDJSbUyVPrRRYMjLpHTZFacGkiu2MzPBeB3+ZF/hGQ26lmZlKTazZ/o2LlxuL1E39
         DA0psnM6msta+GWNePYVYBp/ct2i+jmVrMIK399eteygz67RoZmJC+y4azViV7HWQV
         vSzPpc1cJT/RDpgUL4SCbxvsQK27k3yNIIoadcN/3PCMYc1QBowK9ToZ3eru3tWvGG
         oOS/WNXftOI/g647lAalt85eSJoVi4EI92NujfyXHBgXEm3dIzVO55Mbw7q9I2+3rC
         gwZRcTkLQpEFA==
Date:   Thu, 21 Jan 2021 09:18:55 +0100
From:   Matthias Brugger <matthias.bgg@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        CK Hu <ck.hu@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/5] drm/mediatek: Change disp/ddp term to mutex in
 mtk mutex driver
Message-ID: <YAk4722oCzcegGdx@ziggy.stardust>
References: <20210106231729.17173-1-chunkuang.hu@kernel.org>
 <20210106231729.17173-4-chunkuang.hu@kernel.org>
 <YAh2JGUUpMcgyke0@ziggy.stardust>
 <CAAOTY_82Z_DQuJWDD5NMeq35o2Tf-zQzmSxJwRYRRpHQJVHNEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOTY_82Z_DQuJWDD5NMeq35o2Tf-zQzmSxJwRYRRpHQJVHNEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 07:46:44AM +0800, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Matthias Brugger <matthias.bgg@kernel.org> 於 2021年1月21日 週四 上午2:27寫道：
> >
> > On Thu, Jan 07, 2021 at 07:17:27AM +0800, Chun-Kuang Hu wrote:
> > > From: CK Hu <ck.hu@mediatek.com>
> > >
> > > mtk mutex is used by both drm and mdp driver, so change disp/ddp term to
> > > mutex to show that it's a common driver for drm and mdp.
> > >
> > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  30 +--
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |   2 +-
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   2 +-
> > >  drivers/gpu/drm/mediatek/mtk_mutex.c    | 305 ++++++++++++------------
> > >  drivers/gpu/drm/mediatek/mtk_mutex.h    |  26 +-
> > >  5 files changed, 182 insertions(+), 183 deletions(-)
> > >
> > [...]
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.c b/drivers/gpu/drm/mediatek/mtk_mutex.c
> > > index 1c8a253f4788..98a060bf225d 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_mutex.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_mutex.c
> > [...]
> > >
> > > -static const struct of_device_id ddp_driver_dt_match[] = {
> > > +static const struct of_device_id mutex_driver_dt_match[] = {
> > >       { .compatible = "mediatek,mt2701-disp-mutex",
> > > -       .data = &mt2701_ddp_driver_data},
> > > +       .data = &mt2701_mutex_driver_data},
> > >       { .compatible = "mediatek,mt2712-disp-mutex",
> > > -       .data = &mt2712_ddp_driver_data},
> > > +       .data = &mt2712_mutex_driver_data},
> > >       { .compatible = "mediatek,mt8167-disp-mutex",
> > > -       .data = &mt8167_ddp_driver_data},
> > > +       .data = &mt8167_mutex_driver_data},
> > >       { .compatible = "mediatek,mt8173-disp-mutex",
> > > -       .data = &mt8173_ddp_driver_data},
> > > +       .data = &mt8173_mutex_driver_data},
> > >       {},
> > >  };
> > > -MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
> > > +MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
> >
> > I think it would make sense in a follow-up patch to update the binding
> > to use "mediatek,mt2701-mutex" to reflect that mutex is used for drm and
> > mdp driver. Make sense?
> 
> Yes, it make sense. I would try to update the binding, but I wonder
> device tree should be backward compatible? Let's discuss in that
> follow-up patches.
> 

From my understanding, we will need to keep the of_device_id entries for
the old binding in the driver (so that old DTs still work) while we
should enforce the new binding. I'm not sure if the yaml has a option
for out-of-date compatibles.

Regards,
Matthias
