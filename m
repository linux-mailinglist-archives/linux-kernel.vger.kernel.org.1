Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6FB2E2E11
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 12:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgLZLj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 06:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgLZLjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 06:39:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D32C061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 03:39:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w5so6143584wrm.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 03:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jswlWp9CEwRqHtfiBKcWpmjbL48olnU+8XdBDoym5Gg=;
        b=HeFa7KD0ku0USO28B1avZyQGYpR1ZDw8XiajDcI27yudhaC3Paw5ZerlpyPe+Kwj25
         vJrscurkFC1oofC6+kiPIJucw3F0W+kos84PZUzejFbEkqk24DDryyFc7RxMbXn86sGU
         gnY/1sxT5hzq9ncmOE2ECuk01tB2WAOI8gBJ2akkEsNMSY8t1q/7h+59IoAzjC6ZjmQd
         CfpSGiDrKvK7Ss8Ua/InZ+v6nMNC5Qe0xa0Gss7bjWFEET/P8i07JuTrbQWg5gjMqYAW
         R4cYDX8AFoxjLFo0WJf2I+ZDggvU2lvC0rmXPDpSoRkTnKZJJt3FLZ7S8O4uC6eSbTH2
         DB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jswlWp9CEwRqHtfiBKcWpmjbL48olnU+8XdBDoym5Gg=;
        b=GPuXLaXtiH7+szn+lsTTTF+AxCu8Ewu8UoVpkEWHY9sYki9tZXXprSESWbpmhZTz9R
         0rY0sQUG3Ulg5qdSdt711VCJSk33HVZ3qGEtEVzjZSciih/4LR14LE4xJv1WuoSbRaYj
         JncsqVEkxP9MI6hdHHKRhP48p3A99xZAkvd8ikQLTvF3CjAqfWqnypOvQ0pKOiP9uXTl
         ZrGUXyIta9kcsLlqtVYi//8QQBOu1B5NLVBs1K33vdFndUzb2c41miFPgfoyqGWqUOGq
         KGwiEY05R6HnnmGZnV6KgXATEAsxTQogww9HybHamzYRHWgoAQWZyua7cSXd3wA94yo0
         6a6g==
X-Gm-Message-State: AOAM533EGuFgQg2x/DL3m/QprfOdcmugc+0MH4adEoh8K8tuu0pvQ+gf
        2a5+Odo7EjtgUIPk1UQwsoI=
X-Google-Smtp-Source: ABdhPJyA6Epq0OXFOSj505qmvqeqP0LV0MMVuI9KVAFDqggMSKN+WJZm4gM7B8pKor0y7bnemrZr4Q==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr43266122wrp.340.1608982753302;
        Sat, 26 Dec 2020 03:39:13 -0800 (PST)
Received: from kali.fritz.box ([185.93.201.154])
        by smtp.gmail.com with ESMTPSA id s13sm11406625wmj.28.2020.12.26.03.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 03:39:12 -0800 (PST)
From:   Alexander Guril <alexander.guril02@gmail.com>
To:     christian.brauner@ubuntu.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Guril <alexander.guril02@gmail.com>
Subject: [PATCH] Kernel: fork.c: Fix coding style: Do not use {} around single-line statements
Date:   Sat, 26 Dec 2020 12:40:21 +0100
Message-Id: <20201226114021.2589-1-alexander.guril02@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two coding style issues in kernel/fork.c
Do not use {} around single-line statements.

Signed-off-by: Alexander Guril <alexander.guril02@gmail.com>
---
 kernel/fork.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 37720a6d04ea..d66cd1014211 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -819,9 +819,8 @@ void __init fork_init(void)
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 
-	for (i = 0; i < UCOUNT_COUNTS; i++) {
+	for (i = 0; i < UCOUNT_COUNTS; i++)
 		init_user_ns.ucount_max[i] = max_threads/2;
-	}
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
@@ -1654,9 +1653,8 @@ static inline void init_task_pid_links(struct task_struct *task)
 {
 	enum pid_type type;
 
-	for (type = PIDTYPE_PID; type < PIDTYPE_MAX; ++type) {
+	for (type = PIDTYPE_PID; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_NODE(&task->pid_links[type]);
-	}
 }
 
 static inline void
-- 
2.29.2

