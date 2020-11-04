Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6207D2A5D34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKDDud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:50:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:34726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgKDDud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:50:33 -0500
IronPort-SDR: VJA2ECPWJDqCFgi5fB4xh2J725WZPHI+9TtJogWQw9NpZ6jSfbo4Ik5QJqgom6Wwmb++VJlA0H
 QYAw5lHrZyMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="156150906"
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="156150906"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 19:50:32 -0800
IronPort-SDR: 7yLk8WgFV8IulWqBll0qQ6AUNBY5g7xGXO9konAWwj4X58tWoOMfV0V8tuiQEym4OjOKV17AWd
 aLJRalIs5AIg==
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="538742905"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 19:50:29 -0800
Date:   Wed, 4 Nov 2020 11:50:27 +0800
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
Message-ID: <20201104035027.GA17702@shuo-intel.sh.intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-4-shuo.a.liu@intel.com>
 <20201102143707.GC15392@zn.tnic>
 <20201103062718.GD12408@shuo-intel.sh.intel.com>
 <20201103102538.GB6310@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201103102538.GB6310@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  3.Nov'20 at 11:25:38 +0100, Borislav Petkov wrote:
>On Tue, Nov 03, 2020 at 02:27:18PM +0800, Shuo A Liu wrote:
>> The code just followed KVM style (see kvm_arch_para_features()).
>
>Do you see Documentation/virt/kvm/cpuid.rst?

OK. It documents the leaf number.

>
>Now where is yours explaining what your hypervisor is doing?

Currently, it is in arch/x86/include/asm/acrn.h.

>
>> I can change to use
>> 	cpuid_eax(acrn_cpuid_base() + 1)...
>> If you prefer to.
>
>Yes please.

Sure.

If the leaf numbers be documented explicitly (like kvm), i think i can
use them as eax of cpuid_eax() directly (back to your first comment).
	cpuid_eax(ACRN_CPUID_FEATURES)...

If you looking at implementation of acrn-hypervisor, you will found the
leaf number is hardcoded in the hypervisor. So, they also can be
documented explicitly.

>
>> hypervisor_cpuid_base() implies the base is variable, no? We use
>> this function to detect the base.
>
>Yes, but you need to document all that and make it clear and
>understandable. If Linux is supposed to run as an acrn guest, that
>interface better be documented just like KVM does.

OK. I can add a similar cpuid.rst for acrn.

>
>Also, if there's a bug in the KVM guest/host interface, we might be able
>to fix it modulo ABI. Is that possible with acrn?
>
>I'm guessing the answer to that is yes if I'm looking at
>
>https://github.com/projectacrn/acrn-hypervisor
>
>?

Yes. Fix patches are always welcome.

>
>> OK. Then i will define acrn_cpuid_base() as a static inline function
>> in asm/acrn.h for callers.
>
>Yah, that function is simple enough.


Thanks
shuo
