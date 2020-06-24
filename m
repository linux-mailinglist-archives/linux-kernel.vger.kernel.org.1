Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14124206AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 05:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbgFXDjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 23:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgFXDjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:39:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DED2085B;
        Wed, 24 Jun 2020 03:39:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jnwG5-003u7z-FS; Tue, 23 Jun 2020 23:39:33 -0400
Message-ID: <20200624033858.651927570@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 23:38:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: Fixes for 5.8-rc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami Hiramatsu (2):
      tracing/boot: Fix config dependency for synthedic event
      tracing: Fix event trigger to accept redundant spaces

Sascha Ortmann (1):
      tracing/boottime: Fix kprobe multiple events

Steven Rostedt (VMware) (1):
      ring-buffer: Zero out time extend if it is nested and not absolute

----
 kernel/trace/ring_buffer.c          |  2 +-
 kernel/trace/trace_boot.c           | 10 +++++++---
 kernel/trace/trace_events_trigger.c | 21 +++++++++++++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)
