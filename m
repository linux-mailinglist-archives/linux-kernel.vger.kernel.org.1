Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B062269354
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgINRaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgINR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:28:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6BC06121E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:28:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so799926wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EjNih3r7ygkjYASNBWp7YtEX1KLL1OovUvtOR4yQ8E=;
        b=LDOJW73/Nx4NRSF62nukRv0fkeOiLGfPXVP1aJhDKCMUKmk3HmHAf6NWlyYj1Fc30H
         4ctb86ijJJ+PMUx7pA1+2eEIf+G0cmjOvbtE9oBe55C3Cvn1qkgI3USj0yAzKEsPU9q0
         Kg6zWbX13Nvf35fM5FUm0vCKYp5AV89AlTGoxiq/9SNtkV9H5JeJZSjohjU7p9UCPTCc
         AFzF0SLwziqh80xl5uTlhqNQPcFqdMho3+ObPMEgdgw7XZugj3HlUg9gMeuZ9Wl5vn3G
         sEIZ2338YOSdEnkx35Dj1zujfiD6uqhHIIRpeBrFBUJeHIahNLU31ZLtfIcNVZWFj6tG
         ir0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EjNih3r7ygkjYASNBWp7YtEX1KLL1OovUvtOR4yQ8E=;
        b=ssyEu3icJ+EHCDglqRYEsKgZCgTm65xCa2XMPSNOYcDNkbmIOq+CJb16nn/VNolx4y
         ACdAGUMJEghELCBK8OLVXCIOZgRZ65O/Q65m52wIZMAr2Cyfil6e42CK3x8F1b24MgnH
         UC5k6nmI4RLg3mT+PZ+pow65qER1/aof8CvqGDYbsCRjyNgecEsbkkUbcXfMjUchFpDq
         SPaqEYxMHtxw17QzRaw5Kc1qoOWGk5UMIuhW6ru2TU/MTnoP7Lb+DEblyv6obZ09OnGV
         BdfbDFmTVWL33GdRwlnxLDWRBFD/XYRk8JSkPJXd7TpKN2lOZWyA3Y67V+h5djOaTnnr
         VmlQ==
X-Gm-Message-State: AOAM5303nkB/OEJqB0PvYTNb/qgmARG1QZoKJEpzYJxQFhokihObR7rp
        ATk1Lukdt/W+XLGA8zl5NpjkxA==
X-Google-Smtp-Source: ABdhPJz7n/8ZzKopjoksEbonJHe8/t/B9RylxHy4LiUHqu75FJ9ZhVdcDVjP7yVogd6IknutagEtqw==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr486952wme.4.1600104497464;
        Mon, 14 Sep 2020 10:28:17 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id a17sm22898300wra.24.2020.09.14.10.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 10:28:16 -0700 (PDT)
From:   George-Aurelian Popescu <georgepope@google.com>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        dbrazdil@google.com, broonie@kernel.org, maskray@google.com,
        ascull@google.com, keescook@chromium.org,
        akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        tglx@linutronix.de, arnd@arndb.de,
        George Popescu <georgepope@google.com>
Subject: [PATCH 08/14] KVM: arm64: Enable UBsan check for unreachable code inside hyp/nVHE code
Date:   Mon, 14 Sep 2020 17:27:44 +0000
Message-Id: <20200914172750.852684-9-georgepope@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200914172750.852684-1-georgepope@google.com>
References: <20200914172750.852684-1-georgepope@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Popescu <georgepope@google.com>

The data from __ubsan_handle_builtin_unreachable is passed to the buffer
and printed inside the kernel by its symmetric handler.

Signed-off-by: George Popescu <georgepope@google.com>
---
 arch/arm64/include/asm/kvm_ubsan.h |  5 ++++-
 arch/arm64/kvm/hyp/nvhe/ubsan.c    | 12 +++++++++++-
 arch/arm64/kvm/kvm_ubsan_buffer.c  |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
index 575881e0bd5f..7fd0d0dfbd82 100644
--- a/arch/arm64/include/asm/kvm_ubsan.h
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -20,10 +20,12 @@ struct ubsan_values {
 struct kvm_ubsan_info {
 	enum {
 		UBSAN_NONE,
-		UBSAN_OUT_OF_BOUNDS
+		UBSAN_OUT_OF_BOUNDS,
+		UBSAN_UNREACHABLE_DATA
 	} type;
 	union {
 		struct out_of_bounds_data out_of_bounds_data;
+		struct unreachable_data unreachable_data;
 	};
 	union {
 		struct ubsan_values u_val;
@@ -32,3 +34,4 @@ struct kvm_ubsan_info {
 #endif
 
 void __ubsan_handle_out_of_bounds(void *_data, void *index);
+void __ubsan_handle_builtin_unreachable(void *_data);
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
index b2d3404f6215..9497e7f7f397 100644
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
index ce796bdd027e..f66cc5f7878e 100644
--- a/arch/arm64/kvm/kvm_ubsan_buffer.c
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -25,6 +25,9 @@ void __kvm_check_ubsan_data(struct kvm_ubsan_info *slot)
 		__ubsan_handle_out_of_bounds(&slot->out_of_bounds_data,
 				slot->u_val.lval);
 		break;
+	case UBSAN_UNREACHABLE_DATA:
+		__ubsan_handle_builtin_unreachable(&slot->unreachable_data);
+		break;
 	}
 }
 
-- 
2.28.0.618.gf4bc123cb7-goog

