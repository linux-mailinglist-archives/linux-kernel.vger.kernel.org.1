Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60602FFAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhAVDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:21:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:21647 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbhAVDV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:21:27 -0500
IronPort-SDR: HTrKpBgI0NUmOO3ofCqVBuL1bF4BTFpctfy6w7wMjnr0quGXU1WKCBQ71XHJdBb/FIHq0JdH8y
 ug5E+bGePyvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="198129875"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="198129875"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 19:19:36 -0800
IronPort-SDR: jH04a57aMKeVtAXTtbLk4D3Ap7/MQk1yH9/4muPQ+K5nD71B/P4zOgI761fnpB3k+0lgvcfVtG
 6geKtOvm55zQ==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="427636494"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.93]) ([10.238.4.93])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 19:19:33 -0800
Subject: Re: [PATCH] x86/perf: Use static_call for x86_pmu.guest_get_msrs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel test robot <lkp@intel.com>
References: <20210118072151.44481-1-like.xu@linux.intel.com>
 <202101182008.jQybUDa0-lkp@intel.com>
 <a82754e7-9a2d-7ab4-466d-fc0d51a3b7f2@linux.intel.com>
 <YAWOhxi6Vxiq8JLR@hirez.programming.kicks-ass.net>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <7f31ae2f-25a1-a7fb-1598-a8f21f3bc447@linux.intel.com>
Date:   Fri, 22 Jan 2021 11:19:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAWOhxi6Vxiq8JLR@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/18 21:35, Peter Zijlstra wrote:
> On Mon, Jan 18, 2021 at 09:05:06PM +0800, Like Xu wrote:
>> I guess this fix will silence the compiler error,
>> and v2 will be sent after the local 0day test passes.
> 
> I think there's also a problem where you don't assign a function at all.

Thank you!

> 
> I think you want something like
> 
> 	if (!x86_pmu.guest_get_msr)
> 		x86_pmu.guest_get_msr = guest_get_msr_nop;
> 
> right before x86_pmu_static_call_update();
> 
> And then have it be something like:
> 
> static void *guest_et_msr_nop(int *nr)

The [-Werror=incompatible-pointer-types] will yell at "void *".

Please review the v2 version.

https://lore.kernel.org/lkml/20210122030324.2754492-1-like.xu@linux.intel.com/T/#u

> {
> 	*nr = 0;
> 	return NULL;
> }
> 
> and then you can reduce the entire thing to:
> 
> struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
> {
> 	return static_call(x86_pmu_guest_get_msrs)(nr);
> }
> 

