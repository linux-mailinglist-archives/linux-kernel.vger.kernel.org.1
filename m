Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129A62A6269
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgKDKnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:43:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59190 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgKDKnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:43:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 923391F45919
Subject: Re: [PATCH 0/4] soc: mediatek: Prepare MMSYS for DDP routing using
 tables
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        yongqiang.niu@mediatek.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        chunkuang.hu@kernel.org, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201006193320.405529-1-enric.balletbo@collabora.com>
Message-ID: <e8f42689-4c5f-b5ab-8b4c-ac6b8eafc1d3@collabora.com>
Date:   Wed, 4 Nov 2020 11:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006193320.405529-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 6/10/20 21:33, Enric Balletbo i Serra wrote:
> Dear all,
> 
> The following series are intended to prepare the mtk-mmsys driver to
> allow different DDP (Data Display Path) routing tables per SoC. Note
> that the series has been tested only on MT8173 platform and could break
> the display on MT2701 and MT2712 based devices. I kindly ask for someone
> having these devices to provide a tested routing table (unfortunately I
> didn't have enough documentation to figure out this myself).
> 
> For the other devices (MT8183, MT6779 and MT6797) DRM support is not in
> mainline yet so nothing will break.
> 
> Thanks,
>   Enric
> 
> 
> CK Hu (2):
>   soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
>   soc: mediatek: mmsys: Use an array for setting the routing registers
> 
> Enric Balletbo i Serra (1):
>   soc: mediatek: mmsys: Use devm_platform_ioremap_resource()
> 
> Yongqiang Niu (1):
>   soc / drm: mediatek: Move DDP component defines into mtk-mmsys.h
> 
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  34 +-
>  drivers/soc/mediatek/mtk-mmsys.c            | 429 +++++++++++---------
>  include/linux/soc/mediatek/mtk-mmsys.h      |  33 ++
>  3 files changed, 263 insertions(+), 233 deletions(-)
> 

Although the patches 3 and 4 are controversial, and I'll work on it, I am
wondering if 1 and 2 are ready to be picked, as they are independent, so I can
send next version without these two patches.

Thanks,
  Enric


