Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E3279414
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgIYWXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:23:36 -0400
Received: from mail.efficios.com ([167.114.26.124]:48572 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgIYWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:23:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 53B1C2D24DA;
        Fri, 25 Sep 2020 18:23:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MzbI1bNxLp4d; Fri, 25 Sep 2020 18:23:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EA1D92D25D2;
        Fri, 25 Sep 2020 18:23:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EA1D92D25D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601072615;
        bh=gQoN2wPqNS+dpQu2jHy+0fCG7sG+iR/HyLFfUk3yxvU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EPHZKca6RVotJ2EjUXeuTdjADZBOkBr1St5hfLEM5uSfKS25GQd5+PPgNP/pHtoxM
         JgixCb8zRDx2dp/wYgioiBiv6mbcbplT2B+Zs0rwgj1vD/FcvG+HV0lMKZC+/Jjicf
         pooiDUJSwDExTNgJMKJWUQnmftCRLsEwygvX69JJ9DPzZZLgInpwjDWCO5kS4V3Ngx
         rNv+lMgTOeX4gIAlUuI9qwo1tttQVg1Kaoqklnobpr06gHeXXZsrvEESdgcNJkvCSB
         UJDx0r5Y8oUV4eb/35pZLOqrr5pDmSeI3GLGFDmlY6YbZqwIFbfHPfOactoN2vtQ0I
         DaRjLBQ8igNYA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ueqY3Mk9kQap; Fri, 25 Sep 2020 18:23:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DB53A2D25D1;
        Fri, 25 Sep 2020 18:23:34 -0400 (EDT)
Date:   Fri, 25 Sep 2020 18:23:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Message-ID: <606086581.69952.1601072614802.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200925172640.701ca0a7@oasis.local.home>
References: <20200925211206.423598568@goodmis.org> <20200925172640.701ca0a7@oasis.local.home>
Subject: Re: [PATCH 0/3 v2] tracing/mm: Add tracepoint_enabled() helper
 function for headers
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (zclient/8.8.15_GA_3965)
Thread-Topic: tracing/mm: Add tracepoint_enabled() helper function for headers
Thread-Index: X5CnxcGKVxo6UTP7Vy2I8qU5DLTdog==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No worries, I'll get it from lore.

Thanks,

Mathieu

----- Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> Bah, My cut-and-paste of my "quilt mail --send" chopped off Mathieu's email.
> 
> Mathieu, I didn't meant to not Cc you on this. Do you need me to bounce
> the rest to you or you can get it from lore?
> 
> -- Steve
> 
> 
> On Fri, 25 Sep 2020 17:12:06 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Tracepoints are not safe to be called directly from header files as they may
> > be included by C code that has CREATE_TRACE_POINTS defined, and this would
> > cause side effects and possibly break the build in hard to debug ways. Not
> > to mention it also will bloat the code being in commonly used inline
> > functions.
> > 
> > Instead, it is recommended to call a tracepoint helper function that is
> > defined in a C file that calls the tracepoint. But we would only want this
> > function to be called if the tracepoint is enabled, as function calls add
> > overhead.
> > 
> > The trace_<tracepoint>_enabled() function is also not safe to be called in a
> > header file as it is created by the tracepoint header, which suffers the
> > same fate if CREATE_TRACE_POINTS is defined. Instead, the tracepoint needs
> > to be declared as an extern, and the helper function can test the static key
> > to call the helper function that calls the tracepoint.
> > 
> > This has been done by open coding the tracepoint extern and calling the
> > static key directly:
> > 
> >  commit 95813b8faa0cd ("mm/page_ref: add tracepoint to track down page reference manipulation")
> >  commit 7f47d8cc039f ("x86, tracing, perf: Add trace point for MSR accesses")
> > 
> > does this (back in 2015). Now we have another use case, so a helper function
> > should be created to keep the internals of the tracepoints from being spread
> > out in other subsystems.
> > 
> >  Link: https://lore.kernel.org/r/20200922125113.12ef1e03@gandalf.local.home
> > 
> > This adds tracepoint_enabled() helper macro and DECLARE_TRACEPOINT() macro
> > to allow this to be done without exposing the internals of the tracepoints.
> > 
> > The first patch adds the infrastructure, the second converts page_ref over
> > to it, and third converts over msr.h.
> > 
> > Steven Rostedt (VMware) (3):
> >       tracepoints: Add helper to test if tracepoint is enabled in a header
> >       mm/page_ref: Convert the open coded tracepoint enabled to the new helper
> >       x86: Use tracepoint_enabled() for msr tracepoints instead of open coding it
> > 
> > ----
> > 
> > Changes since v1 (https://lore.kernel.org/r/20200924170928.466191266@goodmis.org):
> > 
> >  - Fixed using "trace_enabled()" instead of "tracepoint_enabled()"
> >    (Mathieu Desnoyers reported)
> > 
> >  - Reworded to include comments about bloating the kernel when tracepoints
> >    are used in commonly used inlined functions.
> > 
> >  - Added the msr update as well.
> > 
> > 
> >  Documentation/trace/tracepoints.rst | 27 ++++++++++++++++++++++++
> >  arch/x86/include/asm/msr.h          | 18 +++++++---------
> >  include/linux/page_ref.h            | 42 ++++++++++++++++++-------------------
> >  include/linux/tracepoint-defs.h     | 34 ++++++++++++++++++++++++++++++
> >  4 files changed, 90 insertions(+), 31 deletions(-)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
