Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C344269B36
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIOBcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:32:36 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:38631 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbgIOBca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:32:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U9-qPWX_1600133547;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U9-qPWX_1600133547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Sep 2020 09:32:27 +0800
Date:   Tue, 15 Sep 2020 09:32:27 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 0/4] tracing: trivial cleanup
Message-ID: <20200915013227.GA2007@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
 <20200828034257.GA8994@L-31X9LVDL-1304.local>
 <20200914185528.77d36e9d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914185528.77d36e9d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 06:55:28PM -0400, Steven Rostedt wrote:
>On Fri, 28 Aug 2020 11:42:57 +0800
>Wei Yang <richard.weiyang@linux.alibaba.com> wrote:
>
>> Steven,
>> 
>> Would you like to pick this up?
>> 
>
>Hmm, patch 1 and 2 have been accepted (different subjects though):
>
>   746cf3459f11859 ("tracing: Simplify defining of the next event id")
>   36b8aacf2a483ba ("tracing: Save one trace_event->type by using __TRACE_LAST_TYPE")
>
>I'm not sure why I didn't pick up patches 3 and 4. I'm looking into that
>now.
>

Yep, thanks a lot :-)

>-- Steve
>
>
>> On Sun, Jul 12, 2020 at 09:10:32AM +0800, Wei Yang wrote:
>> >Some trivial cleanup for tracing.
>> >
>> >v2:
>> >  * drop patch 1
>> >  * merge patch 4 & 5
>> >  * introduce a new patch change the return value of tracing_init_dentry()
>> >
>> >Wei Yang (4):
>> >  tracing: simplify the logic by defining next to be "lasst + 1"
>> >  tracing: save one trace_event->type by using __TRACE_LAST_TYPE
>> >  tracing: toplevel d_entry already initialized
>> >  tracing: make tracing_init_dentry() returns an integer instead of a
>> >    d_entry pointer
>> >
>> > kernel/trace/trace.c                 | 36 ++++++++++++++--------------
>> > kernel/trace/trace.h                 |  2 +-
>> > kernel/trace/trace_dynevent.c        |  8 +++----
>> > kernel/trace/trace_events.c          |  9 ++-----
>> > kernel/trace/trace_events_synth.c    |  9 +++----
>> > kernel/trace/trace_functions_graph.c |  8 +++----
>> > kernel/trace/trace_hwlat.c           |  8 +++----
>> > kernel/trace/trace_kprobe.c          | 10 ++++----
>> > kernel/trace/trace_output.c          | 14 +++++------
>> > kernel/trace/trace_printk.c          |  8 +++----
>> > kernel/trace/trace_stack.c           | 12 +++++-----
>> > kernel/trace/trace_stat.c            |  8 +++----
>> > kernel/trace/trace_uprobe.c          |  9 ++++---
>> > 13 files changed, 66 insertions(+), 75 deletions(-)
>> >
>> >-- 
>> >2.20.1 (Apple Git-117)  
>> 

-- 
Wei Yang
Help you, Help me
