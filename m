Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA421BD33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 20:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGJSwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgGJSwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:52:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B823C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:52:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 72so2623267ple.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bl55R7MkjCz9LQEDWeY819kEKM3Vq/nTi6UOAyX5DJc=;
        b=GJY6d9mNhmHw5jxxiLKCkRvwD/9havQMHLpzsemfm1jjrvdMDw+5WU4aVAmEqoLClz
         I92VYQ0wYKYPa8AZDU6DpMIWIqt3/EyZQOy8ZhfVf5naadqj3KSGniFyIwLBwTauuzEH
         t+M4J78v3NdK0hBZqEMnv+ZIppeQFEIPr8G6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bl55R7MkjCz9LQEDWeY819kEKM3Vq/nTi6UOAyX5DJc=;
        b=WUIxB3nchDnE2dAs7glg7BUcOsbUxcg5QJt+Ib44/UMzL1Z0Ph+zzBMdbSueBRzlPp
         GDt4XupF/bmesY6Jn9y6odpcXQDyYPKvM76dBXZFOx/0+FK5jbbGCwdSJ5EMhG0Fciia
         d5qTfCvJUFwSXywNzh28HPinrzjEAVYNwyhuiOS8Lfu0aq6N8IW3K4N8rBZ/daJ7lZpA
         vGhmiZVo27fsKMSXj8/JvjEwckJZm85YZj1TxBtXeKf6VsmTRhGLnm3T6Kw1h99bjEMW
         94H9ro/g5jihZYK28Xy5VxyXaYkw3zxcYsBEMC66BeDhlYQh5V/bovPWh0Dlpk4gwRuy
         Pc0g==
X-Gm-Message-State: AOAM532bXvL9M4TDg6SK7uiPtOlk90ENRv9JZh/KV3nOPU0BrTfpOdzL
        tOT1bvkabmnHYrwXqwqFUKO3/UX02nk=
X-Google-Smtp-Source: ABdhPJwprVjZLk+LE4sues9Kmn9+2PNrDWDVet5xPoncGvqpaUSekJ4znqxqBHiOggcOPavdHhNYsQ==
X-Received: by 2002:a17:90a:1f08:: with SMTP id u8mr7416985pja.154.1594407121035;
        Fri, 10 Jul 2020 11:52:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w123sm6938932pfd.2.2020.07.10.11.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 11:51:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp 1/2] selftests/seccomp: Add SKIPs for failed unshare()
Date:   Fri, 10 Jul 2020 11:51:55 -0700
Message-Id: <20200710185156.2437687-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710185156.2437687-1-keescook@chromium.org>
References: <20200710185156.2437687-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the seccomp tests as a regular user shouldn't just fail tests
that require CAP_SYS_ADMIN (for getting a PID namespace). Instead,
detect those cases and SKIP them.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index bd97a985c9e6..08bfbb7fc1c2 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3420,7 +3420,10 @@ TEST(user_notification_child_pid_ns)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
-	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
+	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0) {
+		if (errno == EPERM)
+			SKIP(return, "CLONE_NEWPID requires CAP_SYS_ADMIN");
+	};
 
 	listener = user_notif_syscall(__NR_getppid,
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
@@ -3485,7 +3488,10 @@ TEST(user_notification_sibling_pid_ns)
 	}
 
 	/* Create the sibling ns, and sibling in it. */
-	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
+	ASSERT_EQ(unshare(CLONE_NEWPID), 0) {
+		if (errno == EPERM)
+			SKIP(return, "CLONE_NEWPID requires CAP_SYS_ADMIN");
+	}
 	ASSERT_EQ(errno, 0);
 
 	pid2 = fork();
-- 
2.25.1

