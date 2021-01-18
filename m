Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEBB2F9C87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbhARJoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388875AbhARJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:32:27 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D83C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:31:47 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so9870104pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weNjZrEErNFXHPTaQIIiTw8hbCn51QM6hPaZLo2TDko=;
        b=d5iBcuanzwfbdvR36IQ+qsOR6a8QsF1WATdXJqKyaRnjqYi0Esw85UmGyK7zAL2x+7
         1Auk0l2eCTBoGwSLjN1EvOMk6lBipyCw9ocuN8pUiO61PFXJJYN2UKIzGX6+YYaDV5Da
         cYiioEKebmXl+QkkRpOZMRtmkvJEOKZteVF73gDDJKMtwXds4a34CmWzUzEEw8P2jkOu
         SMhRPfUftfVc/9QEiflRheTKINE2Z3Py8Dc1AhrDglJO4ehV9wYgyfJHhu4VwzZaiyGD
         5FirodtnY+RSGmmgw0y0yQ5jgj+pBO1TLQZ60GDldG3/7DJ+pt4WlSuIIrecD+emI4v5
         ICBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weNjZrEErNFXHPTaQIIiTw8hbCn51QM6hPaZLo2TDko=;
        b=UagxRRhBfV6f7FGc4uUqv8Eg2b5DNnn0g7G4L9ndQDii4/YttzBNBVrHpbDYMQihtu
         Fq8n0LlXlVtPvXsrF0kSuV0tYZgntdYZ4FVssV1E9bQmAelfE7DwO5xNcl0I8q6k1Y/r
         JdpYqyyZc5BliX/iDFTpkm1hdbCmaQGSrg+487Q+jKcHv23nwTWCOBEFP7Zq6dwkBddr
         +l6mSm21eI9zitUZBunHhdFBdyvcGlR2MRL/UlRn8PbGVevfNp2qWR7nFp6RwVS7YjjP
         eJJkxxpvC27GVtNrC/Le+pmT0Pta/uTRjWu0NzHUHqm3ohUFcxp66f3eOcO+83XiJHC5
         rf6A==
X-Gm-Message-State: AOAM531TiQPAlxGHgwXrCibpnYVwzcoJZzNijyJyCrwgQJkRC6nZqOUq
        C82360pOSHxGVp4+eLt4VYA=
X-Google-Smtp-Source: ABdhPJwWa+OnJ54swVw4LtN6TdwayZCIBZs0XWey0PmTyVWlKeAVuKwG5U+nZNRpYqEfkhTFCZyXLQ==
X-Received: by 2002:a65:63c7:: with SMTP id n7mr25633698pgv.285.1610962307166;
        Mon, 18 Jan 2021 01:31:47 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id z13sm2828607pgf.89.2021.01.18.01.31.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 01:31:46 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] KVM: arm64: Fix the return value of smp_call_function_single()
Date:   Mon, 18 Jan 2021 17:31:37 +0800
Message-Id: <20210118093137.3383-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In smp_call_function_single(), the 3rd parameter isn't the return value
and it's always positive. But it may return a negative value. So the
'ret' is should be the return value of the smp_call_function_single().

In check_kvm_target_cpu(), 'phys_target' is more readable than 'ret'.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 arch/arm64/kvm/arm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 04c44853b103..5fa5c04106de 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1815,9 +1815,9 @@ static int init_hyp_mode(void)
 	return err;
 }
 
-static void check_kvm_target_cpu(void *ret)
+static void check_kvm_target_cpu(void *phys_target)
 {
-	*(int *)ret = kvm_target_cpu();
+	*(int *)phys_target = kvm_target_cpu();
 }
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
@@ -1879,7 +1879,7 @@ void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
 int kvm_arch_init(void *opaque)
 {
 	int err;
-	int ret, cpu;
+	int ret, cpu, phys_target;
 	bool in_hyp_mode;
 
 	if (!is_hyp_mode_available()) {
@@ -1900,7 +1900,7 @@ int kvm_arch_init(void *opaque)
 			 "Only trusted guests should be used on this system.\n");
 
 	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
+		ret = smp_call_function_single(cpu, check_kvm_target_cpu, &phys_target, 1);
 		if (ret < 0) {
 			kvm_err("Error, CPU %d not supported!\n", cpu);
 			return -ENODEV;
-- 
2.29.0

