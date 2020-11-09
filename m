Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA52AB740
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgKILhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgKILcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:32:47 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A1BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:32:47 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b8so8316036wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9OHqVwmdHbsEbVYkhzfrXC3pmS5HWpDM4H+UgWkOTQ0=;
        b=KiIaN07Lql/jsar+Pt0YQtblLh2tpYdnoBcMlX29cx4cFAvQMzXKXI+pjxYH3unmqQ
         B+zG3cP1r+fCsNjx8DeGaHDo8SboteYbmIYfeUizmQMZYo3cUYcCibjZvKN/CLLT+zDq
         aKmyD15Ykq4sM0Shfe+MpPiQuhryzEAul/E++NLOoq2+NdMg1H5kTt1jdgL5Iw2CCCl5
         3wAxMjWaTyo1od7ojAO3Q599m4BH9FRsMUHGtqQza1xEDXjT4Un/SuuyGuroklXuacGI
         gXj7WBqwBRoBphWrGfXGFX1zCd7zDb/0rhYJ+C2fuz932FB5h14Dh/1Vxl+/opRVXRqN
         +hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9OHqVwmdHbsEbVYkhzfrXC3pmS5HWpDM4H+UgWkOTQ0=;
        b=lVfEPp9Su+owDX3KY7fTOHh8ox+GNMn1ThZk9Ie6uVhl07I1tkE7u+difwOTidAFN3
         IG1xo9PjQexXR8oO8AhaKEpBlI44Lrmjt5Hxe0sHq7KDRbo25OKw+QK0N3bor7NZ/lT/
         5NDpHiBxqBXbJm4VfxwTOMTt7lIWbnX5MELobiFoH96nvle7UbYJcOKSjWwUwN7+f61l
         VuUcrfy+FWKczgvB8cHDnu4bnH/5j93dEQGX6mwBgv09XneotB/5dIphOkbTzVCKu/2m
         esLwGRw/tok0eDGq3TDoEDaHpJDL1Fk0mTV4bNuD/LPH6RBxYOnTLuM4a4stM2Nbe3Ue
         UtpA==
X-Gm-Message-State: AOAM532KjDEkk4SUIruWISWExCf9mBlWTnoJQ4MqWZUbNUWVzb5R8ZEK
        yug4rZ0k/BjTpIxCiYoR7LdbkQ==
X-Google-Smtp-Source: ABdhPJy9YbQLl6FOlXdSqqJeLuvcE3K3eiWcMuLImPT2P8noAXyO9kqewE+UUaL2JJaCpFto5lJFdQ==
X-Received: by 2002:adf:804b:: with SMTP id 69mr17407493wrk.274.1604921565923;
        Mon, 09 Nov 2020 03:32:45 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id v6sm14976826wrb.53.2020.11.09.03.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:32:45 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v1 03/24] arm64: Move MAIR_EL1_SET to asm/memory.h
Date:   Mon,  9 Nov 2020 11:32:12 +0000
Message-Id: <20201109113233.9012-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM currently initializes MAIR_EL2 to the value of MAIR_EL1. In
preparation for initializing MAIR_EL2 before MAIR_EL1, move the constant
into a shared header file.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/memory.h | 13 +++++++++++++
 arch/arm64/mm/proc.S            | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index cd61239bae8c..aca00737e771 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -152,6 +152,19 @@
 #define MT_S2_FWB_NORMAL	6
 #define MT_S2_FWB_DEVICE_nGnRE	1
 
+/*
+ * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
+ * changed during __cpu_setup to Normal Tagged if the system supports MTE.
+ */
+#define MAIR_EL1_SET							\
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
index 23c326a06b2d..25ff21b3a1c6 100644
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
-- 
2.29.2.222.g5d2a92d10f8-goog

