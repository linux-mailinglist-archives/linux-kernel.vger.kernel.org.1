Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2502EF25C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhAHMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbhAHMRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:35 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54207C06125C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:16:17 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id e14so8139016qtr.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pSI0R0y0LyZ0MvEgT/8TLG9r/LMGz98d06c78ikqYMM=;
        b=ncicFESs3ffoWFoGIrRaXV+UDl8OOBsRzdKG5EpyzwDsT0yV7/eDINZFH8YAYdLFQh
         Y9TheqAFWLGOdu5Ma12BYM5IyqUHQAiuEm03eYEc1djPhUHUt+GW5V+HRmWrfKSK6PFG
         OnQkRt6iTH4FfGnyGLVzO+Hhvsauj/Z1MiAePgkHI9jvmc0XEJ5bFXuE23HXRU5lNRY8
         /bH/4yf2JeHIynsSwkiZuJFYhDGSVNoub55OTznCHT6ga1UcI3TVJsV9yzVZ4EFAl5RS
         dUVWi7djxRQN8R6/wJHxV2dByH4KaC4+SmMuujY+2acUKwtQOZnmnJyoO2sgaxMrN5ms
         k35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pSI0R0y0LyZ0MvEgT/8TLG9r/LMGz98d06c78ikqYMM=;
        b=dVDV7jjSsIH37/Uu7lISslVof7cyRbNHjE5gSDhF94Y0ywsdEniEua5l0v+hmV+i20
         OWiyih/8iGpttISXdWsWK7WE9Yl1St4lNuT+qmJlpmXuT7ZTRoxn9csN+81Tal8lUsd6
         mbhyxmg6ZF/8GztzKntk0PpDzWUo0ZlnHNBFkhlFfpay+6TRh0OYXJH+I0oyxsHS0PLd
         FxhVtUOhYWlne+hIaVQ93raA9cVNp+y9+v+Dnrgf1sVGfkRLtbOOUnLlVAO1CWEI6Av6
         rqbBJ1qrqfmmjmiv8LTBwdsoClzN62wL1Zy4A3B4e3n8yoO1Lj7Fvi6TYzV1aZuc/xAg
         kc0A==
X-Gm-Message-State: AOAM531w+Hvaav4hR0tOhVtJ5e5UMsa0z6qDp584j6q4ljudvb9yr7eN
        uLNJciXYmwc+JqBc7Ra88uPn19VrbAoG
X-Google-Smtp-Source: ABdhPJznjaU0Yun87ow+H6KZ/LD9kUqsdbc9elNbI5loy7zUnacmNP+CBQyMkz84xwCbZHRBZ8tbgygT96wL
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:90ee:: with SMTP id
 p101mr3023584qvp.29.1610108176503; Fri, 08 Jan 2021 04:16:16 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:21 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-24-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 23/26] KVM: arm64: Refactor __populate_fault_info()
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
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
2.30.0.284.gd98b1dd5eaa7-goog

