Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04D92A8A59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgKEXC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbgKEXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:02:26 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D1DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 15:02:26 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id n18so3618104wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 15:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BThCLkbWSP8aJh+QloWCyiHqWNi8rcJYJsA63ecoKNM=;
        b=AKqdjAMtrmeCpFMBHY5yoY3TTFEnytJ5mUaKT43wUZePGfH2K84Nsm4bOCkcG+Vx6x
         M4hd/tgL8wZ6tGiV9gPJStg5bsuUcjuGPyWcsBvwZoP6wCcD+OpGnPm98ds+6LKa1lxJ
         nRdlqT/uV4/mGWpzf4eVDURzJ4av5B3u2KwW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BThCLkbWSP8aJh+QloWCyiHqWNi8rcJYJsA63ecoKNM=;
        b=dXrhatSDovzRDkiGwWNg3RFhSoGyYJnJF7XEJYcziKp//k6qXp25AGVKLeLrCVIS4Q
         8u74ZQ2I85927yi6SL33KG7+bCYSYmWJZkw9/xIiEUui9+H1VMgF8Xa6oN2WsL7CQXmj
         fXKap37vm+1tanHdKqoLTPQmvxdAplej8fZikCs9m8n9S9aRtTJBM5QImSenmQaCBCle
         kXuW9TRHviWPsRdshcPWlw4/w0BeIutdmlXqc6pzhcw3oZYkr0KlrwKkaDBs5ayg5IFw
         2cXkUBrz7z0ihYYmCB9QoDfFX0CIMXeFiJ4W1R79LJQvlf0BASPO/Lwp8XbGLyGJiI8Q
         9X7g==
X-Gm-Message-State: AOAM530X7nIsANgxrSySC016I4r72Pn0z9PVg4j5LRaKCjTyut1gJZFp
        gT8dM9fgtm3Q0QnY83IrMYE/fVKHiwAc1ASS
X-Google-Smtp-Source: ABdhPJyqYj9D3x0Dk83Gc3eqA5/JyNigwmYUqYc7yfEsw8QHxc9St/D0eMgqEClRZEB2pMjK9iji1Q==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr5804091wrn.73.1604617344605;
        Thu, 05 Nov 2020 15:02:24 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id v14sm4968686wrq.46.2020.11.05.15.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 15:02:24 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: Update verification logic for LSM programs
Date:   Thu,  5 Nov 2020 23:02:21 +0000
Message-Id: <20201105230221.2620663-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The current logic checks if the name of the BTF type passed in
attach_btf_id starts with "bpf_lsm_", this is not sufficient as it also
allows attachment to non-LSM hooks like the very function that performs
this check, i.e. bpf_lsm_verify_prog.

In order to ensure that this verification logic allows attachment to
only LSM hooks, the LSM_HOOK definitions in lsm_hook_defs.h are used to
generate a BTD id set. The attach_btf_id of the program being attached
is then checked for presence in this set.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/bpf/bpf_lsm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 78ea8a7bd27f..56cc5a915f67 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
+#include <linux/btf_ids.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -26,7 +27,11 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
-#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
+BTF_SET_START(bpf_lsm_hooks)
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+BTF_SET_END(bpf_lsm_hooks)
 
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog)
@@ -37,8 +42,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 		return -EINVAL;
 	}
 
-	if (strncmp(BPF_LSM_SYM_PREFX, prog->aux->attach_func_name,
-		    sizeof(BPF_LSM_SYM_PREFX) - 1)) {
+	if (!btf_id_set_contains(&bpf_lsm_hooks, prog->aux->attach_btf_id)) {
 		bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
 			prog->aux->attach_btf_id, prog->aux->attach_func_name);
 		return -EINVAL;
-- 
2.29.1.341.ge80a0c044ae-goog

