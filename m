Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB842EF993
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbhAHUoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:44:17 -0500
Received: from casper.infradead.org ([90.155.50.34]:51166 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbhAHUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:44:17 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jan 2021 15:43:25 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kZwQDcY9IPyAacZ9EASbsQdMDFZNvjFkh9XlDF5I9d8=; b=SOBZmwdcPVEFA8Pm/sOpe1xWEN
        wwHMx8BXhAMOtT7aQFe9DAzM8Wr3UbRUqObP/U7ACVMKqU4KJEP7qbjPU8W15YWqnQfwIX/3gKmiq
        SrR//oL9vNxlQ8IBx01hn+Zahj/CJC+TfE5CFgP4InlP7gLe5GNcMCSUUMlZAQmHOZAfelEdbTiBP
        P4MFRZgTxW35uV4VDZflQWmgoMAji6lPFRuU/NF8UAl7vUe10NBJc2KZ9PGwF1PTJMAGReye1GnAt
        /WJQ7pkUI4UuXO/HJN0MDv3mmgEzegTd9mnfIvG+okrFjUKIbNdvQgRE7cNoVFxlvZLDTq/5bYioz
        5ju04Iqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxUru-0002K8-Ds; Thu, 07 Jan 2021 12:58:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 595AF3013E5;
        Thu,  7 Jan 2021 13:58:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4747D200D4B98; Thu,  7 Jan 2021 13:58:21 +0100 (CET)
Date:   Thu, 7 Jan 2021 13:58:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: Re: [RFC][PATCH 6/6] x86/mce: Dont use noinstr for now
Message-ID: <X/cFbZVSFXLuj40Q@hirez.programming.kicks-ass.net>
References: <20210106143619.479313782@infradead.org>
 <20210106144017.779081583@infradead.org>
 <8B866DA6-ED68-4681-8D83-A23E8F18E77C@alien8.de>
 <20210107100626.GG14697@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107100626.GG14697@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:06:26AM +0100, Borislav Petkov wrote:
> On Wed, Jan 06, 2021 at 03:57:55PM +0100, Boris Petkov wrote:
> > Another thing that we could do is carve out only the stuff which needs
> > to be noinstr into a separate compilation unit and disable tracing
> > only for that while keeping the rest traceable. Need to try it to see
> > how ugly it'll get...
> 
> Something like the below, it barely builds.
> 
> I haven't found out whether I can even do
> 
> ccflags-remove
> 
> on a per-file basis, I guess I cannot so that's not there yet.
> 
> core_noinstr.c ended up containing all the code needed by the #MC
> handler so that should be ok-ish, carve-out-wise.
> 
> Also, I've exported a bunch of functions which are in mce/core.c through
> the internal.h header so that core_noinstr.c can call them. There are
> no more objtool warnings but if it turns out that we have to move those
> functions:
> 
> +/* core_noinstr.c */
> +bool mce_check_crashing_cpu(void);
> +void print_mce(struct mce *m);
> +void mce_reset(void);
> +bool whole_page(struct mce *m);
> +u64 mce_rdmsrl(u32 msr);
> +void mce_wrmsrl(u32 msr, u64 v);
> +void mce_read_aux(struct mce *m, int i);
> +void mce_gather_info(struct mce *m, struct pt_regs *regs);
> 
> to core_noinstr.c after all, then we can do your solution directly.
> 
> Ok, gnight. :-)
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
> index 9f020c994154..2fa36118a05f 100644
> --- a/arch/x86/kernel/cpu/mce/Makefile
> +++ b/arch/x86/kernel/cpu/mce/Makefile
> @@ -1,5 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y				=  core.o severity.o genpool.o
> +# No instrumentation for #MC handler code
> +KASAN_SANITIZE_core_instr.o	:= n
> +UBSAN_SANITIZE_core_instr.o	:= n
> +KCOV_INSTRUMENT_core_instr.o	:= n

ifdef CONFIG_FUNCTION_TRACER
CFLAGS_REMOVE_core_instr.o = $(CC_FLAGS_FTRACE)
endif

> +
> +obj-y				=  core.o core_noinstr.o severity.o genpool.o

I'm thinking
