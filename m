Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1129BF98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815616AbgJ0RDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:03:31 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44172 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815598AbgJ0RD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:03:28 -0400
Received: by mail-ej1-f65.google.com with SMTP id d6so3236027ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzzUDsidrUC7RWDOol9n2PVflwyj7TpsFpUs6H5wqJA=;
        b=arItqxgk/9qAZij7+w4t2K4qnzeonxHSGtMsdEcN1VWM0eGu//+/5vezf7J97mobGz
         QDpjF+dXBZ/heCAzn4xOmjhbPgZATE0zoDG4W2nd7ZH33TSBgC7vp6JqQ9webblx60Nu
         17pLacCP6vh253pUL46jRoCXH+k6hhbR9C53E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzzUDsidrUC7RWDOol9n2PVflwyj7TpsFpUs6H5wqJA=;
        b=BGnstnrW9b6sNOqDrt3Da/z+SItGE+5FBu42wfH61YtLAXNeE7mOW3n9M5vxAl9KRn
         4sBviHJgyepx1B4wvdn2cJW69HeBMAZHrBeOb9Pn0yMgDymFkm4VsQFiCtcQfJ4uBOem
         TOcTP5N3cJyvTZlvJ5rUrMSZl4DyM+mGFkRgo7KadszmNcRGslnmIeDyiL0OCbotnSUZ
         /Egp5W3a6r2hVmWPPulxOO31TakQSIjU7wBx5gkQ5H23Tdr1cYqgRA/QeyOKMb1/gjv1
         c58WysaOkl+RYYvsaGla8CVyKtyfoKICBOgAcvf0nOMsoGK+xKqM0vkeLh4RvAwoeZMk
         YC6w==
X-Gm-Message-State: AOAM533KYp/47jJrKwgmBBoTyPJvotHIPNkKolQ8uZZB8gqsnqxIAKHO
        0mHhg+tyOGzCdbsq92qiiwZkbcZhyquyrIjq
X-Google-Smtp-Source: ABdhPJzsrVgb1Oxm1IFy4IfZF2gSTGB4bJE60+0bDIScSo64rTssL7rGffuf23uUypG88/PcsvTvZg==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr3203290ejz.97.1603818205481;
        Tue, 27 Oct 2020 10:03:25 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id ba6sm1315006edb.61.2020.10.27.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:03:24 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 4/5] bpf: Update selftests for local_storage to use vmlinux.h
Date:   Tue, 27 Oct 2020 18:03:16 +0100
Message-Id: <20201027170317.2011119-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
In-Reply-To: <20201027170317.2011119-1-kpsingh@chromium.org>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

With the fixing of BTF pruning of embedded types being fixed, the test
can be simplified to use vmlinux.h

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../selftests/bpf/progs/local_storage.c       | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index a3d034eb768e..5acf9203a69a 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -4,9 +4,8 @@
  * Copyright 2020 Google LLC.
  */
 
+#include "vmlinux.h"
 #include <errno.h>
-#include <linux/bpf.h>
-#include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -36,23 +35,6 @@ struct {
 	__type(value, struct dummy_storage);
 } sk_storage_map SEC(".maps");
 
-/* TODO Use vmlinux.h once BTF pruning for embedded types is fixed.
- */
-struct sock {} __attribute__((preserve_access_index));
-struct sockaddr {} __attribute__((preserve_access_index));
-struct socket {
-	struct sock *sk;
-} __attribute__((preserve_access_index));
-
-struct inode {} __attribute__((preserve_access_index));
-struct dentry {
-	struct inode *d_inode;
-} __attribute__((preserve_access_index));
-struct file {
-	struct inode *f_inode;
-} __attribute__((preserve_access_index));
-
-
 SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
-- 
2.29.0.rc2.309.g374f81d7ae-goog

