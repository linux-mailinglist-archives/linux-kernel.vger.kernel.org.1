Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6989D2F2DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbhALLM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhALLMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:12:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A26BC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:12:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r5so1813224eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ua+Z0odgaolBOHm42/0uflOhkiX55mBY8iH4eNMyuf8=;
        b=G3gRKAcmFjtbjul0XJsGRDCH0+x2kCYGDqL47lXK1xKKqWkiF2AIloi4udYoQIFO36
         GM7kemAXySrUu/AYlwg1WmihxnMh0XmSOkRZPz1Wtj21XoqFWI4aPiuBBwplg3OcIh/I
         RxxyxxT7RlNsvfMTUzfW4vS9mo3av3VqvtpyLlCJ73lTS9oQnBAri4c5NJIhEBUjMScl
         UDGTMMEj/qxrqYwNJqguw8+AXvhd6dkVuMOmv+UnanwIdvhDPZs0FWQeFL55TjKp1oXa
         h9AlUVpm9Q03ylr8cvJ3WsXvTfG7J41t+BE6MnrUe+X64o73Ea4+YFlNgV0FZ5o3BIFC
         OUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ua+Z0odgaolBOHm42/0uflOhkiX55mBY8iH4eNMyuf8=;
        b=EpmxWELwYAZDcJcdtsWmKL3ScnSUJUnWINfb4wSMoJjBb/00TSnQlQwNIVSVgqgDk/
         mn7f8p3ADhg0c1prCq8FkiRiEGkHh8H6f0ulamjmdS8Tkj/10jPt1MdAorJ0PI4Zs08G
         cJjxLbM3y11kvoBKM3iKeoGg3V6q+sUmljig059cRZJzOt3xV+hiBS//lC1NxvcMra+d
         AbQSTmTJR+FBH4cwpsAAHiaqSFEcj/67DZj4aEgTbYLwBgiSrmEo/3mnFFAXq2FJI/p7
         0accdEeZBPW/PavNZCE/I4g22R85Zy8BREh8FwAUq9RBhFn0Zlpb9dldtuD2nvCRL6BQ
         1u6Q==
X-Gm-Message-State: AOAM533XqK5JTxHagGyWxgzqjuluN0Klmnt2GL6TYBqe6uXmq37hqTUm
        h7kzP4HjreqJQQDDAl35KbYOqRQKMx4=
X-Google-Smtp-Source: ABdhPJw++Jci34el8JYECKtej9bq1iOuo7UAsxjKl9baOgu+mJlneP+ADjwY2cAK1CPkg0Jjdo0eyg==
X-Received: by 2002:aa7:c151:: with SMTP id r17mr2916892edp.106.1610449931533;
        Tue, 12 Jan 2021 03:12:11 -0800 (PST)
Received: from localhost.localdomain (ip5f5bfcff.dynamic.kabel-deutschland.de. [95.91.252.255])
        by smtp.gmail.com with ESMTPSA id k2sm1066045ejp.6.2021.01.12.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 03:12:11 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, beanhuo@micron.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix two compiling warnings
Date:   Tue, 12 Jan 2021 12:12:02 +0100
Message-Id: <20210112111202.23508-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add description for two function parameters, to fix below two warnings:

kernel/trace/trace.c:464: warning: Function parameter or member 'this_tr' not described in 'trace_array_put'
kernel/trace/trace.c:543: warning: Function parameter or member 'filtered_no_pids' not described in 'trace_ignore_this_task'

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8a2d786b503..8edcd91ed172 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -454,6 +454,7 @@ static void __trace_array_put(struct trace_array *this_tr)
 
 /**
  * trace_array_put - Decrement the reference counter for this trace array.
+ * @this_tr : pointer to the trace array
  *
  * NOTE: Use this when we no longer need the trace array returned by
  * trace_array_get_by_name(). This ensures the trace array can be later
@@ -530,6 +531,7 @@ trace_find_filtered_pid(struct trace_pid_list *filtered_pids, pid_t search_pid)
 /**
  * trace_ignore_this_task - should a task be ignored for tracing
  * @filtered_pids: The list of pids to check
+ * @filtered_no_pids: The list of pids that not be traced by the function tracer
  * @task: The task that should be ignored if not filtered
  *
  * Checks if @task should be traced or not from @filtered_pids.
-- 
2.17.1

