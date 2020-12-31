Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92C2E8102
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgLaPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 10:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 10:36:44 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00C8C061573
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 07:36:03 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b5so5489406pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 07:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPfQ2uebtrSwoqOcDW/lg9b8TxzWpAgk7WIY2LXzPJs=;
        b=Gc/Lh/xpjB628PrfrbxyVewoDf1FQcz1w0RbrHAq+1zucmBPUuv5tN61ZE19fOJv9A
         7zYCD+kQLYjWj7BA7ac2Pw3FZqjm99E5kguh6qXu872YLDzb3CXJo3LFUaIzA5FSAD6l
         Oshu9tVEXqSoQ3Cq2sjvDwaZcHjn9oCAevDQVQ96ychonS1rf7Xdb1kYZBo/Nc/OeYQx
         LPMYrVlPnzPZi2pVBZdJRLFYamdAnkr7Zb8lVQBaYGxtUzZ6Yi1hls4ogNoaGRUv05mN
         vnoEWpdj2HIHikLI23X18eo80Srx/UB1Tei4z2l7PIZpNcoEFoh71BmOcjiFCG1tWEoc
         mBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPfQ2uebtrSwoqOcDW/lg9b8TxzWpAgk7WIY2LXzPJs=;
        b=sJ0dZzah+w5c+re72KMV7vlEsX5oXv3Y/Isk5QxfgzoHbQ4HXrYem6c+7nPgPjFthm
         jUnkKHinl3G2YLxTGfEAdjStu+AsppMIEyOsuqfUS0VHqHHYjPrmsAG8v4hZwgpUoqiz
         hkVfZiEIXxVKCyr0rYtbNzwuUfWFdM3mHqwe13XOCeTDw4nDJHrIyQtjz22ca/CjgpEL
         DtuQ78y2ayLRv3OicvngMsUAJNbWq2ddBqrx+cOBLPgE9JozGgbiy7V+SGnD9XfWHR4x
         ng+IQZSeMRimMlc2olq32+G4J3c7SoglI4Bl24ly489RjrHVL4xCJ+2dpnYJMY1T0Riu
         Avxw==
X-Gm-Message-State: AOAM530S9HrJHbqf7OQnE0FbXZyVVGc/a8hQHmHo4QYXZ8JPRmp+r0lD
        oiJV/2hZBivVtffMKk2Q4EIw4mZ6TJw=
X-Google-Smtp-Source: ABdhPJxBhnaWyYvefe4Ye2D++4H3lq/m35EQykORk0Tb8drlP5bHkMoQXTinLcOiDrr8aM4pHKCWQQ==
X-Received: by 2002:a17:90a:193:: with SMTP id 19mr13771327pjc.45.1609428963402;
        Thu, 31 Dec 2020 07:36:03 -0800 (PST)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id i25sm42823185pfo.137.2020.12.31.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 07:36:02 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] trace: Update trace_ignore_this_task() kernel-doc comment
Date:   Thu, 31 Dec 2020 10:35:58 -0500
Message-Id: <20201231153558.4804-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update kernel-doc parameter after
commit b3b1e6ededa4 ("ftrace: Create set_ftrace_notrace_pid to not trace
tasks")
added @filtered_no_pids.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8a2d786b503..9e4f4043a3df 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -530,6 +530,7 @@ trace_find_filtered_pid(struct trace_pid_list *filtered_pids, pid_t search_pid)
 /**
  * trace_ignore_this_task - should a task be ignored for tracing
  * @filtered_pids: The list of pids to check
+ * @filtered_no_pids: The list of pids not to be traced
  * @task: The task that should be ignored if not filtered
  *
  * Checks if @task should be traced or not from @filtered_pids.
@@ -780,7 +781,7 @@ u64 ftrace_now(int cpu)
 }
 
 /**
- * tracing_is_enabled - Show if global_trace has been disabled
+ * tracing_is_enabled - Show if global_trace has been enabled
  *
  * Shows if the global trace has been enabled or not. It uses the
  * mirror flag "buffer_disabled" to be used in fast paths such as for
-- 
2.26.2

