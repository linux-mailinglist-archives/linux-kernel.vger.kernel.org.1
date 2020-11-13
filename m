Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909092B1396
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKMA7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKMA7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:59:48 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7FC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:59:41 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so6815600wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpc+8RaEdy9qZiZdDQDUeaaADVDGgLUTfDOc8IUPCu4=;
        b=PKma7TRMmdiNVC9nQ3CYstKP6BtQL0TbUe9TzMWmWdtw5oP2N7Cm/kdclFsCzvyUIu
         Sx9SiVaxSdhTo36oodx51MWjGdtNJiWqbJjpn33sDPs6N4eeVOyTNkE5dLbjBH2dnvCq
         2S58wCBjBQwR7O4klWGvRy2nsAPFu0+xlqiXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpc+8RaEdy9qZiZdDQDUeaaADVDGgLUTfDOc8IUPCu4=;
        b=eBJwbO+71ZUdIAQdFErBs5bJjsPT6cByu544n/Xw9/b0g2VzwkI01STVOpAu5dP1VF
         fiBsVXrlHI5wDP/B8pe4exXNNuxmDuyQACJOIIBTK8kDphpt9ejIoIWzj3qOMBKcZd/w
         BDCiH62erJuxqxwiraDPYt4iEodbGOvvc543E99dPdVQahpgtubNnryA2Qk7fXeRJNnE
         6+Cy6XgPHXwQzxb4lE4E2p4U/Gf1FAWfZvHDZ3EJDs2fJWlpIVcohGcx4021tlcHj+0E
         4RXbsw3Y0oi1wNcY7Sa5Jj2AU8A8sTFscDgZVpFZgD9P4AzOJRVon1FidhLQmFbR3Kdm
         34gA==
X-Gm-Message-State: AOAM5326MSB6EjNqN7ttjJvIYvG1bvXWyjTDK+7mCYc25eWguzBuoLXd
        bFSs+9DfcPdzKYyTltsPfHa/6GSvk8jYqh8P
X-Google-Smtp-Source: ABdhPJwqRBtztictHPFaO1CqHOEPx3JAsYtBLem4ynSphW9/ITT1tfLOGIoBNi4uPq61r2hT1i1nhQ==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr538648wmg.18.1605229179819;
        Thu, 12 Nov 2020 16:59:39 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m3sm4508104wrv.6.2020.11.12.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:59:39 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 2/2] bpf: Expose bpf_d_path helper to sleepable LSM hooks
Date:   Fri, 13 Nov 2020 00:59:30 +0000
Message-Id: <20201113005930.541956-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201113005930.541956-1-kpsingh@chromium.org>
References: <20201113005930.541956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Sleepable hooks are never called from an NMI/interrupt context, so it is
safe to use the bpf_d_path helper in LSM programs attaching to these
hooks.

The helper is not restricted to sleepable programs and merely uses the
list of sleeable hooks as the initial subset of LSM hooks where it can
be used.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/trace/bpf_trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e4515b0f62a8..eab1af02c90d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_lsm.h>
 
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/btf.h>
@@ -1178,7 +1179,11 @@ BTF_SET_END(btf_allowlist_d_path)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 {
-	return btf_id_set_contains(&btf_allowlist_d_path, prog->aux->attach_btf_id);
+	if (prog->type == BPF_PROG_TYPE_LSM)
+		return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
+
+	return btf_id_set_contains(&btf_allowlist_d_path,
+				   prog->aux->attach_btf_id);
 }
 
 BTF_ID_LIST_SINGLE(bpf_d_path_btf_ids, struct, path)
-- 
2.29.2.299.gdc1121823c-goog

