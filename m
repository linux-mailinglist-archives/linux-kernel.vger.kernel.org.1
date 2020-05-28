Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BBF1E6B08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 21:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406597AbgE1Tcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 15:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406316AbgE1Tcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:32:41 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDFD02078C;
        Thu, 28 May 2020 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590694361;
        bh=zJpylzLgZEMK9lfVhE0Zem979bgMVdVmXzgOmkZ3VFU=;
        h=From:To:Cc:Subject:Date:From;
        b=tKgGw5uOgdbmF/jWJxr1Tx/4pxYjk9/k3348mZJ76Rmz4UHQFWEl3QpRSzJDRfXU7
         EaMfmEkcb6UFNV2chF8L6MZLcH5shjF3X8x8lQMH0Ixr3PHZ8W0QFbBXHWOI9c5JA6
         XKttAoCjwubuBoCreYj1/A5/cabjtmK4hTpGkkmo=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: Make synthetic events a separate option
Date:   Thu, 28 May 2020 14:32:36 -0500
Message-Id: <cover.1590693308.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

These are the same patches as v1, but after posting v1 I realized that
if you applied them on top of the other patchset I posted awhile back
("[PATCH 0/3] tracing: histogram internals doc, hist_debug, and misc")
[1], you wouldn't be able to apply these.

So assuming you apply the other patchset first, these should apply
cleanly on top of those.

Thanks,

Tom

[1] https://lore.kernel.org/lkml/cover.1585941485.git.zanussi@kernel.org/


v1 text:

Since synthetic events can now be used separately from hist triggers,
it makes sense to actually separate them into different options.  It
also makes sense in terms of file bloat - trace_events_hist.c was
getting very large and this makes it smaller and easier to follow.

Thanks,

Tom

The following changes since commit 77914c22b0ba493d9783c53bbfbc6087d6a7e1b1:

  tracing: Add hist_debug trace event files for histogram debugging (2020-04-03 13:46:05 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/separate-synth-v2

Tom Zanussi (2):
  tracing: Move synthetic events to a separate file
  selftests/ftrace: Distinguish between hist and synthetic event checks

 kernel/trace/Kconfig                          |   20 +-
 kernel/trace/Makefile                         |    1 +
 kernel/trace/trace_events_hist.c              | 2071 ++---------------
 kernel/trace/trace_events_synth.c             | 1789 ++++++++++++++
 kernel/trace/trace_synth.h                    |   36 +
 .../trigger-field-variable-support.tc         |    5 +
 .../trigger-inter-event-combined-hist.tc      |    5 +
 .../trigger-multi-actions-accept.tc           |    5 +
 .../trigger-onmatch-action-hist.tc            |    5 +
 .../trigger-onmatch-onmax-action-hist.tc      |    5 +
 .../inter-event/trigger-onmax-action-hist.tc  |    5 +
 .../trigger-snapshot-action-hist.tc           |    5 +
 .../inter-event/trigger-trace-action-hist.tc  |    5 +
 13 files changed, 2029 insertions(+), 1928 deletions(-)
 create mode 100644 kernel/trace/trace_events_synth.c
 create mode 100644 kernel/trace/trace_synth.h

-- 
2.17.1

