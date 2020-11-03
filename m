Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6B2A50C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKCUPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCUP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:15:28 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF2C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 12:15:28 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so7280834pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcS/eDZKYQVPpPM3i+DV4YykHabb4CCW7PICDQhefoo=;
        b=cfHsoIfG20R3C11RE4UI+XHVhn4awqd8TA1ZVQIXvTfGkMfAw5Bp+iMbnIhID1IcNz
         4Zj2E+kSg/KqyvwolrZ9R/x+RywpPHHreSKyvV5eVAY6FGIjda3XCCmzEzbvb1QHvjNe
         wMffqQh1vzcgYESNIC0mGGYU4dr06IytXYqgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcS/eDZKYQVPpPM3i+DV4YykHabb4CCW7PICDQhefoo=;
        b=BPqkH13q0duob8uKKQKETRYRg+g7b+L/1mkQ9nfi5gnilgSzYVPVQ8CtanAbKh/FiB
         +bWIlIIbFOnKGMs6kMLMuLAWC0YtTPiNJ2ZdD4cl83IAvL1DP5ay4c5qNvstRjqG4qy+
         lqar1YWpbhz67kh0XnkORO7kZrzUg62M9wm/gplYfn+HLe11W41XLxo9k/W3D4ycMwgF
         wrCAG2yIx0tGs1vYWGVUFVitbB6Lq4bclDMD9ARGRWoxROKXr+wdBx1BZjG/GuAhfwOL
         gRHd2GSN/1ReTu9Hn8KJK57buY2eGKLMGximvp7KRyS+TEDkcQvNwaUf90BKkglJIiir
         fBsw==
X-Gm-Message-State: AOAM530cUOyqsrNYROHy5WBrgUHc3yFqDJnu9HUxaTG9o3iC4leZ6qJS
        gzr5nhrJi1751ImOOrB3prQs7w==
X-Google-Smtp-Source: ABdhPJyMwrWw1bim6fkp/jon6iNStNmbV6Qtl7aVQkl/mI4zTPmQ/kIQAnLJcPNAxsDkuyJIIN31kQ==
X-Received: by 2002:a17:90b:3494:: with SMTP id kd20mr952020pjb.84.1604434528221;
        Tue, 03 Nov 2020 12:15:28 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a28sm2523094pfk.50.2020.11.03.12.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 12:15:27 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH stable 5.9] KVM: arm64: ARM_SMCCC_ARCH_WORKAROUND_1 doesn't return SMCCC_RET_NOT_REQUIRED
Date:   Tue,  3 Nov 2020 12:15:26 -0800
Message-Id: <20201103201526.372590-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1de111b51b829bcf01d2e57971f8fd07a665fa3f upstream.

According to the SMCCC spec[1](7.5.2 Discovery) the
ARM_SMCCC_ARCH_WORKAROUND_1 function id only returns 0, 1, and
SMCCC_RET_NOT_SUPPORTED.

 0 is "workaround required and safe to call this function"
 1 is "workaround not required but safe to call this function"
 SMCCC_RET_NOT_SUPPORTED is "might be vulnerable or might not be, who knows, I give up!"

SMCCC_RET_NOT_SUPPORTED might as well mean "workaround required, except
calling this function may not work because it isn't implemented in some
cases". Wonderful. We map this SMC call to

 0 is SPECTRE_MITIGATED
 1 is SPECTRE_UNAFFECTED
 SMCCC_RET_NOT_SUPPORTED is SPECTRE_VULNERABLE

For KVM hypercalls (hvc), we've implemented this function id to return
SMCCC_RET_NOT_SUPPORTED, 0, and SMCCC_RET_NOT_REQUIRED. One of those
isn't supposed to be there. Per the code we call
arm64_get_spectre_v2_state() to figure out what to return for this
feature discovery call.

 0 is SPECTRE_MITIGATED
 SMCCC_RET_NOT_REQUIRED is SPECTRE_UNAFFECTED
 SMCCC_RET_NOT_SUPPORTED is SPECTRE_VULNERABLE

Let's clean this up so that KVM tells the guest this mapping:

 0 is SPECTRE_MITIGATED
 1 is SPECTRE_UNAFFECTED
 SMCCC_RET_NOT_SUPPORTED is SPECTRE_VULNERABLE

Note: SMCCC_RET_NOT_AFFECTED is 1 but isn't part of the SMCCC spec

Fixes: c118bbb52743 ("arm64: KVM: Propagate full Spectre v2 workaround state to KVM guests")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://developer.arm.com/documentation/den0028/latest [1]
Link: https://lore.kernel.org/r/20201023154751.1973872-1-swboyd@chromium.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/kvm/hypercalls.c | 2 +-
 include/linux/arm-smccc.h   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 550dfa3e53cd..b8e7f6c4524f 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -31,7 +31,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 				val = SMCCC_RET_SUCCESS;
 				break;
 			case KVM_BP_HARDEN_NOT_REQUIRED:
-				val = SMCCC_RET_NOT_REQUIRED;
+				val = SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED;
 				break;
 			}
 			break;
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 15c706fb0a37..0e50ba3e88d7 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -86,6 +86,8 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 0x7fff)
 
+#define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
+
 /* Paravirtualised time calls (defined by ARM DEN0057A) */
 #define ARM_SMCCC_HV_PV_TIME_FEATURES				\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
-- 
Sent by a computer, using git, on the internet

