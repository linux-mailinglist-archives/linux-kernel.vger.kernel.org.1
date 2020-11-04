Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B62A6CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgKDSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgKDSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:36:42 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A791C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:36:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x7so23173299wrl.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z4vcpIwywIa5rhEfDa3o17Qy4qQsjexN6rFsZvVCzvI=;
        b=i5BcYNcM6qzN9gIC6Zos02dnE8rZIudFYfeZNcnVwst4EKmc2q2Ms0tbFD1K145rhN
         EyN53gm3SYcjXj8YeQ6px/NtuPMVkpv0swt2sKzFjniFPQHXjOXIiS7QGmMPwHCKGjEH
         0Y3xO9i6IiXIkvBXE8sXwf5az6q2KrGHDE9VP6ovxCl47Hjt9bnzJ5X6mSzWBWX9/rMZ
         sUhvIEaRKj3w2xnjFLkI0BbBArxSG2s/9yPW2CInP6hqnbPKsOM1QaOm07yVZubZXTzR
         RbNN8m8Nvtbbf4tTxGVyg9zdj3UxpU6TOXKsOOF9/VaDzNPIbU98PtEkTT04FBQeh4Mu
         +bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4vcpIwywIa5rhEfDa3o17Qy4qQsjexN6rFsZvVCzvI=;
        b=JZF8nftghOR1XNXuxDItKCOkQHDa1AcW2ek1neRvb73AmJcGsG3zwRr6ixq07OxIYA
         2Q/EJrpk1JrjNflarqlnIIwYRJ05BLHMOn/6gwrSsusqwxq5zYQlIPbGDrhtM3S08V3M
         UmEGhRa18YQwoHCMDu9gfPDk6Nz/3Jit18MKC5P2qLtu0ri7hi8WSXCrMALPb1wU5nEw
         mPq/9SN0dDG9Exc/1y+icJT2s21Lk6m5xO6laygodO9H/L6WpOLABNpAzP217GCz//hA
         mer4YxHJ+l7sJE4eN0vRgPR1lhhnbtXRsNk+PI1XA8pT96Ew8PArxRKSaGC0ld0Ytfa8
         uogQ==
X-Gm-Message-State: AOAM531WyGIFjgEBnsvpCrz0Qw8IIWdHEAg7FFVIzyOVYKcHMUwEzxtM
        xAg3XWdTAeythVjZWtXIh0F+dQ==
X-Google-Smtp-Source: ABdhPJzrzz9sHPqQ+PdVQq+JJJnWPJd6Kn6P7U2cR/hpaxn8sZnauzi5oOrw6gyAkzxG8ER6mhlOAQ==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr32575217wrx.18.1604514999931;
        Wed, 04 Nov 2020 10:36:39 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id 15sm3271469wmg.1.2020.11.04.10.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:38 -0800 (PST)
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
        Andrew Scull <ascull@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 01/26] psci: Export configured PSCI version
Date:   Wed,  4 Nov 2020 18:36:05 +0000
Message-Id: <20201104183630.27513-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The version of PSCI that the kernel should use to communicate with
firmware is typically obtained from probing PSCI_VERSION. However, that
doesn't work for PSCI v0.1 where the host gets the information from
DT/ACPI, or if PSCI is not supported / was disabled.

KVM's PSCI proxy for the host needs to be configured with the same
version used by the host driver. Expose the PSCI version used by the
host.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 6 ++++++
 include/linux/psci.h         | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 00af99b6f97c..ff523bdbfe3f 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -49,6 +49,8 @@ static int resident_cpu = -1;
 struct psci_operations psci_ops;
 static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
 
+int psci_driver_version = PSCI_VERSION(0, 0);
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -461,6 +463,8 @@ static int __init psci_probe(void)
 		return -EINVAL;
 	}
 
+	psci_driver_version = ver;
+
 	psci_0_2_set_functions();
 
 	psci_init_migrate();
@@ -514,6 +518,8 @@ static int __init psci_0_1_init(struct device_node *np)
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
+	psci_driver_version = PSCI_VERSION(0, 1);
+
 	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
 		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
 		psci_ops.cpu_suspend = psci_cpu_suspend;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 2a1bfb890e58..cb35b90d1746 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -21,6 +21,14 @@ bool psci_power_state_is_valid(u32 state);
 int psci_set_osi_mode(bool enable);
 bool psci_has_osi_support(void);
 
+/**
+ * The version of the PSCI specification followed by the driver.
+ * This is equivalent to calling PSCI_VERSION except:
+ *   (a) it also works for PSCI v0.1, which does not support PSCI_VERSION, and
+ *   (b) it is set to v0.0 if the PSCI driver was not initialized.
+ */
+extern int psci_driver_version;
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.29.1.341.ge80a0c044ae-goog

