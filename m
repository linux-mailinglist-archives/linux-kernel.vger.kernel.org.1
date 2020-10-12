Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB8A28C223
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgJLUSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgJLUSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:18:14 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F162074F;
        Mon, 12 Oct 2020 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602533894;
        bh=knCkfBtVCedVIt4i6wM+sHyF4jYkManahTXyu420/Zc=;
        h=From:To:Cc:Subject:Date:From;
        b=WmIAGenTtcvsvZ1Ijpew+RMtY9TK3AVMYcjHc/tLGpYqS264gaPwxDPsr/WK+T9I+
         rVIVQQaCvxCARbPn8cJKWv436EZyA8/jkcNIInNCxWYIHzEhZTTZOypMTGMZY1FDtH
         c/uBA4v0VRLacpKyHYET48N1D6Tx6jTHdbhBHkSg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] tracing: Synthetic event dynamic string fixes
Date:   Mon, 12 Oct 2020 15:18:02 -0500
Message-Id: <cover.1602533267.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates v1 to fix a couple of additional things that Masami
pointed out:

 - The error logging for the BAD_TYPE error was actually pointing to
   the name - it now points to the type as it should.

 - Added a new test case that verifies most of the synthetic event
   error messages and caret positions.
 
 - Added a new patch that correctly strips off trailing semicolons and
   everything else from array types, which wasn't happening before,
   even before the dynamic array patches.

Thanks,

Tom

Original v1 text:

These patches provide fixes for the problems observed by Masami in the
new synthetic event dynamic string patchset.

The first patch (tracing: Don't show dynamic string internals in
synthetic event description) removes the __data_loc from the event
description but leaves it in the format.

The patch (tracing: Add synthetic event error logging) addresses the
lack of error messages when parse errors occur.

The remaining three patches address the other problems Masami noted
which result from allowing illegal characters in synthetic event and
field names when defining an event.  The is_good_name() function is
used to check that's not possible for the probe events, but should
also be used for the synthetic events as well.

(tracing: Move is_good_name() from trace_probe.h to trace.h) makes
that function available to other trace subsystems by putting it in
trace.h.  (tracing: Check that the synthetic event and field names are
legal) applies it to the synthetic events, and (selftests/ftrace:
Change synthetic event name for inter-event-combined test) changes a
testcase that now fails because it uses an illegal name.

The following changes since commit 848183553e431e6e9c2ea2f72421a7a1bbc6532e:

  tracing: Fix synthetic print fmt check for use of __get_str() (2020-10-08 15:29:07 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/dynstring-fixes-v2

Tom Zanussi (7):
  tracing: Don't show dynamic string internals in synthetic event
    description
  tracing: Move is_good_name() from trace_probe.h to trace.h
  tracing: Check that the synthetic event and field names are legal
  tracing: Add synthetic event error logging
  selftests/ftrace: Change synthetic event name for inter-event-combined
    test
  tracing: Handle synthetic event array field type checking correctly
  selftests/ftrace: Add test case for synthetic event syntax errors

 kernel/trace/trace.h                          |  13 ++
 kernel/trace/trace_events_synth.c             | 140 +++++++++++++++++-
 kernel/trace/trace_probe.h                    |  13 --
 .../trigger-inter-event-combined-hist.tc      |   8 +-
 .../trigger-synthetic_event_syntax_errors.tc  |  19 +++
 5 files changed, 171 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc

-- 
2.17.1

