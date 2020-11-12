Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCC2B0B31
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgKLRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgKLRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:21:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B3A20759;
        Thu, 12 Nov 2020 17:21:08 +0000 (UTC)
Date:   Thu, 12 Nov 2020 12:21:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3 v5] ftrace: Have the callbacks receive a struct
 ftrace_regs instead of pt_regs
Message-ID: <20201112122106.50a3e3c3@gandalf.local.home>
In-Reply-To: <1605200348.x55f7x9h4h.naveen@linux.ibm.com>
References: <20201112011516.589846126@goodmis.org>
        <20201112011815.466562067@goodmis.org>
        <1605200348.x55f7x9h4h.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 22:38:53 +0530
"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:

> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> > index 629abaf25681..be73350955e4 100644
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -345,7 +345,7 @@ static inline void wait_for_kprobe_optimizer(void) 
> > { }
> >  #endif /* CONFIG_OPTPROBES */
> >  #ifdef CONFIG_KPROBES_ON_FTRACE
> >  extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > -				  struct ftrace_ops *ops, struct pt_regs *regs);
> > +				  struct ftrace_ops *ops, struct ftrace_regs *fregs);  
> 
> This breaks the build on non-x86 architectures that support 
> KPROBES_ON_FTRACE.

I thought I ran this on my cross tests build. :-/

But it seems this only updated x86. I thought I updated all the other
archs, but it appears that I didn't. I think I may have forgotten to do a
git commit properly.

Let me go and fix that (I have to update this series anyway).

Thanks for reporting.

-- Steve
