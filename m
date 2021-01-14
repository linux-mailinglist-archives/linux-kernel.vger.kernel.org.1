Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F762F6787
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbhANRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbhANRZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:25:28 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7511C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:47 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id n13so5337968qkn.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1t4C6hJFamqbU7IDZaNfsvQVRkq+UVj+9twweJKBJmo=;
        b=bgfP8TgGrR3VBTfxn+pa3clqnf63XhBOsKIAki5GvZtlng2M161ujzp0pHbfhNNyjA
         xeiHwor4Pa7gtipfBdE2Xyw/5O3eTY+OrxtneNgiJWqrYMcs15pI7YZG12eJ+rTMAErL
         3Buf0e0EVzM/0LSP2MFNkc7g6gjFzPDvNTC2STUIooq3kiYEdnpDZJ/3laERZt1iNbBI
         1tjPQh1z+Tuqm5U9LlSnsi5JmCMZ17HTjOv6SGFcezW3O0asUYa18Z6WBxNxDWSpAnCU
         r62U7YSF4uCCVywsYFoM8bS070r7O0OdSpmHLfOsoJYJBwviRB6b1PoU0WuS26CQ5Wa4
         24YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1t4C6hJFamqbU7IDZaNfsvQVRkq+UVj+9twweJKBJmo=;
        b=pADU7ijE5iRaPb5XOSR0MebU0DVXRAxpvX5vCztm6pX/99jt6dA7FS8fy61J4W77QW
         EJC4MO6z7klp7NYxJwXlRW7PDrmGWRRhhak/D0DnPryOtyccPTd1XZyckAe5nYccepTj
         BGR7jaOkqni6fdGNj8JlARGHr3uWYC1YrTuGljqqwBJ2HHJcgLLx9hoiY2Zrvmcv3jGa
         2QRywsxNIltlEAByRRdVpSbtqPCdWxrxqxBnB6pZkJp2Vyk7Sif8S0mW/7bm7sUWRgtw
         nSgx3efjb681BX/dY48gxlIlJrWTVMKrBvGkcXss75KMpabhUPRjgrAXe/rqccQvr8Yb
         fK0g==
X-Gm-Message-State: AOAM5301kipEkjh2NiZf+e7KRfC35JhJXC5blYjCSc9y6PV3rwQIfHqZ
        VI0PqxoHhxaLLt2y0EhlJSWG/2E2GCK/
X-Google-Smtp-Source: ABdhPJyKfgLbpjRvxXH6s/OOkKAxjero/ui32HTdz9vnKOUUCIQ3+JwR/2tIRrkt6fOKe+/IuePNCZ4vImcm
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a0c:e90a:: with SMTP id
 a10mr8225156qvo.38.1610645087031; Thu, 14 Jan 2021 09:24:47 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:34 +0000
In-Reply-To: <20210114172338.2798389-1-lenaptr@google.com>
Message-Id: <20210114172338.2798389-5-lenaptr@google.com>
Mime-Version: 1.0
References: <20210114172338.2798389-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 4/9] KVM: arm64: Enable UBsan check for unreachable code
 inside hyp/nVHE code
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

The data from __ubsan_handle_builtin_unreachable is passed to the buffer
and printed inside the kernel by its simetric handler.

Signed-off-by: George Popescu <georgepope@google.com>
Change-Id: I71d789b7f4ec3d4c787012a061b7f5d7952cee19
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/include/asm/kvm_ubsan.h |  3 +++
 arch/arm64/kvm/hyp/nvhe/ubsan.c    | 12 +++++++++++-
 arch/arm64/kvm/kvm_ubsan_buffer.c  |  3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
index 4f471acb88b0..70c6f2541d07 100644
--- a/arch/arm64/include/asm/kvm_ubsan.h
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -19,9 +19,11 @@ struct ubsan_values {
 struct kvm_ubsan_info {
 	enum {
 		UBSAN_OUT_OF_BOUNDS,
+		UBSAN_UNREACHABLE_DATA
 	} type;
 	union {
 		struct out_of_bounds_data out_of_bounds_data;
+		struct unreachable_data unreachable_data;
 	};
 	union {
 		struct ubsan_values u_val;
@@ -29,3 +31,4 @@ struct kvm_ubsan_info {
 };
 
 void __ubsan_handle_out_of_bounds(void *_data, void *index);
+void __ubsan_handle_builtin_unreachable(void *_data);
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
index 55a8f6db8555..5e55897b2d72 100644
--- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
@@ -58,6 +58,16 @@ void __ubsan_handle_out_of_bounds(void *_data, void *index)
 
 void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs) {}
 
-void __ubsan_handle_builtin_unreachable(void *_data) {}
+void __ubsan_handle_builtin_unreachable(void *_data)
+{
+	struct kvm_ubsan_info *slot;
+	struct unreachable_data *data = _data;
+
+	slot = kvm_ubsan_buffer_next_slot();
+	if (slot) {
+		slot->type = UBSAN_UNREACHABLE_DATA;
+		slot->unreachable_data = *data;
+	}
+}
 
 void __ubsan_handle_load_invalid_value(void *_data, void *val) {}
diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
index a1523f86be3c..e51949c275aa 100644
--- a/arch/arm64/kvm/kvm_ubsan_buffer.c
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -24,6 +24,9 @@ void __kvm_check_ubsan_data(struct kvm_ubsan_info *slot)
 		__ubsan_handle_out_of_bounds(&slot->out_of_bounds_data,
 				slot->u_val.lval);
 		break;
+	case UBSAN_UNREACHABLE_DATA:
+		__ubsan_handle_builtin_unreachable(&slot->unreachable_data);
+		break;
 	}
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

