Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0858280999
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgJAVqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJAVqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:46:50 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC1C206A2;
        Thu,  1 Oct 2020 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601588810;
        bh=9s3bjnAsSPycIAJAxTnMDJ4TGSeKbHmTluOFXssLaHc=;
        h=From:To:Cc:Subject:Date:From;
        b=RRIpuZK15/I2dOOEphfsFHThsE5Tz+qrgUOjubX+POC/v1Oun3/mu5Gdtg9VHnzoa
         rpm/5AgMZWOSyXCTAiynbd5ZNGloesvh8Lf4w+tL7JuHewXJD/tYdSDqfvkEXGzZdu
         S0CgNCuXTvfsKgH3JQ5rsAbPwcFI3fJA3/5wMo5A=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] tracing: Add dynamic strings for synthetic events
Date:   Thu,  1 Oct 2020 16:46:43 -0500
Message-Id: <cover.1601588066.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v3 of the dynamic string support for synthetic events.

No code changes since v2, just added Fixes: tag for 'tracing: Fix
parse_synth_field() error handling' as suggested by Masami along with
his Reviewed-by, and Axel's Tested-bys.

Thanks,

Tom

Previous versions text:

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

The following changes since commit fdb46faeab2f3fa2b43a55059b33b8f98b2e1442:

  x86: Use tracepoint_enabled() for msr tracepoints instead of open coding it (2020-09-28 10:36:02 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-dynstring-v3

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

