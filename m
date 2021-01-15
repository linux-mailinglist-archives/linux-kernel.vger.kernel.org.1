Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913CA2F8208
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbhAORTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbhAORTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:19:38 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B583C061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:18:58 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id h21so3228140wmq.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/8un1Ary21jdPLd+LUk6zbXqqm3VArAc3S7FbSuGJ7M=;
        b=JA9FdkQhxjQG1gw49w0maesw4+ti5fXadr2Pq9t0aXEEkIUFnr+mtX+ZPRryioLTTQ
         ufXKI35Qv4143oJiZ03pZOiJW4C0nD+T2UJHD21bTz/ZqBncZvuqw7RywHlbplN8ubdi
         OPjwcRTE2z0HAJ+M6IAN3c0CzTqyW5Nr9KH5cVTk7RTx4vuxLt8Ip4BYBsSqaOIJaVi+
         DQ/6wlQYfRRGd4+ZEFFmmmPHJjGH4cOU18Jm855txWLIALUp9WPAC9FJUqpExi9dVCY/
         09iJS+eDvTjNHk5QYRigUeLosU5F+HefFR41guZQzpb4hpVI+RxEOrAf4yoR12BrZVbF
         7gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/8un1Ary21jdPLd+LUk6zbXqqm3VArAc3S7FbSuGJ7M=;
        b=BzNp6ruCLNNcEjixtuw5dhMVZuxjYJ2O+q/CkwmSHZhfnoWpX1ZlhfvJnoIKWRjCEx
         fDm3yW9jEpgw0W2EpTXRMGH74kreFVvhWG7frExITe/FTtTwVZvGI9nl8s3al+kxW34F
         jfHZrgHyDUK6qf4mN8NT9rI7V6lTmJYFpLQ99IWAJRZ9WzqJnrP43XHtJ0nC3T+Dj052
         +jW0St7CqVvMDlnALFmcxyPqYELoJzBFO/6a/Iql5i3gqwblZE5AQ446yNFoW4IB8dCu
         pPTnXjvK4spMEjLw83CUJYcqk1BQlaZ29LQ7nedZ6HyvlOZ0fj2svpRnc5ywrfgwCzmu
         C4kg==
X-Gm-Message-State: AOAM533kBZtnICc293j7iTRIiMIHlIAbPAvBk49w3OKPUhI4LDxOYYfI
        ZC3N8JX+lVCq0WDjaoMsu9fikCIwHAAx
X-Google-Smtp-Source: ABdhPJzLy46RtKRhJlfnQR0PbFbCxme0w7jH3ufnM4lCPC+V5c3Y6pJYMT8Sxhrrv3zXM6c86O3sE5a05K3D
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a1c:9dcb:: with SMTP id
 g194mr9789599wme.59.1610731135867; Fri, 15 Jan 2021 09:18:55 -0800 (PST)
Date:   Fri, 15 Jan 2021 17:18:24 +0000
In-Reply-To: <20210115171830.3602110-1-lenaptr@google.com>
Message-Id: <20210115171830.3602110-4-lenaptr@google.com>
Mime-Version: 1.0
References: <20210115171830.3602110-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 3/9] KVM: arm64: Enable UBSAN_BOUNDS for the both the
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
2.30.0.296.g2bfb1c46d8-goog

