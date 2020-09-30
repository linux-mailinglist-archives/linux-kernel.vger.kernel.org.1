Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42AA27E783
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgI3LQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3LQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:16:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84499C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q5E2CrST+Pj8LazvfguW69/NnDg49gNZs3foWVXbBms=; b=njGt6THUdWvT8A0EX5Xm4bRHdD
        XGwxL4H2/6ByD0lu6tIsLPJsitC08HjGuX1GA5cUAH15KAmPE2b+8b0Nrwh2wCNUZzmIWM3QXpLOM
        nO0AXzz9hRJWvCnDqRmNeXM8+1dMl/qo+eX8t2voByeEGcaD4ZsHoHz0ewQKZ0N+dB9P35bOGL7xf
        wC5FiX4iiwVhkMnffO00Y88m/s79CdzhqvKByLGURHJoilxNNtZEn0ZjXhiq8Mp2vf/CVwL5e2HqM
        v3sPBfAm72i4XQOKI458OpQUY4MW4omuNrVoIc3/7Pd7I1hq55+7Kid0BJBUqxnRMzAFosjHCy0+A
        v7CeArfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNa5m-0002Ke-Qa; Wed, 30 Sep 2020 11:16:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A7003003D8;
        Wed, 30 Sep 2020 13:16:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18C8C200D90B3; Wed, 30 Sep 2020 13:16:12 +0200 (CEST)
Date:   Wed, 30 Sep 2020 13:16:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        segher@kernel.crashing.org, ndesaulniers@google.com
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 08:38:03AM -0700, Dave Hansen wrote:
> On 9/27/20 3:51 AM, Greg Kroah-Hartman wrote:
> >> +static inline long acrn_hypercall0(unsigned long hcall_id)
> >> +{
> >> +	register long r8 asm("r8");
> >> +	long result;
> >> +
> >> +	/* Nothing can come between the r8 assignment and the asm: */
> >> +	r8 = hcall_id;
> >> +	asm volatile("vmcall\n\t"
> >> +		     : "=a" (result)
> >> +		     : "r" (r8)
> >> +		     : );
> > What keeps an interrupt from happening between the r8 assignment and the
> > asm: ?
> 
> It's probably better phrased something like: "No other C code can come
> between this r8 assignment and the inline asm".  An interrupt would
> actually be fine in there because interrupts save and restore all
> register state, including r8.
> 
> The problem (mentioned in the changelog) is that gcc does not let you
> place data directly into r8.  But, it does allow you to declare a
> register variable that you can assign to use r8.  There might be a
> problem if a function calls was in between and clobber the register,
> thus the "nothing can come between" comment.
> 
> The comment is really intended to scare away anyone from adding printk()'s.
> 
> More information about these register variables is here:
> 
> > https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html#Local-Register-Variables
> 
> Any better ideas for comments would be greatly appreciated.  It has 4 or
> 5 copies so I wanted it to be succinct.

This is disguisting.. Segher, does this actually work? Nick, does clang
also support this?

