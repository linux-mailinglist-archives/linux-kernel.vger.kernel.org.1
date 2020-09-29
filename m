Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB427D843
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgI2Udp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgI2Udp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:33:45 -0400
Received: from localhost.localdomain (c-98-220-232-140.hsd1.il.comcast.net [98.220.232.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB222076B;
        Tue, 29 Sep 2020 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601411624;
        bh=2ARM7EtvfC73dYBwbKeX0GvCQ36DtNcMhe7IIldK8gY=;
        h=From:To:Cc:Subject:Date:From;
        b=vCkJrQL3FiQ4cFWvD1kv7F21MIl+BeLri+YYMb51yKQIP/0471vGL13b3URDEJ3r+
         gmjBE/j8YJIBwMInmCtUtBqZ+/OoHoIFfa9rCLHb1MgjYpqJZ1yh+qBka38S5M26pN
         iNIl/ctFsUFTef+19r9XRRyvfsCrAcdOI/YrJFQI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing: Add dynamic strings for synthetic events
Date:   Tue, 29 Sep 2020 15:33:38 -0500
Message-Id: <cover.1601410890.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-dynstring-v0

Tom Zanussi (3):
  tracing: Change STR_VAR_MAX_LEN
  tracing: Fix parse_synth_field() error handling
  tracing: Add support for dynamic strings to synthetic events

 Documentation/trace/events.rst    |  15 ++-
 Documentation/trace/histogram.rst |  18 ++++
 kernel/trace/trace_events_hist.c  |   9 ++
 kernel/trace/trace_events_synth.c | 163 ++++++++++++++++++++++++++----
 kernel/trace/trace_synth.h        |   6 +-
 5 files changed, 186 insertions(+), 25 deletions(-)

-- 
2.17.1

