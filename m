Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DDB2F6547
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbhANPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbhANPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:55:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34ACC061574;
        Thu, 14 Jan 2021 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c2nISwHQ1sx1QefEbT/WP5EtkYbOPh92hLF5ZFROw5s=; b=Z7qUy0klmVjhHzu7z3/kBZZ980
        BDKXGXlv1KfhzvOE8LNibSsP/SSpcv6nIiEaeVcHE28jt3hKYvGogPOfBXCmXDqT3Pa5iZV6ox00u
        GEQEdu5l8wneIoXlP9FxK3yMAaenV8rfZZT2PyzgQk4rPDabTdzsGmRkbEgfyx4MkKFB3dNuTA/TC
        xKg4PGtQn2obK2nOt6RtgADNbI1xAQFzhAsHOsUbcArN7b/zWl0Wg5z9F73mXwoViZsrWeeNmYwu0
        fWhSKrztLVudzCnlHcsOfVwFwUpPIytO3A7/ryPjZsMFyM/Kz7k27jA73pN7BKjag9FW79YOtbfa4
        EtpduV3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l04vm-007kuA-SO; Thu, 14 Jan 2021 15:53:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0306D301324;
        Thu, 14 Jan 2021 16:53:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5EDC20079488; Thu, 14 Jan 2021 16:53:01 +0100 (CET)
Date:   Thu, 14 Jan 2021 16:53:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] x86/entry: Remove put_ret_addr_in_rdi THUNK macro
 argument
Message-ID: <YABo3bw8fPdjWZ+Y@hirez.programming.kicks-ass.net>
References: <20210112115421.GB13086@zn.tnic>
 <20210112194625.4181814-1-ndesaulniers@google.com>
 <20210112210154.GI4646@sirena.org.uk>
 <20210113165923.acvycpcu5tzksbbi@treble>
 <CAKwvOdnAMsYF-v1LAqttBV3e3rHhSFZmPcRRV0+v=+9AyMFgNA@mail.gmail.com>
 <20210114103928.GB12284@zn.tnic>
 <YAAszZJ2GcIYZmB5@hirez.programming.kicks-ass.net>
 <20210114132809.GC12284@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114132809.GC12284@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 02:28:09PM +0100, Borislav Petkov wrote:
> On Thu, Jan 14, 2021 at 12:36:45PM +0100, Peter Zijlstra wrote:
> > And while looking, I suppose we can delete the put_ret_addr_in_rdi crud,
> > but that's another patch.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Thu, 14 Jan 2021 14:25:35 +0100
> Subject: [PATCH] x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument
> 
> That logic is unused since
> 
>   320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
> 
> Remove it.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by; Peter Zijlstra (Intel) <peterz@infradead.org>
