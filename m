Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC61B6902
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 01:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgDWXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 19:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbgDWXTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:19:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E6320784;
        Thu, 23 Apr 2020 23:19:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jRl7o-000Yr8-2p; Thu, 23 Apr 2020 19:19:20 -0400
Message-Id: <20200423231838.682478056@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 19:18:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: A few fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Yan (1):
      tracing: Convert local functions in tracing_map.c to static

Nikolay Borisov (1):
      tracing: Remove DECLARE_TRACE_NOARGS

Steven Rostedt (VMware) (1):
      ftrace: Fix memory leak caused by not freeing entry in unregister_ftrace_direct()

Vamshi K Sthambamkadi (1):
      tracing: Fix memory leaks in trace_events_hist.c

----
 include/linux/tracepoint.h       | 22 +---------------------
 kernel/trace/ftrace.c            |  1 +
 kernel/trace/trace_events_hist.c |  7 +++++++
 kernel/trace/tracing_map.c       |  6 +++---
 4 files changed, 12 insertions(+), 24 deletions(-)
