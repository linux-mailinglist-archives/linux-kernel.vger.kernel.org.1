Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD32A178E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgJaNJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgJaNJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:09:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF0A2068D;
        Sat, 31 Oct 2020 13:09:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kYqdP-006ClF-1C; Sat, 31 Oct 2020 09:09:31 -0400
Message-ID: <20201031130642.971173960@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 31 Oct 2020 09:06:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>
Subject: [for-linus][PATCH 0/3] tracing/ftrace: trace_printk buffer fix and ftrace recursion fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indexing of the different context buffers had an off by one error.

The recursion protection for ftrace callbacks had two bugs.
 One that would make NMIs always appear to be recursing
 The other is trasitions between interrupt context could also cause
 false positives and miss tracing those functions.

Qiujun Huang (1):
      tracing: Fix out of bounds write in get_trace_buf

Steven Rostedt (VMware) (2):
      ftrace: Fix recursion check for NMI test
      ftrace: Handle tracing when switching between context

----
 kernel/trace/trace.c          |  2 +-
 kernel/trace/trace.h          | 26 +++++++++++++++++++++++---
 kernel/trace/trace_selftest.c |  9 +++++++--
 3 files changed, 31 insertions(+), 6 deletions(-)
