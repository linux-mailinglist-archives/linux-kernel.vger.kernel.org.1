Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E813B28FC78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404253AbgJPCkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404226AbgJPCkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:40:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B5C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so1190886wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hiZDiQ/TR8ehnjVeOHrF6PP0oyaC/YML4vUQjMFIVA=;
        b=sdfx+7bUGp3cRgeTtdQ816RouRn8j6SP7HsK5d0gZuur4EGmaW0O6FljoLA0m5OoNq
         M7DmZ2odccv8yyAuoF+h0TtyDy1f1mlKs/jIHC9peBhE5Q1KFK5pZamwLxXowCisoDj9
         Q1sG5IuqOrG1ldID+7rHXZ8TshzViT65ThWtRwTdNmLiQt/FwHD0WbfUpjqPsM+eSUrT
         yy9wAPTM14hjTOyqbnGbln1lWVJyoyE+kZ5/StaNoA38OzLLCp3E6f5M5x3V7zD91BHb
         hFXZoQU3reKsdzc1zsedRDOR/VZo16BlDf1Z2jR9wrZxDuGcj+cqpPYbQNLsL1xn3DhR
         PCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hiZDiQ/TR8ehnjVeOHrF6PP0oyaC/YML4vUQjMFIVA=;
        b=dPczJUHB3jU2aabBxyZtyKxRFFE6Dd0KLH6WlVLEx6cXlI2L7S+YJaXvtAJzWU4aSj
         5roGLrTYiOkyMtXKZ2Gzzpvzb6eUXEZFUXsk8NENrl4758pxPMUFahVzxnErqwUMQg1s
         FmbSc7MtNDeJH/0Mi5VDk5ormdzXIwYhbsTYBlSMlcf95PdG+vgvpTNrqZxeiF15qWIr
         KmFFAgkNmE8HuykcCcwazzm75ez+3DKqMrICROfcRkCU8gWHg1jISjp3YM8T0EAbDoxU
         pu5qB8y9urmEqQjpI0hEvffC72QacgYcvMYnmPAIs8Rq/+zRCfXkGC/jEfnhb1MM1WQ4
         n0Sg==
X-Gm-Message-State: AOAM533mAQLjrg+tGXKZWicUQqelQAmnfr79h1EaTYB70akoo8D2IELo
        JWny9riwZsrqxTYJAQAdeZX9yA==
X-Google-Smtp-Source: ABdhPJwUZByfFbdIxgdaG6l/XtUPqQBgTpgUOUyknpODLVNPNySmarleCGv1ABqEejnzZl7lKAm85A==
X-Received: by 2002:a1c:3503:: with SMTP id c3mr1358021wma.43.1602816039091;
        Thu, 15 Oct 2020 19:40:39 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id m14sm1479195wro.43.2020.10.15.19.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 19:40:37 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 4/6] mm, oom: Use mm_ref()/mm_unref() and avoid mmdrop_async()
Date:   Fri, 16 Oct 2020 04:40:17 +0200
Message-Id: <20201016024019.1882062-5-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016024019.1882062-1-jannh@google.com>
References: <20201016024019.1882062-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OOM killer uses MMF_OOM_SKIP to avoid running on an mm that has started
__mmput(); it only uses the mmgrab() reference to ensure that the mm_struct
itself stays alive.

This means that we don't need a full mmgrab() reference, which will keep
the pgd (and potentially also some pmd pages) alive and can't be cleaned up
from RCU callback context; we can use an mm_ref() reference instead.

Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/fork.c | 6 +-----
 mm/oom_kill.c | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index fcdd1ace79e4..59c119b03351 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -686,12 +686,8 @@ static inline void free_signal_struct(struct signal_struct *sig)
 {
 	taskstats_tgid_free(sig);
 	sched_autogroup_exit(sig);
-	/*
-	 * __mmdrop is not safe to call from softirq context on x86 due to
-	 * pgd_dtor so postpone it to the async context
-	 */
 	if (sig->oom_mm)
-		mmdrop_async(sig->oom_mm);
+		mm_unref(sig->oom_mm);
 	kmem_cache_free(signal_cachep, sig);
 }
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index e90f25d6385d..12967f54fbcf 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -704,7 +704,7 @@ static void mark_oom_victim(struct task_struct *tsk)
 
 	/* oom_mm is bound to the signal struct life time. */
 	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
-		mmgrab(tsk->signal->oom_mm);
+		mm_ref(tsk->signal->oom_mm);
 		set_bit(MMF_OOM_VICTIM, &mm->flags);
 	}
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

