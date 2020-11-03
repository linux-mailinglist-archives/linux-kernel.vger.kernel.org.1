Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114B22A44E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgKCMPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:15:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:17445 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgKCMPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:15:34 -0500
IronPort-SDR: z6lbI9/rdZqCH+ITG5lJKQsBoCxpuBsyoaVCBhIeN2Mxiz/rFaSkdBzSrNo35n5+4Nq1EuThmb
 5ZpbXOQLPswQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="156030734"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="156030734"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 04:15:33 -0800
IronPort-SDR: w2Z0yU18SM1WOXKQgjzJ2A4bre+P+PzGlF/xTtG2KjRbBL5yxEt5NCrvEhf31R7JF0BOiAa5I5
 AU1JKBpeGIgQ==
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="538468244"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.28.220]) ([10.255.28.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 04:15:29 -0800
Subject: Re: [PATCH RFC v3 2/4] x86/bus_lock: Handle warn and fatal in #DB for
 bus lock
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <20201031002714.3649728-1-fenghua.yu@intel.com>
 <20201031002714.3649728-3-fenghua.yu@intel.com>
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
Message-ID: <21d0415c-9af4-db18-8e65-410f6ab5ec68@linux.intel.com>
Date:   Tue, 3 Nov 2020 20:15:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201031002714.3649728-3-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2020 8:27 AM, Fenghua Yu wrote:

...

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 3c70fb34028b..1c3442000972 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -953,6 +953,13 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
>   		goto out_irq;
>   	}
>   
> +	/*
> +	 * Handle bus lock. #DB for bus lock can only be triggered from
> +	 * userspace.
> +	 */
> +	if (!(dr6 & DR_BUS_LOCK))

it should be

	if (dr6 & DR_BUS_LOCK)

since you keep DR6.[bit 11] reserved in this version. bit 11 of 
debug_read_clear_dr6() being set to 1 means bus lock detected.


> +		handle_bus_lock(regs);
> +
>   	/* Add the virtual_dr6 bits for signals. */
>   	dr6 |= current->thread.virtual_dr6;
>   	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
> 

