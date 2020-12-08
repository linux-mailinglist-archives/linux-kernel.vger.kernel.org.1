Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F572D2D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgLHO0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgLHO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:26:20 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6FC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:25:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m5so6791724wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8/kp02WsOtyuCy6HonxO8TbrW5eGuVLEWwGykCnj2I=;
        b=cYNQMxDujCmqPGMeSjB/5132Iwcyi91EYgI1F304AcQrUlHZKwrKFnxd5VYUmZe9K3
         qhfD9zstwz62Vgp0K320RLF7hLuvtr9nZDivEzCcR75CoOEA4hb3GFmeyES77O7KnMTF
         pAFnnE6967VFpJ/Fer47PSFKjnPHQQfe7mnE8sjmlVKr9apoDHds84eU2Nsa/WKlIBbn
         e+PddT+iFaoD3sljklf4jA3CdeJ4OWlAk0Nm10aXIftrVEcv1s96VvtC/zC6jeWwHJuO
         iIaowJGppOUfMxWaOtqumlHOPIktlTx+cXWMLrE/XMiCypkUNwIa2Z7JbNAXPdtn61gw
         lM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8/kp02WsOtyuCy6HonxO8TbrW5eGuVLEWwGykCnj2I=;
        b=WWjKYPDQNcqkBI0BLJwV5VoWmb+uKqtby8arGZPv/p7mQKBwwVFVYmLd0vN3CxThQH
         IrDfd55GAoDpIm9y2ZiSzb56dEz3yIi6ZV/QMDKfqW/JXXbI5tAszbbutVoLIsc8GWhN
         VBPXAf/7aHY5vjxdvjHaShoSvAXhN927QXkGj7jHo1VMU+f+EfCcUYstBr2nZTiNBQdZ
         suWB21WBe9FwmkbwY2op3XPwicjQHboSM48veGVmMN24s4eiHdVOTz9IJHgjKZSZaoIy
         Ya6yJlsz6N6t1hCbW2kQTyeAYUiwanmEt37NXumFCgtlI3BDZlKOFkfYQueAGghEq9xy
         z/zQ==
X-Gm-Message-State: AOAM532wbgHYknREu+cY/XFdlc4upJtg7S2qoW4PcGYa2V8rd2Krq19d
        eo8Kw/2oCvt7CLL2xBBnp4D4xw==
X-Google-Smtp-Source: ABdhPJxMNnq/XmyKaQEfovB9gUn+Z+sXBgJfo586XxWEv01Ooqibpo3M5GZvW3EusOCR/yqN4TASEg==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr17334520wrw.372.1607437511630;
        Tue, 08 Dec 2020 06:25:11 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id b200sm3963032wmb.10.2020.12.08.06.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:25:10 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 6/6] kvm: arm64: Move skip_host_instruction to adjust_pc.h
Date:   Tue,  8 Dec 2020 14:24:52 +0000
Message-Id: <20201208142452.87237-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208142452.87237-1-dbrazdil@google.com>
References: <20201208142452.87237-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move function for skipping host instruction in the host trap handler to
a header file containing analogical helpers for guests.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h |  9 +++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c         | 12 ++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
index b1f60923a8fe..61716359035d 100644
--- a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
+++ b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
@@ -59,4 +59,13 @@ static inline void __adjust_pc(struct kvm_vcpu *vcpu)
 	}
 }
 
+/*
+ * Skip an instruction while host sysregs are live.
+ * Assumes host is always 64-bit.
+ */
+static inline void kvm_skip_host_instr(void)
+{
+	write_sysreg_el2(read_sysreg_el2(SYS_ELR) + 4, SYS_ELR);
+}
+
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index bde658d51404..a906f9e2ff34 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -157,11 +157,6 @@ static void default_host_smc_handler(struct kvm_cpu_context *host_ctxt)
 	__kvm_hyp_host_forward_smc(host_ctxt);
 }
 
-static void skip_host_instruction(void)
-{
-	write_sysreg_el2(read_sysreg_el2(SYS_ELR) + 4, SYS_ELR);
-}
-
 static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
 {
 	bool handled;
@@ -170,11 +165,8 @@ static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
 	if (!handled)
 		default_host_smc_handler(host_ctxt);
 
-	/*
-	 * Unlike HVC, the return address of an SMC is the instruction's PC.
-	 * Move the return address past the instruction.
-	 */
-	skip_host_instruction();
+	/* SMC was trapped, move ELR past the current PC. */
+	kvm_skip_host_instr();
 }
 
 void handle_trap(struct kvm_cpu_context *host_ctxt)
-- 
2.29.2.576.ga3fc446d84-goog

