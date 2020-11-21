Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BB92BBB49
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgKUAvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbgKUAvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:51:00 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B9BC061A4B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:50:59 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so12732449wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNfZ0xa6JKwNNxWqj03/KjB0EjaVfS36YlA9F8Reu1w=;
        b=j4P5Gesa95dGfyRNG4KWRAmUesbt1qCEz9MZcVyRRZef5a9//bkVESKcmemK1Qa5Mf
         2EY2QipBVW6g9Ez/hC9CGBFw2H2k2caM6kxJ+wYI4lk8K1y7bvToESGzEOApAKO2P7Lz
         Ncgxb38t4RITuRIkWHXNj+ySXUuvDplVn5niI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNfZ0xa6JKwNNxWqj03/KjB0EjaVfS36YlA9F8Reu1w=;
        b=SuWgy98+Hzhg3O89SGSwwAQPFN15LY1KjrpZDyrj8b6Utdyck/eDsywhLX4wmNtSDP
         Le+W6AriPQm2tcg3rSjBRSho/r/jrF7nT0kUgQmZM+zKjEdRKWmJo+mD0ubiETPLkHZD
         zw2+AUvY8Ey6Wh65JExTJi29dLquuLdK2Ex9/r4cpRGU+jFrQzyRwdbAloKsBagj+S11
         qcbZw1I9fDm+aES0Qwi7QmruY3nPVjFpy+nUzRpwspAE1IaOXaKapn9ESmBHOabPiptd
         bkTZoLMNV86VIOfJGm8VGu6GCHiQKlsjjgInHGbs19CznjxSYL5CoFI19bqWexj7Lh5y
         JPdw==
X-Gm-Message-State: AOAM530MjYrtiQPW2z/y89GFWhVDEjc8Ubes/GsP/0HlssEHvjSplwbK
        o4NWH5s7OrjgOb4ms8GSnjB26P778CfO7L9T
X-Google-Smtp-Source: ABdhPJwE901Pq8K1Dg2K7dhF6+5tXg1xc7YKa4Hla328PUHTL3fxH0K1hjO6sPaGQs9wHxvOjssF5Q==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr12139150wmc.126.1605919858004;
        Fri, 20 Nov 2020 16:50:58 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id s8sm7133607wrn.33.2020.11.20.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:50:57 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
Date:   Sat, 21 Nov 2020 00:50:54 +0000
Message-Id: <20201121005054.3467947-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201121005054.3467947-1-kpsingh@chromium.org>
References: <20201121005054.3467947-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

- Update the IMA policy before executing the test binary (this is not an
  override of the policy, just an append that ensures that hashes are
  calculated on executions).

- Call the bpf_ima_inode_hash in the bprm_committed_creds hook and check
  if the call succeeded and a hash was calculated.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/config            |  3 ++
 .../selftests/bpf/prog_tests/test_lsm.c       | 32 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |  7 +++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2118e23ac07a..4b5764031368 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -39,3 +39,6 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_LSM=y
 CONFIG_SECURITY=y
 CONFIG_LIRC=y
+CONFIG_IMA=y
+CONFIG_IMA_WRITE_POLICY=y
+CONFIG_IMA_READ_POLICY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 6ab29226c99b..bcb050a296a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -52,6 +52,28 @@ int exec_cmd(int *monitored_pid)
 	return -EINVAL;
 }
 
+#define IMA_POLICY "measure func=BPRM_CHECK"
+
+/* This does not override the policy, IMA policy updates are
+ * append only, so this just ensures that "measure func=BPRM_CHECK"
+ * is in the policy. IMA does not allow us to remove this line once
+ * it is added.
+ */
+static int update_ima_policy(void)
+{
+	int fd, ret = 0;
+
+	fd = open("/sys/kernel/security/ima/policy", O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (write(fd, IMA_POLICY, sizeof(IMA_POLICY)) == -1)
+		ret = -errno;
+
+	close(fd);
+	return ret;
+}
+
 void test_test_lsm(void)
 {
 	struct lsm *skel = NULL;
@@ -66,6 +88,10 @@ void test_test_lsm(void)
 	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
 		goto close_prog;
 
+	err = update_ima_policy();
+	if (CHECK(err, "update_ima_policy", "err %d\n", err))
+		goto close_prog;
+
 	err = exec_cmd(&skel->bss->monitored_pid);
 	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
 		goto close_prog;
@@ -83,6 +109,12 @@ void test_test_lsm(void)
 	CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
 	      "mprotect_count = %d\n", skel->bss->mprotect_count);
 
+	CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
+	      "ima_hash_ret = %ld\n", skel->data->ima_hash_ret);
+
+	CHECK(skel->bss->ima_hash == 0, "ima_hash",
+	      "ima_hash = %lu\n", skel->bss->ima_hash);
+
 	syscall(__NR_setdomainname, &buf, -2L);
 	syscall(__NR_setdomainname, 0, -3L);
 	syscall(__NR_setdomainname, ~0L, -4L);
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index ff4d343b94b5..5adc193e414d 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -35,6 +35,8 @@ char _license[] SEC("license") = "GPL";
 int monitored_pid = 0;
 int mprotect_count = 0;
 int bprm_count = 0;
+long ima_hash_ret = -1;
+u64 ima_hash = 0;
 
 SEC("lsm/file_mprotect")
 int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
@@ -65,8 +67,11 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 	__u32 key = 0;
 	__u64 *value;
 
-	if (monitored_pid == pid)
+	if (monitored_pid == pid) {
 		bprm_count++;
+		ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
+						  &ima_hash, sizeof(ima_hash));
+	}
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
-- 
2.29.2.454.gaff20da3a2-goog

