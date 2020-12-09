Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D522D432F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbgLIN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbgLIN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:27:21 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2E8C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:26:41 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r7so1738272wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z02++LUTEnrLpupmJlXRm59FoXOwkMv2mFGcSre7ywI=;
        b=P1lqCmR2/spcwm4C9ok2iOuL/69g9tORHr23ikjzGQsyXlbnf3AaVa/Sj/4RLCWZqp
         71kdJ4Ms+ab7bL76muQWiKFW2W/tJLLUab9mpqGfAa+zvvAH4ppP9ATgNQcb4Jd3A6Gq
         PdFMusWQvb5QshCvPABOU099p1eFwjsB266qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z02++LUTEnrLpupmJlXRm59FoXOwkMv2mFGcSre7ywI=;
        b=UIXraTDNaQpRG8D9undo7IiM/xtTDvqNENsjaFNk10ZaZlvZVMFYrAee8lllXd7sdm
         iKr7n76Ma9q3eqp6hNthX+od+c8xpaQYz9G2w+sWfvC+leV4/jWx9xsUx8ixXjqoSjFW
         1kex739qnRVFL4oRgEzL7Ot7AzI3x95Dtflp3r6uTsuefhawQg9OlkiGc/trRz/Madso
         4NfdktkRqI0fkz+DgqGPpIYZParHLGXYLFlEwkPvYPCQmPY/zZ3uj4I3xOcdgLk9JGA7
         IesvQ5Xx2QbntsG/6kq0Ad7o0Rw8xc9s6nykqSwUnl+Qk99vvlL1d0ML0tWKizeIDTb+
         u4hg==
X-Gm-Message-State: AOAM533HUqrE4nZlcglgMmmX24Cpktk7CSNFAZTI6M94t24X7EM0juSV
        3kD/m0z4N2LUb8JgfFNG/kPPCQ==
X-Google-Smtp-Source: ABdhPJwEN6JBDtUPdJd1rTyYzYkS/XN6N7z7lb1aaiTRZMZEZH5Rs81haOpLSZzYymwg6wr2J6fqTQ==
X-Received: by 2002:adf:e64b:: with SMTP id b11mr2675606wrn.257.1607520399909;
        Wed, 09 Dec 2020 05:26:39 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id t16sm3631490wri.42.2020.12.09.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:26:39 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, kafai@fb.com, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 2/4] bpf: Expose bpf_get_socket_cookie to tracing programs
Date:   Wed,  9 Dec 2020 14:26:34 +0100
Message-Id: <20201209132636.1545761-2-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201209132636.1545761-1-revest@chromium.org>
References: <20201209132636.1545761-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This needs two new helpers, one that works in a sleepable context (using
sock_gen_cookie which disables/enables preemption) and one that does not
(for performance reasons). Both take a struct sock pointer and need to
check it for NULLness.

This helper could also be useful to other BPF program types such as LSM.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/trace/bpf_trace.c       |  2 ++
 net/core/filter.c              | 12 ++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 5 files changed, 29 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 07cb5d15e743..5a858e8c3f1a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1860,6 +1860,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 extern const struct bpf_func_proto bpf_sock_from_file_proto;
+extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ba59309f4d18..9ac66cf25959 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1667,6 +1667,13 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number.
  *
+ * u64 bpf_get_socket_cookie(void *sk)
+ * 	Description
+ * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
+ * 		*sk*, but gets socket from a BTF **struct sock**.
+ * 	Return
+ * 		A 8-byte long unique number.
+ *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 52ddd217d6a1..be5e96de306d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1760,6 +1760,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_delete_tracing_proto;
 	case BPF_FUNC_sock_from_file:
 		return &bpf_sock_from_file_proto;
+	case BPF_FUNC_get_socket_cookie:
+		return &bpf_get_socket_ptr_cookie_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type == BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 255aeee72402..13ad9a64f04f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4631,6 +4631,18 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_get_socket_ptr_cookie, struct sock *, sk)
+{
+	return sk ? sock_gen_cookie(sk) : 0;
+}
+
+const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto = {
+	.func		= bpf_get_socket_ptr_cookie,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+};
+
 BPF_CALL_1(bpf_get_socket_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
 {
 	return __sock_gen_cookie(ctx->sk);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ba59309f4d18..9ac66cf25959 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1667,6 +1667,13 @@ union bpf_attr {
  * 	Return
  * 		A 8-byte long unique number.
  *
+ * u64 bpf_get_socket_cookie(void *sk)
+ * 	Description
+ * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
+ * 		*sk*, but gets socket from a BTF **struct sock**.
+ * 	Return
+ * 		A 8-byte long unique number.
+ *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
-- 
2.29.2.576.ga3fc446d84-goog

