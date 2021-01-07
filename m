Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3D2ED4C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbhAGQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbhAGQut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:50:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FD5C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=rb4F5xJQKldJf/cJL0f/KIXdnuLMI8qRmMYhEVccwXE=; b=eYfxvEdvysLKF23gRLdF56/9NJ
        kv6CO+byUoZGm24ypu2+h74bCEtliBmyVzR6d5CwzkXnUTvQY8aBw4+W6qsz55fZmmYBwIR1WbS8l
        e9Vc8V9H6bVx+MC0DEErZdKVwoAHt3T9VUBdFlQk+cpS07BBMB/bKePxNYyliDEzXC8q1+Tp5/MOL
        DvlZiY2XDxPgxwHl6tnrynb5c3WyiaEEKb/TyCGz8Qxl9aVSFLsJfi8qaIhwaa5yY8CGPnI3bM63l
        Sc1lKnwFcq90mwJ0832l4bvUZ0OqEhyNbsOHt/zTmW+Swowa/r6EdPkn4F+UlQXavkRI8oLRKoeGn
        QFkHYgkQ==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxYTu-0008M8-Dp; Thu, 07 Jan 2021 16:49:50 +0000
Subject: Re: [PATCH 7/6] x86: __always_inline __{rd,wr}msr()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        sfr@canb.auug.org.au, tony.luck@intel.com
References: <20210106143619.479313782@infradead.org>
 <20210106144017.532902065@infradead.org>
 <dc6e7e19-881a-c778-22df-15176db4aeb9@infradead.org>
 <X/bWK1tNB6mtm0Bu@hirez.programming.kicks-ass.net>
 <X/bf3gV+BW7kGEsB@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8de5e0f4-e3c4-cd91-c34c-f214e9db52c7@infradead.org>
Date:   Thu, 7 Jan 2021 08:49:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/bf3gV+BW7kGEsB@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 2:18 AM, Peter Zijlstra wrote:
> On Thu, Jan 07, 2021 at 10:36:43AM +0100, Peter Zijlstra wrote:
>> On Wed, Jan 06, 2021 at 09:59:17AM -0800, Randy Dunlap wrote:
>>> On 1/6/21 6:36 AM, Peter Zijlstra wrote:
>>>> When the compiler fails to inline; we violate nonisntr:
>>>>
>>>>   vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xc7: call to sev_es_wr_ghcb_msr() leaves .noinstr.text section
>>>
>>> I am still seeing (a variant of) this one:
>>>
>>> vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xce: call to __wrmsr.constprop.14() leaves .noinstr.text section
>>
>> Gah, sorry, I managed to mess up my .config :/ /me goes try again.
> 
> OK, restored your original .config and that did indeed reproduce, the
> below cures it.
> 
> ---
> 
> Subject: x86: __always_inline __{rd,wr}msr()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Jan  7 11:14:25 CET 2021
> 
> When the compiler choses to not inline the trivial MSR helpers:
> 
>   vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xce: call to __wrmsr.constprop.14() leaves .noinstr.text section
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/x86/include/asm/msr.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -86,7 +86,7 @@ static inline void do_trace_rdpmc(unsign
>   * think of extending them - you will be slapped with a stinking trout or a frozen
>   * shark will reach you, wherever you are! You've been warned.
>   */
> -static inline unsigned long long notrace __rdmsr(unsigned int msr)
> +static __always_inline unsigned long long __rdmsr(unsigned int msr)
>  {
>  	DECLARE_ARGS(val, low, high);
>  
> @@ -98,7 +98,7 @@ static inline unsigned long long notrace
>  	return EAX_EDX_VAL(val, low, high);
>  }
>  
> -static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
> +static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
>  {
>  	asm volatile("1: wrmsr\n"
>  		     "2:\n"
> 


-- 
~Randy
