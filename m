Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6511E2C58B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391387AbgKZPyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391361AbgKZPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:36 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF5C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:36 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so2857072wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHdsvDKCV+y2T0WHPFGAdN0qhY1OjBTJULnU1VX59iA=;
        b=OchURbw1mLwFNtApGpEjM6AKBpDfQt9A0SnaSO/IvElpZFNXclLui4HRql7+PGhPzu
         w04fOAsLJg76P6WZjX/BoPa8t98z/zCXTtsh3+9RM29/ABXswF3vZehbRj8WIt/AgLtP
         L1k4SXy6vkelZAc1vVbqeOd+r1oeZei7wOPlFer6IGR4IFM5MXaOg8/8g9/rQhagB3ka
         dpXN3Srhy8SuzemOK5jvdLk4cjfBovVom/uweowmjaI38hHlgTpMbjl2MDXmVHPXSN/S
         fbBM51yzh1M2Eluao4XM9cf6bSCqn1yHyxPe1V86PBl5py1rObz13Ko5gXZLpnmXc+U2
         2dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHdsvDKCV+y2T0WHPFGAdN0qhY1OjBTJULnU1VX59iA=;
        b=OAdrhin4waPdSBZwPgfesRxZfifJS9wIF71PCa6wiJEroZfrtNUFilWAuLOLuYAv9v
         KvoPa/02Q0PWH/QCPfKP9amvAPYHM/5/D+w8hf6WxsGdW5jKORQ7ie7NJFpa4CDnxFkx
         4FgI9AzrodljV/UPSY94xT3XtRNWKKg/Fx8OKZTOV8aHfWuVyCHP0mmEouwZjv564++t
         2Bfk04u6qPOpHMAp3UV8R3cWUy8rYhOzXnH9C3XZFQdfGE62V49ul+tQWev+A4h1X/cw
         DLolYg2zOf/I/L+TfzsXnN1QtzEorRAQjs1iU5MZ+59kOqGnOqjdSvjf1OwMrOA1WSar
         ZsUw==
X-Gm-Message-State: AOAM532CWevln3d2oSDNxapPvP1Tbox+r7P6xnINK4my4k40VNwul0VO
        iRGOX0k5Dpb85ah9dkDHAtiz8g==
X-Google-Smtp-Source: ABdhPJxLdnrPvl0zzUmNu9CSpqRHeZvuF+rg/YRWgtrj7i//XJcOslWwSsG2VuZ6GKRjiQHqNZNJ7A==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr4021372wmj.23.1606406075145;
        Thu, 26 Nov 2020 07:54:35 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id a144sm9761056wmd.47.2020.11.26.07.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:34 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 04/23] arm64: Move MAIR_EL1_SET to asm/memory.h
Date:   Thu, 26 Nov 2020 15:54:02 +0000
Message-Id: <20201126155421.14901-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM currently initializes MAIR_EL2 to the value of MAIR_EL1. In
preparation for initializing MAIR_EL2 before MAIR_EL1, move the constant
into a shared header file. Since it is used for EL1 and EL2, rename to
MAIR_ELx_SET.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/memory.h | 13 +++++++++++++
 arch/arm64/mm/proc.S            | 15 +--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index cd61239bae8c..54a22cb5b17b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -152,6 +152,19 @@
 #define MT_S2_FWB_NORMAL	6
 #define MT_S2_FWB_DEVICE_nGnRE	1
 
+/*
+ * Default MAIR_ELx. MT_NORMAL_TAGGED is initially mapped as Normal memory and
+ * changed during __cpu_setup to Normal Tagged if the system supports MTE.
+ */
+#define MAIR_ELx_SET							\
+	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
+
 #ifdef CONFIG_ARM64_4K_PAGES
 #define IOREMAP_MAX_ORDER	(PUD_SHIFT)
 #else
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 23c326a06b2d..e3b9aa372b96 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -45,19 +45,6 @@
 #define TCR_KASAN_FLAGS 0
 #endif
 
-/*
- * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
- * changed during __cpu_setup to Normal Tagged if the system supports MTE.
- */
-#define MAIR_EL1_SET							\
-	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
-	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
-	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
-
 #ifdef CONFIG_CPU_PM
 /**
  * cpu_do_suspend - save CPU registers context
@@ -425,7 +412,7 @@ SYM_FUNC_START(__cpu_setup)
 	/*
 	 * Memory region attributes
 	 */
-	mov_q	x5, MAIR_EL1_SET
+	mov_q	x5, MAIR_ELx_SET
 #ifdef CONFIG_ARM64_MTE
 	/*
 	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
-- 
2.29.2.454.gaff20da3a2-goog

