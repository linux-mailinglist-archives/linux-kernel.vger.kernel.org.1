Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB812F1FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404053AbhAKTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403992AbhAKTs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:48:57 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB75022BEF;
        Mon, 11 Jan 2021 19:48:16 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kz3Ak-006mV8-JL; Mon, 11 Jan 2021 19:48:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 19:48:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v3 09/21] arm64: cpufeature: Add global feature override
 facility
In-Reply-To: <20210111184154.GC17941@gaia>
References: <20210111132811.2455113-1-maz@kernel.org>
 <20210111132811.2455113-10-maz@kernel.org> <20210111184154.GC17941@gaia>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <129db8bd3913a90c96d4cfe4f55e27a0@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 2021-01-11 18:41, Catalin Marinas wrote:
> Hi Marc,
> 
> On Mon, Jan 11, 2021 at 01:27:59PM +0000, Marc Zyngier wrote:
>> Add a facility to globally override a feature, no matter what
>> the HW says. Yes, this is dangerous.
> 
> Yeah, it's dangerous. We can make it less so if we only allow safe
> values (e.g. lower if FTR_UNSIGNED).

My plan was also to allow non-safe values in order to trigger features
that are not advertised by the HW. But I can understand if you are
reluctant to allow such thing! :D

>> diff --git a/arch/arm64/include/asm/cpufeature.h 
>> b/arch/arm64/include/asm/cpufeature.h
>> index 9a555809b89c..465d2cb63bfc 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -75,6 +75,8 @@ struct arm64_ftr_reg {
>>  	u64				sys_val;
>>  	u64				user_val;
>>  	const struct arm64_ftr_bits	*ftr_bits;
>> +	u64				*override_val;
>> +	u64				*override_mask;
>>  };
> 
> At the arm64_ftr_reg level, we don't have any information about the 
> safe
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
> 
> https://lore.kernel.org/linux-arm-msm/1610152163-16554-3-git-send-email-sramana@codeaurora.org/
> 
> The above adds a filter function but, instead, just use your mechanism 
> in
> this series for idreg.feature setting via cmdline. The 
> arm64_ftr_value()
> function extracts the hardware value and lowers it if a cmdline 
> argument
> was passed.

One thing is that it is not always possible to sanitise the value passed
if it is required very early on, as I do with VHE. But in that case
I actually check that we are VHE capable before starting to poke at
VHE-specific state.

I came up with the following patch on top, which preserves the current
global approach (no per arm64_ftr_bits state), but checks (and alters)
the override as it iterates through the various fields.

For example, if I pass "arm64.nopauth kvm-arm.mode=nvhe 
id_aa64pfr1.bt=5"
to the FVP, I get the following output:

[    0.000000] CPU features: SYS_ID_AA64ISAR1_EL1[31:28]: forced from 1 
to 0
[    0.000000] CPU features: SYS_ID_AA64ISAR1_EL1[11:8]: forced from 1 
to 0
[    0.000000] CPU features: SYS_ID_AA64MMFR1_EL1[11:8]: forced from 1 
to 0
[    0.000000] CPU features: SYS_ID_AA64PFR1_EL1[3:0]: not forcing 1 to 
5
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Branch Target Identification

showing that the PAC features have been downgraded, together with VHE,
but that BTI is still detected as value 5 was obviously bogus.

Thoughts?

         M.

diff --git a/arch/arm64/kernel/cpufeature.c 
b/arch/arm64/kernel/cpufeature.c
index 894af60b9669..00d99e593b65 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -774,6 +774,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 
new)
  	u64 strict_mask = ~0x0ULL;
  	u64 user_mask = 0;
  	u64 valid_mask = 0;
+	u64 override_val = 0, override_mask = 0;

  	const struct arm64_ftr_bits *ftrp;
  	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
@@ -781,9 +782,35 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, 
u64 new)
  	if (!reg)
  		return;

+	if (reg->override_mask && reg->override_val) {
+		override_mask = *reg->override_mask;
+		override_val = *reg->override_val;
+	}
+
  	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
  		u64 ftr_mask = arm64_ftr_mask(ftrp);
  		s64 ftr_new = arm64_ftr_value(ftrp, new);
+		s64 ftr_ovr = arm64_ftr_value(ftrp, override_val);
+
+		if ((ftr_mask & override_mask) == ftr_mask) {
+			if (ftr_ovr < ftr_new) {
+				pr_warn("%s[%d:%d]: forced from %llx to %llx\n",
+					reg->name,
+					ftrp->shift + ftrp->width - 1,
+					ftrp->shift, ftr_new, ftr_ovr);
+
+				ftr_new = ftr_ovr;
+			} else if (ftr_ovr != ftr_new) {
+				pr_warn("%s[%d:%d]: not forcing %llx to %llx\n",
+					reg->name,
+					ftrp->shift + ftrp->width - 1,
+					ftrp->shift, ftr_new, ftr_ovr);
+
+				/* Remove the override */
+				*reg->override_mask &= ~ftr_mask;
+				*reg->override_val &= ~ftr_mask;
+			}
+		}

  		val = arm64_ftr_set_value(ftrp, val, ftr_new);

@@ -800,18 +827,6 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, 
u64 new)

  	val &= valid_mask;

-	if (reg->override_mask && reg->override_val) {
-		u64 override = val;
-		override &= ~*reg->override_mask;
-		override |= (*reg->override_val & *reg->override_mask);
-
-		if (val != override)
-			pr_warn("%s: forced from %016llx to %016llx\n",
-				reg->name, val, override);
-
-		val = override;
-	}
-
  	reg->sys_val = val;
  	reg->strict_mask = strict_mask;
  	reg->user_mask = user_mask;

-- 
Jazz is not dead. It just smells funny...
