Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A051B2A9489
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgKFKiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgKFKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:56 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B72CC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:37:56 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so867046wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kutD/q+xVupSFcvYOVJRfZWueeRA7xbNvILSb9eee7Q=;
        b=eP6WYcKgDRMReVxWiLxS57C6vHFdFSJNYCaPFBomsUspTFPr06pJKDD70f9jnpCc1y
         oKkSS4Fy4DtjVHc1m8shQ5Cyroxz+vyMcnABSYIryR+MbQn+0g6rB3J9ndhs/MOsrHVm
         hqJaW7EbUxRpRt09cioSdYKamzkYpZM8dYNfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kutD/q+xVupSFcvYOVJRfZWueeRA7xbNvILSb9eee7Q=;
        b=PLYAY2JDiiUNM6+Jx192mmX3yC8FcFy3UadqUPFGeFRgi2kR5p/GH65XFD+2aBUZ95
         4BRPrf9wTB7NKMAYPoF1CShDm+YaVNW7LIjtpKDN525/O2XBTcwebehdSB/u5W2K2in9
         i+lnXxN1Iw4/T6TElqGDW+cG528+ob4ua/0oxXyMx5b7uoYO0ePfDBXa2+rPuoi0OjHz
         /PUJDVFrT1N18NJ7L3+FyZFCcEPMDQzqDb4F3ceI+34SpUJ0Y0kbhBFdErteeQg/EvLE
         CpNRtZglcVGNC/s3cYgH48IDYxeMHls4a+xsfHhbqePwker4F9Ak3wspB02nlW57paB1
         5zDg==
X-Gm-Message-State: AOAM533PbO923j0sxSJP/xxF761yd7qrSHPJm2tMDsQmPaSZombl8D0M
        PPUSVDZ59YldyWc0DT3DFGCPGhu2TSyGBQGs
X-Google-Smtp-Source: ABdhPJz6XMrRUe5EL699UsUN0RoHJOEiCeakPIruZiBWn0uiFcH3F32rcgR42pycAdF5CBAL7d/TyQ==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr1694252wme.18.1604659074690;
        Fri, 06 Nov 2020 02:37:54 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:54 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 7/9] bpf: Update selftests for local_storage to use vmlinux.h
Date:   Fri,  6 Nov 2020 10:37:45 +0000
Message-Id: <20201106103747.2780972-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

With the fixing of BTF pruning of embedded types being fixed, the test
can be simplified to use vmlinux.h

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../selftests/bpf/progs/local_storage.c       | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 09529e33be98..ef3822bc7542 100644
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
2.29.1.341.ge80a0c044ae-goog

