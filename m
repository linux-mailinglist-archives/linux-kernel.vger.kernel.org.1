Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08D72A947B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKFKiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgKFKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:58 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6EC0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:37:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so889957wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qy5TSUuaroL38no12A5j4plxvxXEpPu7Flx/OqFFfvQ=;
        b=bu6uznQHuEs3uROc2LgjA0rm4ZHPIu7eA6d/aWvr5yY8e0aBKNEUhnoutYRWRkJQ8S
         0+KMF9ovJ6N7UOVPvX22mNTIxHvkO0YYlK5RDh89J8rLoznVp8ExXsXveGnCc2+skJmI
         gDo0XmrYunmhvVu9b0u//jRshrsy2kRq60Les=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qy5TSUuaroL38no12A5j4plxvxXEpPu7Flx/OqFFfvQ=;
        b=pZnBNhLDFPEJe4emqs9WRYY52UurH3H1NTX8KuOHh2hUH9UYdh/JSyFcNnkaX/W3az
         dxqcoA0OSYMCNvleOrNTZrWoB8PFyv2DFVimjLIsfeahVoI0JxxtMnMbB9TA3NiXAfRH
         QgrZAsb2XjehNBubxFG+jUDxoIauFGouuUOtQ8KogXrjEHyHGjKNw7clktUPibUiPoVR
         yjd9Yw+SFdLaVA83WDu7dvOzdtZ5d5K+9SmSnfUbCxECDBH4AL+Nihhw3v5qL0dWVZQx
         mopoM5BbYJKTAM+5Nxs2uaeR2BGGPvwkwVhab/Vie/6NzVW54buO4cxBIYn6BZxfgHzg
         cwFQ==
X-Gm-Message-State: AOAM530Da4i3th/+6wT+4VCfYFSisF5zbQu26Q34uZZVO8OkKQ7SzDCF
        /s3QPrNo3ARCmgc5SFkEPXdTE9m35bq0ofb+
X-Google-Smtp-Source: ABdhPJxrPPDMCec6T2tUbtte5Lwp7FuxLX8TjmfAAARw8cc13RlBlL2/jB1i22j4LMcFbHfJMhVOZw==
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr1763316wmi.142.1604659076375;
        Fri, 06 Nov 2020 02:37:56 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:55 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 9/9] bpf: Exercise syscall operations for inode and sk storage
Date:   Fri,  6 Nov 2020 10:37:47 +0000
Message-Id: <20201106103747.2780972-10-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Use the check_syscall_operations added for task_local_storage to
exercise syscall operations for other local storage maps:

* Check the absence of an element for the given fd.
* Create a new element, retrieve and compare its value.
* Delete the element and check again for absence.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c         | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 4e7f6a4965f2..5fda45982be0 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -157,7 +157,7 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
 void test_test_local_storage(void)
 {
 	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
-	int err, serv_sk = -1, task_fd = -1;
+	int err, serv_sk = -1, task_fd = -1, rm_fd = -1;
 	struct local_storage *skel = NULL;
 
 	skel = local_storage__open_and_load();
@@ -181,6 +181,15 @@ void test_test_local_storage(void)
 	if (CHECK(err < 0, "copy_rm", "err %d errno %d\n", err, errno))
 		goto close_prog;
 
+	rm_fd = open(tmp_exec_path, O_RDONLY);
+	if (CHECK(rm_fd < 0, "open", "failed to open %s err:%d, errno:%d",
+		  tmp_exec_path, rm_fd, errno))
+		goto close_prog;
+
+	if (!check_syscall_operations(bpf_map__fd(skel->maps.inode_storage_map),
+				      rm_fd))
+		goto close_prog;
+
 	/* Sets skel->bss->monitored_pid to the pid of the forked child
 	 * forks a child process that executes tmp_exec_path and tries to
 	 * unlink its executable. This operation should be denied by the loaded
@@ -209,11 +218,15 @@ void test_test_local_storage(void)
 	CHECK(skel->data->sk_storage_result != 0, "sk_storage_result",
 	      "sk_local_storage not set\n");
 
-	close(serv_sk);
+	if (!check_syscall_operations(bpf_map__fd(skel->maps.sk_storage_map),
+				      serv_sk))
+		goto close_prog;
 
 close_prog_unlink:
 	unlink(tmp_exec_path);
 close_prog:
+	close(serv_sk);
+	close(rm_fd);
 	close(task_fd);
 	local_storage__destroy(skel);
 }
-- 
2.29.1.341.ge80a0c044ae-goog

