Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776712C48CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgKYT6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbgKYT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:58:30 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68683C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:58:20 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so3318164pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=A6GqFZlfnfwQpVbBwycgYvuUf87ws0MJU+ShxbokfgI=;
        b=NGEK7Rhc1Uf2RIGyMm824jQ5Cq1mA6jJb1MR4xXvdz3pal6VBHxdSpy6MROb8D4JcY
         kXvrLYN+DGUryRZsH7REq2rNe4QC3tFjXhq2w0OhkHB2tzARQkGKv9/zks3JILAwZbam
         ziuLBVCnnlWm5dTClDgppeTTZvZaOt3devMd0NabDIaqEiBqrFJN8r+mIEvFpanPBci6
         9IYnmio8Z7/DQ+G6lk02BK3Nls+lDmisOcHXzJfDj5brKcN9E98UP4SD13WnJGatGWAs
         7gm7GxeU5g0EmDqj7E2JrF630JWd67rKeOKzuPjnyqjGYCLj6d277kIv2lKygnQt6pn9
         OGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=A6GqFZlfnfwQpVbBwycgYvuUf87ws0MJU+ShxbokfgI=;
        b=rsqc72Dabo3YLDoHPLCUro6SHyG9gOQmC2Jr153o0AWUJIyRGUOH83biGEjohtXghT
         VC3uEfVjWyBTzGMN7hduxzMti2fFVvHiq2/+Jv0wPj9aApbxvChp/Bz0A40ZU7gk3PeF
         qwsGO2rLtDc1mcGahbKSB3RlLRvOePTrEW8z8nq73+KFoa6fBk9UsgS15ptuAPUECBdO
         2Br5kHZoZ71GjkIGDjST+nL0YEKS/mCZ9n+GlteZmqDSyQ5QVHv5325KP0TWBFxLQfAe
         HqnMp5d0VkMBtNgY7GVOZ6zDVwwsfSDmzHMM6a2XLJwHBkarCgSF+tjFub1Pn9mMGFXJ
         GV2g==
X-Gm-Message-State: AOAM532VFb/SrJSJBXrPsor/zaBSVvFzCBtDbZ+N8+E8dzu5F5TE31CW
        R4xpWId8GY2GjCEOx8Z8fXo4BQ==
X-Google-Smtp-Source: ABdhPJzp7Nvm7GiqyReS6Ir0Kb9GhSUuI4szAqtmh5rAnCAosX9h80Xbk6PWFsM4IhaPudbij/bRgw==
X-Received: by 2002:a17:90a:f195:: with SMTP id bv21mr5733533pjb.63.1606334299933;
        Wed, 25 Nov 2020 11:58:19 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r15sm3844651pjp.51.2020.11.25.11.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:58:19 -0800 (PST)
Subject: [PATCH] RISC-V: Define get_cycles64() regardless of M-mode
Date:   Wed, 25 Nov 2020 11:57:03 -0800
Message-Id: <20201125195703.3780383-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, daniel.lezcano@linaro.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

The timer driver uses get_cycles64() unconditionally to obtain the current
time.  A recent refactoring lost the common definition for some configs, which
is now the only one we need.

Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation for M-mode systems")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/timex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index ab104905d4db..81de51e6aa32 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -60,6 +60,8 @@ static inline u32 get_cycles_hi(void)
 }
 #define get_cycles_hi get_cycles_hi
 
+#endif /* !CONFIG_RISCV_M_MODE */
+
 #ifdef CONFIG_64BIT
 static inline u64 get_cycles64(void)
 {
@@ -79,8 +81,6 @@ static inline u64 get_cycles64(void)
 }
 #endif /* CONFIG_64BIT */
 
-#endif /* !CONFIG_RISCV_M_MODE */
-
 #define ARCH_HAS_READ_CURRENT_TIMER
 static inline int read_current_timer(unsigned long *timer_val)
 {
-- 
2.29.2.454.gaff20da3a2-goog

