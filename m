Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390602B5317
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbgKPUov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733258AbgKPUnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:40 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id m125so578127wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LvORiSrCboh1zuDeFhL4WafhjrkSrBKNjZKtj5yVH3Q=;
        b=SVWNYTmys1SPUElJcVnpJBNBs5oAdZHAjK3TgZzZfOjpBoMW5ofiWzcyLp+qfPd/rv
         kxeXWJJS9SoINBmJNnMAemKZcbUNdRiA7IlqnofStvW8mTMj8VEwIz2jUvrT0dA+i3Tm
         g4wlHWyoFXq/VYlwRf/yPokSBq5aRO13qmCxeFQHTGJWcIal7SJ4TcO6OjHoriu8V6fW
         cyyMoYuEkEBo1FJfAZu0x0BSpSDtsrjoio4mZiiVcN8P7hz6TwV2xEP4L0gzcuCfGjgh
         C997sjV7nUnfvAYgYd5xoY0UbaWHocozO0v8uoSSRaRQAVFTZ/vfGLIexqoU652x7Lnm
         bqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvORiSrCboh1zuDeFhL4WafhjrkSrBKNjZKtj5yVH3Q=;
        b=L4WI6fDSFzwj2CFOTEyUUkL7R9yGlr1Id/uHrlPJRVI0FKQVUFxHT5QdVQZU4uF1OZ
         rwD3HPquBPJlCbgkeGR2iA3NCv2teYj5CyCEywrnfCh5HtBGlvlmEO/0eYL4WcUcb5pM
         OtsGSEeKjtiKtvBP6fF2JeRK0ARmnul8ZnhrnOkiEXN88yxZN503jfTb13R9FusYQZ9C
         hmQfpkCuMJemS2sTo0gmZxMCNa8+wqFDc+jxm5os28QSL/BxlK0gvuFpiEsRFu+IR896
         Z4Tg2mKeGHFc6HFapNhOpkHTEbdf8wRfTgEiy7F9Pdpwa3H71nIS1XqCJ+bY0mneroXP
         9MWQ==
X-Gm-Message-State: AOAM5334PgMtfe2jhYtaLs9s2SzRJBm5c7W/5lb86sPuxj8P8+qn3Q3r
        /4JOAcZ6mkAVaUA1PBDFCZL55w==
X-Google-Smtp-Source: ABdhPJwOvc5dWi+xkvClKzcf/gKj3+UyZ1JtpEdN2rvPQaTpD24kr3N4TlMaKDsdi++yak8H6bPEtQ==
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr711033wmj.69.1605559417911;
        Mon, 16 Nov 2020 12:43:37 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id h20sm547704wmb.29.2020.11.16.12.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:36 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 07/24] kvm: arm64: Refactor handle_trap to use a switch
Date:   Mon, 16 Nov 2020 20:43:01 +0000
Message-Id: <20201116204318.63987-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small refactor so that nVHE's handle_trap uses a switch on the Exception
Class value of ESR_EL2 in preparation for adding a handler of SMC32/64.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 411b0f652417..19332c20fcde 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -16,9 +16,9 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
-static void handle_host_hcall(unsigned long func_id,
-			      struct kvm_cpu_context *host_ctxt)
+static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 {
+	unsigned long func_id = host_ctxt->regs.regs[0];
 	unsigned long ret = 0;
 
 	switch (func_id) {
@@ -109,11 +109,12 @@ static void handle_host_hcall(unsigned long func_id,
 void handle_trap(struct kvm_cpu_context *host_ctxt)
 {
 	u64 esr = read_sysreg_el2(SYS_ESR);
-	unsigned long func_id;
 
-	if (ESR_ELx_EC(esr) != ESR_ELx_EC_HVC64)
+	switch (ESR_ELx_EC(esr)) {
+	case ESR_ELx_EC_HVC64:
+		handle_host_hcall(host_ctxt);
+		break;
+	default:
 		hyp_panic();
-
-	func_id = host_ctxt->regs.regs[0];
-	handle_host_hcall(func_id, host_ctxt);
+	}
 }
-- 
2.29.2.299.gdc1121823c-goog

