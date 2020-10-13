Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6040628C734
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgJMCoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:44:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:51305 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgJMCoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:44:23 -0400
IronPort-SDR: B1kp5NLImV8kaLcHd4OSebv2l8lBrmOJbEPrHmLDqBkF2Va8u3CKgnAdec/tg24UYIsUHafOl9
 avut6fpWh//A==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165047936"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="165047936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 19:44:23 -0700
IronPort-SDR: lWdiXz+T4KiijsEjiqrjEYORvDRsWS2jBywAPiYgeffHw8AGc2wVXmy1vxOXpUSEbdN2/OTD0i
 LPE87mIblDSw==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="530208643"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 19:44:18 -0700
Date:   Tue, 13 Oct 2020 10:44:16 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201013024416.GN1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
 <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
 <20200930161036.GY28786@gate.crashing.org>
 <20200930171346.GC2628@hirez.programming.kicks-ass.net>
 <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com>
 <20201012084431.GK1057@shuo-intel.sh.intel.com>
 <20201012164916.GA613777@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201012164916.GA613777@rani.riverdale.lan>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12.Oct'20 at 12:49:16 -0400, Arvind Sankar wrote:
>On Mon, Oct 12, 2020 at 04:44:31PM +0800, Shuo A Liu wrote:
>> On Wed 30.Sep'20 at 12:14:03 -0700, Nick Desaulniers wrote:
>> >On Wed, Sep 30, 2020 at 10:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> >>
>> >> On Wed, Sep 30, 2020 at 11:10:36AM -0500, Segher Boessenkool wrote:
>> >>
>> >> > Since this variable is a local register asm, on entry to the asm the
>> >> > compiler guarantees that the value lives in the assigned register (the
>> >> > "r8" hardware register in this case).  This all works completely fine.
>> >> > This is the only guaranteed behaviour for local register asm (well,
>> >> > together with analogous behaviour for outputs).
>> >>
>> >> Right, that's what they're trying to achieve. The hypervisor calling
>> >> convention needs that variable in %r8 (which is somewhat unfortunate).
>> >>
>> >> AFAIK this is the first such use in the kernel, but at least the gcc-4.9
>> >> (our oldest supported version) claims to support this.
>> >>
>> >> So now we need to know if clang will actually do this too..
>> >
>> >Does clang support register local storage? Let's use godbolt.org to find out:
>> >https://godbolt.org/z/YM45W5
>> >Looks like yes. You can even check different GCC versions via the
>> >dropdown in the top right.
>> >
>> >The -ffixed-* flags are less well supported in Clang; they need to be
>> >reimplemented on a per-backend basis. aarch64 is relatively well
>> >supported, but other arches not so much IME.
>> >
>> >Do we need register local storage here?
>> >
>> >static inline long bar(unsigned long hcall_id)
>> >{
>> >  long result;
>> >  asm volatile("movl %1, %%r8d\n\t"
>> >  "vmcall\n\t"
>> >    : "=a" (result)
>> >    : "ir" (hcall_id)
>> >    : );
>> >  return result;
>> >}
>>
>> Yeah, this approach is also mentioned in the changelog. I will change to
>> this way to follow your preference. With an addtional "r8" clobber what
>> Arvind mentioned.
>>
>> Thanks
>> shuo
>
>Btw, I noticed that arch/x86/xen/hypercall.h uses register-local
>variables already for its hypercalls for quite some time, so this
>wouldn't be unprecedented. [0]
>
>Do these calls also need a memory clobber? The KVM/xen hypercall functions
>all have one.

Yes. it's needed. I will add it. Thanks

>
>Thanks.
>
>[0] e74359028d548 ("xen64: fix calls into hypercall page")
