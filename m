Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193881BE3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgD2Qbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 12:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Qbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:31:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A34CE2073E;
        Wed, 29 Apr 2020 16:31:42 +0000 (UTC)
Date:   Wed, 29 Apr 2020 12:31:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
Message-ID: <20200429123141.580f89ce@gandalf.local.home>
In-Reply-To: <5EA96AE8.6000707@cn.fujitsu.com>
References: <20200424223630.224895-1-joel@joelfernandes.org>
        <5EA80319.7080005@cn.fujitsu.com>
        <20200428104409.0995ceb0@gandalf.local.home>
        <20200428104543.3926eaaf@gandalf.local.home>
        <5EA96AE8.6000707@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 19:54:16 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> On 2020/4/28 22:45, Steven Rostedt wrote:
> > diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c  
> >>  index 1c28ca20e30b..6d9131ae7e8c 100644
> >>  --- a/kernel/trace/preemptirq_delay_test.c
> >>  +++ b/kernel/trace/preemptirq_delay_test.c
> >>  @@ -113,15 +113,27 @@ static int preemptirq_delay_run(void *data)
> >>
> >>    	for (i = 0; i<  s; i++)
> >>    		(testfuncs[i])(i);
> >>  +
> >>  +	while (!kthread_should_stop()) {
> >>  +		schedule();
> >>  +		set_current_state(TASK_INTERRUPTIBLE);
> >>  +	}
> >>  +
> >>  +	__set_current_state(TASK_RUNNING);
> >>  +
> >>    	return 0;
> >>    }
> >>  
> Hi Steven,
> 
> Thanks for your patch.
> 
> I also used the following steps to do test and didn't get any 
> warning/panic after applying your patch.
> ---------------------------------
> for i in $(seq 1 100); do modprobe preemptirq_delay_test test_mode=irq 
> delay=500000; rmmod preemptirq_delay_test; done
> for i in $(seq 1 100); do modprobe preemptirq_delay_test 
> test_mode=preempt delay=500000; rmmod preemptirq_delay_test; done
> ---------------------------------
> 
> But I am not sure which fix(from you and Joel) is better.

Mine ;-)

The "kthread_should_stop()" is the normal way to end kernel threads. Using
get/put is not the orthodox way.

-- Steve

