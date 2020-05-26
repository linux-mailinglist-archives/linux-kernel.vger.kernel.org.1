Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837931C9803
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgEGRja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 13:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEGRj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:39:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC6220735;
        Thu,  7 May 2020 17:39:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jWkUa-000Dl3-Bw; Thu, 07 May 2020 13:39:28 -0400
Message-ID: <20200507173904.729935165@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 07 May 2020 13:39:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/9] tracing: Fixes for 5.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu (4):
      bootconfig: Fix to remove bootconfig data from initrd while boot
      tracing/kprobes: Fix a double initialization typo
      tracing/boottime: Fix kprobe event API usage
      tracing/kprobes: Reject new event if loc is NULL

Steven Rostedt (VMware) (2):
      tracing: Wait for preempt irq delay thread to finish
      tracing: Add a vmalloc_sync_mappings() for safe measure

Wei Yang (1):
      tracing: Fix doc mistakes in trace sample

Yiwei Zhang (1):
      gpu/trace: Minor comment updates for gpu_mem_total tracepoint

Zou Wei (1):
      tracing: Make tracing_snapshot_instance_cond() static

----
 include/trace/events/gpu_mem.h             |  2 +-
 init/main.c                                | 69 ++++++++++++++++++++++--------
 kernel/trace/preemptirq_delay_test.c       | 30 ++++++++++---
 kernel/trace/trace.c                       | 16 ++++++-
 kernel/trace/trace_boot.c                  | 20 ++++-----
 kernel/trace/trace_kprobe.c                |  8 +++-
 samples/trace_events/trace-events-sample.h |  2 +-
 7 files changed, 108 insertions(+), 39 deletions(-)
