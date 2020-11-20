Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45B02B9F53
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 01:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKTAaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 19:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgKTAaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 19:30:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EFEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:30:00 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so8328793wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tVDijfDshOZ5EX5JCLPn1kfMb9n0yaU32SCV2DQVsFg=;
        b=dC/Qm7TK0SdC/clTSEdXr+ZlvFVP6/r3El7Nj1d85rGH0xWL4QXS/SQmTtEHILh9YP
         YzWHTlI9/+08wfIiXcVSPNk4Oyo0c0oTXUP+OHKR8PC4/+irR6FX3xGZDbucyPxOF6XC
         TFHDhg10JUjzcHvg/NLWA2mBhPB44RbYU+ngMNqwotrIC0P6wSNOs7PArgE0rqkQeEEf
         xLN8Ep0UUjTav28YLp11bWjs8VKmSq8nDgW7v+YXnzQef/BqP0LhqY6fO/aZSiCgz1CQ
         uiIlxdF31UHobu8ieTnDNdtRem1oVC+3+Uz1V9I8Mjl+XxuqdBQgpwmFau0frUlWh56o
         jB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tVDijfDshOZ5EX5JCLPn1kfMb9n0yaU32SCV2DQVsFg=;
        b=DLowmRfmrvsS82fsZAlyVYLtZ/jT9641ybonwvVfWyDiuSiVTudKGZ7yOKVdEZFCbk
         gvSTpLTzarImwJlOWpKXmyz8bgf4z873Dam/NNJ64mflihlzXDTlPlOLmc1nR3tYQUZw
         w+2+Vo7qfoR+c4YjV1bIhgLsZDHpug6VF54M0FBgY3PzSZF5dQHeH+0ys/uibqZVOpHJ
         gUwuhgntiX7vlaoyNN7rykmh/t3aI3fmxWTmkSTPYPdEkXdSZSc4Noks0pvELTaFK0fk
         e8+Q94+oFTskWLcU4IH7ZaSUhj7GwHb/fYAXCQpat3q2q7sT6I9aHVS36ZCXXlvVcYvM
         R66Q==
X-Gm-Message-State: AOAM533IE8VemEcac8umR8ilsU6zlhWjCZA1B53FIXl9SywtiSCzOHi4
        8ZWu68T8ywqka5CEcJRE9HRj2LANAGciWkaM
X-Google-Smtp-Source: ABdhPJyxtKzKptFTtq9dzV6T1By5V/tWzrHZ3dAmfuqSv6J1FS5yP9p5uuDSbEtaaBzYolhgL2Ff7g==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr7044795wmj.109.1605832199186;
        Thu, 19 Nov 2020 16:29:59 -0800 (PST)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id 89sm2554633wrp.58.2020.11.19.16.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 16:29:58 -0800 (PST)
Date:   Fri, 20 Nov 2020 05:29:50 +0500
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Modify horizontal front/back porch
 byte formula
Message-ID: <20201120052950.0ca597fb@a-VirtualBox>
In-Reply-To: <20201119232335.6704-1-chunkuang.hu@kernel.org>
References: <20201119232335.6704-1-chunkuang.hu@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK, 

On Fri, 20 Nov 2020 07:23:35 +0800
Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:

> From: CK Hu <ck.hu@mediatek.com>
> 
> In the patch to be fixed, horizontal_backporch_byte become to large
> for some panel, so roll back that patch. For small hfp or hbp panel,
> using vm->hfront_porch + vm->hback_porch to calculate
> horizontal_backporch_byte would make it negtive, so
> use horizontal_backporch_byte itself to make it positive.
> 
> Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of panel with
> small hfp or hbp")
> 
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 61
> +++++++++++------------------- 1 file changed, 22 insertions(+), 39
> deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c index 4a188a942c38..65fd99c528af
> 100644 --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -444,7 +444,10 @@ static void mtk_dsi_config_vdo_timing(struct
> mtk_dsi *dsi) u32 horizontal_sync_active_byte;
>  	u32 horizontal_backporch_byte;
>  	u32 horizontal_frontporch_byte;
> +	u32 horizontal_front_back_byte;
> +	u32 data_phy_cycles_byte;
>  	u32 dsi_tmp_buf_bpp, data_phy_cycles;
> +	u32 delta;
>  	struct mtk_phy_timing *timing = &dsi->phy_timing;
>  
>  	struct videomode *vm = &dsi->vm;
> @@ -466,50 +469,30 @@ static void mtk_dsi_config_vdo_timing(struct
> mtk_dsi *dsi) horizontal_sync_active_byte = (vm->hsync_len *
> dsi_tmp_buf_bpp - 10); 
>  	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> -		horizontal_backporch_byte = vm->hback_porch *
> dsi_tmp_buf_bpp;
> +		horizontal_backporch_byte = vm->hback_porch *
> dsi_tmp_buf_bpp - 10; else
>  		horizontal_backporch_byte = (vm->hback_porch +
> vm->hsync_len) *
> -					    dsi_tmp_buf_bpp;
> +					    dsi_tmp_buf_bpp - 10;
>  
>  	data_phy_cycles = timing->lpx + timing->da_hs_prepare +
> -			  timing->da_hs_zero + timing->da_hs_exit;
> -
> -	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> -		if ((vm->hfront_porch + vm->hback_porch) *
> dsi_tmp_buf_bpp >
> -		    data_phy_cycles * dsi->lanes + 18) {
> -			horizontal_frontporch_byte =
> -				vm->hfront_porch * dsi_tmp_buf_bpp -
> -				(data_phy_cycles * dsi->lanes + 18) *
> -				vm->hfront_porch /
> -				(vm->hfront_porch + vm->hback_porch);
> -
> -			horizontal_backporch_byte =
> -				horizontal_backporch_byte -
> -				(data_phy_cycles * dsi->lanes + 18) *
> -				vm->hback_porch /
> -				(vm->hfront_porch + vm->hback_porch);
> -		} else {
> -			DRM_WARN("HFP less than d-phy, FPS will
> under 60Hz\n");
> -			horizontal_frontporch_byte =
> vm->hfront_porch *
> -						     dsi_tmp_buf_bpp;
> -		}
> +			  timing->da_hs_zero + timing->da_hs_exit +
> 3; +
> +	delta = dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 :
> 12; +
> +	horizontal_frontporch_byte = vm->hfront_porch *
> dsi_tmp_buf_bpp;
> +	horizontal_front_back_byte = horizontal_frontporch_byte +
> horizontal_backporch_byte;
> +	data_phy_cycles_byte = data_phy_cycles * dsi->lanes + delta;
> +
> +	if (horizontal_front_back_byte > data_phy_cycles_byte) {
> +		horizontal_frontporch_byte -= data_phy_cycles_byte *
> +
> horizontal_frontporch_byte /
> +
> horizontal_front_back_byte; +
> +		horizontal_backporch_byte -= data_phy_cycles_byte *
> +
> horizontal_backporch_byte /
> +
> horizontal_front_back_byte; } else {
> -		if ((vm->hfront_porch + vm->hback_porch) *
> dsi_tmp_buf_bpp >
> -		    data_phy_cycles * dsi->lanes + 12) {
> -			horizontal_frontporch_byte =
> -				vm->hfront_porch * dsi_tmp_buf_bpp -
> -				(data_phy_cycles * dsi->lanes + 12) *
> -				vm->hfront_porch /
> -				(vm->hfront_porch + vm->hback_porch);
> -			horizontal_backporch_byte =
> horizontal_backporch_byte -
> -				(data_phy_cycles * dsi->lanes + 12) *
> -				vm->hback_porch /
> -				(vm->hfront_porch + vm->hback_porch);
> -		} else {
> -			DRM_WARN("HFP less than d-phy, FPS will
> under 60Hz\n");
> -			horizontal_frontporch_byte =
> vm->hfront_porch *
> -						     dsi_tmp_buf_bpp;
> -		}
> +		DRM_WARN("HFP + HBP less than d-phy, FPS will under
> 60Hz\n"); }
>  
>  	writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);

Tested on Chromebook ELM.

Tested-by: Bilal Wasim <bilal.wasim@imgtec.com>

Thanks,
Bilal
