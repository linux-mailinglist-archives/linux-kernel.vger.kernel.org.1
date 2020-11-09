Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392A52AB3AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgKIJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:36:41 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:33929 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKIJgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:36:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604914600; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=NUG+xe2aYnHYm1NJnJvLO3G8nDtGuTSPGCrIjMUoJg4=;
 b=h92gxcIKZpvk04cPZECsxiRolv45l/5trU/z4kXnpqJN7TshMn9fTeGRItkP1CxCHdIqB+c8
 GyyAp7zAEbbV5DKAmpb1CD0R8V8NntngtV1AKPg86E+b+m1XaQTfySriVxMdWuRJywUOs0j/
 /zx5GR4Wr4CWcdemXbMihlOoUcA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fa90da4dd52edb7344d1384 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 09:36:36
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 693EBC433FF; Mon,  9 Nov 2020 09:36:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CE19C433C6;
        Mon,  9 Nov 2020 09:36:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Nov 2020 15:06:35 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX
 Silver
In-Reply-To: <3faa81d537320dfb20bb3f882cfaea1b@kernel.org>
References: <20201104232218.198800-1-konrad.dybcio@somainline.org>
 <20201104232218.198800-5-konrad.dybcio@somainline.org>
 <3faa81d537320dfb20bb3f882cfaea1b@kernel.org>
Message-ID: <8771f66911522ab87fe1b9b16e4e9921@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020-11-05 14:59, Marc Zyngier wrote:
> On 2020-11-04 23:22, Konrad Dybcio wrote:
>> QCOM KRYO2XX Silver cores are Cortex-A53 based and are
>> susceptible to the 845719 erratum. Add them to the lookup
>> list to apply the erratum.
>> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>  arch/arm64/kernel/cpu_errata.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/arm64/kernel/cpu_errata.c 
>> b/arch/arm64/kernel/cpu_errata.c
>> index 61314fd70f13..cafaf0da05b7 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -299,6 +299,8 @@ static const struct midr_range 
>> erratum_845719_list[] = {
>>  	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 4),
>>  	/* Brahma-B53 r0p[0] */
>>  	MIDR_REV(MIDR_BRAHMA_B53, 0, 0),
>> +	/* Kryo2XX Silver rAp4 */
>> +	MIDR_REV(MIDR_QCOM_KRYO_2XX_SILVER, 0xa, 0x4),
> 
> Is this the only affected version? If this is actually an A53, how do 
> the
> revisions map between Kryo and Cortex cores?
> 

 From what I see from the docs, this is the only version used
in MSM8998(silver cores are based on Cortex A53) and it maps
to r0p4. @Konrad, can you include (rap4 => r0p4) in comment.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
