Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F48E1E4EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgE0Tx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387476AbgE0Tx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:53:56 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5845E20C56;
        Wed, 27 May 2020 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590609235;
        bh=4sKYqrqT58XQJu6YqTjBkzYKTSsWXRC0DR2xdPwzIM0=;
        h=From:To:Cc:Subject:Date:From;
        b=QqklepFAhMoO2DnK+P8kJnhwgAjJ/NYlJ73VknO5K8D2m4XsZ90jCoYt5rn3/dn+U
         a1XVNzthS61mJ7oNalaCxYtg2aytDB76big7aKFurgq8xDSW5H3Zj69yzgoOeEPsfU
         eEmXKUp9uxyF5EXkLk4UvEF4MJN5qCN9xiY3Fhc8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: Make synthetic events a separate option
Date:   Wed, 27 May 2020 14:53:46 -0500
Message-Id: <cover.1590608239.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Since synthetic events can now be used separately from hist triggers,
it makes sense to actually separate them into different options.  It
also makes sense in terms of file bloat - trace_events_hist.c was
getting very large and this makes it smaller and easier to follow.

Thanks,

Tom

The following changes since commit 8e99cf91b99bb30e16727f10ad6828741c0e992f:

  tracing: Do not allocate buffer in trace_find_next_entry() in atomic (2020-04-03 11:30:50 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/separate-synth-v1

Tom Zanussi (2):
  tracing: Move synthetic events to a separate file
  selftests/ftrace: Distinguish between hist and synthetic event checks

 kernel/trace/Kconfig                          |   20 +-
 kernel/trace/Makefile                         |    1 +
 kernel/trace/trace_events_hist.c              | 2082 ++---------------
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
 13 files changed, 2028 insertions(+), 1940 deletions(-)
 create mode 100644 kernel/trace/trace_events_synth.c
 create mode 100644 kernel/trace/trace_synth.h

-- 
2.17.1

