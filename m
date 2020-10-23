Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6807297844
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756144AbgJWUeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465502AbgJWUeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:34:00 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A308320BED;
        Fri, 23 Oct 2020 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603485239;
        bh=pDhvGEzuyqPaFxwqeyyoKZ2uEzRNX8xNXhrmhyKtNXk=;
        h=From:To:Cc:Subject:Date:From;
        b=D0wrNFTjIgphxbSVr0o0y2roJ8qiBvtkv3KX3gVIpbxQehiCg8+IjIx8XyWbEmdLY
         YI64fzf8uTxC9nVCe7bqMwIW1VlwpaP22/Itk/nf/4nvQB9nmNxfihkUNpBNJ6xigE
         ziWI3m9k8y9EJEB0LsibtNSvoRDoazBPzrQWDogc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] tracing: More synthetic event error fixes
Date:   Fri, 23 Oct 2020 15:33:51 -0500
Message-Id: <cover.1603484117.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of the previous sythetic event error fix patchset.

This version drops the original ([PATCH 1/4] tracing: Make
trace_*_run_command() more flexible) and (tracing: Use new
trace_run_command() options) patches and replaces them with Masami's
patch (tracing/dynevent: Delegate parsing to create function) [1].
The new version adds in all the synthetic event changes needed to
compile and use the new interface.

A new patch was also added (selftests/ftrace: Add synthetic event
field separators) that fixes more invalid synthetic event syntax I
found while testing.

I also added some more new checks to the synthetic event sytax error
testcase.

As before, I didn't see any problems running the entire ftrace
testsuite or the test modules that also use the things that were
touched here.

[1] https://lore.kernel.org/lkml/20201019001504.70dc3ec608277ed22060d2f7@kernel.org/

Thanks,

Tom


v1 text:

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

The following changes since commit ce66f6136460a51acfc32de4481fe8fd69dfd50b:

  tracing: Remove __init from __trace_early_add_new_event() (2020-10-16 09:43:36 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-fixes-v2

Masami Hiramatsu (1):
  tracing/dynevent: Delegate parsing to create function

Tom Zanussi (3):
  tracing: Update synth command errors
  selftests/ftrace: Add synthetic event field separators
  selftests/ftrace: Update synthetic event syntax errors

 kernel/trace/trace.c                          |  23 +-
 kernel/trace/trace.h                          |   3 +-
 kernel/trace/trace_dynevent.c                 |  35 ++-
 kernel/trace/trace_dynevent.h                 |   4 +-
 kernel/trace/trace_events_synth.c             | 246 +++++++++++-------
 kernel/trace/trace_kprobe.c                   |  33 +--
 kernel/trace/trace_probe.c                    |  17 ++
 kernel/trace/trace_probe.h                    |   1 +
 kernel/trace/trace_uprobe.c                   |  17 +-
 .../trigger-inter-event-combined-hist.tc      |   4 +-
 .../trigger-onmatch-action-hist.tc            |   2 +-
 .../trigger-onmatch-onmax-action-hist.tc      |   2 +-
 .../trigger-synthetic_event_syntax_errors.tc  |  36 ++-
 .../inter-event/trigger-trace-action-hist.tc  |   2 +-
 14 files changed, 262 insertions(+), 163 deletions(-)

-- 
2.17.1

