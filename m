Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0482A2F6786
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbhANRZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:25:23 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E90BC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:43 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t17so5114723qvv.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xV+/a2Rp5lRcHlFRCafjdMqZdknib/NjGfl4/F+eUSQ=;
        b=RHWeCTmFFlh0JG7mSrwt1xtK3BPDcF/hNwHiBSWk2tm3duHiYAEvtevj2/GAO5f869
         2m3HICWqldEJ2EfhWZYJCnQAAWHfwp4TUOTERQqiZTnMzKq4FXSuSlHKsQCkxaLo5kyJ
         JZVSqwaPfHYu/kDGisDgA7beJwN0XcGGRgTpC4koHF1IBZ6E1aV1zcU2X2ozQZL+hprg
         GrABIORMdgZx5+EJ9vs7hqClA49Ey+lSP3BmQz4bubQJKTHQ36oAAVVxJ3tegF17coOb
         T9ZgM+wBKsYD90vhlOkPfEgk6gcyTQJ+48x4N36NaoN+BBBZ8562dlxSZD1b5nMk/z5w
         cP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xV+/a2Rp5lRcHlFRCafjdMqZdknib/NjGfl4/F+eUSQ=;
        b=IifsIz/3uGrx5Wvkm4rjaxwiXL/xZ9qMcHfPckviMKQU63NwyjBo/q1nEBN3ubpayq
         x551Q/athCVr6QEqP3Do1bcV4gDcmioGjU3hJ9kCVEye77ue+azShe5jgjd3x3jTa+Wa
         WFxXQ3o3xZgz3ZxWVVZwgyWtdGD0RqWD/qegzHoaxKqIZyMAdhw/BHQdGNP+KPXfgnVX
         7SRm4T66uV6H+6N7zYKcPqDr0f/DhfaXq4e7w9uACqjQRrTXiWFQYaFnpGqAKfcFXdx2
         Hi61uxZN1mmdagLusfa9JvaWqgr7UXF11cTS+p+KPO9U+6j7cWKnHJHOLIT0wYNV6f7s
         eYCQ==
X-Gm-Message-State: AOAM532/Urd8wcdcV0PqigvbIji3t0IUkiJFVHSAfR6lEcin/rO0+15v
        cYSabanDJ4FCUbNRRmA7Z/vSv9b58wDH
X-Google-Smtp-Source: ABdhPJxYOrg0jToecCcCtBlCANab6SAeOu4IUUuOLW8kdj70MALJwg3ucMAxQNeuFfe9E7QdMPkIvkLD8o+D
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a0c:a789:: with SMTP id
 v9mr7957944qva.41.1610645082204; Thu, 14 Jan 2021 09:24:42 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:33 +0000
In-Reply-To: <20210114172338.2798389-1-lenaptr@google.com>
Message-Id: <20210114172338.2798389-4-lenaptr@google.com>
Mime-Version: 1.0
References: <20210114172338.2798389-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 3/9] KVM: arm64: Enable UBSAN_BOUNDS for the both the
 kernel and hyp/nVHE
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

If an out of bounds happens inside the hyp/nVHE code, the ubsan_out_of_bounds
handler stores the logging data inside the kvm_ubsan_buffer. The one responsible
for printing is the kernel ubsan_out_of_bounds handler. The process of
decapsulating the data from the buffer is straightforward.

Signed-off-by: George Popescu <georgepope@google.com>
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/include/asm/kvm_ubsan.h | 19 ++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/ubsan.c    | 14 ++++++++++++--
 arch/arm64/kvm/kvm_ubsan_buffer.c  | 10 ++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
index fb32c7fd65d4..4f471acb88b0 100644
--- a/arch/arm64/include/asm/kvm_ubsan.h
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -9,6 +9,23 @@
 #define UBSAN_MAX_TYPE 6
 #define KVM_UBSAN_BUFFER_SIZE 1000
 
+
+struct ubsan_values {
+	void *lval;
+	void *rval;
+	char op;
+};
+
 struct kvm_ubsan_info {
-	int type;
+	enum {
+		UBSAN_OUT_OF_BOUNDS,
+	} type;
+	union {
+		struct out_of_bounds_data out_of_bounds_data;
+	};
+	union {
+		struct ubsan_values u_val;
+	};
 };
+
+void __ubsan_handle_out_of_bounds(void *_data, void *index);
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
index 8a194fb1f6cf..55a8f6db8555 100644
--- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
@@ -13,7 +13,6 @@
 #include <asm/kvm_ubsan.h>
 #include <asm/kvm_debug_buffer.h>
 #include <kvm/arm_pmu.h>
-#include <ubsan.h>
 
 DEFINE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
                 kvm_ubsan_buff_wr_ind, KVM_UBSAN_BUFFER_SIZE);
@@ -44,7 +43,18 @@ void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr) {}
 
 void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr) {}
 
-void __ubsan_handle_out_of_bounds(void *_data, void *index) {}
+void __ubsan_handle_out_of_bounds(void *_data, void *index)
+{
+	struct kvm_ubsan_info *slot;
+	struct out_of_bounds_data *data = _data;
+
+	slot = kvm_ubsan_buffer_next_slot();
+	if (slot) {
+		slot->type = UBSAN_OUT_OF_BOUNDS;
+		slot->out_of_bounds_data = *data;
+		slot->u_val.lval = index;
+	}
+}
 
 void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs) {}
 
diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
index 4a1959ba9f68..a1523f86be3c 100644
--- a/arch/arm64/kvm/kvm_ubsan_buffer.c
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -17,6 +17,15 @@
 DECLARE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
 		kvm_ubsan_buff_wr_ind, KVM_UBSAN_BUFFER_SIZE);
 
+void __kvm_check_ubsan_data(struct kvm_ubsan_info *slot)
+{
+	switch (slot->type) {
+	case UBSAN_OUT_OF_BOUNDS:
+		__ubsan_handle_out_of_bounds(&slot->out_of_bounds_data,
+				slot->u_val.lval);
+		break;
+	}
+}
 
 void iterate_kvm_ubsan_buffer(unsigned long left, unsigned long right)
 {
@@ -26,6 +35,7 @@ void iterate_kvm_ubsan_buffer(unsigned long left, unsigned long right)
 	slot = (struct kvm_ubsan_info *) this_cpu_ptr_nvhe_sym(kvm_ubsan_buffer);
 	for (i = left; i < right; ++i) {
 		/* check ubsan data */
+		__kvm_check_ubsan_data(slot + i);
 		slot[i].type = 0;
 	}
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

