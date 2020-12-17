Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5F2DCA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbgLQBMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:12:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388944AbgLQBMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:12:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A2C23A7F;
        Thu, 17 Dec 2020 01:05:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kphj3-000xqU-Te; Wed, 16 Dec 2020 20:05:01 -0500
Message-ID: <20201217010408.742794078@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 16 Dec 2020 20:04:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-linus][PATCH 0/9] tracing: Last minute fixes before pushing to Linus
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: f6a694665f132cbf6e2222dd2f173dc35330a8aa


Arnd Bergmann (1):
      seq_buf: Avoid type mismatch for seq_buf_init

Lukas Bulwahn (2):
      ring-buffer: Remove obsolete rb_event_is_commit()
      tracing: Drop unneeded assignment in ring_buffer_resize()

Masami Hiramatsu (1):
      tracing: Disable ftrace selftests when any tracer is running

Qiujun Huang (3):
      ring-buffer: Fix a typo in function description
      ring-buffer: Fix two typos in comments
      ring-buffer: Add rb_check_bpage in __rb_allocate_pages

Steven Rostedt (VMware) (2):
      Revert: "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"
      tracing: Offload eval map updates to a work queue

----
 arch/Kconfig                  | 16 ++++++++++++
 include/linux/seq_buf.h       |  2 +-
 include/linux/trace_seq.h     |  4 +--
 kernel/trace/ring_buffer.c    | 61 +++++++++++++++++++------------------------
 kernel/trace/trace.c          | 51 +++++++++++++++++++++++++++++++-----
 kernel/trace/trace.h          |  5 ++++
 kernel/trace/trace_boot.c     |  2 ++
 kernel/trace/trace_events.c   |  2 +-
 kernel/trace/trace_kprobe.c   |  9 +++----
 kernel/trace/trace_selftest.c |  2 +-
 10 files changed, 102 insertions(+), 52 deletions(-)
