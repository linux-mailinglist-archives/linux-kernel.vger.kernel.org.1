Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73C92F820D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbhAORUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbhAORUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:20:10 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D8DC061796
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:12 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id n11so4426444wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ac9iKnNyoG+yHGcTDAMRhMwUzeXQu2/WPJbZdHzHiDM=;
        b=OAyogaLZUq5MdAiMQ7o6yYDrA4xFWT3n//pON1UcS/hSVpv0bPZGVr5NBg7ZTb4yO6
         Q80Ta+Re6sKynisYOvneXafA6KmueojgT1HmipWZVI/xy5JrRkwc6vI/K2bNA4fGsXzQ
         WLdpwCeoopBmdpGI5TAMS0hrNbHej7j7SweB583NzaooMOTNOWURPog3cFUxUztdNS1f
         gkjb9dYC85KgoaxaumXHIi1kzeGf98swUpoTsXI656EhGUHLtSnpbBgCNdXSHv3o1Jnk
         kIWddWa7f7LK4G00om+EmIdTn2mV3xrf9FpR4lvhLfiOM5kpNLhmIEkegfvDPX06Y13k
         L8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ac9iKnNyoG+yHGcTDAMRhMwUzeXQu2/WPJbZdHzHiDM=;
        b=SnRNkqLDmTJl8eBY4XE9TOVpq3145AJFPFLbE3VRTWx55QgrRt5ptsgVMS/EuCqSPr
         +VR6sULTJYEawwU4NkNiYoyDkJHW/KVk/ADPw4Sa9yFf4XbG7L79x+iEf5TaJnxy7ola
         r+LzrwAX7EVXPZNajlNsY83RE1KZ9a+7MpeE8L3ot8792eMTisR3keGffMkocP9PRR8Z
         Ubzd9EAYtzi+0Z//zASstLP5MHPjJKCchh32b5oSzQZe6k3Zn3tPYlPLERopWPNsjbwD
         B3ePqS4uMTqVTv+lqpRfdovbOGJbhz6ITIPjh3oLmhIAcJ6gxcciWqqGTcUNuCbX1A6X
         yyNw==
X-Gm-Message-State: AOAM532eTz9KDPvcxPdgr6MrN5L4lHJzUGSb77FS6UsfINI274rq8n59
        HY9sqpET7QE9P65ESbyAlDgF4VMiKEi0
X-Google-Smtp-Source: ABdhPJx8CnxfxMc88an10BfA7jJXL8kT9++eM18I3b0opJbatRfb/r4GrAI2JcUfytJA5JKRYuFonjSWiQc5
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a7b:c395:: with SMTP id
 s21mr7798201wmj.97.1610731151420; Fri, 15 Jan 2021 09:19:11 -0800 (PST)
Date:   Fri, 15 Jan 2021 17:18:28 +0000
In-Reply-To: <20210115171830.3602110-1-lenaptr@google.com>
Message-Id: <20210115171830.3602110-8-lenaptr@google.com>
Mime-Version: 1.0
References: <20210115171830.3602110-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 7/9] KVM: arm64: Detect type mismatch undefined behaviour
 from hyp/nVHE code
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

Type mismatch undefiend behaviour handler provides two handlers with two
data structures type_mismatch_data and type_mismatch_data_v1. Both can be
stored inside a common data structure: type_mismatch_data_common, which
differs of type_mismatch_data only by keeping a pointer to a
struct source_location.
In this way, the buffer keeps the data encapsulated inside of a struct
type_mismatch_data, because pointers from nVHE can not be passed to the
kernel.

Inside the kernel call the __ubsan_handle_type_mismatch_data with the
data from the buffer.

Signed-off-by: George Popescu <georgepope@google.com>
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/include/asm/kvm_ubsan.h |  6 ++++-
 arch/arm64/kvm/hyp/nvhe/ubsan.c    | 41 ++++++++++++++++++++++++++++--
 arch/arm64/kvm/kvm_ubsan_buffer.c  |  5 +++-
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
index 95ac6728ffd1..93c1b695097a 100644
--- a/arch/arm64/include/asm/kvm_ubsan.h
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -21,13 +21,15 @@ struct kvm_ubsan_info {
 		UBSAN_OUT_OF_BOUNDS,
 		UBSAN_UNREACHABLE_DATA,
 		UBSAN_SHIFT_OUT_OF_BOUNDS,
-		UBSAN_INVALID_DATA
+		UBSAN_INVALID_DATA,
+		UBSAN_TYPE_MISMATCH
 	} type;
 	union {
 		struct out_of_bounds_data out_of_bounds_data;
 		struct unreachable_data unreachable_data;
 		struct shift_out_of_bounds_data shift_out_of_bounds_data;
 		struct invalid_value_data invalid_value_data;
+		struct type_mismatch_data type_mismatch_data;
 	};
 	union {
 		struct ubsan_values u_val;
@@ -38,3 +40,5 @@ void __ubsan_handle_out_of_bounds(void *_data, void *index);
 void __ubsan_handle_builtin_unreachable(void *_data);
 void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
 void __ubsan_handle_load_invalid_value(void *_data, void *val);
+void __ubsan_handle_type_mismatch(struct type_mismatch_data  *_data, void *ptr);
+
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
index 3143f7722be2..a9f72d4bcab7 100644
--- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
@@ -29,6 +29,24 @@ static inline struct kvm_ubsan_info *kvm_ubsan_buffer_next_slot(void)
 	return res;
 }
 
+static void write_type_mismatch_data(struct type_mismatch_data_common *data, void *lval)
+{
+	struct kvm_ubsan_info *slot;
+	struct type_mismatch_data *aux_cont;
+
+	slot = kvm_ubsan_buffer_next_slot();
+	if (slot) {
+		slot->type = UBSAN_TYPE_MISMATCH;
+		aux_cont = &slot->type_mismatch_data;
+		aux_cont->location.file_name = data->location->file_name;
+		aux_cont->location.reported = data->location->reported;
+		aux_cont->type = data->type;
+		aux_cont->alignment = data->alignment;
+		aux_cont->type_check_kind = data->type_check_kind;
+		slot->u_val.lval = lval;
+	}
+}
+
 void __ubsan_handle_add_overflow(void *_data, void *lhs, void *rhs) {}
 
 void __ubsan_handle_sub_overflow(void *_data, void *lhs, void *rhs) {}
@@ -39,9 +57,28 @@ void __ubsan_handle_negate_overflow(void *_data, void *old_val) {}
 
 void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs) {}
 
-void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr) {}
+void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr)
+{
+	struct type_mismatch_data_common common_data = {
+		.location = &data->location,
+		.type = data->type,
+		.alignment = data->alignment,
+		.type_check_kind = data->type_check_kind
+	};
+	write_type_mismatch_data(&common_data, ptr);
+}
 
-void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr) {}
+void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr)
+{
+	struct type_mismatch_data_v1 *data = _data;
+	struct type_mismatch_data_common common_data = {
+		.location = &data->location,
+		.type = data->type,
+		.alignment = 1UL << data->log_alignment,
+		.type_check_kind = data->type_check_kind
+	};
+	write_type_mismatch_data(&common_data, ptr);
+}
 
 void __ubsan_handle_out_of_bounds(void *_data, void *index)
 {
diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
index 5439f7a91636..b7823dedf8b1 100644
--- a/arch/arm64/kvm/kvm_ubsan_buffer.c
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -35,6 +35,10 @@ void __kvm_check_ubsan_data(struct kvm_ubsan_info *slot)
 		__ubsan_handle_load_invalid_value(&slot->invalid_value_data,
 				slot->u_val.lval);
 		break;
+	case UBSAN_TYPE_MISMATCH:
+		__ubsan_handle_type_mismatch(&slot->type_mismatch_data,
+				slot->u_val.lval);
+		break;
     	}
 }
 
@@ -58,4 +62,3 @@ void __kvm_check_ubsan_buffer(void)
 	write_ind = (unsigned long *) this_cpu_ptr_nvhe_sym(kvm_ubsan_buff_wr_ind);
 	iterate_kvm_ubsan_buffer(0, *write_ind);
 }
-
-- 
2.30.0.296.g2bfb1c46d8-goog

