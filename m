Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1366290DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409430AbgJPXJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408340AbgJPXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:09:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F3C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n6so4822058wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqE9YT9elxKHcuMev0eqxdSAa29MOpdvFBgbgr/Dw4c=;
        b=LhDuPgReRaskA4lZJUuE4meGMw+AgSOBWcN0nqcL7KFy86acDGi8um3oRgd5CDOyyW
         bJFG22PeRLjTWFTU0ukD0tLvCbDgdbDFYPyGitxBgX1xKbXiv598o0EuHa9yELSghqKw
         VA4T4kdrHVqd88Cs852iMYBnFRMpkx301IXdoi39KfAj+zcBhsCDBtvTEc8dT3mQEW7T
         7cylEg7GMWupAk7aZgn16x9jAZeU8zBSiMABrBnBpXTYtig7uF8ZJ7QptnUymL6udJDm
         sSK7gfMVEBYedaoF17S5Y2Kt1jq2Ee3Ymywe0au8W2vWFh7Kb2xhY8Sfp9vAdq5IO04Z
         rTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqE9YT9elxKHcuMev0eqxdSAa29MOpdvFBgbgr/Dw4c=;
        b=rDAFlsBL9gnhueEfUlhHVK0gLMWaqL5W2jE+A+dp5Bt2JoYAcwpf8jg9SisjfkWfWS
         5B756Qma4hF669FApJmMYP0X8W+Ux2vKdWBMMw5/0SbloTBJh+OMVnvBpoJ5HyZbOmLv
         XWrNz7E6EHc2V6pFyWS3G0LApubsil2mqop3CbcCcAcbxeEvN+BG84bNzScgKsit1rei
         rhM8fSMGAW6t2xjtGQuLU7g9Tu2EHW3v6/SYyloYEN15qCB4jaghvoDatXibH1wkKsK4
         ayecmW+QM7e0YkvrJE24w1J0czbVNgPtUuVcE5AcMTSpBDJiER7umedyG0Ivw41lj4uI
         APqw==
X-Gm-Message-State: AOAM531hmw7StzltALHAvs/1FegldrgJnhNMaxTelPYd0QJDJQqAZL3a
        +flsGEN5bUBDi3RR4fNIYKGReA==
X-Google-Smtp-Source: ABdhPJxhjUYQmLunbOMgkbnTqMUJ/Am0yPCMEVT4RqDmKWTqbn4mCWM3hyiVNo2TJIXie6ukzbX0NA==
X-Received: by 2002:a5d:4b49:: with SMTP id w9mr7015093wrs.41.1602889784661;
        Fri, 16 Oct 2020 16:09:44 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id v17sm6144214wrc.23.2020.10.16.16.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:09:44 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH resend 5/6] ptrace: Use mm_ref() for ->exit_mm
Date:   Sat, 17 Oct 2020 01:09:14 +0200
Message-Id: <20201016230915.1972840-6-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016230915.1972840-1-jannh@google.com>
References: <20201016230915.1972840-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
 	current->mm =3D NULL;
-	mmgrab(mm); /* for current->exit_mm */
+	mm_ref(mm); /* for current->exit_mm */
 	current->exit_mm =3D mm;
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
--=20
2.29.0.rc1.297.gfa9743e501-goog

