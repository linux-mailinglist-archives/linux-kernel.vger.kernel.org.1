Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C4282EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 03:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJEBoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 21:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJEBoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 21:44:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0577C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 18:44:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so7680774wrn.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 18:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwACq6EY+00lWsh3rNkUGyKYCrtYeYAMaw1jRuUMdvs=;
        b=fNg5L3S+yHkDMcPhytLgg77oXhuGNesWJz1Wby+q2X5qI+BlWOuCZdCreZagdPpykA
         hVChIHuVuwG4JEHlHrkcdP5O6izL9Fagv1e5d9WkRXvAgyq2c8zdN/mgIoF1JbLj+LlY
         IXXuboAELVu6iL1Yu2NzIclkeJP271fhX8O8JQ8/7wzQtjgVwLFxmkzwHPbkOXdtjKze
         Q+dl7geC9CM1zgW4IlZ0ief7jL3WP0fvTz3DFhdqAybB18Aw1uD7Tw1R7s2EQP5yqatM
         np4RWoVtRE9Iq0QRodksw1cK7WtYQvIMrk8TA7+sCbam+Kj8kF9LZGqiaF/GNLt4uiK9
         eFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwACq6EY+00lWsh3rNkUGyKYCrtYeYAMaw1jRuUMdvs=;
        b=VbIxCBSBHuQI7MF3Lk2372CUFE+O47eD/S3zg/XGMCqEHFzrOFqPWzhrQWhi31QjtH
         HpaIRafzNxWezMfaclZ55pmFeFTS/a48cYQiqEl0Fwa9AwBkF4278C2RLUQxJngtIjHo
         9/QrCExCXmbFsSjbvAtSFLnnGbd6tRTwzXUgyLjtJWgXg7GMvNhntny85gZ57E+bX4Df
         ogWDgadYrqsQXf2HDs2MmelfZT/8Jifhtp923jQ+gmEtalFcaH1i5gCUVMnuBCmZ+cVu
         HnBHAV3HDY732TznQA6MsapSqWYfaAyIYp2FSln+SDeXZ4JHe3MhGZsLfCi3ztPiMzuF
         lwzw==
X-Gm-Message-State: AOAM532DrFaZU5aOREava8MgzIp4k3AzNqYV4uzC096Mt+jJAEiOf0lg
        H1yj/Q/j1DWtw9cm5bMcslhpYXvgQzb22A==
X-Google-Smtp-Source: ABdhPJxsq+kWrH67eZyvDx8Cy5yRg/8erdAlDa9QjbtL9+0FsHS5K3VJ74xw7Q3p98KM4TjZwG6e/Q==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr14403425wrt.162.1601862255972;
        Sun, 04 Oct 2020 18:44:15 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id s19sm6745390wmc.41.2020.10.04.18.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 18:44:15 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH resend] seccomp: Make duplicate listener detection non-racy
Date:   Mon,  5 Oct 2020 03:44:01 +0200
Message-Id: <20201005014401.490175-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, init_listener() tries to prevent adding a filter with
SECCOMP_FILTER_FLAG_NEW_LISTENER if one of the existing filters already
has a listener. However, this check happens without holding any lock that
would prevent another thread from concurrently installing a new filter
(potentially with a listener) on top of the ones we already have.

Theoretically, this is also a data race: The plain load from
current->seccomp.filter can race with concurrent writes to the same
location.

Fix it by moving the check into the region that holds the siglock to guard
against concurrent TSYNC.

(I am not marking this for stable backport because I believe that this does
not have any implications beyond a theoretical data race and allowing
userspace to create seccomp filters with weird semantics if userspace
concurrently installs seccomp filters in a way no benign userspace workload
would.)

(The "Fixes" tag points to the commit that introduced the theoretical
data race; concurrent installation of another filter with TSYNC only
became possible later, in commit 51891498f2da ("seccomp: allow TSYNC and
USER_NOTIF together").)

Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Jann Horn <jannh@google.com>
---
NOTE: After Tycho gave his Reviewed-by, I've had to adjust the errno
to -EBUSY (my original patch broke UAPI, good thing we have selftests),
remove the unused "cur" from init_listener(), and remove the now
useless initialization of "ret".

resending because the first time I mangled the diff... sorry

 kernel/seccomp.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 676d4af62103..c359ef4380ad 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1472,13 +1472,7 @@ static const struct file_operations seccomp_notify_ops = {
 
 static struct file *init_listener(struct seccomp_filter *filter)
 {
-	struct file *ret = ERR_PTR(-EBUSY);
-	struct seccomp_filter *cur;
-
-	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
-		if (cur->notif)
-			goto out;
-	}
+	struct file *ret;
 
 	ret = ERR_PTR(-ENOMEM);
 	filter->notif = kzalloc(sizeof(*(filter->notif)), GFP_KERNEL);
@@ -1504,6 +1498,31 @@ static struct file *init_listener(struct seccomp_filter *filter)
 	return ret;
 }
 
+/*
+ * Does @new_child have a listener while an ancestor also has a listener?
+ * If so, we'll want to reject this filter.
+ * This only has to be tested for the current process, even in the TSYNC case,
+ * because TSYNC installs @child with the same parent on all threads.
+ * Note that @new_child is not hooked up to its parent at this point yet, so
+ * we use current->seccomp.filter.
+ */
+static bool has_duplicate_listener(struct seccomp_filter *new_child)
+{
+	struct seccomp_filter *cur;
+
+	/* must be protected against concurrent TSYNC */
+	lockdep_assert_held(&current->sighand->siglock);
+
+	if (!new_child->notif)
+		return false;
+	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
+		if (cur->notif)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * seccomp_set_mode_filter: internal function for setting seccomp filter
  * @flags:  flags to change filter behavior
@@ -1575,6 +1594,11 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	if (!seccomp_may_assign_mode(seccomp_mode))
 		goto out;
 
+	if (has_duplicate_listener(prepared)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	ret = seccomp_attach_filter(flags, prepared);
 	if (ret)
 		goto out;

base-commit: fb0155a09b0224a7147cb07a4ce6034c8d29667f
-- 
2.28.0.806.g8561365e88-goog

