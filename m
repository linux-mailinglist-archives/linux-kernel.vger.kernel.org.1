Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24D277986
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIXTkN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Sep 2020 15:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXTkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:40:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3F92220D;
        Thu, 24 Sep 2020 19:40:11 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:40:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
Message-ID: <20200924154009.4b45d56e@oasis.local.home>
In-Reply-To: <20200924153517.73f5f257@oasis.local.home>
References: <20200924170928.466191266@goodmis.org>
        <20200924171846.993048030@goodmis.org>
        <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
        <20200924143025.58dc3c1f@gandalf.local.home>
        <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com>
        <20200924153517.73f5f257@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 15:35:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > I'm ok with tracepoint_enabled(). However, I would have placed it in
> > tracepoint.h rather than tracepoint-defs.h, and we should figure out
> > why people complain that tracepoint.h is including headers too
> > eagerly.  
> 
> I could see if it would work in tracepoints.h.
> 
> It might. I was just being extra cautious.

Well that blew up quick!

Try using tracepoint.h in include/linux/page_ref.h and
arch/x86/include/asm/msr.h and see what happens.

  CC      arch/x86/kernel/asm-offsets.s
In file included from /work/git/linux-trace.git/include/linux/srcu.h:20,
                 from /work/git/linux-trace.git/include/linux/tracepoint.h:16,
                 from /work/git/linux-trace.git/arch/x86/include/asm/msr.h:68,
                 from /work/git/linux-trace.git/arch/x86/include/asm/processor.h:22,
                 from /work/git/linux-trace.git/arch/x86/include/asm/cpufeature.h:5,
                 from /work/git/linux-trace.git/arch/x86/include/asm/thread_info.h:53,
                 from /work/git/linux-trace.git/include/linux/thread_info.h:38,
                 from /work/git/linux-trace.git/arch/x86/include/asm/preempt.h:7,
                 from /work/git/linux-trace.git/include/linux/preempt.h:78,
                 from /work/git/linux-trace.git/include/linux/spinlock.h:51,
                 from /work/git/linux-trace.git/include/linux/mmzone.h:8,
                 from /work/git/linux-trace.git/include/linux/gfp.h:6,
                 from /work/git/linux-trace.git/include/linux/slab.h:15,
                 from /work/git/linux-trace.git/include/linux/crypto.h:20,
                 from /work/git/linux-trace.git/arch/x86/kernel/asm-offsets.c:9:
/work/git/linux-trace.git/include/linux/rcupdate.h: In function ‘rcu_read_lock_sched’:
/work/git/linux-trace.git/include/linux/rcupdate.h:740:2: error: implicit declaration of function ‘preempt_disable’ [-Werror=implicit-function-declaration]
  740 |  preempt_disable();
      |  ^~~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/rcupdate.h: In function ‘rcu_read_lock_sched_notrace’:
/work/git/linux-trace.git/include/linux/rcupdate.h:750:2: error: implicit declaration of function ‘preempt_disable_notrace’; did you mean ‘paravirt_disable_iospace’? [-Werror=implicit-function-declaration]
  750 |  preempt_disable_notrace();
      |  ^~~~~~~~~~~~~~~~~~~~~~~
      |  paravirt_disable_iospace
/work/git/linux-trace.git/include/linux/rcupdate.h: In function ‘rcu_read_unlock_sched’:
/work/git/linux-trace.git/include/linux/rcupdate.h:765:2: error: implicit declaration of function ‘preempt_enable’ [-Werror=implicit-function-declaration]
  765 |  preempt_enable();
      |  ^~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/rcupdate.h: In function ‘rcu_read_unlock_sched_notrace’:
/work/git/linux-trace.git/include/linux/rcupdate.h:772:2: error: implicit declaration of function ‘preempt_enable_notrace’ [-Werror=implicit-function-declaration]
  772 |  preempt_enable_notrace();
      |  ^~~~~~~~~~~~~~~~~~~~~~

-- Steve
