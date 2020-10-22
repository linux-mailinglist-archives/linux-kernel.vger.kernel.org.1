Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F92965FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371730AbgJVUcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368680AbgJVUcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:32:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF0B21534;
        Thu, 22 Oct 2020 20:32:50 +0000 (UTC)
Date:   Thu, 22 Oct 2020 16:32:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 trace_hardirqs_on
Message-ID: <20201022163247.5bb93ab3@gandalf.local.home>
In-Reply-To: <20201022103028.GC2611@hirez.programming.kicks-ass.net>
References: <000000000000e921b305b18ba0a7@google.com>
        <20201013091743.12c371a8@gandalf.local.home>
        <20201021131733.GH2628@hirez.programming.kicks-ass.net>
        <20201021103433.38fed220@gandalf.local.home>
        <20201021151237.GK2628@hirez.programming.kicks-ass.net>
        <20201021112757.0945a922@gandalf.local.home>
        <20201022103028.GC2611@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 12:30:28 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Subject: lockdep: Fix preemption WARN for spurious IRQ-enable
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Oct 22 12:23:02 CEST 2020
> 
> It is valid (albeit uncommon) to call local_irq_enable() without first
> having called local_irq_disable(). In this case we enter
> lockdep_hardirqs_on*() with IRQs enabled and trip a preemption warning
> for using __this_cpu_read().
> 
> Use this_cpu_read() instead to avoid the warning.

I was wondering why you were using __this_cpu_read() in the first place.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> 
> Fixes: 4d004099a6 ("lockdep: Fix lockdep recursion")
> Reported-by: syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
