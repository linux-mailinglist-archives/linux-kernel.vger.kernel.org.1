Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45128D9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgJNGDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:03:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:50171 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgJNGDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:03:03 -0400
IronPort-SDR: z9LmIVX4+1J+zPx3s0v+FOjBbtO/IA/T2jcLBlVO2MPxc8Zbzvm0Rtn+AsQ2DtbJJM+JUvje0y
 xgbulsZq7V3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="152981074"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="152981074"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 23:03:03 -0700
IronPort-SDR: xx+Nl1AYmulD7/nlguq4O232Az5cnWWaOZiIWz2fr8+9RIWep27uRKNOnKj7+aHQPOKQDTNU73
 hCMI89bv8YUg==
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="463764697"
Received: from kwhitemx-mobl.amr.corp.intel.com (HELO [10.213.181.206]) ([10.213.181.206])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 23:03:02 -0700
Subject: Re: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area
 on first use
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Brown, Len" <len.brown@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <c4669d5f-11b8-3879-562c-78a791b86229@intel.com>
 <78F221DB-CB61-40DB-9C6F-6C86D0F1BCDF@amacapital.net>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <226772b9-7109-c632-2e9a-372df38b81a0@intel.com>
Date:   Tue, 13 Oct 2020 23:03:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <78F221DB-CB61-40DB-9C6F-6C86D0F1BCDF@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 6:11 PM, Andy Lutomirski wrote:
> I have no problem with vmalloc(), but I do have a problem with
> vfree() due to the IPIs that result. We need a cache or something.

This sounds like the kind of thing we should just build into vmalloc()
instead of having a bunch of callers implement their own caches.  It
shouldn't be too much of a challenge to have vmalloc() keep a cacheline
or two of stats about common vmalloc() sizes and keep some pools around.

It's not going to be hard to implement caches to reduce vfree()-induced
churn, but I'm having a hard time imaging that it'll have anywhere near
the benefits that it did for stacks.  Tasks fundamentally come and go a
*lot*, and those paths are hot.

Tasks who go to the trouble to populate 8k or 64k of register state
fundamentally *can't* come and go frequently.  We also (probably) don't
have to worry about AMX tasks doing fork()/exec() pairs and putting
pressure on vmalloc().  Before an app can call out to library functions
to do the fork, they've got to save the state off themselves and likely
get it back to the init state.  The fork() code can tell AMX is in the
init state and decline to allocate actual space for the child.

> I have to say: this mechanism is awful. Can we get away with skipping
> the dynamic XSAVES mess entirely?  What if we instead allocate
> however much space we need as an array of pages and have one percpu
> contiguous region. To save, we XSAVE(S or C) just the AMX state to
> the percpu area and then copy it.  To restore, we do the inverse.  Or
> would this kill the modified optimization and thus be horrible?

Actually, I think the modified optimization would survive such a scheme:

 * copy page array into percpu area
 * XRSTORS from percpu area, modified optimization tuple is saved
 * run userspace
 * XSAVES back to percpu area.  tuple matches, modified optimization
   is still in play
 * copy percpu area back to page array

Since the XRSTORS->XSAVES pair is both done to the percpu area, the
XSAVE tracking hardware never knows it isn't working on the "canonical"
buffer (the page array).

It seems a bit ugly, but it's not like an 8k memcpy() is *that* painful.
 The double dcache footprint isn't super nice, though.

Chang, I think that leaves us with three possibilities:

1. use plain old vmalloc()
2. use vmalloc(), but implement caches for large XSAVE state, either in
   front of, or inside the vmalloc() API
3. Use a static per-cpu buffer for XSAVE*/XRSTOR* and memcpy() to/from
   a scattered list of pages.

A #4 also comes to mind:

Do something somewhat like kmap_atomic().  Map the scattered pages
contiguously and use XSAVE*/XRSTOR* directly, but unmap immediately
after XSAVE*/XRSTOR*.  For ~12k of state, I suspect the ~400-500 cycles
for 3 INVLPG's might beat out a memcpy() of 12k of state.

Global TLB invalidations would not be required.

I have to say, though, that I'd be OK with sticking with plain old
vmalloc() for now.
