Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557EE2CC586
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgLBSmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgLBSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:42:49 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD41C061A49
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:41:37 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a6so10139183wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYr8FdouxPNXJYj6F8T1dGVqWutC568ZBSlYDhNUpeM=;
        b=NFEcyQF7W9LakzcYiLFbTpnuPAMTiR4UFuRT3IJs/i5DDvUsC/Uk+pNi698+XnR+B3
         QvuGNYXhk0dGxab42tIg+hNWSU6kt6X6ohldo4maT1nBg8OCcEsLb7KMRGyrWvFjWZ/H
         2MB6Hn6JpAEzYKrPxpWA8Q8hRQJkCsOHXtT+NYu5fSFfNjcA1GfzpsmPzA56wvUk00Cj
         IZL1Q9wtPhCPc1k8fuvTMtfqVkMsQw16wnU8dYjnzN/A3CT2NCxt5QMNeN/STdRHVymz
         g9/rpoZBqCJQLXqQDVCHWAEfjit68BnXYNUkvRfxB6WeaygnWo0DN1M+xUvQPp3l3xPn
         +LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYr8FdouxPNXJYj6F8T1dGVqWutC568ZBSlYDhNUpeM=;
        b=o8rBmXQ8dT60Jt96ZIB6DBgAV7U87Jkxmty1pRE+Sgu34WmefRDKMSCRR8l1WH0HzR
         S0+kTN+A4nO1zYgZDY1bGa3iF0LpA4mDIguS3clZ3rJO0fOtWu67utNvim3JSKdu8qf5
         DuOpAnqIKJWoC61jnJSLh/SDGKNGZI16gIuGGOuQBX2qFGnrh5wQcTO1fWJhKECNQhov
         BeKhfkCTQig/HR+V/N9LxKJGe1zEbPPYAjTgKlPXMpos+Tb86yvr8daysOeqZ1VUfhu9
         RJG4mh1j3AKGYQcsjDBbXUCegSJLP30I9wAewsjx+4VWpmzz8onfSb1da5gkFmphUqOL
         TcAQ==
X-Gm-Message-State: AOAM533DOQ5gpzG7xUtHH14K9eLiyyxw50ABD+jbz1qpvkZ7ZMDQHBCE
        N3f+f5upkLxx2oNm15xu6G3XEQ==
X-Google-Smtp-Source: ABdhPJyA+FeKGAZ0pnrVUnW1W88hwOUW0I0MbdOAm+Y14RWvjrRicJ4tZn4rpByON5cgnGjgoXvNAw==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr4543655wmq.1.1606934496105;
        Wed, 02 Dec 2020 10:41:36 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id h15sm3006773wrw.15.2020.12.02.10.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:41:35 -0800 (PST)
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
Subject: [PATCH v4 04/26] psci: Split functions to v0.1 and v0.2+ variants
Date:   Wed,  2 Dec 2020 18:41:00 +0000
Message-Id: <20201202184122.26046-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor implementation of v0.1+ functions (CPU_SUSPEND, CPU_OFF,
CPU_ON, MIGRATE) to have two functions psci_0_1_foo / psci_0_2_foo that
select the function ID and call a common helper __psci_foo.

This is a small cleanup so that the function ID array is only used for
v0.1 configurations.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 94 +++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index ace5b9ac676c..13b9ed71b446 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -168,46 +168,80 @@ int psci_set_osi_mode(bool enable)
 	return psci_to_linux_errno(err);
 }
 
-static int psci_cpu_suspend(u32 state, unsigned long entry_point)
+static int __psci_cpu_suspend(u32 fn, u32 state, unsigned long entry_point)
 {
 	int err;
-	u32 fn;
 
-	fn = psci_function_id[PSCI_FN_CPU_SUSPEND];
 	err = invoke_psci_fn(fn, state, entry_point, 0);
 	return psci_to_linux_errno(err);
 }
 
-static int psci_cpu_off(u32 state)
+static int psci_0_1_cpu_suspend(u32 state, unsigned long entry_point)
+{
+	return __psci_cpu_suspend(psci_function_id[PSCI_FN_CPU_SUSPEND],
+				  state, entry_point);
+}
+
+static int psci_0_2_cpu_suspend(u32 state, unsigned long entry_point)
+{
+	return __psci_cpu_suspend(PSCI_FN_NATIVE(0_2, CPU_SUSPEND),
+				  state, entry_point);
+}
+
+static int __psci_cpu_off(u32 fn, u32 state)
 {
 	int err;
-	u32 fn;
 
-	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
 }
 
-static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
+static int psci_0_1_cpu_off(u32 state)
+{
+	return __psci_cpu_off(psci_function_id[PSCI_FN_CPU_OFF], state);
+}
+
+static int psci_0_2_cpu_off(u32 state)
+{
+	return __psci_cpu_off(PSCI_0_2_FN_CPU_OFF, state);
+}
+
+static int __psci_cpu_on(u32 fn, unsigned long cpuid, unsigned long entry_point)
 {
 	int err;
-	u32 fn;
 
-	fn = psci_function_id[PSCI_FN_CPU_ON];
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
 	return psci_to_linux_errno(err);
 }
 
-static int psci_migrate(unsigned long cpuid)
+static int psci_0_1_cpu_on(unsigned long cpuid, unsigned long entry_point)
+{
+	return __psci_cpu_on(psci_function_id[PSCI_FN_CPU_ON], cpuid, entry_point);
+}
+
+static int psci_0_2_cpu_on(unsigned long cpuid, unsigned long entry_point)
+{
+	return __psci_cpu_on(PSCI_FN_NATIVE(0_2, CPU_ON), cpuid, entry_point);
+}
+
+static int __psci_migrate(u32 fn, unsigned long cpuid)
 {
 	int err;
-	u32 fn;
 
-	fn = psci_function_id[PSCI_FN_MIGRATE];
 	err = invoke_psci_fn(fn, cpuid, 0, 0);
 	return psci_to_linux_errno(err);
 }
 
+static int psci_0_1_migrate(unsigned long cpuid)
+{
+	return __psci_migrate(psci_function_id[PSCI_FN_MIGRATE], cpuid);
+}
+
+static int psci_0_2_migrate(unsigned long cpuid)
+{
+	return __psci_migrate(PSCI_FN_NATIVE(0_2, MIGRATE), cpuid);
+}
+
 static int psci_affinity_info(unsigned long target_affinity,
 		unsigned long lowest_affinity_level)
 {
@@ -352,7 +386,7 @@ static void __init psci_init_system_suspend(void)
 
 static void __init psci_init_cpu_suspend(void)
 {
-	int feature = psci_features(psci_function_id[PSCI_FN_CPU_SUSPEND]);
+	int feature = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
 
 	if (feature != PSCI_RET_NOT_SUPPORTED)
 		psci_cpu_suspend_feature = feature;
@@ -426,24 +460,16 @@ static void __init psci_init_smccc(void)
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
-	psci_ops.get_version = psci_0_2_get_version;
-
-	psci_function_id[PSCI_FN_CPU_SUSPEND] =
-					PSCI_FN_NATIVE(0_2, CPU_SUSPEND);
-	psci_ops.cpu_suspend = psci_cpu_suspend;
-
-	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
-	psci_ops.cpu_off = psci_cpu_off;
-
-	psci_function_id[PSCI_FN_CPU_ON] = PSCI_FN_NATIVE(0_2, CPU_ON);
-	psci_ops.cpu_on = psci_cpu_on;
 
-	psci_function_id[PSCI_FN_MIGRATE] = PSCI_FN_NATIVE(0_2, MIGRATE);
-	psci_ops.migrate = psci_migrate;
-
-	psci_ops.affinity_info = psci_affinity_info;
-
-	psci_ops.migrate_info_type = psci_migrate_info_type;
+	psci_ops = (struct psci_operations){
+		.get_version = psci_0_2_get_version,
+		.cpu_suspend = psci_0_2_cpu_suspend,
+		.cpu_off = psci_0_2_cpu_off,
+		.cpu_on = psci_0_2_cpu_on,
+		.migrate = psci_0_2_migrate,
+		.affinity_info = psci_affinity_info,
+		.migrate_info_type = psci_migrate_info_type,
+	};
 
 	arm_pm_restart = psci_sys_reset;
 
@@ -523,22 +549,22 @@ static int __init psci_0_1_init(struct device_node *np)
 
 	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
 		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
-		psci_ops.cpu_suspend = psci_cpu_suspend;
+		psci_ops.cpu_suspend = psci_0_1_cpu_suspend;
 	}
 
 	if (!of_property_read_u32(np, "cpu_off", &id)) {
 		psci_function_id[PSCI_FN_CPU_OFF] = id;
-		psci_ops.cpu_off = psci_cpu_off;
+		psci_ops.cpu_off = psci_0_1_cpu_off;
 	}
 
 	if (!of_property_read_u32(np, "cpu_on", &id)) {
 		psci_function_id[PSCI_FN_CPU_ON] = id;
-		psci_ops.cpu_on = psci_cpu_on;
+		psci_ops.cpu_on = psci_0_1_cpu_on;
 	}
 
 	if (!of_property_read_u32(np, "migrate", &id)) {
 		psci_function_id[PSCI_FN_MIGRATE] = id;
-		psci_ops.migrate = psci_migrate;
+		psci_ops.migrate = psci_0_1_migrate;
 	}
 
 	return 0;
-- 
2.29.2.454.gaff20da3a2-goog

