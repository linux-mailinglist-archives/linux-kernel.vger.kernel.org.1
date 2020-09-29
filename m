Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF827B930
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgI2BMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgI2BMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:12:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762132083B;
        Tue, 29 Sep 2020 01:12:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kN4C2-002Irr-9R; Mon, 28 Sep 2020 21:12:34 -0400
Message-ID: <20200929011156.807392552@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 28 Sep 2020 21:11:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] tracing: Updates for 5.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: fdb46faeab2f3fa2b43a55059b33b8f98b2e1442


Masami Hiramatsu (1):
      tracing/boot: Initialize per-instance event list in early boot

Steven Rostedt (VMware) (3):
      tracepoints: Add helper to test if tracepoint is enabled in a header
      mm/page_ref: Convert the open coded tracepoint enabled to the new helper
      x86: Use tracepoint_enabled() for msr tracepoints instead of open coding it

----
 Documentation/trace/tracepoints.rst | 27 ++++++++++++++++++++++++
 arch/x86/include/asm/msr.h          | 20 ++++++++----------
 include/linux/page_ref.h            | 42 ++++++++++++++++++-------------------
 include/linux/tracepoint-defs.h     | 34 ++++++++++++++++++++++++++++++
 kernel/trace/trace.c                |  3 ++-
 kernel/trace/trace.h                |  1 +
 kernel/trace/trace_events.c         | 30 +++++++++++++-------------
 7 files changed, 110 insertions(+), 47 deletions(-)
