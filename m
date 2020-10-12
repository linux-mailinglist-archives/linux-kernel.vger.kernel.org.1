Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33B028B08C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgJLItW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:49:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:1643 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLItW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:49:22 -0400
IronPort-SDR: Rc7/ORsciR8IfVtMOMF3PMKrp7mU35INAn0VkwBtDcyC9VRH6wmUASGXxiyZQg52j/IkpSScro
 QsmSsQiNxS4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="227354764"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="227354764"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:49:20 -0700
IronPort-SDR: W1INldpGY4WqOBSuCGNqDxKaU7e5QiWC0MXW4CQcmPLo3L0C5gq8GYxjsbb405PCqAK5FI3a2z
 5LbWkluJdnCQ==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="463027628"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:49:14 -0700
Date:   Mon, 12 Oct 2020 16:49:12 +0800
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
        Yakui Zhao <yakui.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201012084912.GL1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200930105408.GE6810@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200930105408.GE6810@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30.Sep'20 at 12:54:08 +0200, Borislav Petkov wrote:
>On Tue, Sep 22, 2020 at 07:42:58PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> The Service VM communicates with the hypervisor via conventional
>> hypercalls. VMCALL instruction is used to make the hypercalls.
>>
>> ACRN hypercall ABI:
>>   * Hypercall number is in R8 register.
>>   * Up to 2 parameters are in RDI and RSI registers.
>>   * Return value is in RAX register.
>
>I'm assuming this is already cast in stone in the HV and it cannot be
>changed?

Yes, it is.

>
>> Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
>> register as direct register constraints, here are two ways to use R8 in
>> extended asm:
>>   1) use explicit register variable as input
>>   2) use supported constraint as input with a explicit MOV to R8 in
>>      beginning of asm
>>
>> The number of instructions of above two ways are same.
>> Asm code from 1)
>>   38:   41 b8 00 00 00 80       mov    $0x80000000,%r8d
>>   3e:   48 89 c7                mov    %rax,%rdi
>>   41:   0f 01 c1                vmcall
>> Here, writes to the lower dword (%r8d) clear the upper dword of %r8 when
>> the CPU is in 64-bit mode.
>>
>> Asm code from 2)
>>   38:   48 89 c7                mov    %rax,%rdi
>>   3b:   49 b8 00 00 00 80 00    movabs $0x80000000,%r8
>>   42:   00 00 00
>>   45:   0f 01 c1                vmcall
>>
>> Choose 1) for code simplicity and a little bit of code size
>> optimization.
>
>What?
>
>How much "optimization" is this actually? A couple of bytes?
>
>And all that for this
>
>	/* Nothing can come between the r8 assignment and the asm: */
>
>restriction?
>
>If it is only a couple of bytes, just do the explicit MOV to %r8 and
>f'get about it.

Yes. Just a couple of bytes. Number of instructions is same.
sure, i can change to approach 2)
  2) use supported constraint as input with a explicit MOV to R8
     in beginning of asm

Thanks
shuo
