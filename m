Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5A1F75F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgFLJ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 05:29:03 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36072 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgFLJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:28:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U.LDzuO_1591954132;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U.LDzuO_1591954132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 17:28:53 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 4/4] tracing: not necessary to define DEFINE_EVENT_PRINT to be empty again
Date:   Fri, 12 Jun 2020 17:28:44 +0800
Message-Id: <20200612092844.56107-5-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
References: <20200612092844.56107-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous cleanup, DEFINE_EVENT_PRINT's definition has no
relationship with DEFINE_EVENT. So After we re-define DEFINE_EVENT, it
is not necessary to define DEFINE_EVENT_PRINT to be empty again.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/trace/trace_events.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 43023c3e9d74..1bc3e7bba9a4 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -709,9 +709,6 @@ static inline void ftrace_test_probe_##call(void)			\
 	check_trace_callback_type_##call(trace_event_raw_event_##template); \
 }
 
-#undef DEFINE_EVENT_PRINT
-#define DEFINE_EVENT_PRINT(template, name, proto, args, print)
-
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 #undef __entry
-- 
2.20.1 (Apple Git-117)

