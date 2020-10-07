Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311DC2856A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 04:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgJGC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 22:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJGC3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 22:29:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC2C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 19:29:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k3so979186ybk.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 19:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JsnyKWrbECrfBzXkqNc7AuN/S85GdnYe4agNLqwli20=;
        b=UxRcy5CAZ82sxkQRn6UmD30seYN1cnIRmTD+GibYAjnx3BSnWBWRZnltZy0EfS3aQN
         CxgB3iK33Z9SiHflnTbpwnsDx2t1tnSfm+pgxenQ4D4sztbbSppVHQx57c0pXs3MdT7w
         jUhKG7jsEkv+iIkdJU4RPKbD75wqy8viGDdkDcrTF4+d1RWDG3LwcB7cG/qRrs8kFN6Z
         k3QIcRJOtWyAEX54ZnwF2/6epGb3SFPaiZ+UCMNkLY933pBgeBK+4tcfp9rsg/pi/aRi
         ZeHKvtjxnGxa7CZBzllQDFws6DXPE6DQm4ge219mEUBX8IfduPMx1EJPCulMGH6p1WEk
         Ehhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JsnyKWrbECrfBzXkqNc7AuN/S85GdnYe4agNLqwli20=;
        b=gXJdjFT/XLi7ZTWJl8ry4+rHxQrPawaCwGhkQxmYiqsLaKACnFPtavIe9oV2q/O5tf
         blArYpllJ0y8Icld55FdJ27POlzuY4QYBpy5ecuyOsbYQeyisJIDyAO0bQi/vsCORPRB
         GfJ25YnEbJZLCROJJs6LIZaOETlp4WwLo44DCJ9MOOChtavn+WDEVxFCyfeAKITlv/rV
         uPLYshuGqGxHS/lANjMB771VgQaI1Xya4qmRMmw0ycp67+BlqDQQS9ZkiFkwQt2EOL5B
         BfMtCS/+Zbvt18ACd1OUIDwHneWkFM+U3PEcHzjPK55CNwiEzSUZMDeI2wdh07k/lJH9
         G5dQ==
X-Gm-Message-State: AOAM530VyRV6l5jXEH88xov+DzC+1K0RyfsEvY+BD77uk67d/+jGsMld
        7EkYEv9Sh+YWtp9K6LBLugyAOB786mQ=
X-Google-Smtp-Source: ABdhPJxtAXVnX5DVi19z61yuLvPzy8HDauToLRlzql2Attti0KIu+POudPPRkMApD1XiYo/CKFZXn4oGy90=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a25:241:: with SMTP id 62mr1451366ybc.244.1602037740608;
 Tue, 06 Oct 2020 19:29:00 -0700 (PDT)
Date:   Tue,  6 Oct 2020 19:28:57 -0700
Message-Id: <20201007022857.2791884-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v3] selftests/bpf: Fix test_verifier after introducing resolve_pseudo_ldimm64
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4976b718c355 ("bpf: Introduce pseudo_btf_id") switched
the order of check_subprogs() and resolve_pseudo_ldimm() in
the verifier. Now an empty prog expects to see the error "last
insn is not an the prog of a single invalid ldimm exit or jmp"
instead, because the check for subprogs comes first. It's now
pointless to validate that half of ldimm64 won't be the last
instruction.

Tested:
 # ./test_verifier
 Summary: 1129 PASSED, 537 SKIPPED, 0 FAILED
 and the full set of bpf selftests.

Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
Signed-off-by: Hao Luo <haoluo@google.com>
---
Changelog in v3:
 - Remove without renaming the rest

Changelog in v2:
 - Remove the test instead of modifying the err msg.

 tools/testing/selftests/bpf/verifier/basic.c    | 2 +-
 tools/testing/selftests/bpf/verifier/ld_imm64.c | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/basic.c b/tools/testing/selftests/bpf/verifier/basic.c
index b8d18642653a..de84f0d57082 100644
--- a/tools/testing/selftests/bpf/verifier/basic.c
+++ b/tools/testing/selftests/bpf/verifier/basic.c
@@ -2,7 +2,7 @@
 	"empty prog",
 	.insns = {
 	},
-	.errstr = "unknown opcode 00",
+	.errstr = "last insn is not an exit or jmp",
 	.result = REJECT,
 },
 {
diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index 3856dba733e9..f9297900cea6 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -50,14 +50,6 @@
 	.errstr = "invalid bpf_ld_imm64 insn",
 	.result = REJECT,
 },
-{
-	"test5 ld_imm64",
-	.insns = {
-	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
-	},
-	.errstr = "invalid bpf_ld_imm64 insn",
-	.result = REJECT,
-},
 {
 	"test6 ld_imm64",
 	.insns = {
-- 
2.28.0.806.g8561365e88-goog

