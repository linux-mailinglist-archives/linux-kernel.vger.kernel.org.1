Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C3F28B45C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbgJLMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388209AbgJLMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:07:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2564C0613D0;
        Mon, 12 Oct 2020 05:07:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f21so16953806wml.3;
        Mon, 12 Oct 2020 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyLQqnsPp2QoVdD4Le8oIZ3NiV3JMjhazdAHbl+D9wU=;
        b=ekcRy/FNerrYq8mtZClP73dij3+euY9uxtnkcEGlMlV8MZqFJ2h2HlCRPN7vUpmD+E
         E3EaWddH3zQ5nNyp0FYQrcx3YrR9+HFIzMqwRQNz2j2t2MciWm3Q13tYSlL1u7M9xMSW
         /baaGrFZEiYjDOWq7ANLWzMqDORmEK6+SVqOlO7SDgGlFdUeP5xRztTpvHEp1wAdjAKO
         gkhjI3bbztIsQnnhJL/LcdQzZqfokPcKc8sTB/1egrWEA/y+FtRQZB9cHB8rqOT5t/yp
         txfGLiAcCcb2YklH61lAcf65+RJDa7P8NqcBfPPTFEfaXHED2Bo6//ktag1HY8LIUmYE
         42uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyLQqnsPp2QoVdD4Le8oIZ3NiV3JMjhazdAHbl+D9wU=;
        b=A7CoLdT/vsf76dAG1fzl2V7M5LjsSzMIoksD2lsjwuzXD0D/QRkiPVB4UdNAU572hi
         ngkH6gE/Ldi+bq0yBbKVWkSbzmiQ49/021WojI1WPBpsdAYOPK8Km9u/2sIcoerDLaNi
         wRzDCY6G8HT4JSAXWfgZowhHN1RWboFSw6IdfQ9euXNSZf9ysIJfhXKe2r4QRDgM2qx8
         M27xg+A+pR4eYGWm76b5yutcF/zgBCx3vLhk9AK8yLdONAIIlr9/ksjZ//v9Y/0iIyzx
         yMIUKp1O4BbndoiYgsGW80wz6PPq0yLeDpl4sgkMquIniTRYoGddwECJGKa6OneduQUH
         4YGQ==
X-Gm-Message-State: AOAM531E7WzPSxuG9XnPTUgm/dYUgcbPToNkmxm+owlyS6bBZ3jeP3gg
        Lj9F8DYkoFYlKeaJDBNdU3g=
X-Google-Smtp-Source: ABdhPJwUfj7Av4Hl9jD8LHoYMEWgeUV0AjRwanMiqDbt+5CmZuFGRVLDSBGWKu5ymbYpQDPIw0414w==
X-Received: by 2002:a05:600c:2211:: with SMTP id z17mr6322560wml.92.1602504461204;
        Mon, 12 Oct 2020 05:07:41 -0700 (PDT)
Received: from a-VirtualBox ([103.120.71.253])
        by smtp.gmail.com with ESMTPSA id q4sm24238151wru.65.2020.10.12.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 05:07:40 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:07:30 +0500
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com, linux-mediatek@lists.infradead.org,
        bibby.hsieh@mediatek.com, ck.hu@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] Revert "drm/mediatek: dsi: Fix scrolling of
 panel with small hfp or hbp"
Message-ID: <20201012170730.582d4b96@a-VirtualBox>
In-Reply-To: <20201010070910.11294-2-jitao.shi@mediatek.com>
References: <20201010070910.11294-1-jitao.shi@mediatek.com>
        <20201010070910.11294-2-jitao.shi@mediatek.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao,

On Sat, 10 Oct 2020 15:09:09 +0800
Jitao Shi <jitao.shi@mediatek.com> wrote:

> This reverts commit 35bf948f1edbf507f6e57e0879fa6ea36d2d2930.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c index 80b7a082e874..16fd99dcdacf
> 100644 --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -466,13 +466,14 @@ static void mtk_dsi_config_vdo_timing(struct
> mtk_dsi *dsi) horizontal_sync_active_byte = (vm->hsync_len *
> dsi_tmp_buf_bpp - 10); 
>  	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> -		horizontal_backporch_byte = vm->hback_porch *
> dsi_tmp_buf_bpp;
> +		horizontal_backporch_byte =
> +			(vm->hback_porch * dsi_tmp_buf_bpp - 10);
>  	else
> -		horizontal_backporch_byte = (vm->hback_porch +
> vm->hsync_len) *
> -					    dsi_tmp_buf_bpp;
> +		horizontal_backporch_byte = ((vm->hback_porch +
> vm->hsync_len) *
> +			dsi_tmp_buf_bpp - 10);
>  
>  	data_phy_cycles = timing->lpx + timing->da_hs_prepare +
> -			  timing->da_hs_zero + timing->da_hs_exit;
> +			  timing->da_hs_zero + timing->da_hs_exit +
> 3; 
>  	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
>  		if ((vm->hfront_porch + vm->hback_porch) *
> dsi_tmp_buf_bpp >

Reviewed-by: Bilal Wasim <bilal.wasim@imgtec.com>
Tested-by: Bilal Wasim <bilal.wasim@imgtec.com>

Thanks,
Bilal
