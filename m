Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7592823D7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgJCLgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 07:36:31 -0400
Received: from z5.mailgun.us ([104.130.96.5]:60211 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgJCLgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 07:36:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601724990; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+b3m7jKQ1O6fiYm/hL5ZFgqJTiOppqki6YMsfwFKW/s=; b=vsc/WZpgY2kbi0tQZKoD0UYkxJLnNc6bPPs89lHnvHip498hcMTGF6IZpWiJWLvuISQBlwvb
 QdkHtEdVIpPFXGXgObaAYdqNl4l/YlRFPQbKW5aITjXPXZAmPnCFHMRpHW43Qc8eANK3enAa
 I2mJDFhK0V3xkafET6HfZbcZ3vg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f78622ed63768e57b3be321 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 03 Oct 2020 11:36:14
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C15E5C4339C; Sat,  3 Oct 2020 11:36:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.131.172.121] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC457C433CB;
        Sat,  3 Oct 2020 11:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC457C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
Subject: Re: [PATCH v8 5/7] ASoC: qcom: Add support for lpass hdmi driver
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>
References: <1601447977-18115-1-git-send-email-srivasam@codeaurora.org>
 <1601447977-18115-6-git-send-email-srivasam@codeaurora.org>
 <c94cf74d-03f6-999e-012f-5d9ef2316d61@linaro.org>
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited
Message-ID: <925e2586-39dd-b1d9-174a-bda3367ab668@codeaurora.org>
Date:   Sat, 3 Oct 2020 17:06:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <c94cf74d-03f6-999e-012f-5d9ef2316d61@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for bringing up this point Srinivas!!!

On 9/30/2020 8:57 PM, Srinivas Kandagatla wrote:
>
>
> On 30/09/2020 07:39, Srinivasa Rao Mandadapu wrote:
>> +}
>> +
>> +static bool lpass_hdmi_regmap_volatile(struct device *dev, unsigned 
>> int reg)
>> +{
>> +    return true;
>> +}
>
> I did ask this question in multiple reviews, but never got an answer!
> Are all the dp/hdmi port register range really volatile!?

Sorry for incomplete response in last review comment reply.
With making only specific DMA registers and interrupts registers true, 
aplay was stuck.

Now we identified issue causing register and made it volatile.
With that change it seems working fine. After doing all the tests we 
will share v9 series patch.

>
>
>
> --srini
>> +
>> +struct regmap_config lpass_hdmi_regmap_config = {
>> +    .reg_bits = 32,
>> +    .reg_stride = 4,
>> +    .val_bits = 32,
>> +    .writeable_reg = lpass_hdmi_regmap_writeable,
>> +    .readable_reg = lpass_hdmi_regmap_readable,
>> +    .volatile_reg = lpass_hdmi_regmap_volatile,

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

