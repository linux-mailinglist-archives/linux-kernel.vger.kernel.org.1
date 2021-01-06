Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F148A2EBADC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbhAFHx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:53:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:58640 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbhAFHxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:53:22 -0500
IronPort-SDR: Ir8vJOleTLztTCE255dgnsUbRiYA5/h/Yc7BdGhfgkxDPc/sqYQqTPDI2Ha0duGKNaiMA4JhJA
 AlcZVV1BS8kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="164315970"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="164315970"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:52:41 -0800
IronPort-SDR: vzSTcC9jT6yZ03ArRvQdODG5E7MR8/CJtMqxNGXdMsj+MOstxE4FSxYB+W2YpbaY3bmxdTkRtI
 xJLPlPXnZnyg==
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="346565754"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:52:37 -0800
Date:   Wed, 6 Jan 2021 15:52:35 +0800
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v6 04/18] x86/acrn: Introduce hypercall interfaces
Message-ID: <20210106075235.GA22447@shuo-intel.sh.intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-5-shuo.a.liu@intel.com>
 <20201230173305.GF22022@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201230173305.GF22022@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30.Dec'20 at 18:33:05 +0100, Borislav Petkov wrote:
>On Tue, Dec 01, 2020 at 05:38:39PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> The Service VM communicates with the hypervisor via conventional
>> hypercalls. VMCALL instruction is used to make the hypercalls.
>>
>> ACRN hypercall ABI:
>>   * Hypercall number is in R8 register.
>>   * Up to 2 parameters are in RDI and RSI registers.
>>   * Return value is in RAX register.
>>
>> Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
>> register as direct register constraints, use supported constraint as
>> input with a explicit MOV to R8 in beginning of asm.
>>
>> Originally-by: Yakui Zhao <yakui.zhao@intel.com>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Fengwei Yin <fengwei.yin@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Arvind Sankar <nivedita@alum.mit.edu>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
>> ---
>>  arch/x86/include/asm/acrn.h | 54 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>
>The x86 bits in patches 2-4 look ok now, thanks!
>
>Acked-by: Borislav Petkov <bp@suse.de>

Thanks for review!

Shuo
