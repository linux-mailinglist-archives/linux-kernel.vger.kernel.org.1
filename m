Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5D2B6CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgKQSRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbgKQSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:17:14 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E2C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:14 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id e15so1906612wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=e9MvRELompdcQ9+x82O89Ri9iXp7qNvrmx/wGARfLl4=;
        b=GrNemWJ571s3IP05lzCIf+o9mQWG20WSzj1XWIbqs4BH51p4FibpD+1iIudjxdsldY
         VTOoE+KKuVVeeDxGnJBQ6qpGvS4olzVpA4h2kHUJdYePK03MTWF1sVNn29wYr8jCqsP1
         zfnuBAtCdwfY4dVJuW13O2zHGn/wvP8TJd+7Gv88DeaAnl6Vr0lt8jupKQCVqBMY6LJu
         UuVkqgukfwDXxkwuFocX4twgxviyx3guAteMin0WGg+8TngA8wcruUWGUCFFyFlGLDAH
         GgrgZwJ5cpl+PeisJnHcFbNvplQ+JU+cK6fr/J2jY7HohI0LpW8XQQFBmZ0pMJ5mGWt9
         sFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e9MvRELompdcQ9+x82O89Ri9iXp7qNvrmx/wGARfLl4=;
        b=NfR4YjalUf6TA53VAFH3kDUTA21PuS/xc2oCGWVUGaEwUfEPLTkoVI/htbIFBYEST7
         cz0NaHaiLNB9EHh7IzZTdDVpY/E87mEJh4GzEmHfajGEt4HaPzLWa2oZ5JVSZ1D2hD8z
         WFfYvxi1rqpIQH5jhqrTnli/nY1ttfK07XzYN5BIVyJrrKyhfkRcJptA3B/oWW4N4yxd
         27fAi7yD58+1Fv/FnesK3Xa9ApXvzuYuSClWZwb0iO/Fase48voQoX4oBy2l0qf9BCt+
         jS4246o1BSdSOQH6wrlmOoDhjUab3eScyp/RJBjQT1mufR8/lBerC2thexAMVXGAeo+D
         0IGg==
X-Gm-Message-State: AOAM531xZGfogKrmPajMIV6tHeRgWfwWH7xkAFlmsL5mcvze9GrK2744
        v4i3JoQkdmrtiSG/DePDbjF9IDEOm0k9
X-Google-Smtp-Source: ABdhPJz7BNpBZ+O3LELUcm62RbTCKz5SEYVRtuO5fjYtpJDAqHE3syxKSKHYJAgBXthIughVPk93YxkQXa72
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a1c:6405:: with SMTP id
 y5mr376392wmb.150.1605637032528; Tue, 17 Nov 2020 10:17:12 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:16:03 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-24-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 23/27] KVM: arm64: Refactor __populate_fault_info()
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor __populate_fault_info() to introduce __get_fault_info() which
will be used once the host is wrapped in a stage 2.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 36 +++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 84473574c2e7..e9005255d639 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -157,19 +157,9 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	return true;
 }
 
-static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
+static inline bool __get_fault_info(u64 esr, u64 *far, u64 *hpfar)
 {
-	u8 ec;
-	u64 esr;
-	u64 hpfar, far;
-
-	esr = vcpu->arch.fault.esr_el2;
-	ec = ESR_ELx_EC(esr);
-
-	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
-		return true;
-
-	far = read_sysreg_el2(SYS_FAR);
+	*far = read_sysreg_el2(SYS_FAR);
 
 	/*
 	 * The HPFAR can be invalid if the stage 2 fault did not
@@ -185,12 +175,30 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 	if (!(esr & ESR_ELx_S1PTW) &&
 	    (cpus_have_final_cap(ARM64_WORKAROUND_834220) ||
 	     (esr & ESR_ELx_FSC_TYPE) == FSC_PERM)) {
-		if (!__translate_far_to_hpfar(far, &hpfar))
+		if (!__translate_far_to_hpfar(*far, hpfar))
 			return false;
 	} else {
-		hpfar = read_sysreg(hpfar_el2);
+		*hpfar = read_sysreg(hpfar_el2);
 	}
 
+	return true;
+}
+
+static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
+{
+	u8 ec;
+	u64 esr;
+	u64 hpfar, far;
+
+	esr = vcpu->arch.fault.esr_el2;
+	ec = ESR_ELx_EC(esr);
+
+	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
+		return true;
+
+	if (!__get_fault_info(esr, &far, &hpfar))
+		return false;
+
 	vcpu->arch.fault.far_el2 = far;
 	vcpu->arch.fault.hpfar_el2 = hpfar;
 	return true;
-- 
2.29.2.299.gdc1121823c-goog

