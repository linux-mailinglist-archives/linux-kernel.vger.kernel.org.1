Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8081E2B52F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgKPUna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKPUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:28 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965C9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:28 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so3096620wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBK5eZkVMoQritbd0wCyBeq8n+u1kTTgyjfghI2qI2A=;
        b=LpPgLYJoCTv1oHKKJjTShTeJ0/jzOj8483R1CyGe1/2yiVHw7V+amuY2dvDpQHINYo
         B71XuITyMBPai4U5C6bwKeUbWwMyZoqtuG+ktdinJPefMIYT5OKiw4TZp1VA2qnS0Y7i
         qNcxpiT4Yiep08Ci0LKvyduGtf9H/28dn9zw9DWwG8kr7EwA668DtdnfK4Mnx7PrfUdl
         D2iNXtKU2gxvyT50AqnyqkyBUsEGaZHkJ6nfWFso5KbSeHu4i5iIOb/OtoKv+e4Nf+oI
         vzovOiJ+Q4vTPXfsSSvudXA8WMmsl8qtUik5L4t7/Oc1UtHytqTGpUI4dciQJHhRjFre
         TEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBK5eZkVMoQritbd0wCyBeq8n+u1kTTgyjfghI2qI2A=;
        b=EYXZUNUvdhjTnO8fy/MwXBX2K7EfVuAAdsUgq/5b2tX9W/S7mqGCUWUGpg5AqjyNXG
         5+Y5J/ErSzZmiy8WLeChAiz/6q2jMDXD4QJBlwaOgKcXfBmjkkqi+092dzMLiwOo06JA
         b+3n9PbjbqHgwe+De9BLbQdC4ugTUlWZ1gL39QhHlDNDozc5b+MI9RG7AMc2xUKPPppy
         5UuONpSoJc8PQ7XCWfBZfzjKrcJl7srF5k3AcmFx77c/0nSfXKUKlBch4d7pwcIIqOqy
         KwSWTdW4zXKySmkZYM4Liwt12Iyo4PAxxTNBFtJIotwepIbtOjP3YdKOCTlTQ8dzueeX
         OumQ==
X-Gm-Message-State: AOAM5334nZ6Ho/r4LY5Rdh8zZGwYhz9txUxbU4TyUXOMIUt9k7QApd4Q
        RoEyFB+haGR7Uso4uHB4u+hm+g==
X-Google-Smtp-Source: ABdhPJw6INFk2z1GcoyqqnoLQUKmvHq4aEzJ1qjQiEeW2TjsoBHTbzNVv6avTC1esSkrC1mwnL7QGg==
X-Received: by 2002:adf:a40c:: with SMTP id d12mr21800321wra.154.1605559407257;
        Mon, 16 Nov 2020 12:43:27 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id o10sm516959wma.47.2020.11.16.12.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:26 -0800 (PST)
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
Subject: [PATCH v2 02/24] psci: Accessor for configured PSCI function IDs
Date:   Mon, 16 Nov 2020 20:42:56 +0000
Message-Id: <20201116204318.63987-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function IDs used by PSCI are configurable for v0.1 via DT/APCI. If the
host is using PSCI v0.1, KVM's host PSCI proxy needs to use the same IDs.
Expose the array holding the information with a read-only accessor.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 14 ++++++--------
 include/linux/psci.h         | 10 ++++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 213c68418a65..d835f3d8b121 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -58,16 +58,14 @@ typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
 static psci_fn *invoke_psci_fn;
 
-enum psci_function {
-	PSCI_FN_CPU_SUSPEND,
-	PSCI_FN_CPU_ON,
-	PSCI_FN_CPU_OFF,
-	PSCI_FN_MIGRATE,
-	PSCI_FN_MAX,
-};
-
 static u32 psci_function_id[PSCI_FN_MAX];
 
+u32 psci_get_function_id(enum psci_function fn)
+{
+	WARN_ON(fn >= PSCI_FN_MAX);
+	return psci_function_id[fn];
+}
+
 #define PSCI_0_2_POWER_STATE_MASK		\
 				(PSCI_0_2_POWER_STATE_ID_MASK | \
 				PSCI_0_2_POWER_STATE_TYPE_MASK | \
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 2a1bfb890e58..5b49a5c82d6f 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -21,6 +21,16 @@ bool psci_power_state_is_valid(u32 state);
 int psci_set_osi_mode(bool enable);
 bool psci_has_osi_support(void);
 
+enum psci_function {
+	PSCI_FN_CPU_SUSPEND,
+	PSCI_FN_CPU_ON,
+	PSCI_FN_CPU_OFF,
+	PSCI_FN_MIGRATE,
+	PSCI_FN_MAX,
+};
+
+u32 psci_get_function_id(enum psci_function fn);
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.29.2.299.gdc1121823c-goog

