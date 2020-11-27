Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA72C6B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbgK0R56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgK0R55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:57:57 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB7C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:57:55 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id a22so3169929wmj.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EiPiPUafMgOaehLSLTGCVFZQBAOetMfRBds+Fc1vJSU=;
        b=akOQ2ZMN9W6euIG+IX9HlmE81+hrKhPw5OCfnLqK8PqcBSdfEcIpZ2/w26yPMURt/f
         kHYXpDQ4Emx4vBD2UOdj56/tyhuo8ib5Ic8TejR8yEu5Fej6yP8kKUo9rCe7pwJ5e2lr
         3/T976Jru34VCKkV9ncI66Z18jKrp3SWv5F/UtLCsCscH+ublDACEOClqwiFCqblEUlJ
         J/vD/zE94YloeZrYp/ovr0dL5jXyfmgtgNILR7rU0DHO/p0kE2yYxRGyAqsJ4LhX4xvB
         f5HibXuUlctdvesV1sf4ya6juEFTKnjKr2iaxR+mxRzDdLfCMJv6P31InidCMJTE0uwl
         ffZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EiPiPUafMgOaehLSLTGCVFZQBAOetMfRBds+Fc1vJSU=;
        b=HHYDlIi0LeLzRVOVZXVujD+9ShzVpy5QIEApJO0/OprbeGvP5sOuIxKsiQynGTqZnI
         uddMRIayit1WvNvZ6WkEvp8ybv5Euz63DqFzOacG5u/xgWX7UFrLZvU+0YTFIC19AQSs
         bVlzwK/rmvWLaVKUGp82V4kAQyfX6NrKNfnDE0sQd77UB8nhGiHWke6SOCHenbcEf8XZ
         iBvvbJtt7BH9DsOT7mQO9jd2EKBZ0/FwbSFj9M2k7gxJKYIFSYolPj9/AVURQ+9iTPbJ
         5iNauhp9oce+zwVTLRnaousQ0gZ8pj5AYkHlhgHxZfjVfDsBnSnBTEBWz0BbdtV7DxE2
         Ybmw==
X-Gm-Message-State: AOAM533Z3gxD9SVT0mp9Az9MR8mAn2msZ/rU1kBUFXPiocFKR1gqNFpF
        fNaCGL6kYhNwG285+0S88fLWhGVqCMx0Iw==
X-Google-Smtp-Source: ABdhPJybWNL8ifikgSrknPlXXQMhlVShu89S3WwBiSTCfyaxbGqNhJHCJwDo+3vOuydrljUSzKJ6LJ/OLzPscA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:e7d0:: with SMTP id
 e16mr12210610wrn.114.1606499874225; Fri, 27 Nov 2020 09:57:54 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:28 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-4-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 03/13] bpf: x86: Factor out function to emit NEG
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's currently only one usage of this but implementation of
atomic_sub add another.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a839c1a54276..49dea0c1a130 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -783,6 +783,22 @@ static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 	*pprog = prog;
 }
 
+
+static void emit_neg(u8 **pprog, u32 reg, bool is64)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	/* Emit REX byte if necessary */
+	if (is64)
+		EMIT1(add_1mod(0x48, reg));
+	else if (is_ereg(reg))
+		EMIT1(add_1mod(0x40, reg));
+
+	EMIT2(0xF7, add_1reg(0xD8, reg)); /* x86 NEG */
+	*pprog = prog;
+}
+
 static bool ex_handler_bpf(const struct exception_table_entry *x,
 			   struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr)
@@ -884,11 +900,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			/* neg dst */
 		case BPF_ALU | BPF_NEG:
 		case BPF_ALU64 | BPF_NEG:
-			if (BPF_CLASS(insn->code) == BPF_ALU64)
-				EMIT1(add_1mod(0x48, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_1mod(0x40, dst_reg));
-			EMIT2(0xF7, add_1reg(0xD8, dst_reg));
+			emit_neg(&prog, dst_reg,
+				 BPF_CLASS(insn->code) == BPF_ALU64);
 			break;
 
 		case BPF_ALU | BPF_ADD | BPF_K:
-- 
2.29.2.454.gaff20da3a2-goog

