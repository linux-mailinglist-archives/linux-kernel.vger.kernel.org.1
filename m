Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C526F2DFFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgLUS0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgLUS0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:26:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC782C061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:25:59 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g185so11853142wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLw6nQbk/SU8lor3DghNwoYBaH7N9lfp25b6fBdb1sw=;
        b=kv9f9FBQ5KU+lFWFobkjTsS11p+MP+8+3s/tALVbsyZWR1IL2vmksuQ//j5412KpRE
         dHpdFsxJHItMKV2VOwRYFCc8I9H61/QfwADw2rN1cYLK3+AGUcHdiR06x0A6gvFeHPqz
         KFUhHQOlNv3f7cNnloLR+9KD6XTXuMUD6oedD3tB842N75soAvjlK0ampMXbh33jssvA
         o77qfNhA+jKyayjVUJs5FDIeVXjIZy5LTpFe64mU5hdDEnVTf14DaQILwFN06hB+Lgy9
         rRaCigEBMJ42jIFgK5cFHRzY5gn1c+VlJOkOM/r/+93ywgsS3IoHKEbS02vpNTJCkv9t
         jt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLw6nQbk/SU8lor3DghNwoYBaH7N9lfp25b6fBdb1sw=;
        b=Pgt/yZt724QKBBy/SHlGkNkZpSdszAK2rIK70Maf9ewoDPHEbAupKYp9d7/LbH8k0i
         tAe7USRluBZDRjeuwDyLbpmScBGO6rvxx1qgscBd54+e01RUrYQ3F6Spyzaxq0Qryreq
         YncO2+PZedsM2m8xcYF3tti6lOG5jhR3f9C9a9oIFIBKOMOIoUxuy/qYQizUvW/oedUS
         6kVoEHb4raWrc9odx207mgxN3cgiiLgKX4yknOB30KK2/tgiAUs0ocogKxU8naP4J/xF
         xFnUoZ1WTx7q0sKRBH+as90510L/9oBDDj4ZE1Q+ozeCuUf88jM6TJBrdVe8JUBsj7kR
         xmUQ==
X-Gm-Message-State: AOAM530GTVayPjQeyniXTsIm8am54mgMDtC9XNm5/Tj6SOHelWo82naf
        lqdQl/aGMmfd9PBKrXdYOTO87KkMUzh9GWfl
X-Google-Smtp-Source: ABdhPJyosfxMTszKvv7J3/O9V1D4v0Hp25kt6LsMP9DtoKMhwdoP15IIONsioYiN5HGFR5pB+6zEyA==
X-Received: by 2002:a05:600c:21c7:: with SMTP id x7mr16594583wmj.75.1608563040796;
        Mon, 21 Dec 2020 07:04:00 -0800 (PST)
Received: from kali.fritz.box ([185.93.203.205])
        by smtp.gmail.com with ESMTPSA id i16sm26553682wrx.89.2020.12.21.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:04:00 -0800 (PST)
From:   Alexander Guril <alexander.guril02@gmail.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Guril <alexander.guril02@gmail.com>
Subject: [PATCH] Kernel: Fixed two bracket problems in fork.c
Date:   Mon, 21 Dec 2020 16:05:02 +0100
Message-Id: <20201221150502.70290-1-alexander.guril02@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes two bracket problems in kernel/fork.c

Signed-off-by: Alexander Guril <alexander.guril02@gmail.com>
---
 kernel/fork.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 41906a52a764..3a5301867297 100644
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

