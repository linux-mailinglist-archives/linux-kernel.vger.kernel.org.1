Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF02F678A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbhANRZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbhANRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:25:31 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D983C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:51 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id cc1so5141381qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=g4KIFCTj4cFhEnW/O46us+TReSaxYy0f2hLe/I7ffcA=;
        b=Hhr7KAKs8kOi8WVwQmidsIWDfqEk25rtQyJk/MDOmviLPuxOOzJXYdh3f3lkDblIxi
         bkOl0KJfgrERFCfypVjkChfLf+YPjTJ2R6MoqdE8g3xwuh+pQXXK3sHhXvwsKekmTuQr
         QQZ4C8ABTaOUX/c4/fxJ2IPw96KQYShHaP4aBligI7fm0lZfPVmDgpSb+bb/A9vzI0uT
         05p9H0NYCR5SOIC0wIYgnUW2Vp5y9e+ep8LU3dqPpAd0MTpr4eJacqrwxYq+CNdewQnp
         iAKYH+6BEWrpZfWVGQL8yXKYA9g/L++6zE4c2taW502LbXImxUOSySltAIpQbEX82Xxe
         KNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g4KIFCTj4cFhEnW/O46us+TReSaxYy0f2hLe/I7ffcA=;
        b=Qj8Zh4QQs4p+oP+T77rEQQMAVOeczjLLr5iW0cg2V9NrYi9p5FdrIXqiIW3CHHs6/5
         2NplYRyuyLQ5AC0rl942JKytHEV5FZCJ7lmE0TaA3UOiMrMA5PHeyTg871nbAx4s1hKV
         iXOFJA1tmm3sbdaPeDw+s254yd+TTxhlIcnt3Cvxq/4N0dlUuBrEGF8X3ZYDZguZsIfI
         Iq2zgRHmjQdGSM4x8T8f2DhUwITdJdiHEBLoCvqXUcmeYwC76vyVoMGbVvkN7lG3cnRG
         pXb7fHJLDqL5EU0ZM55ANK2ZygUkzqAbgAPZZKSqj/kA2Wrs9Eg39PRYG+HbQKn1s6OF
         Ks4g==
X-Gm-Message-State: AOAM531+2kIEFker8arbArtp0m42s0KYGyYvyL3H/AYxPoPJFbGuLgHW
        JYILXsTQ8HEdcve7hO/+wsMu9Ub/LWpf
X-Google-Smtp-Source: ABdhPJygeOs4qkIrlkzeio5jc/x8qxwkfpCDIRzqWD6MrXutel9ZiEnpHM1XoAxYJ1uynxI++vLlmJLX5+SR
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:ad4:5188:: with SMTP id
 b8mr8125977qvp.55.1610645090361; Thu, 14 Jan 2021 09:24:50 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:35 +0000
In-Reply-To: <20210114172338.2798389-1-lenaptr@google.com>
Message-Id: <20210114172338.2798389-6-lenaptr@google.com>
Mime-Version: 1.0
References: <20210114172338.2798389-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 5/9] KVM: arm64: Enable shift out of bounds undefined
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
2.30.0.284.gd98b1dd5eaa7-goog

