Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB71C980C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgEGRj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 13:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgEGRja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:39:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7005624953;
        Thu,  7 May 2020 17:39:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jWkUb-000Dok-CZ; Thu, 07 May 2020 13:39:29 -0400
Message-ID: <20200507173929.271802310@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 07 May 2020 13:39:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yiwei Zhang <zzyiwei@google.com>
Subject: [for-linus][PATCH 7/9] gpu/trace: Minor comment updates for gpu_mem_total tracepoint
References: <20200507173904.729935165@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yiwei Zhang <zzyiwei@google.com>

This change updates the improper comment for the 'size' attribute in the
tracepoint definition. Most gfx drivers pre-fault in physical pages
instead of making virtual allocations. So we drop the 'Virtual' keyword
here and leave this to the implementations.

Link: http://lkml.kernel.org/r/20200428220825.169606-1-zzyiwei@google.com

Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/gpu_mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
index 1897822a9150..26d871f96e94 100644
--- a/include/trace/events/gpu_mem.h
+++ b/include/trace/events/gpu_mem.h
@@ -24,7 +24,7 @@
  *
  * @pid: Put 0 for global total, while positive pid for process total.
  *
- * @size: Virtual size of the allocation in bytes.
+ * @size: Size of the allocation in bytes.
  *
  */
 TRACE_EVENT(gpu_mem_total,
-- 
2.26.2


