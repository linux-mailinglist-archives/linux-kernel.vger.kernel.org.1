Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108712C58AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391357AbgKZPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391347AbgKZPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:32 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD71C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so2566314wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRbbAoAyT+twJ6DWAMnVPh0yMfbGrEWPbKn8Cs93LQs=;
        b=RIxckPoe2SCexeONFtE4DSkvr9AstiWpnehcv0VL5bhqQYEg6F/oOLEITVaQ1YoEfP
         hGk3BAB/mFs/TVGkOysWFzWL2o2OJ63MAD9vHn6ziIvpoT6iU7Kp+f3yRtPmRLGrK3uL
         0deZiq22+yVHN3uu+0OcZirO1XVk48C0r0exGjyDri75/b+No5iT5S4xp4Jb/F2siD20
         9mbZCjgyOtXgQaVY+Md/r07NG7gzIABxytKiAfgC6hHFqf47OWj1AJA/CygIdN1Nz3RG
         QjClGrsnaR32TvHvOZhfrzbfM8Kl2yeEXRKWMhh3KYMG0WT+diIy8djka0sD24s2czFl
         LSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRbbAoAyT+twJ6DWAMnVPh0yMfbGrEWPbKn8Cs93LQs=;
        b=EtqK9QdN0twbeliZ0QgKWclM7wWb7QQK48nGdspUS9jvDKBdIBmp01Ha7EPO5020FQ
         Y9AuCc++MYcYOQupz36bQR2K5wWZUgiGe1U9SAwbBMgnj4FS+XUgLmXTGrUiFpzRldqq
         zRC5ITxRzzEDdOuJc3gr6KxfkTWDDPNVDly2TQNdWIvXeQO8rIuyLE1VkwUaUfxR2c1+
         nPB/c4LQ8prPgeFY7ew3FdYhXwMFxnqT2/wnGHS5bJWc59s3lBSp6Gqaq10U5zyBFs80
         mCUhWU6PdgC4giELVj7rqpCoqzVssMOXRF/4U8x/PwMa9Cbi1FjTrdlPrPHDtf2uC8I4
         6szw==
X-Gm-Message-State: AOAM531dFYxywC4GmSnlQnsp3Z7WCUt6TUYm2K79wpkAxIiqpAWNAW33
        wAp5UYiq2xRPEMskr8iLkrF2hg==
X-Google-Smtp-Source: ABdhPJwT9SLDB2L8OAgTeM8M2ZPVm2Y3TUfSJCQdJPrpoyLr/4gGDkZXGYwQZBc52TdBQc78XLbyjQ==
X-Received: by 2002:a1c:31c6:: with SMTP id x189mr4071224wmx.50.1606406070792;
        Thu, 26 Nov 2020 07:54:30 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id q1sm9612864wrj.8.2020.11.26.07.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:29 -0800 (PST)
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
Subject: [PATCH v3 02/23] psci: Accessor for configured PSCI function IDs
Date:   Thu, 26 Nov 2020 15:54:00 +0000
Message-Id: <20201126155421.14901-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
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
 drivers/firmware/psci/psci.c | 16 ++++++++--------
 include/linux/psci.h         | 10 ++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 213c68418a65..40609564595e 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -58,16 +58,16 @@ typedef unsigned long (psci_fn)(unsigned long, unsigned long,
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
+	if (WARN_ON_ONCE(fn < 0 || fn >= PSCI_FN_MAX))
+		return 0;
+
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
2.29.2.454.gaff20da3a2-goog

