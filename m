Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1206C2B9471
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgKSORG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgKSORG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:17:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E363E22210;
        Thu, 19 Nov 2020 14:17:03 +0000 (UTC)
Date:   Thu, 19 Nov 2020 09:17:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent
 of RT
Message-ID: <20201119091702.59aac061@gandalf.local.home>
In-Reply-To: <20201119121413.GI3306@suse.de>
References: <20201118194838.753436396@linutronix.de>
        <20201118204007.269943012@linutronix.de>
        <20201119093834.GH3306@suse.de>
        <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
        <20201119121413.GI3306@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 12:14:13 +0000
Mel Gorman <mgorman@suse.de> wrote:

> * Usage of migrate_disable is heavily discouraged as it is extremely
> * hazardous on PREEMPT_RT kernels and any usage needs to be heavily

I don't believe it's just PREEMPT_RT. It's RT tasks that are concerned,
especially when you are dealing with SCHED_DEADLINE.

PREEMPT_RT just allows better determinism for RT tasks, but the issue with
migrate_disable is not limited to just PREEMPT_RT.

-- Steve


> * justified. Before even thinking about using this, read
> * "Migrate-Disable and why it is undesired" in
> * include/linux/preempt.h and include both a comment and document
> * in the changelog why the use case is an exception.

