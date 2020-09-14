Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383A526991D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINWnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgINWnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:43:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B108C20732;
        Mon, 14 Sep 2020 22:43:10 +0000 (UTC)
Date:   Mon, 14 Sep 2020 18:43:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200914184309.7a9de53a@gandalf.local.home>
In-Reply-To: <20200901232839.GB13346@codeaurora.org>
References: <20200813014552.23539-1-tingwei@codeaurora.org>
        <20200901232839.GB13346@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 07:28:39 +0800
Tingwei Zhang <tingweiz@codeaurora.org> wrote:

> Hi Alexander,
> 
> May I know your comments for this patch set?

I ran your patch set against get_maintainers.pl and it came up with this:

Alexander Shishkin <alexander.shishkin@linux.intel.com> (maintainer:SYSTEM TRACE MODULE CLASS)
Maxime Coquelin <mcoquelin.stm32@gmail.com> (maintainer:ARM/STM32 ARCHITECTURE)
Alexandre Torgue <alexandre.torgue@st.com> (maintainer:ARM/STM32 ARCHITECTURE)
Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)
Ingo Molnar <mingo@redhat.com> (maintainer:TRACING)
linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
linux-kernel@vger.kernel.org (open list)

I would use that to know who to send to.

You have Alexander, myself, Ingo and LKML, but you should add the others in
that list for this series, and then it may get noticed. Please use
get_maintainers.pl for future patches if you don't know who to send them to.

-- Steve

> 
> Thanks,
> Tingwei
> 
> On Thu, Aug 13, 2020 at 09:45:46AM +0800, Tingwei Zhang wrote:
> > Ftrace has ability to export trace packets to other destination.
> > Currently, only function trace can be exported. This series extends the
> > support to event trace and trace_maker. STM is one possible destination to
> > export ftrace. Use separate channel for each CPU to avoid mixing up
> > packets
> > from different CPUs together.
> > 
> > Change from v2:
> > Change flag definition to BIT(). (Steven)
> > Add comment in stm_ftrace_write() to clarify it's safe to use 
> > smp_processor_id() here since preempt is disabled. (Steven) 
> > 
> > Change from v1:
> > All changes are suggested by Steven Rostedt.
> > User separate flag to control function trace, event trace and trace mark.
> > Allocate channels according to num_possible_cpu() dynamically.
> > Move ftrace_exports routines up so all ftrace can use them.
> > 
> > Tingwei Zhang (6):
> >   stm class: ftrace: change dependency to TRACING
> >   tracing: add flag to control different traces
> >   tracing: add trace_export support for event trace
> >   tracing: add trace_export support for trace_marker
> >   stm class: ftrace: enable supported trace export flag
> >   stm class: ftrace: use different channel accroding to CPU
> > 
> >  drivers/hwtracing/stm/Kconfig  |   2 +-
> >  drivers/hwtracing/stm/ftrace.c |   7 +-
> >  include/linux/trace.h          |   7 +
> >  kernel/trace/trace.c           | 270 ++++++++++++++++++---------------
> >  4 files changed, 159 insertions(+), 127 deletions(-)
> > 
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> >   

