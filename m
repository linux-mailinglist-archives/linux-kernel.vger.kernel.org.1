Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7959A19DE94
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 21:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbgDCTbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 15:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgDCTbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:31:24 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E5C52063A;
        Fri,  3 Apr 2020 19:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585942283;
        bh=jHcp++x/r+JwBBRNdT9jiYig+C5p2N9/dx/2wwFnXlw=;
        h=From:To:Cc:Subject:Date:From;
        b=btoDr/h340zwzEWqqteBly0Bt/9vD5YgEAGufTX3a2xpIa+QZN5RJlhhl08mHBXFo
         p9KMGqXULujwP955qWc+tmiMbBJGzeVGRXVAiXezsXlA2KfP2o9HH8Xd/PrdWQJE6g
         ZndkBGdnF6Kv6umBFTdy2ncMqn/7XuNlRE5v2qEo=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing: histogram internals doc, hist_debug, and misc
Date:   Fri,  3 Apr 2020 14:31:18 -0500
Message-Id: <cover.1585941485.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Here's the histogram internals documentation I promised awhile back
(second patch).

Accompanying it is a new config option that enables a new hist_debug
event file, which is used by the examples in the doc to display
some of the histogram internals (third patch).

The first patch is just a cleanup suggested by Masami that I
previously missed.

Thanks,

Tom

The following changes since commit 8e99cf91b99bb30e16727f10ad6828741c0e992f:

  tracing: Do not allocate buffer in trace_find_next_entry() in atomic (2020-04-03 11:30:50 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-design-doc-v1

Tom Zanussi (3):
  tracing: Check state.disabled in synth event trace functions
  tracing: Add histogram-design document
  tracing: Add hist_debug trace event files for histogram debugging

 Documentation/trace/histogram-design.rst | 2115 ++++++++++++++++++++++
 kernel/trace/Kconfig                     |   23 +
 kernel/trace/trace.h                     |    1 +
 kernel/trace/trace_events.c              |    4 +
 kernel/trace/trace_events_hist.c         |  292 ++-
 5 files changed, 2419 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/trace/histogram-design.rst

-- 
2.17.1

