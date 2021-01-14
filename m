Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230672F678D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbhANRZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbhANRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:25:43 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28436C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:25:03 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id r5so2142668wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2qQJjLuQRjXExkzU8FZkqO0GipUsTAXdfg8Nhn7veDk=;
        b=FWNr+g3VRFdqTHe9xhQ8PSAipaLD6xxQVRv7dohU3W24sntVwNzQCi+pb1OJbiKThd
         EG4CrBJtgW/DtsRcBldbjHi6ZGDI+7oCojMoVYt9wWKDDn/VfrccIILjLgLs2PvzxvtG
         PHqQIinKIrWoe8tpNcpB8OiBFzjyDS7TKggJkf6JvJhAstI6uuQ/lvswbzkuQXAhmUa5
         jsngsMfh29icsgLfBqPcDnvNHwsugUbJVHple85F9jpI0v1nQ/r+RIiliJXbRAExuXrd
         ENxbF/uepCqWaWBJhaWuUNAthL/EblAcvqg6U2dg+XDXSsYV/GwoTzDMdG83grljnimE
         pLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2qQJjLuQRjXExkzU8FZkqO0GipUsTAXdfg8Nhn7veDk=;
        b=qOkTw076653w3VfHTEUo+AqwGHO5Hgu95AxeMAqnnkJXfx7P+yvu6U3YMmCEpNbuYK
         RqSjjtRrt9xUUg036VUlFOG7pWvDyU/00oREu1tc4hfsaTj7oFuiBLfuhYvYiXHIZuML
         h9QxvyBtdCRWnd+LW7JDRehQZNyFgaHOJJX9vk2wcsLlAGjBH4awMjlzBkjCcRqJhH7a
         qvGGvWXav/xITm/Zw2w/Qx0BYm9a9cyxy1v2QoK397wxaRd/cxqr9EPbKUMxrI5xFhpe
         DAUJZeGzXpkOomqnopgLfnQEO2HnSqmQ45j7Av3EYz1Xe8mwp1ToVzX5TsWjDinn0eyU
         xHMA==
X-Gm-Message-State: AOAM531D0zE8UT+Ud0P+vkJIDTls0Lg8afzJllsunb9eYujI7exoGwdA
        oiQoxAug2vNbMn3TIzqtBIfR562Rfjdr
X-Google-Smtp-Source: ABdhPJyqTh4gvF7otj7lmh3sfqgJ0R/FBjbEpmEgMRafwtxyhVmHUhbSGS8nbO+OrmqxnyZOGB2Dpcd48cfN
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:adf:9cca:: with SMTP id
 h10mr9047981wre.77.1610645101843; Thu, 14 Jan 2021 09:25:01 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:38 +0000
In-Reply-To: <20210114172338.2798389-1-lenaptr@google.com>
Message-Id: <20210114172338.2798389-9-lenaptr@google.com>
Mime-Version: 1.0
References: <20210114172338.2798389-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 8/9] KVM: arm64: Detect arithmetic overflow is inside hyp/nVHE.
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

Whenever an arithmetic overflow: addition, substraction, multiplication,
division or negating happens inside the hyp/nVHE code,
an __ubsan_handle_*_overflow is called.

All the overflow handlers are sharing the same structure called
overflow_data.

Signed-off-by: George Popescu <georgepope@google.com>
Change-Id: Iec1ef331e471efbb35a39ffaee0641107a3a0e3a
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/include/asm/kvm_ubsan.h | 10 ++++++--
 arch/arm64/kvm/hyp/nvhe/ubsan.c    | 40 ++++++++++++++++++++++++++----
 arch/arm64/kvm/kvm_ubsan_buffer.c  | 20 ++++++++++++++-
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
index 93c1b695097a..da4a3b4e28e0 100644
--- a/arch/arm64/include/asm/kvm_ubsan.h
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -22,7 +22,8 @@ struct kvm_ubsan_info {
 		UBSAN_UNREACHABLE_DATA,
 		UBSAN_SHIFT_OUT_OF_BOUNDS,
 		UBSAN_INVALID_DATA,
-		UBSAN_TYPE_MISMATCH
+		UBSAN_TYPE_MISMATCH,
+		UBSAN_OVERFLOW_DATA
 	} type;
 	union {
 		struct out_of_bounds_data out_of_bounds_data;
@@ -30,6 +31,7 @@ struct kvm_ubsan_info {
 		struct shift_out_of_bounds_data shift_out_of_bounds_data;
 		struct invalid_value_data invalid_value_data;
 		struct type_mismatch_data type_mismatch_data;
+		struct overflow_data overflow_data;
 	};
 	union {
 		struct ubsan_values u_val;
@@ -41,4 +43,8 @@ void __ubsan_handle_builtin_unreachable(void *_data);
 void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
 void __ubsan_handle_load_invalid_value(void *_data, void *val);
 void __ubsan_handle_type_mismatch(struct type_mismatch_data  *_data, void *ptr);
-
+void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
+void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
+void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
+void __ubsan_handle_negate_overflow(void *_data, void *old_val);
+void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
index a9f72d4bcab7..f16842ff7316 100644
--- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
@@ -47,15 +47,45 @@ static void write_type_mismatch_data(struct type_mismatch_data_common *data, voi
 	}
 }
 
-void __ubsan_handle_add_overflow(void *_data, void *lhs, void *rhs) {}
+static void write_overflow_data(struct overflow_data *data, void *lval, void *rval, char op)
+{
+	struct kvm_ubsan_info *slot = kvm_ubsan_buffer_next_slot();
+
+	if (slot) {
+		slot->type = UBSAN_OVERFLOW_DATA;
+		slot->overflow_data = *data;
+		slot->u_val.op = op;
+		slot->u_val.lval = lval;
+		if (op != '!')
+			slot->u_val.rval = rval;
+	}
+}
+
+void __ubsan_handle_add_overflow(void *_data, void *lhs, void *rhs)
+{
+	write_overflow_data(_data, lhs, rhs, '+');
+}
 
-void __ubsan_handle_sub_overflow(void *_data, void *lhs, void *rhs) {}
+void __ubsan_handle_sub_overflow(void *_data, void *lhs, void *rhs)
+{
+	write_overflow_data(_data, lhs, rhs, '-');
+}
 
-void __ubsan_handle_mul_overflow(void *_data, void *lhs, void *rhs) {}
+void __ubsan_handle_mul_overflow(void *_data, void *lhs, void *rhs)
+{
+	write_overflow_data(_data, lhs, rhs, '*');
+}
 
-void __ubsan_handle_negate_overflow(void *_data, void *old_val) {}
+void __ubsan_handle_negate_overflow(void *_data, void *old_val)
+{
+	write_overflow_data(_data, old_val, NULL, '!');
+}
+
+void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
+{
+	write_overflow_data(_data, lhs, rhs, '/');
+}
 
-void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs) {}
 
 void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr)
 {
diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
index b7823dedf8b1..2c7060cbb48b 100644
--- a/arch/arm64/kvm/kvm_ubsan_buffer.c
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -39,7 +39,25 @@ void __kvm_check_ubsan_data(struct kvm_ubsan_info *slot)
 		__ubsan_handle_type_mismatch(&slot->type_mismatch_data,
 				slot->u_val.lval);
 		break;
-    	}
+	case UBSAN_OVERFLOW_DATA:
+		if (slot->u_val.op == '/') {
+			__ubsan_handle_divrem_overflow(&slot->overflow_data,
+					slot->u_val.lval, slot->u_val.rval);
+		} else if (slot->u_val.op == '!') {
+			__ubsan_handle_negate_overflow(&slot->overflow_data,
+					slot->u_val.lval);
+		} else if (slot->u_val.op == '+') {
+			__ubsan_handle_add_overflow(&slot->overflow_data,
+					slot->u_val.lval, slot->u_val.rval);
+		} else if (slot->u_val.op == '-') {
+			__ubsan_handle_sub_overflow(&slot->overflow_data,
+					slot->u_val.lval, slot->u_val.rval);
+		} else if (slot->u_val.op == '*') {
+			__ubsan_handle_mul_overflow(&slot->overflow_data,
+					slot->u_val.lval, slot->u_val.rval);
+		}
+		break;
+    }
 }
 
 void iterate_kvm_ubsan_buffer(unsigned long left, unsigned long right)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

