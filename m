Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA72D2D44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgLHOdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgLHOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:33:35 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:32:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t16so1145415wra.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhwBnGH/U8Xqw28a+YdxdYYHy57oO21DeTW4Enf63Uw=;
        b=lRZz4RbsIt4fuy9Ur8pDp8z200Zy/sUksg2tsbV8Tqj3DYjRArrUidclWk8POzjSnb
         U1wxN4637eCzRvJBWP2kQhfGRDuRF9ER/k7UZlLSSdui4zN3hfGcwYXbT/nGtAUImUr7
         USxfwW+8GXMGlqnGTHWwdYRnOZTZ6tjpmNNePuHMEftY/EUsGFXwJUj8ucLBVg0XL+wN
         0+FARj7duaovx+DWp8RNHKlRAn3Oz0cDSegO+H0FzAOC0Eetas/7X53PLW2an/Kackm/
         8IP/OOur3rUgeNlVAVL8HbozvwU0RwQV5qgYKSoQ1oQFP0yj3AHLK7BZT2BaKWbO/SNk
         OqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhwBnGH/U8Xqw28a+YdxdYYHy57oO21DeTW4Enf63Uw=;
        b=IZIUS2O80DYYPV3sQ8EGVR0o05y2/yeCS87ykPeJMJMmuCOJgsiL4J/zCaSGC5J50o
         acCK5Nf8OK2lUNgpaPV9JkuiJjmNc5fAyGfX0Q0cSNF/VEJKFQf0WHuznjO7cao2bjSC
         Wn6hjbIOt2PHVP1bTsp34V0BRZiy2CgE6mCQVnrZBe7cK+SK5EWjLvEAQ6zjEpcayYeF
         FNcXB2uD4gVvZAyhVQiv3Xip5Fuy764vzqk/jIrUrGcIXpGrM0YvArRPWV22FBRKMOOv
         dp6SUV6u/0TtQnoMsajZ8Eqym1px9Srhj/eVckJeaZDw52BRUaOdK3qlaZFlq4ZssoBy
         Blqg==
X-Gm-Message-State: AOAM533k5ZwyCWlf2y4nV1jP6FGTx9P2mTg8OKnsTRbW3ok88PCeNgJj
        qcTP37R6ObC0HgrugXGmlufhubVLOSnyBQ==
X-Google-Smtp-Source: ABdhPJwIc5kylMIuDFq9ZYONlAB6VjiAUSMzZXmTAnNv/IwaI5Ky33Y71CefkSvTy38yNymoNNLKrg==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr8886153wrs.379.1607437973309;
        Tue, 08 Dec 2020 06:32:53 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g192sm4030847wme.48.2020.12.08.06.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 06:32:52 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH] ARM: Kconfig: Select ARCH_HAVE_NMI_SAFE_CMPXCHG where possible
Date:   Tue,  8 Dec 2020 14:32:39 +0000
Message-Id: <20201208143239.1129168-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ARCH_HAVE_NMI_SAFE_CMPXCHG is not set on Arm systems and this
makes it impossible to enable features such as ftrace histogram triggers
on Arm platforms.

Most Arm systems are NMI safe simply because there is no NMI but this isn't
universally true meaning we cannot set ARCH_HAVE_NMI_SAFE_CMPXCHG for all
Arm devices. However the load/store exclusive implementation of cmpxchg is
NMI-safe and this implementation is used ARMv6k and later. Let's select
ARCH_HAVE_NMI_SAFE_CMPXCHG for these systems.

Note that ARMv6 uses load/store exclusive for 32-bit cmpxchg but relies on
interrupt masking for 8- and 16-bit operations. This patch is conservative
and does not change behaviour for CPU_V6.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 002e0cf025f59..fd434c5958b62 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,6 +24,7 @@ config ARM
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK if HAVE_ARCH_PFN_VALID || KEXEC
 	select ARCH_MIGHT_HAVE_PC_PARPORT

base-commit: 0477e92881850d44910a7e94fc2c46f96faa131f
--
2.28.0

