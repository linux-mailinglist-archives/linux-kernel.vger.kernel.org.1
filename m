Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29232A3CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKCG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:27:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:15383 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCG1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:27:24 -0500
IronPort-SDR: wsUM/cWouavsJxsdYGckKAczmVY9w9UXWw0G3+e56VHnTBmuj6KloM/gv6KUFYZvZUkaySB7FD
 WKKTbw5P1r+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="230635754"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="230635754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 22:27:23 -0800
IronPort-SDR: rRNqDHkbbWSfJZ+Q8GJgxohO1GjU5Gw1DoIgCmDOHq0SErQy85b9F+P0wzg9u/3gfq6e63QFFF
 rHI6neLJu11w==
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="470670550"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 22:27:20 -0800
Date:   Tue, 3 Nov 2020 14:27:18 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v5 03/17] x86/acrn: Introduce an API to check if a VM is
 privileged
Message-ID: <20201103062718.GD12408@shuo-intel.sh.intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-4-shuo.a.liu@intel.com>
 <20201102143707.GC15392@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201102143707.GC15392@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Mon  2.Nov'20 at 15:37:07 +0100, Borislav Petkov wrote:
>On Mon, Oct 19, 2020 at 02:17:49PM +0800, shuo.a.liu@intel.com wrote:
>> +bool acrn_is_privileged_vm(void)
>> +{
>> +	return cpuid_eax(acrn_cpuid_base() | ACRN_CPUID_FEATURES) &
>> +			 ACRN_FEATURE_PRIVILEGED_VM;
>
>I asked in the previous review why that acrn_cpuid_base() is used here,
>you said that the base might vary. Looking at hypervisor_cpuid_base(),
>it searches in the range [0x40000000, 0x40010000] with an 0x100 offset.
>
>So you're saying that ACRN_CPUID_FEATURES is the first leaf beyond the
>base. Close?

Yes.

>
>If so, why isn't the code doing this?
>
>	return cpuid_eax(acrn_cpuid_base() + 1)...
>
>and why doesn't it have a comment above it explaining that the base can
>change and it needs to be discovered each time?

The code just followed KVM style (see kvm_arch_para_features()).
I can change to use
	cpuid_eax(acrn_cpuid_base() + 1)...
If you prefer to.

hypervisor_cpuid_base() implies the base is variable, no? We use
this function to detect the base.

>
>> +EXPORT_SYMBOL_GPL(acrn_is_privileged_vm);
>
>Also, that acrn_is_privileged_vm() silly helper is used only once and
>I don't like the exported symbols pollution we're doing. So make that
>function give you the eax of ACRN_CPUID_FEATURES and callers can do
>their testing themselves.

OK. Then i will define acrn_cpuid_base() as a static inline function in
asm/acrn.h for callers.

>
>When it turns out that code patterns get repeated, you can then
>aggregate stuff into a helper.

Got it. Thanks.

Thanks
shuo
