Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D032FD6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404131AbhATRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404205AbhATRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611163075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fd3SneEs7LAJ1uccBAB3yP/7OE/eohRmcIK76GMHPPY=;
        b=TpUIKXFcQWZbionqYxV/c0kipvrNpuGYdA+6L8fHqkMJB+Q+WbyBKeKTcYVb9vE+vnqP0G
        o/RHXx7Sx5lfF1XqRqGThqPLTJT/hbHEV1ZXI5EZJcwjOPmNTzWTZmvZAGxJMyR2sjTsfF
        TQTWpcOWhQWB7uzU8e7qlIpF4yORFsk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-DzZhGQzPP-iWy_X3eemR_g-1; Wed, 20 Jan 2021 12:17:53 -0500
X-MC-Unique: DzZhGQzPP-iWy_X3eemR_g-1
Received: by mail-wr1-f69.google.com with SMTP id v7so11850563wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fd3SneEs7LAJ1uccBAB3yP/7OE/eohRmcIK76GMHPPY=;
        b=XvygjozfM7rjhA84G/D0jEDflb/55LkWWtZHWy/Qjr/hCv/exlN05Bk0nUAFH42gGc
         /HSs8pAJj0QjtAopbfvgwrV9cfOpRCVmEL6Zp+dqBkGpHYTcDGOQDQ9wZqGBIfo/m9b2
         U1HjWyrlrYiwJqCcvBiD0VkW/1H0bOxcZ8Su+IILNagSTFATnBP1EnciHRhNTWCfl3if
         Q/HMQRzv77ETqwyxvni0ieDJBgWGF2oGc+uMUwdNBQDse8Z/xGhmOUtblxH/81KSVW8V
         eXc0vvjTNGV8esSXlCEnfr4quhal2VeA5UkxYCzSgI9AgKMtB5UKBVoYWBUC6WKDN80P
         jIPA==
X-Gm-Message-State: AOAM533QsjFEd1cBgJHwhkrNPA/2+HZ3dpAKjhpRC4OaAxEXKguvRxoN
        i+6Bm0s8lLdlRoLMH1+LF/r7AD7Hxt/ro55KozUfh4SQygULo4B/R98Dnb/B4QkAOlnXYaf6TGD
        eOBWOnoB5paIOb3sl9x2Bf/AKbtfdejmoGZos9LC1SKFWylANp9JpPvhXIjzxWKplcjFaUinvK2
        +2
X-Received: by 2002:adf:df06:: with SMTP id y6mr10383137wrl.241.1611163072509;
        Wed, 20 Jan 2021 09:17:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeuYEC/fsaR3mx2YNIF8bssLZt2TpKGMHbhFlyb6NHHt6LAR5+Rk9Oh83U0NusT4UYuabgLQ==
X-Received: by 2002:adf:df06:: with SMTP id y6mr10383126wrl.241.1611163072382;
        Wed, 20 Jan 2021 09:17:52 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o124sm5444077wmb.5.2021.01.20.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:17:51 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 2/5] arm64: aarch64-insn: Add SVE instruction class
Date:   Wed, 20 Jan 2021 18:17:42 +0100
Message-Id: <20210120171745.1657762-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120171745.1657762-1-jthierry@redhat.com>
References: <20210120171745.1657762-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SVE has been public for some time now. Let the decoder acknowledge
its existence.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/aarch64-insn.h | 1 +
 arch/arm64/lib/aarch64-insn.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/aarch64-insn.h b/arch/arm64/include/asm/aarch64-insn.h
index cead3be1a2d0..200bee726172 100644
--- a/arch/arm64/include/asm/aarch64-insn.h
+++ b/arch/arm64/include/asm/aarch64-insn.h
@@ -40,6 +40,7 @@
  */
 enum aarch64_insn_encoding_class {
 	AARCH64_INSN_CLS_UNKNOWN,	/* UNALLOCATED */
+	AARCH64_INSN_CLS_SVE,		/* SVE instructions */
 	AARCH64_INSN_CLS_DP_IMM,	/* Data processing - immediate */
 	AARCH64_INSN_CLS_DP_REG,	/* Data processing - register */
 	AARCH64_INSN_CLS_DP_FPSIMD,	/* Data processing - SIMD and FP */
diff --git a/arch/arm64/lib/aarch64-insn.c b/arch/arm64/lib/aarch64-insn.c
index df233a7790dc..95d9143aa9c6 100644
--- a/arch/arm64/lib/aarch64-insn.c
+++ b/arch/arm64/lib/aarch64-insn.c
@@ -17,7 +17,7 @@
 static const int aarch64_insn_encoding_class[] = {
 	AARCH64_INSN_CLS_UNKNOWN,
 	AARCH64_INSN_CLS_UNKNOWN,
-	AARCH64_INSN_CLS_UNKNOWN,
+	AARCH64_INSN_CLS_SVE,
 	AARCH64_INSN_CLS_UNKNOWN,
 	AARCH64_INSN_CLS_LDST,
 	AARCH64_INSN_CLS_DP_REG,
-- 
2.25.4

