Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C502CA79D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403818AbgLAQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390717AbgLAQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:00:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729CD2080A;
        Tue,  1 Dec 2020 16:00:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kk84T-002R3z-4v; Tue, 01 Dec 2020 11:00:05 -0500
Message-ID: <20201201155835.647858317@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 10:58:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/12] tracing: Fixes for 5.10-rc6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi (1):
      ring-buffer: Set the right timestamp in the slow path of __rb_reserve_next()

Masami Hiramatsu (4):
      tools/bootconfig: Fix errno reference after printf()
      tools/bootconfig: Fix to check the write failure correctly
      tools/bootconfig: Align the bootconfig applied initrd image size to 4
      docs: bootconfig: Update file format on initrd image

Minchan Kim (1):
      tracing: Fix alignment of static buffer

Naveen N. Rao (2):
      ftrace: Fix updating FTRACE_FL_TRAMP
      ftrace: Fix DYNAMIC_FTRACE_WITH_DIRECT_CALLS dependency

Sami Tolvanen (1):
      samples/ftrace: Mark my_tramp[12]? global

Steven Rostedt (VMware) (2):
      ring-buffer: Update write stamp with the correct ts
      ring-buffer: Always check to put back before stamp when crossing pages

Vasily Averin (1):
      tracing: Remove WARN_ON in start_thread()

----
 Documentation/admin-guide/bootconfig.rst |  18 +++--
 include/linux/bootconfig.h               |   3 +
 kernel/trace/Kconfig                     |   2 +-
 kernel/trace/ftrace.c                    |  22 +++++-
 kernel/trace/ring_buffer.c               |  20 +++--
 kernel/trace/trace.c                     |   2 +-
 kernel/trace/trace_hwlat.c               |   2 +-
 samples/ftrace/ftrace-direct-modify.c    |   2 +
 samples/ftrace/ftrace-direct-too.c       |   1 +
 samples/ftrace/ftrace-direct.c           |   1 +
 tools/bootconfig/main.c                  | 121 ++++++++++++++++++++-----------
 tools/bootconfig/test-bootconfig.sh      |   6 +-
 12 files changed, 138 insertions(+), 62 deletions(-)
