Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783ED303233
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 03:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbhAYOCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbhAYN47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:56:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE1522C9C;
        Mon, 25 Jan 2021 13:56:01 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l42LW-009t5S-S6; Mon, 25 Jan 2021 13:55:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Jan 2021 13:55:58 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        kernel-team@android.com
Subject: Re: [PATCH v5 13/21] arm64: Allow ID_AA64MMFR1_EL1.VH to be
 overridden from the command line
In-Reply-To: <b43570e9-585d-3229-df2f-9af9777b55ec@arm.com>
References: <20210125105019.2946057-1-maz@kernel.org>
 <20210125105019.2946057-14-maz@kernel.org>
 <b43570e9-585d-3229-df2f-9af9777b55ec@arm.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <9923965b870d71eee0fa828059185f33@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-25 13:15, Suzuki K Poulose wrote:
> On 1/25/21 10:50 AM, Marc Zyngier wrote:
>> As we want to be able to disable VHE at runtime, let's match
>> "id_aa64mmfr1.vh=" from the command line as an override.
>> This doesn't have much effect yet as our boot code doesn't look
>> at the cpufeature, but only at the HW registers.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Acked-by: David Brazdil <dbrazdil@google.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h |  2 ++
>>   arch/arm64/kernel/cpufeature.c      |  5 ++++-
>>   arch/arm64/kernel/idreg-override.c  | 11 +++++++++++
>>   3 files changed, 17 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/include/asm/cpufeature.h 
>> b/arch/arm64/include/asm/cpufeature.h
>> index 4179cfc8ed57..b0ed37da4067 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -818,6 +818,8 @@ static inline unsigned int get_vmid_bits(u64 
>> mmfr1)
>>   	return 8;
>>   }
>>   +extern struct arm64_ftr_override id_aa64mmfr1_override;
>> +
>>   u32 get_kvm_ipa_limit(void);
>>   void dump_cpu_features(void);
>>   diff --git a/arch/arm64/kernel/cpufeature.c 
>> b/arch/arm64/kernel/cpufeature.c
>> index 4b84a1e1dc51..c1d6712c4249 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -557,6 +557,8 @@ static const struct arm64_ftr_bits ftr_raz[] = {
>>     #define ARM64_FTR_REG(id, table) ARM64_FTR_REG_OVERRIDE(id, table, 
>> &no_override)
>>   +struct arm64_ftr_override id_aa64mmfr1_override;
> 
> Does this need to be ro_after_init ?

Could do, together with the other two override targeting system 
registers.

> Otherwise, looks good to me:
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
