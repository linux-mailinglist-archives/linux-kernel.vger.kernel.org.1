Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB67269161
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgINQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:23:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35534 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgINQUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:20:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600100416; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=F5bs4rBvHEZe+ElUCrFGBZzrwjt5Km+YdDRv7em3208=; b=ZjXTnJ2wiGneUc9ot2dmiN0+rsTaaZA84TMwiDkZeBi+uAPM7lwpXGbONASDhrN0NR/Q0WlV
 JqDARVsyK/ZeYBGCVPX025TAb5SZtD1M0jf7ivnKrnOxbCBURuF9VNZIq3v8XgRX5wrtqkcH
 TGy+PlSgpQO66my1vljHK7CDg18=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f5f983f9bdf68cc03a98b4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 16:20:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C84C6C43385; Mon, 14 Sep 2020 16:20:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4875C433F0;
        Mon, 14 Sep 2020 16:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4875C433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 14 Sep 2020 10:20:10 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, smasetty@codeaurora.org,
        jonathan@marek.ca, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/a6xx: fix a potential overflow issue
Message-ID: <20200914162010.GB15060@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, smasetty@codeaurora.org,
        jonathan@marek.ca, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20200912102558.656-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912102558.656-1-zhenzhong.duan@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 06:25:58PM +0800, Zhenzhong Duan wrote:
> It's allocating an array of a6xx_gpu_state_obj structure rathor than
> its pointers.
> 
> This patch fix it.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>

LGTM but should have a Fixes: tag for the stable trees

Fixes: d6852b4b2d01 ("drm/msm/a6xx: Track and manage a6xx state memory")
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index b12f5b4..e9ede19 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -875,7 +875,7 @@ static void a6xx_get_indexed_registers(struct msm_gpu *gpu,
>  	int i;
>  
>  	a6xx_state->indexed_regs = state_kcalloc(a6xx_state, count,
> -		sizeof(a6xx_state->indexed_regs));
> +		sizeof(*a6xx_state->indexed_regs));
>  	if (!a6xx_state->indexed_regs)
>  		return;
>  
> -- 
> 1.8.3.1
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
