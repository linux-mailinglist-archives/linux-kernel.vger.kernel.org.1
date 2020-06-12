Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDCA1F75F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 11:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFLJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 05:28:58 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43606 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbgFLJ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:28:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U.LnXL5_1591954132;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.LnXL5_1591954132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 17:28:52 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 3/4] tracing: define DEFINE_EVENT_PRINT not related to DEFINE_EVENT
Date:   Fri, 12 Jun 2020 17:28:43 +0800
Message-Id: <20200612092844.56107-4-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
References: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current definition define DEFINE_EVENT_PRINT to be DEFINE_EVENT.
Actually, at this point DEFINE_EVENT is already an empty macro. Let's
cut the relationship between DEFINE_EVENT_PRINT and DEFINE_EVENT.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/trace/trace_events.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 5219f81b9d74..43023c3e9d74 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -210,8 +210,7 @@ TRACE_MAKE_SYSTEM_STR();
 #define DEFINE_EVENT(template, name, proto, args)
 
 #undef DEFINE_EVENT_PRINT
-#define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
+#define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
 #undef TRACE_EVENT_FLAGS
 #define TRACE_EVENT_FLAGS(event, flag)
@@ -444,8 +443,7 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	{} };
 
 #undef DEFINE_EVENT_PRINT
-#define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
+#define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-- 
2.20.1 (Apple Git-117)

