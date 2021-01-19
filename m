Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F962FAF76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbhASE1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:27:15 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:16183 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbhASE0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:26:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611030351; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ig+DNXjze7tgIPB3ugCbMP6PTZNKcUA0/cbdRd66EJg=;
 b=buikkKPW00xvypqyq4mFgC7ZHJBZtErE9AGZGlKA14TWnLDa1z1AKHUgFpdbW+99Hjmj2IEm
 UH1gZgIU20nUBLLu7vUqXD0fatAQy2ZdaEhfZDfvx9yAEsaglKF13gQirCU69M+jMHpY6wOs
 Fx0aN8EB2sU5+Cr6i2b/qQKJ3r4=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60065f32ba7f868506d7882a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 04:25:22
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13D1FC433CA; Tue, 19 Jan 2021 04:25:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58A1BC433C6;
        Tue, 19 Jan 2021 04:25:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jan 2021 09:55:21 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] soc: qcom: socinfo: Don't print anything if nothing found
In-Reply-To: <20210115203951.850873-1-swboyd@chromium.org>
References: <20210115203951.850873-1-swboyd@chromium.org>
Message-ID: <532f14ced3ba915dfa4d92b2d2f4eaba@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-16 02:09, Stephen Boyd wrote:
> Let's skip printing anything if there's nothing to see. This makes it 
> so
> the file length is 0 instead of 1, for the newline, and helps scripts
> figure out if there's anything to see in these files.
> 
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

>  drivers/soc/qcom/socinfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index a985ed064669..0844b5d4e354 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -373,8 +373,8 @@ QCOM_OPEN(chip_id, qcom_show_chip_id);
>  static int show_image_##type(struct seq_file *seq, void *p)		  \
>  {								  \
>  	struct smem_image_version *image_version = seq->private;  \
> -	seq_puts(seq, image_version->type);			  \
> -	seq_putc(seq, '\n');					  \
> +	if (image_version->type[0] != '\0')			  \
> +		seq_printf(seq, "%s\n", image_version->type);	  \
>  	return 0;						  \
>  }								  \
>  static int open_image_##type(struct inode *inode, struct file *file)	  
> \
> 
> base-commit: 3bc4bf77fa2adca8d6677461b6ec57505f1a3331

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
