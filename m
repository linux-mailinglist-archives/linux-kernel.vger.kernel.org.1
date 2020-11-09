Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94242AC346
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgKISKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKISKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:10:08 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E735F20678;
        Mon,  9 Nov 2020 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604945408;
        bh=nYCGURReaUreeGBHrXbl9iNHp3A/C4AwY6eb8qAExsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KUtZu1RnUQqSxMBLI3fAWGVI5lMwBSpHUy5touvUvB0NURtA38bMOPugtz9BGhOQy
         vb35Fbvo9bPZjR3ZxgiiFfPdpk/Rha9GnYZk8knuTKFTryuOAjbfrxWFBSytOqzZZC
         sXJIhflIuW0amm+u+oHEvdGvGrD89NPunTQZb7cY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcBcD-009BeV-RM; Mon, 09 Nov 2020 18:10:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Nov 2020 18:10:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 17/24] kvm: arm64: Add __hyp_pa_symbol helper macro
In-Reply-To: <20201109165933.GA447754@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-18-dbrazdil@google.com>
 <20201109165933.GA447754@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1951645a457232caeca323bec2af5408@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qperret@google.com, dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 16:59, Quentin Perret wrote:
> Hey David,
> 
> On Monday 09 Nov 2020 at 11:32:26 (+0000), David Brazdil wrote:
>> Add helper macro for computing the PA of a kernel symbol in nVHE hyp
>> code. This will be useful for computing the PA of a PSCI CPU_ON entry
>> point.
>> 
>> Signed-off-by: David Brazdil <dbrazdil@google.com>
>> ---
>>  arch/arm64/kvm/hyp/nvhe/psci.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c 
>> b/arch/arm64/kvm/hyp/nvhe/psci.c
>> index b0b5df590ba5..7510b9e174e9 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/psci.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/psci.c
>> @@ -20,6 +20,16 @@ s64 hyp_physvirt_offset;
>> 
>>  #define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
>> 
>> +#define __hyp_pa_symbol(sym)					\
>> +	({							\
>> +		extern char sym[];				\
>> +		unsigned long kern_va;				\
>> +								\
>> +		asm volatile("ldr %0, =%1" : "=r" (kern_va)	\
>> +					   : "S" (sym));	\
>> +		kern_va - kimage_voffset;			\
>> +	})
>> +
> 
> Could this be simplified to __hyp_pa(hyp_symbol_addr(sym))? That would
> avoid the dependency on kimage_voffset.

I'm going to move away from evaluating kimage_voffset at runtime anyway,
see [1].

Thanks,

         M.

[1] https://lore.kernel.org/r/20201109175923.445945-1-maz@kernel.org
-- 
Jazz is not dead. It just smells funny...
