Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793072CDCC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbgLCRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731379AbgLCRvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:51:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CD95206D8;
        Thu,  3 Dec 2020 17:51:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kkskz-002qtu-R6; Thu, 03 Dec 2020 12:51:05 -0500
Message-ID: <20201203175013.038902435@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Dec 2020 12:50:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] tracing: More updates for 5.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 5b7be9c709e10e88531f1f81e1150bbad65be1aa


Lukas Bulwahn (1):
      tracing: Clean up after filter logic rewriting

Steven Rostedt (VMware) (2):
      ftrace/documentation: Fix RST C code blocks
      ring-buffer: Add test to validate the time stamp deltas

----
 Documentation/trace/ftrace-uses.rst |   6 ++
 kernel/trace/Kconfig                |  20 +++++
 kernel/trace/ring_buffer.c          | 150 ++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_events_filter.c  |  21 -----
 4 files changed, 176 insertions(+), 21 deletions(-)
