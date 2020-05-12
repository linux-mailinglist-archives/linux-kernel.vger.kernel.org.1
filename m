Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A491CF59C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgELNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 09:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELNXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:23:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E2A206DD;
        Tue, 12 May 2020 13:23:48 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jYUst-0006NY-Mp; Tue, 12 May 2020 09:23:47 -0400
Message-ID: <20200512132317.343672858@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 09:23:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: More fixes for 5.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami Hiramatsu (1):
      bootconfig: Fix to prevent warning message if no bootconfig option

Steven Rostedt (VMware) (2):
      tools/bootconfig: Fix apply_xbc() to return zero on success
      tracing: Wait for preempt irq delay thread to execute

----
 init/main.c                          | 10 ++++++----
 kernel/trace/preemptirq_delay_test.c | 12 ++++++++++--
 tools/bootconfig/main.c              |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)
