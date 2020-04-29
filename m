Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC11BE496
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgD2RBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 13:01:44 -0400
Received: from foss.arm.com ([217.140.110.172]:42538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgD2RBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:01:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D8D1106F;
        Wed, 29 Apr 2020 10:01:43 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AE7A3F73D;
        Wed, 29 Apr 2020 10:01:40 -0700 (PDT)
Subject: Re: [PATCH v9 10/18] arm64: kexec: cpu_soft_restart change argument
 types
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-11-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Message-ID: <e6faa23d-27a8-838a-33ef-2a6ad8a5c746@arm.com>
Date:   Wed, 29 Apr 2020 18:01:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-11-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Change argument types from unsigned long to a more descriptive
> phys_addr_t.

For 'entry', which is a physical addresses, sure...

> diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
> index ed50e9587ad8..38cbd4068019 100644
> --- a/arch/arm64/kernel/cpu-reset.h
> +++ b/arch/arm64/kernel/cpu-reset.h
> @@ -10,17 +10,17 @@
>  
>  #include <asm/virt.h>
>  
> -void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
> -	unsigned long arg0, unsigned long arg1, unsigned long arg2);

> +void __cpu_soft_restart(phys_addr_t el2_switch, phys_addr_t entry,
> +			phys_addr_t arg0, phys_addr_t arg1, phys_addr_t arg2);

This looks weird because its re-using the hyp-stub API, because it might call the hyp-stub
from the idmap. entry is passed in, so this isn't tied to kexec. Without tying it to
kexec, how do you know arg2 is a physical address?
I think it tried to be re-usable because 32bit has more users for this.

arg0-2 are unsigned long because the hyp-stub is just moving general purpose registers around.

This is to avoid casting?
Sure, its only got one caller. This thing evolved because the platform-has-EL2 and
kdump-while-KVM-was-running code was bolted on as they were discovered.


> -static inline void __noreturn cpu_soft_restart(unsigned long entry,
> -					       unsigned long arg0,
> -					       unsigned long arg1,
> -					       unsigned long arg2)
> +static inline void __noreturn cpu_soft_restart(phys_addr_t entry,
> +					       phys_addr_t arg0,
> +					       phys_addr_t arg1,
> +					       phys_addr_t arg2)
>  {
>  	typeof(__cpu_soft_restart) *restart;
>  
> -	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
> +	phys_addr_t el2_switch = !is_kernel_in_hyp_mode() &&
>  		is_hyp_mode_available();

What on earth happened here!?


>  	restart = (void *)__pa_symbol(__cpu_soft_restart);


Thanks,

James
