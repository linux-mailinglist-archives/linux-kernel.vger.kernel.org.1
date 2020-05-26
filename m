Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7864E1C980A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 19:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgEGRjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 13:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgEGRja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:39:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9987624956;
        Thu,  7 May 2020 17:39:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jWkUb-000DpG-H3; Thu, 07 May 2020 13:39:29 -0400
Message-ID: <20200507173929.409881472@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 07 May 2020 13:39:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [for-linus][PATCH 8/9] tracing: Fix doc mistakes in trace sample
References: <20200507173904.729935165@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@gmail.com>

As the example below shows, DECLARE_EVENT_CLASS() is used instead of
DEFINE_EVENT_CLASS().

Link: http://lkml.kernel.org/r/20200428214959.11259-1-richard.weiyang@gmail.com

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/trace_events/trace-events-sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 80b4a70315b6..13a35f7cbe66 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -416,7 +416,7 @@ TRACE_EVENT_FN(foo_bar_with_fn,
  * Note, TRACE_EVENT() itself is simply defined as:
  *
  * #define TRACE_EVENT(name, proto, args, tstruct, assign, printk)  \
- *  DEFINE_EVENT_CLASS(name, proto, args, tstruct, assign, printk); \
+ *  DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, printk); \
  *  DEFINE_EVENT(name, name, proto, args)
  *
  * The DEFINE_EVENT() also can be declared with conditions and reg functions:
-- 
2.26.2


