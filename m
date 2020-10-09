Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E2288C64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389222AbgJIPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387978AbgJIPRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:17:15 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2AA222C2;
        Fri,  9 Oct 2020 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602256634;
        bh=C3voXAnVOVWTXwItSqn/8ESKA7Phe7brw1YHxvJYzkA=;
        h=From:To:Cc:Subject:Date:From;
        b=QW5d9vCnP6o0oy3jfYbeeqVnmdNyaLlsSp4qA8P+L/3O8WbH14IQBBzv0diSCE9h7
         C6WUKSzfu3lko9wX5lUuaKqT579S8MKChrE2RV3KEVCXXMaZbSeMU/tFNZhBZKcILN
         1VW8R3opjSPsSGYAHlY614heOv8HeS5cWxoUU0dk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] tracing: Synthetic event dynamic string fixes
Date:   Fri,  9 Oct 2020 10:17:06 -0500
Message-Id: <cover.1602255803.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/dynstring-fixes-v1

Tom Zanussi (5):
  tracing: Don't show dynamic string internals in synthetic event
    description
  tracing: Move is_good_name() from trace_probe.h to trace.h
  tracing: Check that the synthetic event and field names are legal
  tracing: Add synthetic event error logging
  selftests/ftrace: Change synthetic event name for inter-event-combined
    test

 kernel/trace/trace.h                          |  13 ++
 kernel/trace/trace_events_synth.c             | 133 +++++++++++++++++-
 kernel/trace/trace_probe.h                    |  13 --
 .../trigger-inter-event-combined-hist.tc      |   8 +-
 4 files changed, 147 insertions(+), 20 deletions(-)

-- 
2.17.1

