Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01A2272B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgIUQPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgIUQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:15:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AB8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:15:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so77836wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rSiDIY+mBJXBx7mTEaoU7iUTrz5OuKwc6R4EdUzPFxQ=;
        b=FOlph9vPpLg7Qs+DqdBZs6dhzlOsW8G8sPt/Z6iDZR/iwWMXUgsTrrH3+DFfed2ptg
         MC5qh32BgeRFrVp9mhJlRPwwUz7WgpXOanAvIdJ7j/SILhqQsIbmU8sHwMztmh/TFMdP
         xBGQ5NvApAIYmRg/3VRdJLA+dFtDyyyN5bv/Ohx/txkS1JGzzV0eE+yVJ5M0GWYhFnnQ
         r0uxV5VwalBiNRhOL0MCCmDu3zGmuN0mOVTanH2+goKU9Mt8o8W+TFrCj4BNEYufNQJv
         h7E/bGoHIqh6xxr1XJrrR60bNcSqOS8bQiENjSFd7WAESx7ehqia4nVncKDqlxbOG0XZ
         BQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rSiDIY+mBJXBx7mTEaoU7iUTrz5OuKwc6R4EdUzPFxQ=;
        b=ZPx7pBDfzqD3B0AVLktxxFJZQn8lM81Q1pb/yn5Y+2+2It/cr1iQ20nR1/N318dniG
         3vDcIkFAavFDoFk3u+8SLnVYIg+VHbNRxOMinTNNPlAarn1c0Uu6C+94MvIj3KF5yahU
         6/1gpjt3y3xDVEzbYWXEsPsPlwt+WFgH5ZyLX5Q2iMQ6PdVsz6Igm7w49lfMYSw/BmVJ
         Ly0RdHx+9MtfF6KdjgerN2fWK197IEg6LvU2SFE/wxyprzhTBnWGN1unSSJ7BW1adQT4
         HPu93sRHAjYSzRJz1KdCtJ/WYXQD/+V0N3ncktENhnPCfn5QdJ7ME+OREMg8QqY+Z+v7
         90sg==
X-Gm-Message-State: AOAM532NkJzHY7LGhRvleNBovF1d47liPRdG5d/GC6UhAHxufCrjwxuZ
        MEG24PI3ZaBMl/JWjhvR/9Q=
X-Google-Smtp-Source: ABdhPJyObcKg6ezQrEsMRRb/qsn7AmBo/RdJ+Ov0IeCGrXN1B6RC1FB4M7qxxPKQXjkiuh0Debuv3w==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr134592wmg.33.1600704920224;
        Mon, 21 Sep 2020 09:15:20 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id i26sm115868wmb.17.2020.09.21.09.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:15:19 -0700 (PDT)
Subject: Re: [PATCH v3 1/9] soc: mediatek: cmdq: add address shift in jump
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, HS Liao <hs.liao@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1594136714-11650-2-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <ddfff699-0ff7-4c15-4449-d6229c046142@gmail.com>
Date:   Mon, 21 Sep 2020 18:15:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1594136714-11650-2-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 17:45, Dennis YC Hsieh wrote:
> Add address shift when compose jump instruction
> to compatible with 35bit format.
> 
> Change since v1:
> - Rename cmdq_mbox_shift() to cmdq_get_shift_pa().
> 
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>

Now pushed to v5.9-next/soc

Thanks!

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index dc644cfb6419..9faf78fbed3a 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -329,7 +329,8 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   
>   	/* JUMP to end */
>   	inst.op = CMDQ_CODE_JUMP;
> -	inst.value = CMDQ_JUMP_PASS;
> +	inst.value = CMDQ_JUMP_PASS >>
> +		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
>   	err = cmdq_pkt_append_command(pkt, inst);
>   
>   	return err;
> 
