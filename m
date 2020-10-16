Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC3290D68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgJPVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgJPVs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:48:29 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D64214DB;
        Fri, 16 Oct 2020 21:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602884908;
        bh=dcYVjaBdCGaoj0hJBdbvHdr6Px5Oys+Dj6cFnGXEy8U=;
        h=From:To:Cc:Subject:Date:From;
        b=wL0+WBcWWLcfMIJFgRl1wRNtbMicql5klDt/5C5ZZEglj5hXR4gt9RDRWf/yF3WD1
         dERlkgm9rFrjUb7h3b1/0agg9pGoUx2X/ESDNKJKbzcFOa8XGXBdbIqL87jrv1w2AF
         FbQPMZFo24LHnFX3S7181Ci64obKP53CobVygg0s=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] tracing: More synthetic event error fixes
Date:   Fri, 16 Oct 2020 16:48:21 -0500
Message-Id: <cover.1602883818.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset addresses the synthetic event error anomalies reported
by Masami in the last patchset [1].

It turns out that most of the problems boil down to clunky separator
parsing; adding a couple new abilities to trace_run_command() and then
adapting the existing users seemed to me the best way to fix these
things, and also gets rid of some code.

Also, to make things easier for error display, I changed these to
preserve the original command string and pass it through the callback
instead of rebuilding it for error display.

I added some new error strings and removed unused ones as well, and
added a bunch of new test cases to the synthetic parser error test
case.

I didn't see any problems running the entire ftrace testsuite or the
test modules that also use the things that were touched here.

Thanks,

Tom

[1] https://lore.kernel.org/lkml/20201014110636.139df7be275d40a23b523b84@kernel.org/

The following changes since commit 6107742d15832011cd0396d821f3225b52551f1f:

  tracing: support "bool" type in synthetic trace events (2020-10-15 12:01:14 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-fixes-v1

Tom Zanussi (4):
  tracing: Make trace_*_run_command() more flexible
  tracing: Use new trace_run_command() options
  tracing: Update synth command errors
  selftests/ftrace: Update synthetic event syntax errors

 kernel/trace/trace.c                          | 41 ++++++++--
 kernel/trace/trace.h                          | 12 ++-
 kernel/trace/trace_dynevent.c                 |  4 +-
 kernel/trace/trace_events_synth.c             | 79 ++++---------------
 kernel/trace/trace_kprobe.c                   |  5 +-
 kernel/trace/trace_uprobe.c                   |  5 +-
 .../trigger-synthetic_event_syntax_errors.tc  | 17 ++--
 7 files changed, 78 insertions(+), 85 deletions(-)

-- 
2.17.1

