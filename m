Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607CE28FC79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbgJPCkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404251AbgJPCkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:40:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C232FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so968495wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MM4vknTStYRLkGZw4tEHhTyBDfVUaCowXRmIC2TIp+c=;
        b=UzPVodG7vA2ic1HH1rFJ9ZFcjIcafLiynej1hsfsW7Kk8wfH5gNDzFpgzEjh3lN58l
         k0dAp9bXU+cG3pzw3tHSGbuYEk2L7mtIYHUFm+JeveAYlOMp75+XCbhV8IOZtonrBENQ
         N3EuUEXsABr3wvBaELeeMCVuFKi/re3WS+eoQMSP1pOGXHnkEyafFQENqCfVkz8ZBh12
         LEr/np5tTIRUXaDrf3a6Zu5AOPiFCvfr+ogI139Xbc2dsROxhWd1zDR87GC3eWDxiU15
         Mgm+yz3mfYc2ggE+SKeJcFy7gWvizCM5fduQMpvrjIhdvXokKcUaTd0xrhi19exO0wq1
         CZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MM4vknTStYRLkGZw4tEHhTyBDfVUaCowXRmIC2TIp+c=;
        b=R7owW4X4faazngEk1MLHP/Ki9FzUmALc8dOHOmcv/MLyscAJ8uo200vvG0rkeJxbJu
         X/rk5bxyt6/UpYPS2WwN1cRyogtI6CpRZwArHhqL3O4Ya8FskD2Z1eR7bhpLJjrbWahK
         LvFbOQWELOvn1ieZ9127cgiUxgPU9HYJfS2aqCta/hFMG3WdyIhz1rHczfAEVV03UO3g
         0TEZ6OIkepscg1WC5QcAiZAHQ1Z+R0t+bqBc3tMU0U8g2aMwg8Ak8o86SWGv51bQMOre
         7QX7CY9eY759mEKv1uoRj0ZaaipC1TAx5id66mHygvn+I9m5NSDIx2jFR7wNWsp0RR+d
         dtPw==
X-Gm-Message-State: AOAM531lSb7PiHzTneaeYB2ittdq3DyRWXjhfO1bBCULq9e+4zf9E3t0
        GgWTsGRbVNnNq8TaRUiYc8aIhw==
X-Google-Smtp-Source: ABdhPJzhEFMFksHr3z4YKmc2OKnKI/GGyeg8SX7OdlCeHKjZMM8NAVXhzJhEFVJQFXw7prbPniY0DA==
X-Received: by 2002:a7b:c451:: with SMTP id l17mr1421587wmi.127.1602816042197;
        Thu, 15 Oct 2020 19:40:42 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id p9sm990595wma.12.2020.10.15.19.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 19:40:41 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 6/6] mm: remove now-unused mmdrop_async()
Date:   Fri, 16 Oct 2020 04:40:19 +0200
Message-Id: <20201016024019.1882062-7-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016024019.1882062-1-jannh@google.com>
References: <20201016024019.1882062-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preceding patches have removed all users of mmdrop_async(); get rid of
it.

Note that on MMU, we still need async_put_work because mmput_async() uses
it, which in turn is used by binder's shrinker callback. We could claw back
those 4 words per mm if we made mmput_async() depend on
CONFIG_ANDROID_BINDER_IPC.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/mm_types.h |  2 ++
 kernel/fork.c            | 16 ----------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 764d251966c7..8fde2068bde1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -560,7 +560,9 @@ struct mm_struct {
 #ifdef CONFIG_HUGETLB_PAGE
 		atomic_long_t hugetlb_usage;
 #endif
+#ifdef CONFIG_MMU
 		struct work_struct async_put_work;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 4383bf055b40..c5f2ec544933 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -666,22 +666,6 @@ void __mmdrop(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
 
-static void mmdrop_async_fn(struct work_struct *work)
-{
-	struct mm_struct *mm;
-
-	mm = container_of(work, struct mm_struct, async_put_work);
-	__mmdrop(mm);
-}
-
-static void mmdrop_async(struct mm_struct *mm)
-{
-	if (unlikely(atomic_dec_and_test(&mm->mm_count))) {
-		INIT_WORK(&mm->async_put_work, mmdrop_async_fn);
-		schedule_work(&mm->async_put_work);
-	}
-}
-
 static inline void free_signal_struct(struct signal_struct *sig)
 {
 	taskstats_tgid_free(sig);
-- 
2.29.0.rc1.297.gfa9743e501-goog

