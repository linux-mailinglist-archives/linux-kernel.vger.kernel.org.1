Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B4A28D80D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbgJNBkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:40:00 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:64628 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730193AbgJNBj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:39:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602639599; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=VBMK5XSzYvlhE5a/mQchIoVG+PrYT6ANp/NOsNsTu2s=; b=KU7V8/n+1a9VC2sk4ZtD0+uUG3U1QPcP32McuhYJnR6yzfGq9SUROmxtra4u9dTUozhkybjw
 PYI2cN3Y4jbYoeYnTktRyyY5X4c3i9rOr2VXfXjjyS+jV+yDTJnxxdEqc79PpiGZGbrlZ3Kr
 X2lce8cPhd/4SISpsydeqIs73YQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f8656edbfed2afaa6f39712 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Oct 2020 01:39:57
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 008C0C433FF; Wed, 14 Oct 2020 01:39:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.159] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6FCFC433FE;
        Wed, 14 Oct 2020 01:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6FCFC433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH] interconnect: qcom: Simplify the vcd compare function
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org
Cc:     okukatla@codeaurora.org, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
References: <20201013171923.7351-1-georgi.djakov@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <2e9385a0-56ea-0a2f-6389-7530c34a5364@codeaurora.org>
Date:   Tue, 13 Oct 2020 18:39:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201013171923.7351-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2020 10:19 AM, Georgi Djakov wrote:
> Let's simplify the cmp_vcd() function and replace the conditionals
> with just a single statement, which also improves readability.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/qcom/bcm-voter.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index 887d13721e52..1cc565bce2f4 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -41,17 +41,10 @@ struct bcm_voter {
>   
>   static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
>   {
> -	const struct qcom_icc_bcm *bcm_a =
> -			list_entry(a, struct qcom_icc_bcm, list);
> -	const struct qcom_icc_bcm *bcm_b =
> -			list_entry(b, struct qcom_icc_bcm, list);
> -
> -	if (bcm_a->aux_data.vcd < bcm_b->aux_data.vcd)
> -		return -1;
> -	else if (bcm_a->aux_data.vcd == bcm_b->aux_data.vcd)
> -		return 0;
> -	else
> -		return 1;
> +	const struct qcom_icc_bcm *bcm_a = list_entry(a, struct qcom_icc_bcm, list);
> +	const struct qcom_icc_bcm *bcm_b = list_entry(b, struct qcom_icc_bcm, list);
> +
> +	return bcm_a->aux_data.vcd - bcm_b->aux_data.vcd;
>   }
>   
>   static u64 bcm_div(u64 num, u32 base)
> 

Reviewed-by: Mike Tipton <mdtipton@codeaurora.org>
