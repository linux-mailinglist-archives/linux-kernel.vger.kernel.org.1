Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0896A2F8209
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbhAORTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbhAORTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:19:41 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82ADC061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:00 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id c83so8627169qkg.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VLLmnZ0Ac3m76z32lc7f4mhhOZikEiI3As160KoTLrU=;
        b=egSS6f+/ZiSYDrYEqcmLy80yB2G8pLh4/46w4bOcE9bAiACETRhrIOb9DHjpvEIVRC
         /PgKrFttwj0MMDdD5zOroWcM10AEnpHSh4bCQdjiPpZNljcUGkNfLJRvgUCW/z/yGQfN
         LnctQtGQmXmFh4qFP8c74u0vAbaWhzKuG3qTIL0jDn8XsP/f1xVmGf2wfipFy0xdD1a5
         6PsIwBV/6iCT6SuAY28J4lBPpO182IzI3Mhs0PwRRVnv53i45BbGMWwOVIb6W+dV/wtZ
         ZRYUwJGEFaLcB/qIU7O2/lXdYU4SRAXB0q5fCJNRSpnp5nw0eVPUwCE/IrGeHwWLtMxi
         PtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VLLmnZ0Ac3m76z32lc7f4mhhOZikEiI3As160KoTLrU=;
        b=DjI4nl40Z6LVhOop5wAisaxXN9+kyE7MLuZ4+UMnF35AoPJrEQQl5cODsZK8a9QfuZ
         A3/CHGTwcPJM/tPAdGRvo6mj9Cxyac112cXlledSj38U6ihBWtWkqwOTySLCP7t5FM24
         ydE9V8mmrk6VcpHa2jcokPtafFYcDpdzKrG/GXYBPedsvr2Q+ZED8f0uGa6en9SFBHlX
         QzYWmAIvNaQddscguZ5lX1NE+HogPu+Y4izULBHbnm0IupI/ZRWAKgaV+sNxRZAF7jKL
         2lgNSf3tQocOddIJ65BTDviLnAA0LHM+QAQzQ0X/JU3HRckkdCXY1tQQ3QlsSgYy8ZMn
         Bv6A==
X-Gm-Message-State: AOAM532FOTYKrkrdL6l3Y8jU37//kJatq5w2OhT3SGrS7PBBk1nlLsZg
        hN5nNWYmnJchzH9fGQ9HJjS6JqO2Re0v
X-Google-Smtp-Source: ABdhPJyX2gz/c3WBh1CNS135ZWzqDcKoMX6gQYN7QuSu6bRWqRPWCQ+Yg2fsS5KxlhOHepRi0Xak+17hYmtT
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a05:6214:a94:: with SMTP id
 ev20mr13079298qvb.56.1610731139913; Fri, 15 Jan 2021 09:18:59 -0800 (PST)
Date:   Fri, 15 Jan 2021 17:18:25 +0000
In-Reply-To: <20210115171830.3602110-1-lenaptr@google.com>
Message-Id: <20210115171830.3602110-5-lenaptr@google.com>
Mime-Version: 1.0
References: <20210115171830.3602110-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 4/9] KVM: arm64: Enable UBsan check for unreachable code
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
2.30.0.296.g2bfb1c46d8-goog

