Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C231F75F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 11:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgFLJ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 05:28:56 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59153 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbgFLJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:28:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U.LjMey_1591954130;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.LjMey_1591954130)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 17:28:51 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 1/4] tracing: not necessary to undefine DEFINE_EVENT again
Date:   Fri, 12 Jun 2020 17:28:41 +0800
Message-Id: <20200612092844.56107-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
References: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After un-define DEFINE_EVENT in Stage 2, DEFINE_EVENT is not defined to a
specific form. It is not necessary to un-define it again.

Let's skip this.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/trace/trace_events.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 502c7be50b8d..a4994761bdaf 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -443,9 +443,6 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	tstruct								\
 	{} };
 
-#undef DEFINE_EVENT
-#define DEFINE_EVENT(template, name, proto, args)
-
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
 	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
@@ -523,9 +520,6 @@ static inline notrace int trace_event_get_offsets_##call(		\
 	return __data_size;						\
 }
 
-#undef DEFINE_EVENT
-#define DEFINE_EVENT(template, name, proto, args)
-
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
 	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
-- 
2.20.1 (Apple Git-117)

