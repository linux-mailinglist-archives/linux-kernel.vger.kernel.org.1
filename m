Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7E128FC77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404237AbgJPCko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404228AbgJPCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:40:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B012C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so908635wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IcagjNj/dK1Y8RczpuQCkX5yBuEwqqFKdmDjpHwB/uo=;
        b=MddfLAWGyYBRfNuN1ok8b6DU3DiyooyjcqJoJfOhV+LJKWza09r9Go8ofj1LC/QisZ
         RX1U7FiWILjd8tJ4OPgtOUEDISb8w3/bkgvVAJMxqUZUHmQ+HhuSYJFp/Ralp9ECoDZq
         SMtrG+132hhR9UTmdkq2zSCiGcjHv1krB4OeKFj1QSfxQBK595gy4ZNGwhxkNu3BZxOK
         bn81x1r9B6DOkbjCVmkPpnJ/P0Hiju8Dg99yreeh5ABC2m7yGbRjs7seprwLuOdcEt5s
         My5XZ+XMcAOZGWsPD45667KU2tZIhqcxBWzE2Ng//a54J+Tl1nGWSutjgrXIQcYbJuar
         Ctig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcagjNj/dK1Y8RczpuQCkX5yBuEwqqFKdmDjpHwB/uo=;
        b=pKzbw9hPeyYDTrV1xgRtstAxLPvl7l0MkMKIpL3ulQoYwd7WIYVoBsLzaUfmDfmpOX
         X7HhDxvxqt+9jfgJR1MS6sDo22SRJolbs9neCnbyx9fPi4w4xYzvF2qN6Ky3lDSh51Q+
         dnsnWh3tsPJdmsHAYB7T3UWT4JpE9MBbGRsyVJZ09K8nzYOoN5KwDw0CL1yfqVsX3N+1
         +K5hnBf0y2mz6U7OKukBus7LKznG0cOInnwiy238npO4wBjJTOyhzPaL0B0+KyZ1PJwR
         PEFgFJ3YDnhf63ewg5AIYOMfBW3GcSvjyJM8aIZBygoIRerbLO73Qx/oFiFBQN2k5KND
         LMZw==
X-Gm-Message-State: AOAM5324BdRWeqNrfFg8I7CqIATMEDkpQcs5XgbY3mnBttQsOtPI62Tf
        AJXRFlHg9UM3Bc7QTODa/M6n4A==
X-Google-Smtp-Source: ABdhPJximA8TmzkmMulZ0xLdHIxKgoI2ci4m2SYAs/YeDnDT1bJXj91PiKhT9FEUOj80FiKoKk0j4Q==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr1179844wrp.312.1602816040727;
        Thu, 15 Oct 2020 19:40:40 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id z5sm1511651wrw.37.2020.10.15.19.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 19:40:40 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 5/6] ptrace: Use mm_ref() for ->exit_mm
Date:   Fri, 16 Oct 2020 04:40:18 +0200
Message-Id: <20201016024019.1882062-6-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016024019.1882062-1-jannh@google.com>
References: <20201016024019.1882062-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only use ->exit_mm to look up dumpability and the ->user_mm; we don't
need to keep the PGD alive for this.
mmgrab() is also inconvenient here, because it means that we need to use
mmdrop_async() when dropping the reference to the mm from an RCU callback.
Use mm_ref() instead of mmgrab() to make things neater.

Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/exit.c | 2 +-
 kernel/fork.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 97253ef33486..03ba6d13ef1e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -476,7 +476,7 @@ static void exit_mm(void)
 	/* more a memory barrier than a real lock */
 	task_lock(current);
 	current->mm = NULL;
-	mmgrab(mm); /* for current->exit_mm */
+	mm_ref(mm); /* for current->exit_mm */
 	current->exit_mm = mm;
 	mmap_read_unlock(mm);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/fork.c b/kernel/fork.c
index 59c119b03351..4383bf055b40 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -720,7 +720,7 @@ void free_task(struct task_struct *tsk)
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
 	if (tsk->exit_mm)
-		mmdrop_async(tsk->exit_mm);
+		mm_unref(tsk->exit_mm);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
-- 
2.29.0.rc1.297.gfa9743e501-goog

