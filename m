Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6DD304F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhA0DRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:17:12 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:23141 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388214AbhAZUf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:35:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611693340; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=PksgwQjYAE5mCkWpEhf8FuD4MEP1lZzvNn1nk/aOcJ4=; b=FFlpRz8uAtsaubLt0sgYJ2RAkdiHeZJg0FSo1v4IsgzryuikDFi+1bAnu1zFn28zTvaO6Eld
 ZfNEXx0+jw+Qny8snpSwqPILecS0+drrOp/AC4MPBAl8u18DEx8t18n6oybr25dRlyZtCemf
 h87PfUecJK8osriVkPds7F4/hTY=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60107cfdad4c9e395b9242fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Jan 2021 20:35:09
 GMT
Sender: sramana=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61CDBC433CA; Tue, 26 Jan 2021 20:35:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.11] (cpe-70-95-74-122.san.res.rr.com [70.95.74.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sramana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 836DAC433C6;
        Tue, 26 Jan 2021 20:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 836DAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sramana@codeaurora.org
Subject: Re: [PATCH v4 19/21] arm64: cpufeatures: Allow disabling of BTI from
 the command-line
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
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-20-maz@kernel.org>
 <YAwxhuw8L0Fp3cUf@Catalins-MacBook-Air.local>
From:   Srinivas Ramana <sramana@codeaurora.org>
Message-ID: <f78c9df6-1dc1-a2fa-08c9-5b9e890c320e@codeaurora.org>
Date:   Tue, 26 Jan 2021 12:35:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAwxhuw8L0Fp3cUf@Catalins-MacBook-Air.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 1/23/2021 6:24 AM, Catalin Marinas wrote:
> On Mon, Jan 18, 2021 at 09:45:31AM +0000, Marc Zyngier wrote:
>> In order to be able to disable BTI at runtime, whether it is
>> for testing purposes, or to work around HW issues, let's add
>> support for overriding the ID_AA64PFR1_EL1.BTI field.
>>
>> This is further mapped on the arm64.nobti command-line alias.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Verified this Series for BTI as well for command line control.
With arm64.nobti:
BTI is disabled on both primary and secondary cores as expected(verified 
page table entries).
HWCAPs show no BTI support and kernel instructions are being treated as 
NOPs.
We don't have plan to repeat the test on v5 as there are not major 
changes here.

Tested-by: Srinivas Ramana <sramana@codeaurora.org>

