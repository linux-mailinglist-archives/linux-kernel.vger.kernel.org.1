Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB572D89DE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407863AbgLLUCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 15:02:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407856AbgLLUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 15:02:16 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607803294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B0wIRxjcjQ7ZdgzDFFckloI+mr3zEeiymdJuPWTPIcM=;
        b=iLC+wGnYUxjA7ENBbnFotIvjaGmm7XzqnLQqRavvDv3DonD+3JbfdkUjxXnz22KCzM7EeO
        niOAFkazH8lRQYKVA8jtuK6lkl11rZsqqybfl+K0rJtu4r7iPi1Xn4dU4sj/8e5tdRwTjA
        +tNUpop85c/2krtXcveRQWtJhWoNQORnUDJ1zIPoKCmx3lgn44bNB685+Phay1XuMKSh1B
        H2B2+mKb65RYEcy6LWH7gJ830MJ3nKReCRF4lCnv2g03xpZOyQ5LhNK++6ezk6ozpgWVnj
        pc7oyulPjhX59XNFzJ4ZKzXXBE2xZqkRXokgfNwQtNd5TSLEQIs3iJ/TxKIjvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607803294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B0wIRxjcjQ7ZdgzDFFckloI+mr3zEeiymdJuPWTPIcM=;
        b=2OhEMJV46E0LhVsywuxOM+MRJd4KnCzdTI5+F5+BqtM4dj6fwTxmMG6WrTs0AYNeoHB9GM
        JfFxRmjPvde1uFBw==
To:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
In-Reply-To: <X9S28TcEXd2zghzp@elver.google.com>
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
Date:   Sat, 12 Dec 2020 21:01:34 +0100
Message-ID: <87czzeg5ep.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12 2020 at 13:26, Marco Elver wrote:
> On Thu, Mar 07, 2019 at 10:14AM +0100, Arnd Bergmann wrote:
>> -static void __init futex_detect_cmpxchg(void)
>> +static noinline void futex_detect_cmpxchg(void)
>>  {
>>  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
>>  	u32 curval;
>
> What ever happened to this patch?

It obviously fell through the cracks. 

> I'm seeing this again with the attached config + next-20201211 (for
> testing https://bugs.llvm.org/show_bug.cgi?id=48492). Had to apply this
> patch to build the kernel.

What really bothers me is to remove the __init from a function which is
clearly only used during init. And looking deeper it's simply a hack.

This function is only needed when an architecture has to runtime
discover whether the CPU supports it or not. ARM has unconditional
support for this, so the obvious thing to do is the below.

Thanks,

        tglx
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -86,6 +86,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IDE if PCI || ISA || PCMCIA


