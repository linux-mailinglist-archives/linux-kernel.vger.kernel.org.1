Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36D2269943
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgINWzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgINWza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:55:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF40020732;
        Mon, 14 Sep 2020 22:55:29 +0000 (UTC)
Date:   Mon, 14 Sep 2020 18:55:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 0/4] tracing: trivial cleanup
Message-ID: <20200914185528.77d36e9d@gandalf.local.home>
In-Reply-To: <20200828034257.GA8994@L-31X9LVDL-1304.local>
References: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
        <20200828034257.GA8994@L-31X9LVDL-1304.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 11:42:57 +0800
Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> Steven,
> 
> Would you like to pick this up?
> 

Hmm, patch 1 and 2 have been accepted (different subjects though):

   746cf3459f11859 ("tracing: Simplify defining of the next event id")
   36b8aacf2a483ba ("tracing: Save one trace_event->type by using __TRACE_LAST_TYPE")

I'm not sure why I didn't pick up patches 3 and 4. I'm looking into that
now.

-- Steve


> On Sun, Jul 12, 2020 at 09:10:32AM +0800, Wei Yang wrote:
> >Some trivial cleanup for tracing.
> >
> >v2:
> >  * drop patch 1
> >  * merge patch 4 & 5
> >  * introduce a new patch change the return value of tracing_init_dentry()
> >
> >Wei Yang (4):
> >  tracing: simplify the logic by defining next to be "lasst + 1"
> >  tracing: save one trace_event->type by using __TRACE_LAST_TYPE
> >  tracing: toplevel d_entry already initialized
> >  tracing: make tracing_init_dentry() returns an integer instead of a
> >    d_entry pointer
> >
> > kernel/trace/trace.c                 | 36 ++++++++++++++--------------
> > kernel/trace/trace.h                 |  2 +-
> > kernel/trace/trace_dynevent.c        |  8 +++----
> > kernel/trace/trace_events.c          |  9 ++-----
> > kernel/trace/trace_events_synth.c    |  9 +++----
> > kernel/trace/trace_functions_graph.c |  8 +++----
> > kernel/trace/trace_hwlat.c           |  8 +++----
> > kernel/trace/trace_kprobe.c          | 10 ++++----
> > kernel/trace/trace_output.c          | 14 +++++------
> > kernel/trace/trace_printk.c          |  8 +++----
> > kernel/trace/trace_stack.c           | 12 +++++-----
> > kernel/trace/trace_stat.c            |  8 +++----
> > kernel/trace/trace_uprobe.c          |  9 ++++---
> > 13 files changed, 66 insertions(+), 75 deletions(-)
> >
> >-- 
> >2.20.1 (Apple Git-117)  
> 

