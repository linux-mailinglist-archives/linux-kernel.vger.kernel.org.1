Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF95327F17C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgI3Sk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgI3Sk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:40:56 -0400
Received: from localhost.localdomain (c-98-220-232-140.hsd1.il.comcast.net [98.220.232.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7624B2076B;
        Wed, 30 Sep 2020 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601491256;
        bh=ZqpDxEO3m0DRyyJc48yncKEqA34Tu2F7H7OjlL1kqkk=;
        h=From:To:Cc:Subject:Date:From;
        b=RO7cijZtUkR4e1o5iEcDFHZZJAUa1nN8vM8X7kpGEibrbsbJpGNoN8D0CUDzvUSQM
         v31YvXdKkrHSjW01nU6O+Ssvx9peySteLRO/jIUgIRoAqz3BOVX5u9uyy0qg6k6af4
         Z/6LBqcye2/uyucSXDtDXe77AcW2JARdrFr88TQ4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] tracing: Add dynamic strings for synthetic events
Date:   Wed, 30 Sep 2020 13:40:49 -0500
Message-Id: <cover.1601490263.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of the dynamic string support for synthetic events.

v1 was missing some very important code in the in-kernel API functions
that should have reserved room for dynamic strings.  This adds it
along also some additional test code in the synth_event_gen_test
module that tests the dynamic strings for those APIs.

I also added Axel's changelog text to the 'tracing: Fix
parse_synth_field() error handling' patch and used ssize_t as he also
suggested.  Thanks, Axel!  I also noticed that the original patch
didn't use <= as it should have, so changed that as well.

Neither my command-line tests or the synth_event_gen_test module are
showing any problems at this point for me...

Tom

Original v1 text:

This patchset adds support for dynamic strings for synthetic events,
as requested by Axel Rasmussen.

Actually, the first two patches should be applied in any case - the
first just changes the current max string length and the second fixes
a bug I found while testing.

It works fine for my simple test cases, but I still need to do a lot
more testing, especially of the in-kernel API parts, which don't
affect Axel's use case.

Anyway, Axel, please try it out and send me your Tested-by: if it
works for you, and your broken testcase(s) if it doesn't. ;-)

Thanks,

Tom

The following changes since commit 106c076d23cca67c959a6fd1ccadb5b3ef01ddc9:

  mmap_lock: add tracepoints around lock acquisition (2020-09-23 08:48:08 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-dynstring-v2

Tom Zanussi (3):
  tracing: Change STR_VAR_MAX_LEN
  tracing: Fix parse_synth_field() error handling
  tracing: Add support for dynamic strings to synthetic events

 Documentation/trace/events.rst      |  15 +-
 Documentation/trace/histogram.rst   |  18 +++
 kernel/trace/synth_event_gen_test.c |  18 ++-
 kernel/trace/trace_events_hist.c    |   9 ++
 kernel/trace/trace_events_synth.c   | 243 ++++++++++++++++++++++++----
 kernel/trace/trace_synth.h          |   6 +-
 6 files changed, 269 insertions(+), 40 deletions(-)

-- 
2.17.1

