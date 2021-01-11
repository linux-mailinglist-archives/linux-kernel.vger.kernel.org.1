Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF692F20F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbhAKUjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:39:48 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:42867 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403903AbhAKUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:39:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610397561; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Ees3o6e/XkCpCJVrzGN7Ici92EyC8KlYvYm+4z3SO9w=; b=TYqqbT3XZK3rj5GnlAuS/5EcfjT96r+gNiNND8FmqLNshivrwSJzcbxTOKErsxDQYDz65ZOo
 k5g/B+96rZlkWmTmflg7kfARFBSc/oBrgO20MJyo+mcE5WUu0yGFvELpbu/kUfJMSlsKXdfM
 VZkkHC9OhtTrEsWGsyZG1sVT3xQ=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ffcb756af68fb3b06b880cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 20:38:46
 GMT
Sender: sramana=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4F37C433ED; Mon, 11 Jan 2021 20:38:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.11] (cpe-70-95-74-122.san.res.rr.com [70.95.74.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sramana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE9AAC433CA;
        Mon, 11 Jan 2021 20:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE9AAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sramana@codeaurora.org
Subject: Re: [PATCH v3 09/21] arm64: cpufeature: Add global feature override
 facility
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
References: <20210111132811.2455113-1-maz@kernel.org>
 <20210111132811.2455113-10-maz@kernel.org> <20210111184154.GC17941@gaia>
From:   Srinivas Ramana <sramana@codeaurora.org>
Message-ID: <de9d8631-4ff9-9d0c-e4eb-5ce0eeb0ecea@codeaurora.org>
Date:   Mon, 11 Jan 2021 12:38:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111184154.GC17941@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 1/11/2021 10:41 AM, Catalin Marinas wrote:
> Hi Marc,
>
> On Mon, Jan 11, 2021 at 01:27:59PM +0000, Marc Zyngier wrote:
>> Add a facility to globally override a feature, no matter what
>> the HW says. Yes, this is dangerous.
> Yeah, it's dangerous. We can make it less so if we only allow safe
> values (e.g. lower if FTR_UNSIGNED).
>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 9a555809b89c..465d2cb63bfc 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -75,6 +75,8 @@ struct arm64_ftr_reg {
>>   	u64				sys_val;
>>   	u64				user_val;
>>   	const struct arm64_ftr_bits	*ftr_bits;
>> +	u64				*override_val;
>> +	u64				*override_mask;
>>   };
> At the arm64_ftr_reg level, we don't have any information about the safe
> values for a feature. Could we instead move this to arm64_ftr_bits? We
> probably only need a single field. When populating the feature values,
> we can make sure it doesn't go above the hardware one.
>
> I attempted a feature modification for MTE here, though I dropped the
> entire series in the meantime as we clarified the ARM ARM:
>
> https://lore.kernel.org/linux-arm-kernel/20200515171612.1020-24-catalin.marinas@arm.com/
>
> Srinivas copied it in his patch (but forgot to give credit ;)):

Sorry about that. I did mention that its taken from your patch-set in my 
cover letter. But missed your signed-off-by in the patch.

https://lore.kernel.org/linux-arm-msm/6dfdf691b5ed57df81c4c61422949af5@misterjones.org/T/#m1ae76e6096c07ab5f1636a4e383a3fd6cfb4665f

Since we can ignore my patch with the mechanism added by Marc, I am not 
re-sending this. Thanks.

>
> https://lore.kernel.org/linux-arm-msm/1610152163-16554-3-git-send-email-sramana@codeaurora.org/
>
> The above adds a filter function but, instead, just use your mechanism in
> this series for idreg.feature setting via cmdline. The arm64_ftr_value()
> function extracts the hardware value and lowers it if a cmdline argument
> was passed.
>
