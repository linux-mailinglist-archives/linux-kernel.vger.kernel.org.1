Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F72DAD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgLOMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbgLOMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:20:04 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD70C0611CD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:37 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id b194so1512831wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yo/EOAEPVNdynk8L6rBhSdFRvsKoTS6jdXVz2yMuFAk=;
        b=eFih63xH5IwSHHK/i6Ygk3nW8AJiZKDqI3iaQMhQulhhCeuIpwhw9jZ13KEQCg5LYg
         gWmW0TTitgc6Qqw46IqQUttNvX97WJ3sTMi737ZfoQAKquOVVupDK9I+Pcwp/RWuTRl9
         bQVIdSvh+KuJxUF8LSPsLvKQOLm7+KStMbgpbaBY2Sa3F0qMTBlBRt613YnwpzDV4T4Q
         0gtLVA80orrK2lDwvGi3pGbCsmDGKx0+/tPhyHdGB4vcyerybxVAh8QOozJbWNemretT
         ZTQFQjzaHUMCCN9S1IS9+xbSBq7UBdIIE1LpI3BqOwHLOXca7rteXEVZopoYJqSc1VyB
         U76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yo/EOAEPVNdynk8L6rBhSdFRvsKoTS6jdXVz2yMuFAk=;
        b=ZDHla6UKvt1iXjA59PqT8n0l8f+iAuOmx9mv6pyhhSNDWjmB/r4wca1RauuhQWCZf9
         x2zAGfDbofZCBg03sWEO7rZIrxkN/LgUCr5MFKiK/CZjfBRZCwDD4TXekA6y6b+ciqOY
         OPeGUdX16rKSSTLpxHWPrja14TWpkd085F8HvHAaUcTacR8m53d/0i+pLviCAhj9WIQa
         iu/xNeksfP8EMFDDdKuB1mb6jPdUHqaeiNLs/SfeFuafWFSGuI+qFPvUsVSABTE/cJjV
         Z9GnoQ8Z2RehlmsK0Dw5GaTzLxV0tKuKM9JUSx9xQjbvtkRj3hz10Mk0IUF20nfRNB3U
         mDTQ==
X-Gm-Message-State: AOAM531vAmMU2reazyp8FlbxErNgI0BIVOikYSHxur7iUKEU07PzUAr4
        mhqh9cdIFt6RHB2qsmCgOr/MnPoSOJAREw==
X-Google-Smtp-Source: ABdhPJzfk3eEDbfSITgyhjnyHpWBB8HtiPw5KrqJSTRo2LULK9UuEQs6jzq3tVH0APZvJHWpmhqNSagZRHWk2w==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a5d:4101:: with SMTP id
 l1mr34493968wrp.196.1608034716075; Tue, 15 Dec 2020 04:18:36 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:18:10 +0000
In-Reply-To: <20201215121816.1048557-1-jackmanb@google.com>
Message-Id: <20201215121816.1048557-7-jackmanb@google.com>
Mime-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH bpf-next v5 05/11] bpf: Move BPF_STX reserved field check into
 BPF_STX verifier code
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't find a reason why this code is in resolve_pseudo_ldimm64;
since I'll be modifying it in a subsequent commit, tidy it up.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d562268c1fd1..48e398667a69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9528,6 +9528,12 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
+			if (((BPF_MODE(insn->code) != BPF_MEM &&
+			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -9940,13 +9946,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (BPF_CLASS(insn->code) == BPF_STX &&
-		    ((BPF_MODE(insn->code) != BPF_MEM &&
-		      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-			verbose(env, "BPF_STX uses reserved fields\n");
-			return -EINVAL;
-		}
-
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
 			struct bpf_map *map;
-- 
2.29.2.684.gfbc64c5ab5-goog

