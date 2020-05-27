Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4771E35F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 04:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgE0C4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 22:56:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24288 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728066AbgE0C4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590548204;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eD3RZrp9fcIjAqS8NKhao/3RbPRprLb6DUKgvzv45Y=;
        b=Zu/R9eYtHfN9aJp0n/yTLD8xrdiHG5BGusrpvpTmS4fA7tt+H/MZ4MdBC9fsWADxh6RsEz
        vmv6zehimbZkSyh24I7hIp/8vWmeiLs1BxOKVkgZ06LMyrGuyTBsP80VdBrGIUJC1c22SE
        lL9Gqgg/2q//5QNcqsI+d7d9VvpM/gM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-mOIlRL0jPSCYqqch8kwzlA-1; Tue, 26 May 2020 22:56:40 -0400
X-MC-Unique: mOIlRL0jPSCYqqch8kwzlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AC191800D42;
        Wed, 27 May 2020 02:56:39 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-130.bne.redhat.com [10.64.54.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A64B05C1B0;
        Wed, 27 May 2020 02:56:31 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 5/9] kvm/arm64: Replace hsr with esr
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-6-gshan@redhat.com>
 <20200526104507.GC1363@C02TD0UTHF1T.local>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <63d4e673-4e7e-145e-93f0-3df646bd79da@redhat.com>
Date:   Wed, 27 May 2020 12:56:29 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200526104507.GC1363@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 5/26/20 8:45 PM, Mark Rutland wrote:
> On Fri, May 08, 2020 at 01:29:15PM +1000, Gavin Shan wrote:
>> This replace the variable names to make them self-explaining. The
>> tracepoint isn't changed accordingly because they're part of ABI:
>>
>>     * @hsr to @esr
>>     * @hsr_ec to @ec
>>     * Use kvm_vcpu_trap_get_class() helper if possible
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> As with patch 3, I think this cleanup makes sense independent from the
> rest of the series, and I think it'd make sense to bundle all the
> patches renaming hsr -> esr, and send those as a preparatory series.
> 

Yes, PATCH[3/4/5] will be posted independently, as part of the
preparatory work, as you suggested.

Thanks,
Gavin

> Thanks,
> Mark.
> 
>> ---
>>   arch/arm64/kvm/handle_exit.c | 28 ++++++++++++++--------------
>>   arch/arm64/kvm/hyp/switch.c  |  9 ++++-----
>>   arch/arm64/kvm/sys_regs.c    | 30 +++++++++++++++---------------
>>   3 files changed, 33 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>> index 00858db82a64..e3b3dcd5b811 100644
>> --- a/arch/arm64/kvm/handle_exit.c
>> +++ b/arch/arm64/kvm/handle_exit.c
>> @@ -123,13 +123,13 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>    */
>>   static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>   {
>> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
>> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>>   	int ret = 0;
>>   
>>   	run->exit_reason = KVM_EXIT_DEBUG;
>> -	run->debug.arch.hsr = hsr;
>> +	run->debug.arch.hsr = esr;
>>   
>> -	switch (ESR_ELx_EC(hsr)) {
>> +	switch (kvm_vcpu_trap_get_class(esr)) {
>>   	case ESR_ELx_EC_WATCHPT_LOW:
>>   		run->debug.arch.far = vcpu->arch.fault.far_el2;
>>   		/* fall through */
>> @@ -139,8 +139,8 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>   	case ESR_ELx_EC_BRK64:
>>   		break;
>>   	default:
>> -		kvm_err("%s: un-handled case hsr: %#08x\n",
>> -			__func__, (unsigned int) hsr);
>> +		kvm_err("%s: un-handled case esr: %#08x\n",
>> +			__func__, (unsigned int)esr);
>>   		ret = -1;
>>   		break;
>>   	}
>> @@ -150,10 +150,10 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>   
>>   static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>   {
>> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
>> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>>   
>> -	kvm_pr_unimpl("Unknown exception class: hsr: %#08x -- %s\n",
>> -		      hsr, esr_get_class_string(hsr));
>> +	kvm_pr_unimpl("Unknown exception class: esr: %#08x -- %s\n",
>> +		      esr, esr_get_class_string(esr));
>>   
>>   	kvm_inject_undefined(vcpu);
>>   	return 1;
>> @@ -230,10 +230,10 @@ static exit_handle_fn arm_exit_handlers[] = {
>>   
>>   static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>>   {
>> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
>> -	u8 hsr_ec = ESR_ELx_EC(hsr);
>> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>> +	u8 ec = kvm_vcpu_trap_get_class(esr);
>>   
>> -	return arm_exit_handlers[hsr_ec];
>> +	return arm_exit_handlers[ec];
>>   }
>>   
>>   /*
>> @@ -273,15 +273,15 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>   {
>>   	if (ARM_SERROR_PENDING(exception_index)) {
>>   		u32 esr = kvm_vcpu_get_esr(vcpu);
>> -		u8 hsr_ec = ESR_ELx_EC(esr);
>> +		u8 ec = kvm_vcpu_trap_get_class(esr);
>>   
>>   		/*
>>   		 * HVC/SMC already have an adjusted PC, which we need
>>   		 * to correct in order to return to after having
>>   		 * injected the SError.
>>   		 */
>> -		if (hsr_ec == ESR_ELx_EC_HVC32 || hsr_ec == ESR_ELx_EC_HVC64 ||
>> -		    hsr_ec == ESR_ELx_EC_SMC32 || hsr_ec == ESR_ELx_EC_SMC64) {
>> +		if (ec == ESR_ELx_EC_HVC32 || ec == ESR_ELx_EC_HVC64 ||
>> +		    ec == ESR_ELx_EC_SMC32 || ec == ESR_ELx_EC_SMC64) {
>>   			u32 adj =  kvm_vcpu_trap_il_is32bit(esr) ? 4 : 2;
>>   			*vcpu_pc(vcpu) -= adj;
>>   		}
>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>> index 369f22f49f3d..7bf4840bf90e 100644
>> --- a/arch/arm64/kvm/hyp/switch.c
>> +++ b/arch/arm64/kvm/hyp/switch.c
>> @@ -356,8 +356,8 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
>>   static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
>>   {
>>   	u32 esr = kvm_vcpu_get_esr(vcpu);
>> +	u8 ec = kvm_vcpu_trap_get_class(esr);
>>   	bool vhe, sve_guest, sve_host;
>> -	u8 hsr_ec;
>>   
>>   	if (!system_supports_fpsimd())
>>   		return false;
>> @@ -372,14 +372,13 @@ static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
>>   		vhe = has_vhe();
>>   	}
>>   
>> -	hsr_ec = kvm_vcpu_trap_get_class(esr);
>> -	if (hsr_ec != ESR_ELx_EC_FP_ASIMD &&
>> -	    hsr_ec != ESR_ELx_EC_SVE)
>> +	if (ec != ESR_ELx_EC_FP_ASIMD &&
>> +	    ec != ESR_ELx_EC_SVE)
>>   		return false;
>>   
>>   	/* Don't handle SVE traps for non-SVE vcpus here: */
>>   	if (!sve_guest)
>> -		if (hsr_ec != ESR_ELx_EC_FP_ASIMD)
>> +		if (ec != ESR_ELx_EC_FP_ASIMD)
>>   			return false;
>>   
>>   	/* Valid trap.  Switch the context: */
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 012fff834a4b..58f81ab519af 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -2182,10 +2182,10 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
>>   				struct sys_reg_params *params)
>>   {
>>   	u32 esr = kvm_vcpu_get_esr(vcpu);
>> -	u8 hsr_ec = kvm_vcpu_trap_get_class(esr);
>> +	u8 ec = kvm_vcpu_trap_get_class(esr);
>>   	int cp = -1;
>>   
>> -	switch(hsr_ec) {
>> +	switch (ec) {
>>   	case ESR_ELx_EC_CP15_32:
>>   	case ESR_ELx_EC_CP15_64:
>>   		cp = 15;
>> @@ -2216,17 +2216,17 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
>>   			    size_t nr_specific)
>>   {
>>   	struct sys_reg_params params;
>> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
>> -	int Rt = kvm_vcpu_sys_get_rt(hsr);
>> -	int Rt2 = (hsr >> 10) & 0x1f;
>> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>> +	int Rt = kvm_vcpu_sys_get_rt(esr);
>> +	int Rt2 = (esr >> 10) & 0x1f;
>>   
>>   	params.is_aarch32 = true;
>>   	params.is_32bit = false;
>> -	params.CRm = (hsr >> 1) & 0xf;
>> -	params.is_write = ((hsr & 1) == 0);
>> +	params.CRm = (esr >> 1) & 0xf;
>> +	params.is_write = ((esr & 1) == 0);
>>   
>>   	params.Op0 = 0;
>> -	params.Op1 = (hsr >> 16) & 0xf;
>> +	params.Op1 = (esr >> 16) & 0xf;
>>   	params.Op2 = 0;
>>   	params.CRn = 0;
>>   
>> @@ -2273,18 +2273,18 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
>>   			    size_t nr_specific)
>>   {
>>   	struct sys_reg_params params;
>> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
>> -	int Rt  = kvm_vcpu_sys_get_rt(hsr);
>> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>> +	int Rt = kvm_vcpu_sys_get_rt(esr);
>>   
>>   	params.is_aarch32 = true;
>>   	params.is_32bit = true;
>> -	params.CRm = (hsr >> 1) & 0xf;
>> +	params.CRm = (esr >> 1) & 0xf;
>>   	params.regval = vcpu_get_reg(vcpu, Rt);
>> -	params.is_write = ((hsr & 1) == 0);
>> -	params.CRn = (hsr >> 10) & 0xf;
>> +	params.is_write = ((esr & 1) == 0);
>> +	params.CRn = (esr >> 10) & 0xf;
>>   	params.Op0 = 0;
>> -	params.Op1 = (hsr >> 14) & 0x7;
>> -	params.Op2 = (hsr >> 17) & 0x7;
>> +	params.Op1 = (esr >> 14) & 0x7;
>> +	params.Op2 = (esr >> 17) & 0x7;
>>   
>>   	if (!emulate_cp(vcpu, &params, target_specific, nr_specific) ||
>>   	    !emulate_cp(vcpu, &params, global, nr_global)) {
>> -- 
>> 2.23.0
>>
> 

