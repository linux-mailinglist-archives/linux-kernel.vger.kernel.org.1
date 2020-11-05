Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E02A760C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbgKEDZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:25:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:33200 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgKEDZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:25:30 -0500
IronPort-SDR: sN/RHjDqsqwzMR6fit0MjqcVnU3BHeHERWWjyebTcglCbPDrKcY+1TW7dE4oUCi5JFgMR1sh7m
 fjafLuvvxG6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="233482034"
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="233482034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 19:25:29 -0800
IronPort-SDR: ZrKPoAYYgtTJyDiXIauVM/1+ylNUbJXxAgclTUOzApmsa9zIkdUb2zFQTCWBPnnbKtl2PmLmQo
 E4jqBJvvBHmQ==
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="471474907"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 19:25:24 -0800
Date:   Thu, 5 Nov 2020 11:25:22 +0800
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
Message-ID: <20201105032522.GC17702@shuo-intel.sh.intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-4-shuo.a.liu@intel.com>
 <20201102143707.GC15392@zn.tnic>
 <20201103062718.GD12408@shuo-intel.sh.intel.com>
 <20201103102538.GB6310@zn.tnic>
 <20201104035027.GA17702@shuo-intel.sh.intel.com>
 <20201104185157.GE23298@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201104185157.GE23298@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed  4.Nov'20 at 19:51:57 +0100, Borislav Petkov wrote:
>On Wed, Nov 04, 2020 at 11:50:27AM +0800, Shuo A Liu wrote:
>> On Tue  3.Nov'20 at 11:25:38 +0100, Borislav Petkov wrote:
>> > On Tue, Nov 03, 2020 at 02:27:18PM +0800, Shuo A Liu wrote:
>> > > The code just followed KVM style (see kvm_arch_para_features()).
>> >
>> > Do you see Documentation/virt/kvm/cpuid.rst?
>>
>> OK. It documents the leaf number.
>
>It also says
>
>"Note also that old hosts set eax value to 0x0. This should be
>interpreted as if the value was 0x40000001."

Ok.

>
>Does this hold true for the acrn HV? The fact that I'm asking about
>all those things should give you a hint that documenting the API is
>important.

No, acrn HV is always return eax with maximum leaf number.

Let me add the document.

>
>> > Now where is yours explaining what your hypervisor is doing?
>>
>> Currently, it is in arch/x86/include/asm/acrn.h.
>
>Yeah, you can't expect people to go scrape it from headers though - it
>should be concentrated in a doc file.
>
>> If the leaf numbers be documented explicitly (like kvm), i think i can
>> use them as eax of cpuid_eax() directly (back to your first comment).
>
>Which means, you don't need to do the logical OR-ing which kvm does
>because of what I pasted above about eax being 0 on old hosts. Now we're
>getting somewhere...

Yes.

>
>> 	cpuid_eax(ACRN_CPUID_FEATURES)...
>>
>> If you looking at implementation of acrn-hypervisor, you will found the
>> leaf number is hardcoded in the hypervisor. So, they also can be
>> documented explicitly.
>
>Ok.
>
>> OK. I can add a similar cpuid.rst for acrn.
>
>Yes please.
>
>> Yes. Fix patches are always welcome.
>
>Ok, good, the thing is open. You could put that in the doc too, along
>with the link so that people can find it.

OK.

Thanks
shuo
