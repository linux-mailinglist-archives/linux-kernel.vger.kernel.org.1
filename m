Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E518129331E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 04:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390655AbgJTCbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 22:31:00 -0400
Received: from z5.mailgun.us ([104.130.96.5]:24729 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390609AbgJTCbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 22:31:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603161059; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IkpvxoQzggIcAY4nLVzLSfhxrsSSTOJ1BW/qHQMn9SE=;
 b=sCt2RVxYO5UVitmlbRiTsz7/oBy41PNiSWhUs9fyO/htL4LrfzapJxDh7vPNeIUDqU8Xn9Sk
 G9NQCtSKLRHRZOO7qO7e24DGq1XNWvsbrSeBoFjuowAjy+7NkUHi1qKP44yoZfs4PcAJXQzM
 KtzC31BNJksAToYs2H6Sb0yXNQw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f8e4bba3711fec7b17a43fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 02:30:18
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B9DAC433F1; Tue, 20 Oct 2020 02:30:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66641C433FE;
        Tue, 20 Oct 2020 02:30:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Oct 2020 10:30:16 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, Jaegeuk Kim <jaegeuk@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH 1/4] scsi: ufs: atomic update for clkgating_enable
In-Reply-To: <20201005223635.2922805-1-jaegeuk@kernel.org>
References: <20201005223635.2922805-1-jaegeuk@kernel.org>
Message-ID: <61df6574cf7b845e1b1f72cda0b0ee02@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-06 06:36, Jaegeuk Kim wrote:
> From: Jaegeuk Kim <jaegeuk@google.com>
> 
> When giving a stress test which enables/disables clkgating, we hit 
> device
> timeout sometimes. This patch avoids subtle racy condition to address 
> it.
> 
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Can Guo <cang@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 1d157ff58d817..d929c3d1e58cc 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1791,19 +1791,19 @@ static ssize_t
> ufshcd_clkgate_enable_store(struct device *dev,
>  		return -EINVAL;
> 
>  	value = !!value;
> +
> +	spin_lock_irqsave(hba->host->host_lock, flags);
>  	if (value == hba->clk_gating.is_enabled)
>  		goto out;
> 
> -	if (value) {
> -		ufshcd_release(hba);
> -	} else {
> -		spin_lock_irqsave(hba->host->host_lock, flags);
> +	if (value)
> +		hba->clk_gating.active_reqs--;
> +	else
>  		hba->clk_gating.active_reqs++;
> -		spin_unlock_irqrestore(hba->host->host_lock, flags);
> -	}
> 
>  	hba->clk_gating.is_enabled = value;
>  out:
> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
>  	return count;
>  }

I agree that we should protect the flag "is_enabled" with spin lock,
but I prefer the old logic of calling ufshcd_release() instead of
just doing hba->clk_gating.active_reqs--, you can use 
__ufshcd_release(),
which is free of locking.

Thanks,

Can Guo.
