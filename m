Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA8290E00
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409703AbgJPXKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407010AbgJPXJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:09:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83477C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t9so4833933wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdMs/4BkKI2uJNTjUP69TVUzfQ5T9+m8xYXEzWMRNr4=;
        b=GEabQQbYPZdJBOj2BGbAAiir4cXarxTnRaOVXj4JRtZnmqkGa2CMArEAtTbi/+hATc
         B3cLhuNPZmMDZZJ86auETwNS7l/UKxN72uloxbt8mov62APgfpCPMibJZymXO2u+hfYY
         tWXoKpqkr2Qqiu4JCttGYfZAkH/ujpEvJ1ewfBPeR4HRYEvHCoGe/kRLeMDB/rCwR+td
         NMmO7SkZilT2N5jpR4yiruA6rC3UNfH7boHds7qX9AyQpG3q9B/gPQRxlhOAm08sEyOa
         5WtVENVcOyUP7EBHec33EsP8pE9FjCvAdNR+mwZMFo//3lJ7WJyRClrGRBrrLRzn4e2R
         Z1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdMs/4BkKI2uJNTjUP69TVUzfQ5T9+m8xYXEzWMRNr4=;
        b=DYlj1vgo42UxfOd/7GKm1hQTVB6LO6BG//JP6hg59ZliS8Nb44K5a6/2YV3jLi4zAC
         eApxRPUQwK3fLBl05X1taT+M1I7JFj49z+9xP94dWlX+jalzMUPLhQrofsirT7iGRiBD
         EeFZGeBOZMvLtIgiUzlB5bhncaBjAQHUjofLxeOjjR9XHFgbAep7JD9wXrzONC1Qj194
         NKH5PyxDLiu/1txDXk88vHU2EJL5acugC6xp6gMYVX2l/dcQJyQfQeAE3Y4zg6jrNc9i
         dGM3r2qIodVdc26klKE0zTSS2BgiytDHXnprdow/PACkuaBg+N9jxLn4a2NuQXcmBbm3
         5ztg==
X-Gm-Message-State: AOAM530MMm7iHM6fAIcbIvuMRaAOCL6VNRmmj6L+2JIsao4Q5fCa0FVg
        2huSkk56FVBnfMeJbNetPIi81A==
X-Google-Smtp-Source: ABdhPJxbfO8IUNwESku/fIzsOaLeXDX/vfAWxdZkmAezDlH0QNO6awB1LAUdwuJDWyVhjwRK4WO4nQ==
X-Received: by 2002:adf:f810:: with SMTP id s16mr6374268wrp.424.1602889786072;
        Fri, 16 Oct 2020 16:09:46 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id t19sm5148559wmi.26.2020.10.16.16.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:09:45 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH resend 6/6] mm: remove now-unused mmdrop_async()
Date:   Sat, 17 Oct 2020 01:09:15 +0200
Message-Id: <20201016230915.1972840-7-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016230915.1972840-1-jannh@google.com>
References: <20201016230915.1972840-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
=20
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 4383bf055b40..c5f2ec544933 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -666,22 +666,6 @@ void __mmdrop(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
=20
-static void mmdrop_async_fn(struct work_struct *work)
-{
-	struct mm_struct *mm;
-
-	mm =3D container_of(work, struct mm_struct, async_put_work);
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
--=20
2.29.0.rc1.297.gfa9743e501-goog

