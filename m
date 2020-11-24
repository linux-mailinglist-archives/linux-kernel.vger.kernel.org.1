Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698C42C2AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389550AbgKXPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389481AbgKXPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:12:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68826C061A4F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:12:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so4380580wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHReVnK5DGw5eK9squ1uNmgtFICRFlU41vCb7hFlmTM=;
        b=c2oZekMKp7GTW7xfXhH0T5dmVgBeJKD4aw9oCeOlcCjEvejVkNvkVGHH8p6ZppFcTD
         L2aWKw5btqyH+mN2rxqEBgcGlSwPoGKkqrShNj/VywZKGHPgYb/V4fNYGTDVR9lIIip+
         I5cxWR/qZeM8er2E/mtFvNwkprGsWBi14/cYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHReVnK5DGw5eK9squ1uNmgtFICRFlU41vCb7hFlmTM=;
        b=qUsegY64MxSvWsu0gKA8k40yW8fkSYYy7ifss/8L6d3rVNlZRtMC52oaOcedlwucaj
         l+IgVmy6SBrpJODfRdPX/3h7wcIj1M9pV4cHWZifVPWiWrPIbaBEsMjZ98J75bKVlEXm
         FBmj1VY1lppAfGIAueM5y3I/pF8kZ0vnUNPzYri2NlvA4qyAjqt2fk+3z/qWx9JIRSru
         ZiQTVFz12Lx6gpf9RY2edW3DDwwvuFpfhGjZG74D+qLHi3Er9CF2c8fEPfSlvm2H8CFk
         sx3tWlJ0XBvrXt+aspHoZ9l6tbO67EXd6pi//KNHyPhaVbdQlNdo6VwWVTqpfzIK++qp
         MrYQ==
X-Gm-Message-State: AOAM533YXtS67eSNZh3DOtyqk33Lx3fljHHQTJVDlYYPpoTAyZ7kCx8o
        3g+lSt2QGTDS9UdouYhQHAuEmw==
X-Google-Smtp-Source: ABdhPJwcLnDXSz4KvH8DEi6Yxc5ekgJgMuTggVda4M+OLl6NikSdxRlMY/lgA2LrZxWWUCiHRrSliw==
X-Received: by 2002:adf:dd04:: with SMTP id a4mr5965770wrm.77.1606230734066;
        Tue, 24 Nov 2020 07:12:14 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id g131sm6353127wma.35.2020.11.24.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:12:13 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next v3 2/3] bpf: Add a BPF helper for getting the IMA hash of an inode
Date:   Tue, 24 Nov 2020 15:12:09 +0000
Message-Id: <20201124151210.1081188-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201124151210.1081188-1-kpsingh@chromium.org>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Provide a wrapper function to get the IMA hash of an inode. This helper
is useful in fingerprinting files (e.g executables on execution) and
using these fingerprints in detections like an executable unlinking
itself.

Since the ima_inode_hash can sleep, it's only allowed for sleepable
LSM hooks.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/uapi/linux/bpf.h       | 11 +++++++++++
 kernel/bpf/bpf_lsm.c           | 26 ++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3ca6146f001a..c3458ec1f30a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3807,6 +3807,16 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
  * 	Return
  * 		Current *ktime*.
+ *
+ * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
+ *	Description
+ *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		If the hash is larger than *size*, then only *size*
+ *		bytes will be copied to *dst*
+ *	Return
+ *		The **hash_algo** is returned on success,
+ *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
+ *		invalid arguments are passed.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3970,6 +3980,7 @@ union bpf_attr {
 	FN(get_current_task_btf),	\
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
+	FN(ima_inode_hash),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index b4f27a874092..70e5e0b6d69d 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -15,6 +15,7 @@
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
+#include <linux/ima.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -75,6 +76,29 @@ const static struct bpf_func_proto bpf_bprm_opts_set_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_3(bpf_ima_inode_hash, struct inode *, inode, void *, dst, u32, size)
+{
+	return ima_inode_hash(inode, dst, size);
+}
+
+static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
+{
+	return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
+}
+
+BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct, inode)
+
+const static struct bpf_func_proto bpf_ima_inode_hash_proto = {
+	.func		= bpf_ima_inode_hash,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_ima_inode_hash_btf_ids[0],
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+	.allowed	= bpf_ima_inode_hash_allowed,
+};
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -97,6 +121,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_bprm_opts_set:
 		return &bpf_bprm_opts_set_proto;
+	case BPF_FUNC_ima_inode_hash:
+		return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index c5bc947a70ad..8b829748d488 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -436,6 +436,7 @@ class PrinterHelpers(Printer):
             'struct xdp_md',
             'struct path',
             'struct btf_ptr',
+            'struct inode',
     ]
     known_types = {
             '...',
@@ -480,6 +481,7 @@ class PrinterHelpers(Printer):
             'struct task_struct',
             'struct path',
             'struct btf_ptr',
+            'struct inode',
     }
     mapped_types = {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3ca6146f001a..c3458ec1f30a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3807,6 +3807,16 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
  * 	Return
  * 		Current *ktime*.
+ *
+ * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
+ *	Description
+ *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		If the hash is larger than *size*, then only *size*
+ *		bytes will be copied to *dst*
+ *	Return
+ *		The **hash_algo** is returned on success,
+ *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
+ *		invalid arguments are passed.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3970,6 +3980,7 @@ union bpf_attr {
 	FN(get_current_task_btf),	\
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
+	FN(ima_inode_hash),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.29.2.454.gaff20da3a2-goog

