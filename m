Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66C0299546
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789746AbgJZS1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:27:40 -0400
Received: from z5.mailgun.us ([104.130.96.5]:24609 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1789740AbgJZS1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:27:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603736859; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2rVdRj4SsbfGPG3FVq4W/LAdXew0WoAOEbrxP4lHncM=;
 b=DyAUFq//vPF8dgR6OKKXgNqmh7O7UiryG/B1S+RI5oMBqu/FxT9lKMzTXzSlwi0z9BXyFVwF
 6nnyuGrYHgFA4rWwX6BhYsequWOukE4Ft0spllRK6/U+evuJLheiHbGEOlhj466Ziuyff9Gt
 baWQWz6o3FFEhyy58/FndKtPa60=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f97151b6311e6e920de586a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 18:27:39
 GMT
Sender: asutoshd=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68FF4C43395; Mon, 26 Oct 2020 18:27:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B56BBC433FE;
        Mon, 26 Oct 2020 18:27:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 11:27:38 -0700
From:   asutoshd@codeaurora.org
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, Jaegeuk Kim <jaegeuk@google.com>
Subject: Re: [PATCH v3 3/5] scsi: ufs: use WQ_HIGHPRI for gating work
In-Reply-To: <20201024150646.1790529-4-jaegeuk@kernel.org>
References: <20201024150646.1790529-1-jaegeuk@kernel.org>
 <20201024150646.1790529-4-jaegeuk@kernel.org>
Message-ID: <0ba2065c107eacd112858905e8d079e0@codeaurora.org>
X-Sender: asutoshd@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-24 08:06, Jaegeuk Kim wrote:
> From: Jaegeuk Kim <jaegeuk@google.com>
> 
> Must have WQ_MEM_RECLAIM
> ``WQ_MEM_RECLAIM``
>   All wq which might be used in the memory reclaim paths **MUST**
>   have this flag set.  The wq is guaranteed to have at least one
>   execution context regardless of memory pressure.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> ---

Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>

>  drivers/scsi/ufs/ufshcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 011e80a21170..bc0d623aed66 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1867,7 +1867,7 @@ static void ufshcd_init_clk_gating(struct ufs_hba 
> *hba)
>  	snprintf(wq_name, ARRAY_SIZE(wq_name), "ufs_clk_gating_%d",
>  		 hba->host->host_no);
>  	hba->clk_gating.clk_gating_workq = alloc_ordered_workqueue(wq_name,
> -							   WQ_MEM_RECLAIM);
> +					WQ_MEM_RECLAIM | WQ_HIGHPRI);
> 
>  	hba->clk_gating.is_enabled = true;
