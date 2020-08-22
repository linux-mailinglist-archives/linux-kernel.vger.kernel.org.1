Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470EA24E486
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 03:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHVBkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 21:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHVBk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 21:40:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5ADC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:40:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g127so4011488ybf.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tKITLEyWnWCi9IJ4HMcscwuSv2AmZTmql/ok3Wo7ZvQ=;
        b=ucn8M6gYfR4WBFzw8eeNOL6MRtLncDDzaiGDLI6u21NlKZXLjmVIM6kCYQFIxVdxSJ
         zdsSL8sRuhAY02v8EPbLClsbB0hu7jJeZNfVgz2NwSv1KCveVJooy4+EBftCUaaGKJJw
         cc0qLfj32PQHBoSrbsvLv6ke8gSbrx/SedtQAYLjKRti5v3LdgVFIdmSGSWVviicG1/D
         OB7LLKlB6f+VXc1/QEm2z+HDWzzNrpQga3HUi3OjTldhS5rFl6ZI9PXBVWmJ2feZKBiW
         0FqU6fHiUHVDFPOeLhfxiOUK4oGWMNOO6Z8a7ewewzlpFXDGeRIjH056qHfnde08RZKq
         WNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tKITLEyWnWCi9IJ4HMcscwuSv2AmZTmql/ok3Wo7ZvQ=;
        b=e5WuCObCpZnJHzPpPQAFbKTpqT1RGZYBGbBbgNMgl8+mBNl0dk9HezQofTGT3OkVrK
         zbIDHG4bkhzMKoRcB99krpirPXSs9CLTJMrKIcFN35rlB6EvPPtzmuiTtnElXQTG2URG
         gKP0xxop7lfc5NfxfXTJNvugLmFHw0kF3i9QSn0VIJFHqiZEe/3ZM8yuVeKCGV0BaRoP
         Una5RtVqxwygWFFVdalKEkrnnpT196eViGw4pF/OcVAA58QHlpzSgYu9bL2RFxcLq1EX
         VA6Kqui46gY8qMFFIO92Kb3SfgHUvvKyFK9mnXnvgLdv0eaed7mol2qq5Rkhty1JzWjH
         HI+A==
X-Gm-Message-State: AOAM531ZNDPUhGv1yIKTe2OCmUSSjzlRbyOfkpA8bMxurMB1bk91Jtky
        IRtXENPD+ihWNxYvS2vSYSJrUoEmxw3N4YIStw==
X-Google-Smtp-Source: ABdhPJyDjyQrzQvudTYj4/X7uhGm0k2D6vJ9FL3QpJpxNbUXIBUfhsFQ4o0as7SBR1h8V3D/ko8jO98VYXcUtxCLwQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:c582:: with SMTP id
 v124mr7843055ybe.456.1598060426970; Fri, 21 Aug 2020 18:40:26 -0700 (PDT)
Date:   Fri, 21 Aug 2020 18:40:17 -0700
In-Reply-To: <20200822014018.913868-1-lokeshgidra@google.com>
Message-Id: <20200822014018.913868-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200822014018.913868-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2 1/2] Add UFFD_USER_MODE_ONLY
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

userfaultfd handles page faults from both user and kernel code.
Add a new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes
the resulting userfaultfd object refuse to handle faults from kernel
mode, treating these faults as if SIGBUS were always raised, causing
the kernel code to fail with EFAULT.

A future patch adds a knob allowing administrators to give some
processes the ability to create userfaultfd file objects only if they
pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
will exploit userfaultfd's ability to delay kernel page faults to open
timing windows for future exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c                 | 7 ++++++-
 include/uapi/linux/userfaultfd.h | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0e4a3837da52..3e4ae6145112 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -405,6 +405,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
+	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
+	    ctx->flags & UFFD_USER_MODE_ONLY)
+		goto out;
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -1966,6 +1969,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	static const int uffd_flags = UFFD_USER_MODE_ONLY;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1975,10 +1979,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
+	BUILD_BUG_ON(uffd_flags & UFFD_SHARED_FCNTL_FLAGS);
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
-	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
+	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
 		return -EINVAL;
 
 	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index e7e98bde221f..5f2d88212f7c 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -257,4 +257,13 @@ struct uffdio_writeprotect {
 	__u64 mode;
 };
 
+/*
+ * Flags for the userfaultfd(2) system call itself.
+ */
+
+/*
+ * Create a userfaultfd that can handle page faults only in user mode.
+ */
+#define UFFD_USER_MODE_ONLY 1
+
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.28.0.297.g1956fa8f8d-goog

