Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29862F37DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406004AbhALSDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:03:39 -0500
Received: from relay01.th.seeweb.it ([5.144.164.162]:48779 "EHLO
        relay01.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbhALSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:03:37 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 489341F665;
        Tue, 12 Jan 2021 19:02:55 +0100 (CET)
Subject: Re: [PATCH 9/9] drm/msm/dpu: Fix timeout issues on command mode
 panels
To:     linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        robdclark@gmail.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210109133736.143469-1-angelogioacchino.delregno@somainline.org>
 <20210109133736.143469-10-angelogioacchino.delregno@somainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <bdc67afc-3736-5497-c43f-5165c55e0354@somainline.org>
Date:   Tue, 12 Jan 2021 19:02:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210109133736.143469-10-angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/01/21 14:37, AngeloGioacchino Del Regno ha scritto:
> In function dpu_encoder_phys_cmd_wait_for_commit_done we are always
> checking if the relative CTL is started by waiting for an interrupt
> to fire: it is fine to do that, but then sometimes we call this
> function while the CTL is up and has never been put down, but that
> interrupt gets raised only when the CTL gets a state change from
> 0 to 1 (disabled to enabled), so we're going to wait for something
> that will never happen on its own.
> 
> Solving this while avoiding to restart the CTL is actually possible
> and can be done by just checking if it is already up and running
> when the wait_for_commit_done function is called: in this case, so,
> if the CTL was already running, we can say that the commit is done
> if the command transmission is complete (in other terms, if the
> interface has been flushed).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index 2311e98480b9..0624864da343 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -695,6 +695,9 @@ static int dpu_encoder_phys_cmd_wait_for_commit_done(
>   	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
>   		return 0;
>   
> +	if (phys_enc->hw_ctl->ops.is_started)
> +		return dpu_encoder_phys_cmd_wait_for_tx_complete(phys_enc);
> +
>   	return _dpu_encoder_phys_cmd_wait_for_ctl_start(phys_enc);
>   }
>   
> 

Sorry, this patch is obviously faulty, Took it from the wrong local 
tree. I will send a V2.
