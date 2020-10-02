Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B72280C5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 04:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbgJBCpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 22:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBCpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 22:45:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3396C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 19:45:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qp15so743581ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 19:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=5Rjsywlk8XcXJ5AAHDX/GldFTWUqaZJyljRbSSLDafg=;
        b=LDpJ3Y2DTWoa+9SzChnL9us+LKkVfOon3vIbU1tveY5BFIYpRrOKpbw/LKdeH8FNJN
         dOR5mORlBEPIfO2yW9YSH60b8do6QdZKJsHeIzwYJ7eKaC3m5DNeyZS8Ii9phR3qEolK
         knSsxjCLdEK3WITdJcZ0/7rxu22K6kUO1Ws3cu6lgTTo2HwBOCT3uNCF9r/21+H+e60W
         hiAtit2+I/FT3hTt3tI7eubUu1JClOVTfRYrqCTbISTFdvFLj9bQm6wiYlRecEuMIOg4
         r0j3PCI7rMAL9Mg/NWd+xXPFd0LisICku6eiwi+k6onEFW1SeenRyq5Yw3fr8Hzkqezx
         Hofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=5Rjsywlk8XcXJ5AAHDX/GldFTWUqaZJyljRbSSLDafg=;
        b=h8JgDXuausIFQh97HmwZat+4RgHgnUHavZquvztC8Iknh2OW19fwgns3q9CUKBzT/u
         cww9MKy9VWquZIbuDfde2MRNsanh51ncRhnz08T3DvO654thFfvgk5KYY1NVRzbxTwUG
         DRKvbmRmZks76O2eSXDbLY/u9Z+Eh01c9mR5TdBOPOz3qccKa/5+Nz7DaMIGLXTYiErU
         MrugOJWs5EBdpt/xwMa9YQjo8+Uh/8OmnLUvsm9lirfk+urY04rCy3ttHy5beKyi96lj
         GKQapQOO8GyJCzSWIh03/CGgxbqn79k6qqtqLCd9f/SYjqKUDvwtWW1urImrT1g1m3Xz
         YYIQ==
X-Gm-Message-State: AOAM53247rgc+xwNHBTd+T+eLnM4XMIuSIT45tWrW4Kh3fPSBgLC9yqu
        EMfx3SaKtG06da0LcY/9MVR83NgLByKsjkqZ5/Wv4Q==
X-Google-Smtp-Source: ABdhPJxlz65dxxdhJi+0bzrMqazw6Z2XjAfoRpwGCGrYt8n2sZDkOaJudrNslPFQ5LOdTTP4s+ay5DTN0J7JteAm8e4=
X-Received: by 2002:a17:907:2076:: with SMTP id qp22mr5670ejb.358.1601606730218;
 Thu, 01 Oct 2020 19:45:30 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2020 22:45:29 -0400
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Date:   Thu, 1 Oct 2020 22:45:29 -0400
Message-ID: <CAG48ez3C8Zb+CZ=gSZkcL3w8DC5b9tNnR8vOf9XaKPF-fYEsjw@mail.gmail.com>
Subject: [PATCH] seccomp: Make duplicate listener detection non-racy
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

 kernel/seccomp.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 676d4af62103..c359ef4380ad 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1472,13 +1472,7 @@ static const struct file_operations
seccomp_notify_ops = {

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
@@ -1504,6 +1498,31 @@ static struct file *init_listener(struct
seccomp_filter *filter)
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
