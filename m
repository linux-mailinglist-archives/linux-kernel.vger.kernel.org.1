Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CE529E5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgJ2IKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:10:32 -0400
Received: from z5.mailgun.us ([104.130.96.5]:56583 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbgJ2IIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:08:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603958897; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=GdZm8hyiYjrSeOIvvYYKFxrUBPSbb9jZzU/NBLFA8tA=; b=VrX55W2oa71ShRECUs7cbmiEnss8YsNoGnKAfZsgZbldwD7TWseF8DEEl3dGRFmDgMxcJDKB
 qV/LESQBi3ymnjrOzwJZuFC6GSA5EGMu+Wa88ce8uXjU5ONnU1hRK1NOlvCHyOBUtQjLPzpd
 cQYByrZ5f0k72r9F/hKC7vWup8c=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f9a40b34e4fe7071d40f662 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Oct 2020 04:10:27
 GMT
Sender: kathirav=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53F8EC43391; Thu, 29 Oct 2020 04:10:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.43.11] (unknown [106.198.101.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B1E6C433CB;
        Thu, 29 Oct 2020 04:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B1E6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kathirav@codeaurora.org
Subject: Re: [PATCH] arm64: defconfig: enable APSS clock driver for IPQ6018
From:   Kathiravan T <kathirav@codeaurora.org>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sivaprak@codeaurora.org
References: <1600350970-26607-1-git-send-email-kathirav@codeaurora.org>
 <8edb1ab1-4afd-e36a-f2d4-f790cd7bd0cb@codeaurora.org>
Message-ID: <8eb264db-54d8-3ad7-3666-8d1975926af1@codeaurora.org>
Date:   Thu, 29 Oct 2020 09:39:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <8edb1ab1-4afd-e36a-f2d4-f790cd7bd0cb@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

Wondering if this patch was overlooked due to some reason or should I 
send V2 based on v5.10-rc1?

Thanks,

Kathiravan T.

On 10/8/2020 9:59 PM, Kathiravan T wrote:
> Bjorn,
>
> Any comments on this? I would like to know if there is any chances of 
> taking this patch for v5.10 merge window?
>
> Thanks,
>
> Kathiravan T.
>
>
> On 9/17/2020 7:26 PM, Kathiravan T wrote:
>> Lets enable the APSS clock driver for the DVFS support.
>>
>> Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 6d04b9577b0b..67244560f869 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -850,6 +850,7 @@ CONFIG_QCOM_A53PLL=y
>>   CONFIG_QCOM_CLK_APCS_MSM8916=y
>>   CONFIG_QCOM_CLK_SMD_RPM=y
>>   CONFIG_QCOM_CLK_RPMH=y
>> +CONFIG_IPQ_APSS_6018=y
>>   CONFIG_IPQ_GCC_8074=y
>>   CONFIG_IPQ_GCC_6018=y
>>   CONFIG_MSM_GCC_8916=y
>>
>> base-commit: 856deb866d16e29bd65952e0289066f6078af773
>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

