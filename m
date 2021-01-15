Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E987E2F820B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbhAORUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbhAORUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:20:06 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440ACC061798
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:10 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id i13so8269622qvx.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wIND0+cbxytiLi3TnPdU2y1dHj/fBtnQl0WZoWO1f3g=;
        b=iHwsC+akDTq/2izyfNfOh1mU4qeWdID+7XlRvI35seFl8BcVTWfx/aYX6KGgmYx4gm
         nemwGN0YAtiLxNca5Pah/pRIobzlTYHohJdqOHFZSuDTAN0HlibzCwDjaeY5UaVR3wKD
         yYQVD1ZTbEEsZVfEFwQfUqlIPV8RSbFp3u+G3YHrrOUXDmlbhMZPXGM/WPvJ70UPskaz
         OC1lWKa0J5wDu5N9gpIf1qGsJnTNl+AbVHva8vHJynBcAQPu6YDKyeOsdLyBa1n+GY4D
         t2uagGsIxrG+2prq9ENs/kMJ2pMUBIFg3hBWWQTd2h/3hHInUH30Y2BxUxo+//q9w44h
         MD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wIND0+cbxytiLi3TnPdU2y1dHj/fBtnQl0WZoWO1f3g=;
        b=cS9M1b4HkdpNUBbjKeJo06I7ACbulpq2cLT39pK8A0Mda40eTpqEiYb0LtXL9tMBUW
         DS4cOp0hySAsFjtBq/bANiItn9CWe0RZzuMUNvBuw+on78O3cr5WU3vUatz1fI2aMxJL
         ZVkvUNWvG0PlWFtNRbYmbaevuKPQP7TUl27FtjESN18gIz3WCDTULpsTheAb9vphaF+Q
         6hxmlM9Dn+b89Su036zTdTDtLeM76Hz3IlnOPkJ1doUjq2yPvYsVY0+6l4nvP2OjGk2w
         FVXQLmUDK1wtt3Az69119u6lEKgFZZ46wGza9wh+sRZyFy48QlIZe/I4rlwDe2IN/4DU
         mEAw==
X-Gm-Message-State: AOAM531294jBszXrG6MSahI387iKPSfnwOIV0EaZ8FF8wDKobiUXk5Kf
        kRXDWPiDNf/J413Bi7FW+W42cwtddcRv
X-Google-Smtp-Source: ABdhPJwoIqBmsZNjVlpKeTgLS1FR734TbBWA8MBe6gEFE2giI4dUNxyRBYn+N6v78Z3Uq8/6D05NfIKeh490
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a0c:f185:: with SMTP id
 m5mr13304807qvl.19.1610731149343; Fri, 15 Jan 2021 09:19:09 -0800 (PST)
Date:   Fri, 15 Jan 2021 17:18:27 +0000
In-Reply-To: <20210115171830.3602110-1-lenaptr@google.com>
Message-Id: <20210115171830.3602110-7-lenaptr@google.com>
Mime-Version: 1.0
References: <20210115171830.3602110-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 6/9] KVM: arm64: __ubsan_handle_load_invalid_value EL2 implementation.
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
2.30.0.296.g2bfb1c46d8-goog

