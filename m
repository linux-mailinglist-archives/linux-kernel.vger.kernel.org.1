Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6725633C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 00:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgH1Wyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 18:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgH1Wyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:54:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9449208A9;
        Fri, 28 Aug 2020 22:54:51 +0000 (UTC)
Date:   Fri, 28 Aug 2020 18:54:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel-owner@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, abhishekpandit@google.com,
        briannorris@google.com, drinkcat@google.com, tientzu@google.com
Subject: Re: [for-next][PATCH 2/2] tracing: Use temp buffer when filtering
 events
Message-ID: <20200828185450.101ebd09@oasis.local.home>
In-Reply-To: <20200828184955.6de9b54e@oasis.local.home>
References: <20160504135202.422290539@goodmis.org>
        <20160504135241.308454993@goodmis.org>
        <b504b3d7e989cae108669a0cd3072454@codeaurora.org>
        <20200828184955.6de9b54e@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 18:49:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 28 Aug 2020 15:53:06 +0800
> Wen Gong <wgong@codeaurora.org> wrote:
> 
> > this patch commit id is : 0fc1b09ff1ff404ddf753f5ffa5cd0adc8fdcdc9 which 
> > has upstream.
> > 
> > how much size is the per cpu buffer?
> > seems it is initilized in trace_buffered_event_enable,
> > it is only 1 page size as below:
> > void trace_buffered_event_enable(void)
> > {
> > ...
> > 	for_each_tracing_cpu(cpu) {
> > 		page = alloc_pages_node(cpu_to_node(cpu),
> > 					GFP_KERNEL | __GFP_NORETRY, 0);
> > If the size of buffer to trace is more than 1 page, such as 46680, then 
> > it trigger kernel crash/panic in my case while run trace-cmd.
> > After debugging, the trace_file->flags in 
> > trace_event_buffer_lock_reserve is 0x40b while run trace-cmd, and it is 
> > 0x403 while collecting ftrace log.
> > 
> > Is it have any operation to disable this patch dynamically?  
> 
> It shouldn't be disabled, this is a bug that needs to be fixed.
> 
> Also, if an event is more than a page, it wont be saved in the ftrace
> ring buffer, as events are limited by page size minus the headers.
> 

Untested (not even compiled, as I'm now on PTO) but does this patch
work for you?

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f40d850ebabc..3a9b4422e7fc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2598,7 +2598,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
 		val = this_cpu_inc_return(trace_buffered_event_cnt);
-		if (val == 1) {
+		if (val == 1 || (len > (PAGE_SIZE - 8))) {
 			trace_event_setup(entry, type, flags, pc);
 			entry->array[0] = len;
 			return entry;
