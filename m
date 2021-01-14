Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E52F678B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbhANRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:25:36 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795C5C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:55 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id o17so2899678wra.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mBnNW8oub18hKhhe8yHqfoSEZU2iRCB395w7gjgwxWc=;
        b=YyThgL189juUYY1QafUrt/nr4mL1Dlewr+4os9Exz6q+m6zwQXnoNIhxbHXPalrLo3
         rT8BweykI8RXTWknugQU6KAjnTbwTL5UC5KFh1fQWQXdH41NrYXFexJt5/aptCnupsFC
         0d1H6PKi/v1QEYbt0efPZVVZD5cgvjLF83q3cN7iaf2PLa7zmhtCGfTdNqioLq6dWhRd
         DPThFVt8UzRBUnyK/afuRop1dx5ZpmVKxLe29q8bs4SAmFaQR5aNAdvHzAeCXBAWn1d4
         pqMd0rSFv2FKBgy8quIF4elmlwiDGceTp7vVFHE3FNNBk8B0YjV19JXoNZ096PTB1a18
         UH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mBnNW8oub18hKhhe8yHqfoSEZU2iRCB395w7gjgwxWc=;
        b=BoyiVuLaZHc6hSomMH9JfBN/vjgytbazyW5j8EFZsGj5uXBPmxYgps9YZ8ZqAe6/dd
         hn3729QLD+kxxlTh7uFLxMCMf8qNeBTQZr6P6fWEIOgIg+3U3FkhSHDGYyVVEs1dFi6e
         Um3M79nMuGaSKtz8WgZ1zpDlGvHbzQFBS4eQrAgwjlDX6YbHO0Awzp3zFmJyCSVZ/5ZS
         ZrwPCue2N+azweOrpeNUENKOhNicxVWZKkkDJGE/tksfELbWb7Oz1nBsZKjcHz/knvpe
         AMWGeMMucMEkTY8XHj3MUCeUQxZVc26TyxQWyH5HdtzS0lSSz9iPV9CRt5wVufaH0VTS
         ctBA==
X-Gm-Message-State: AOAM533DKIh3qyNOoovedzhANo5yshWsAinyecH02uakIrkJHRYeMgw9
        yNcWxP/idYiS0lgUopZUUKN76/0he45G
X-Google-Smtp-Source: ABdhPJwgNb+fXta79qoc3ofmUnstDxPUmBtXRsFXZPs561fwW9D9l7EWAZMF5Ae/x9bNaAM6+JkZbZCSBJbJ
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a1c:2c89:: with SMTP id
 s131mr533256wms.0.1610645093881; Thu, 14 Jan 2021 09:24:53 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:36 +0000
In-Reply-To: <20210114172338.2798389-1-lenaptr@google.com>
Message-Id: <20210114172338.2798389-7-lenaptr@google.com>
Mime-Version: 1.0
References: <20210114172338.2798389-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 6/9] KVM: arm64: __ubsan_handle_load_invalid_value EL2 implementation.
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

The handler for the load invalid value undefined behaviour is
implemented at EL2. The EL2 handler's parameters are stored inside the buffer.
They are used by the symetric handler from EL1.

Signed-off-by: George Popescu <georgepope@google.com>
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/include/asm/kvm_ubsan.h |  5 ++++-
 arch/arm64/kvm/hyp/nvhe/ubsan.c    | 14 +++++++++++++-
 arch/arm64/kvm/kvm_ubsan_buffer.c  |  6 +++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
index 0eef0e11a93b..95ac6728ffd1 100644
--- a/arch/arm64/include/asm/kvm_ubsan.h
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -20,12 +20,14 @@ struct kvm_ubsan_info {
 	enum {
 		UBSAN_OUT_OF_BOUNDS,
 		UBSAN_UNREACHABLE_DATA,
-		UBSAN_SHIFT_OUT_OF_BOUNDS
+		UBSAN_SHIFT_OUT_OF_BOUNDS,
+		UBSAN_INVALID_DATA
 	} type;
 	union {
 		struct out_of_bounds_data out_of_bounds_data;
 		struct unreachable_data unreachable_data;
 		struct shift_out_of_bounds_data shift_out_of_bounds_data;
+		struct invalid_value_data invalid_value_data;
 	};
 	union {
 		struct ubsan_values u_val;
@@ -35,3 +37,4 @@ struct kvm_ubsan_info {
 void __ubsan_handle_out_of_bounds(void *_data, void *index);
 void __ubsan_handle_builtin_unreachable(void *_data);
 void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
+void __ubsan_handle_load_invalid_value(void *_data, void *val);
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
index 1069ed5036d5..3143f7722be2 100644
--- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
@@ -82,4 +82,16 @@ void __ubsan_handle_builtin_unreachable(void *_data)
 	}
 }
 
-void __ubsan_handle_load_invalid_value(void *_data, void *val) {}
+void __ubsan_handle_load_invalid_value(void *_data, void *val)
+{
+	struct kvm_ubsan_info *slot;
+	struct invalid_value_data *data = _data;
+
+	slot = kvm_ubsan_buffer_next_slot();
+	if (slot) {
+		slot->type = UBSAN_INVALID_DATA;
+		slot->invalid_value_data = *data;
+		slot->u_val.lval = val;
+	}
+
+}
diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
index b80045883047..5439f7a91636 100644
--- a/arch/arm64/kvm/kvm_ubsan_buffer.c
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -31,7 +31,11 @@ void __kvm_check_ubsan_data(struct kvm_ubsan_info *slot)
         	__ubsan_handle_shift_out_of_bounds(&slot->shift_out_of_bounds_data,
 				slot->u_val.lval, slot->u_val.rval);
 		break;
-	}
+	case UBSAN_INVALID_DATA:
+		__ubsan_handle_load_invalid_value(&slot->invalid_value_data,
+				slot->u_val.lval);
+		break;
+    	}
 }
 
 void iterate_kvm_ubsan_buffer(unsigned long left, unsigned long right)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

