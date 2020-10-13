Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996EC28D007
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgJMOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgJMOSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:18:02 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2430C247F7;
        Tue, 13 Oct 2020 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602598681;
        bh=k2cHafGOR2Ev94dm0fK5wfP7+nr3jF7fyuoBH50eZZo=;
        h=From:To:Cc:Subject:Date:From;
        b=Ob0xbt8ktzaMSG3AaE3+06RhuaCDf/Wnuf5fWomsGTQbiwV8+A/WYr/j/AYP63pvk
         m9tjhRZtEMeUBYAocNbWYmt/I6e6WLGq6XbPLBcBSSXI9iNMjSN2NTW4JLQI+TOd4O
         hmbob1f6di0VvoVMln6S5piIa8UlQ/esLi9ixUzw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] tracing: Synthetic event dynamic string fixes
Date:   Tue, 13 Oct 2020 09:17:51 -0500
Message-Id: <cover.1602598160.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates v2 to replace some of the v2 code with improved code from
Steve (tracing: Add synthetic event error logging) and (tracing:
Handle synthetic event array field type checking correctly) and remove
the synth_error_clear() function and change last_cmd_set() to use
strncpy.

Thanks,

Tom

v2 text:

This updates v1 to fix a couple of additional things that Masami
pointed out:

 - The error logging for the BAD_TYPE error was actually pointing to
   the name - it now points to the type as it should.

 - Added a new test case that verifies most of the synthetic event
   error messages and caret positions.
 
 - Added a new patch that correctly strips off trailing semicolons and
   everything else from array types, which wasn't happening before,
   even before the dynamic array patches.

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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/dynstring-fixes-v3

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
 kernel/trace/trace_events_synth.c             | 123 +++++++++++++++++-
 kernel/trace/trace_probe.h                    |  13 --
 .../trigger-inter-event-combined-hist.tc      |   8 +-
 .../trigger-synthetic_event_syntax_errors.tc  |  19 +++
 5 files changed, 153 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc

-- 
2.17.1

