Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5403A290DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409056AbgJPXJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407671AbgJPXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:09:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE70C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s9so4847654wro.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4AQ8wqNpjVt1ykz0FMlQ/Hn0cAH4pxEjRmJmEVEXzM=;
        b=rClZn7/P2brEcbJ17hk3v5Ov20ONpnJc3N7mscK6TVtzEI4C2dZVcNCjb2UbK3GcrH
         KOrmC+GfSAgf5CBO5WNij6aH3a293buv1EwV41bQyMSXwzh3MJn0iVkBEv+G7SWWNczj
         vtzPCkqVAbbr0bjfD35ZzQpr1Lgn5CWWWEo3YXHFLlZ8tkf99ubo03jvazvBLhHOC1xP
         8gQ+Xx3eR9NO0/YTyQOT7IdV6mTksrXqZTCaWg2l4hqnPa7E/QS3IEX9eLUnc7yluLWQ
         xj88YsUnFOCQpCiwuPuGMsh2AevEdExmakr+DPQ/A9NSXLpx5p+Kxfi/o7cfTQtApJEc
         NN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4AQ8wqNpjVt1ykz0FMlQ/Hn0cAH4pxEjRmJmEVEXzM=;
        b=YGKtQRkx/zqicM6sF3isrdzLrkPwCQqGsFt/dZZWZv+ID7e+gg1rv3m+Oozd59cSVU
         Lu8sopGuLoY1nUcg3GxDt0xQTkbxPD7gTn6xVQ47hl60ethD5d/3wKRPyke+z+zTJhXP
         7qHAqtegU77kYbVdi2TEp0bcRcBNtRvD35I8ApHzZmm15WN4v01bzOBbaxkByhmXaO8I
         xbiif+w6NApgCxWe/4BKBwepMfk3vBiaVKZ9zg7d3jx4rCwQdnDwCKNOwEn6GpbLTteL
         m6n4WiFTrXWDlyXSbGmm2m2Uq+6eUMaaVQMWZM5q8krGyTgpkhyCGZ/20Vi9Fp6tZh93
         houA==
X-Gm-Message-State: AOAM530fhKueHOWAl9tH1s0a+PzNBoGncJw65Wc5AyDGgM/fvaO6DogB
        RSM3XQiB4NLZXjQbMGG4QGGDYQ==
X-Google-Smtp-Source: ABdhPJzEacUrzZyN0193KfsbDyP+Nq2E/fuEoba3R3HJmfpoAO6isYjIW2vwr6uW3TdeSSNG7cYQgg==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr6904873wrm.423.1602889783182;
        Fri, 16 Oct 2020 16:09:43 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id q6sm4718202wma.0.2020.10.16.16.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:09:42 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH resend 4/6] mm, oom: Use mm_ref()/mm_unref() and avoid mmdrop_async()
Date:   Sat, 17 Oct 2020 01:09:13 +0200
Message-Id: <20201016230915.1972840-5-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016230915.1972840-1-jannh@google.com>
References: <20201016230915.1972840-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
@@ -686,12 +686,8 @@ static inline void free_signal_struct(struct signal_st=
ruct *sig)
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
=20
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index e90f25d6385d..12967f54fbcf 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -704,7 +704,7 @@ static void mark_oom_victim(struct task_struct *tsk)
=20
 	/* oom_mm is bound to the signal struct life time. */
 	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
-		mmgrab(tsk->signal->oom_mm);
+		mm_ref(tsk->signal->oom_mm);
 		set_bit(MMF_OOM_VICTIM, &mm->flags);
 	}
=20
--=20
2.29.0.rc1.297.gfa9743e501-goog

