Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1872A8376
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKEQZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKEQZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:25:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8870920786;
        Thu,  5 Nov 2020 16:25:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kai53-007Pce-S7; Thu, 05 Nov 2020 11:25:45 -0500
Message-ID: <20201105162458.408429167@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Nov 2020 11:24:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: A few fixes for 5.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Qiujun Huang (1):
      tracing: Fix the checking of stackidx in __ftrace_trace_stack

Steven Rostedt (VMware) (3):
      ring-buffer: Fix recursion protection transitions between interrupt context
      tracing: Make -ENOMEM the default error for parse_synth_field()
      kprobes: Tell lockdep about kprobe nesting

----
 kernel/kprobes.c                  | 25 ++++++++++++++---
 kernel/trace/ring_buffer.c        | 58 +++++++++++++++++++++++++++++++--------
 kernel/trace/trace.c              |  4 +--
 kernel/trace/trace_events_synth.c | 17 +++++-------
 4 files changed, 76 insertions(+), 28 deletions(-)
