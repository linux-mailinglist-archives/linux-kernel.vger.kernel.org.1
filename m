Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740BA2F820A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbhAORUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733216AbhAORUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:20:06 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F07C061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:03 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 189so8652749qko.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r0Yb1c7k86IyNObw3uSoYlpOEjwui41Agh14pBOSnbw=;
        b=hSGoDFKkQJHGGbbbprh+JxndXzQMIC8A2b8d9cTjLGKS/6zjlELBAHWg4LPBIoZ4jj
         sjmAkDmfv8OsfkYhVYnYCIySbeWOKuX/YZ1Ccj1CD02RwKuakr2GX0dRfijjqAv1wS3K
         U9n5bG3Wpn8v3e/+eR4uc6iSuNxdSuav4Ptyyb1iFzorCs1hN2Mi7vMiOD2jI2m59SYP
         hE2QzF1GzaMu2pOCfiYHmdwDe6f0Z0L4DNaBXsGwupkD6R3LZKduwiOrHwvy3o6qXMuA
         SulMTJ5ImdYgKkn7evHvJql8gV/auPPTSyGhJAq51ES+qrEVB9OqAbZNeZhysMsu2A4E
         boCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r0Yb1c7k86IyNObw3uSoYlpOEjwui41Agh14pBOSnbw=;
        b=gNMpenJVY6vqmysPHLTfEdIZYkKGhEQf5sbX6oQH04Uvrch6E+EUhjMpV8zMTJ3Jfq
         n/8wX1DGNgKTDn+ZEa6mRvamquMWjFiYRB9hRUnoEh/ilWxBUm6Q3hAZarLl3fdRRu45
         nKVYVAiIHqnNQ2SL1th5UNAD4VXTnR+CP5rvAqqreSrUCkZqyh4LIIM3dtvHR/xnnoqK
         jOHGFHOrpVeB4kzcmxCnopY3hn5CBi2YF9S6ggotr3/FquZB5F6M7vWZFWA0gyX8k8CA
         zlthEUrx51OYSwS5E0gChIFcYaPJ0cuMxeqA0PoFXn6jA5AI+Ha8/xVSJoaC/PKMtQcS
         c40Q==
X-Gm-Message-State: AOAM531M8yn22pq46iGBA7Ln6bF7ecdsqjta9B6qNj9tTazaIlm8Z3Rx
        GByBGGhvZ2Qv0TEbvZyJgH86zlxOTC8Z
X-Google-Smtp-Source: ABdhPJweYd/lOR/2KFC86rRuTjATek2F+PrOdMNMG0Iz9+YTijZh11W4oUszwbXeTbKE9po4C1UvasiMh4dA
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a0c:b65f:: with SMTP id
 q31mr13017862qvf.24.1610731143114; Fri, 15 Jan 2021 09:19:03 -0800 (PST)
Date:   Fri, 15 Jan 2021 17:18:26 +0000
In-Reply-To: <20210115171830.3602110-1-lenaptr@google.com>
Message-Id: <20210115171830.3602110-6-lenaptr@google.com>
Mime-Version: 1.0
References: <20210115171830.3602110-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 5/9] KVM: arm64: Enable shift out of bounds undefined
 behaviour check for hyp/nVHE
From:   Elena Petrova <lenaptr@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Elena Petrova <lenaptr@google.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        George Popescu <george.apopescu97@gmail.com>,
        George Popescu <georgepope@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Popescu <georgepope@google.com>

__ubsan_handle_shift_out_of_bounds data is passed to the buffer inside
hyp/nVHE. This data is passed to the original handler from kernel.

The 64bit values of the shift expression operands are stored as the lhs
and rhs pointers, so there is no need to dereference them.

Signed-off-by: George Popescu <georgepope@google.com>
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/include/asm/kvm_ubsan.h |  5 ++++-
 arch/arm64/kvm/hyp/nvhe/ubsan.c    | 14 +++++++++++++-
 arch/arm64/kvm/kvm_ubsan_buffer.c  |  4 ++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
index 70c6f2541d07..0eef0e11a93b 100644
--- a/arch/arm64/include/asm/kvm_ubsan.h
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -19,11 +19,13 @@ struct ubsan_values {
 struct kvm_ubsan_info {
 	enum {
 		UBSAN_OUT_OF_BOUNDS,
-		UBSAN_UNREACHABLE_DATA
+		UBSAN_UNREACHABLE_DATA,
+		UBSAN_SHIFT_OUT_OF_BOUNDS
 	} type;
 	union {
 		struct out_of_bounds_data out_of_bounds_data;
 		struct unreachable_data unreachable_data;
+		struct shift_out_of_bounds_data shift_out_of_bounds_data;
 	};
 	union {
 		struct ubsan_values u_val;
@@ -32,3 +34,4 @@ struct kvm_ubsan_info {
 
 void __ubsan_handle_out_of_bounds(void *_data, void *index);
 void __ubsan_handle_builtin_unreachable(void *_data);
+void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
index 5e55897b2d72..1069ed5036d5 100644
--- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
@@ -56,7 +56,19 @@ void __ubsan_handle_out_of_bounds(void *_data, void *index)
 	}
 }
 
-void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs) {}
+void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs)
+{
+	struct kvm_ubsan_info *slot;
+	struct shift_out_of_bounds_data *data = _data;
+
+	slot = kvm_ubsan_buffer_next_slot();
+	if (slot) {
+		slot->type = UBSAN_SHIFT_OUT_OF_BOUNDS;
+		slot->shift_out_of_bounds_data = *data;
+		slot->u_val.lval = lhs;
+		slot->u_val.rval = rhs;
+	}
+}
 
 void __ubsan_handle_builtin_unreachable(void *_data)
 {
diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
index e51949c275aa..b80045883047 100644
--- a/arch/arm64/kvm/kvm_ubsan_buffer.c
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -27,6 +27,10 @@ void __kvm_check_ubsan_data(struct kvm_ubsan_info *slot)
 	case UBSAN_UNREACHABLE_DATA:
 		__ubsan_handle_builtin_unreachable(&slot->unreachable_data);
 		break;
+	case UBSAN_SHIFT_OUT_OF_BOUNDS:
+        	__ubsan_handle_shift_out_of_bounds(&slot->shift_out_of_bounds_data,
+				slot->u_val.lval, slot->u_val.rval);
+		break;
 	}
 }
 
-- 
2.30.0.296.g2bfb1c46d8-goog

