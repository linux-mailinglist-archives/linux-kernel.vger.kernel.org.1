Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051A92EAD67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbhAEOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbhAEOek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:34:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EADC322AAD;
        Tue,  5 Jan 2021 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609857239;
        bh=AHdWbMizLqWnjpEj20WLaJHtYbx1APROVD58O58/4TM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pfFv8oHCQfEKL1+B+bYmzio5mTzuyYpuZzA+SHLFOpbKQLU6Wb3epOTxTWhwmXLWV
         35doX1hTz1wsXFtsS0MqFOm/eL0IZVq9vUxTUMtKmAMEWo8LxAuxDH2Wi/VkDyscFl
         kQRv8XOxatHO3KJEDX068vnf6iHfosOIByVyxIDo14zcWd6djWaQFXsGukRpvz+Mil
         5WsIKR5R15tsZTl+pm9tU2iko+3cZbu4LrnPCUKKBqRKMzFsH7c72m/0zUh8muG3Lg
         qKZxmL4E7amNOI88D9O3g8ZypQhPe2W6t6IaMsYogq8yyaORUzbHDOgJE3WT8QCn0C
         j3QOlZ55ZDCAA==
Date:   Tue, 5 Jan 2021 23:33:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/ftrace: Disable multiple_kprobes test on
 powerpc
Message-Id: <20210105233356.33c3102c766ad040dc53b694@kernel.org>
In-Reply-To: <1609845480.pjhqgleg8n.naveen@linux.ibm.com>
References: <20210105065730.2634785-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210105190156.ada6ce0d46d7eada18b9ad76@kernel.org>
        <20210105191518.fc5e602cb10fb22ef1a2303d@kernel.org>
        <1609845480.pjhqgleg8n.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jan 2021 16:51:50 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Tue, 5 Jan 2021 19:01:56 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> On Tue,  5 Jan 2021 12:27:30 +0530
> >> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >> 
> >> > Not all symbols are blacklisted on powerpc. Disable multiple_kprobes
> >> > test until that is sorted, so that rest of ftrace and kprobe selftests
> >> > can be run.
> >> 
> >> This looks good to me, but could you try to find the functions
> >> which should be blocked from kprobes?
> >> (Usually, the function which are involved in the sw-breakpoint
> >>  handling, including locks etc.)
> > 
> > Ah, OK. 
> > I wonder why CONFIG_KPROBE_EVENTS_ON_NOTRACE=n doesn't help, it
> > was ignored if the arch doesn't support CONFIG_KPROBES_ON_FTRACE.
> 
> Good point, though we do support CONFIG_KPROBES_ON_FTRACE on powerpc so 
> the below patch is unlikely to help. However, since entry code is 
> unlikely to be the source of the issue due to 
> CONFIG_KPROBE_EVENTS_ON_NOTRACE, I will take another look to see where 
> the problem lies.

Yeah, if any issue happens even if the notrace function check is done,
there might be some other issues. (of course this depends on whether the
critical functions correctly annotated by notrace...)

> > Naveen, could you try to run this test case with following patch
> > on powerpc?
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index b911e9f6d9f5..241a55313476 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -433,7 +433,7 @@ static int disable_trace_kprobe(struct trace_event_call *call,
> >         return 0;
> >  }
> > 
> > -#if defined(CONFIG_KPROBES_ON_FTRACE) && \
> > +#if defined(CONFIG_FUNCTION_TRACER) && \
> >         !defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
> >  static bool __within_notrace_func(unsigned long addr)
> >  {
> > 
> 
> This looks like a good change regardless, so if you intend to post this 
> separately:
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
