Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0932A2AB6DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgKILcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgKILcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:32:43 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35810C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:32:43 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so1209977wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzuHJ5pL7t9NbTEFogq/8Y23xeOn+spq7fy4sQhhUGw=;
        b=WWfakKwGe1YouBXlERhaEppVHXGHFfpGO6bW/qiGXsfrnx2X9Lb/WvrzQ1BmW5RS/5
         zHLiFC7sJhMK2RlWUkklFx+QINQJt1MhJ3kSxKkvhs0XrDOB01DonqHn5Emvim+ioae0
         mzXqV6OD7rZ1HSeAlSSDGTafFQGnM2ub6vcj/8Xmt2enbD8TouDTCyPN/DRyQDDtF59k
         mWUJLHIx+sJoEQIEa+cOmDc1ijKk+N4l7rd1M6uJti+h61k4Lpgatharg5X9b8N/s2tO
         3ys6wT2kD/LsHwgKSgmM2snJbpUNI7giobddJY6xsKxnsjnqKVOAuK1ozzqZAQuNkoXW
         p8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzuHJ5pL7t9NbTEFogq/8Y23xeOn+spq7fy4sQhhUGw=;
        b=XjRb1Vhs5F8hUyfm6VrhwJHEi28Wa5NqTlmv/RSQxCFDy6mie5j6rcdQnZGnOwaQDJ
         ruvfugGZhnJiED5rnpvFb1K9JkVAdxHqL1A93Z5k7uNQkqKI3gmlkBU98PGhdTIXR3pm
         sBnh5v8LO4hC6yCF6cf2TDGJbvddjUafLdJM26NAOhc27WtMKdbDJBmLvGka4zXH+3Sw
         h/PLUYaSnW25OxBSkyVoqsjB8ZBq1TD6lp4C0CtlTPBmKk/B3TjjpNNyzfPwJqABgC9Q
         sBFCBu7e+UDCXxrVR93GaBAkNLarKWWhyxAM27rbpmhvgswTuliLQHT8rllUm49/if5x
         aHXA==
X-Gm-Message-State: AOAM5300NmRjEU8X38Fefti+o3/FGqWxRGf7C7J9GoOIUR/vyBRVCGir
        HEDWEZs2Fp6IokICHtIM6Vzo8g==
X-Google-Smtp-Source: ABdhPJygvHSvFhOYazfMvt3AJzEQrYuyl6Z5s6RaM4KlhnPW6/ZF7ztOig2+Ano7PbZOzUl7hy8ELw==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr17832902wrp.399.1604921561816;
        Mon, 09 Nov 2020 03:32:41 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id y20sm12191934wma.15.2020.11.09.03.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:32:40 -0800 (PST)
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
Subject: [PATCH v1 01/24] psci: Accessor for configured PSCI version
Date:   Mon,  9 Nov 2020 11:32:10 +0000
Message-Id: <20201109113233.9012-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The version of PSCI that the kernel should use to communicate with
firmware is typically obtained from probing PSCI_VERSION. However, that
doesn't work for PSCI v0.1 where the host gets the information from
DT/ACPI, or if PSCI is not supported / was disabled.

KVM's host PSCI proxy needs to be configured with the same version
used by the host driver. Expose the PSCI version used by the host
with a read-only accessor.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 11 +++++++++++
 include/linux/psci.h         |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 00af99b6f97c..bc1b2d60fdbf 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -49,6 +49,13 @@ static int resident_cpu = -1;
 struct psci_operations psci_ops;
 static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
 
+static int driver_version = PSCI_VERSION(0, 0);
+
+int psci_driver_version(void)
+{
+	return driver_version;
+}
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -461,6 +468,8 @@ static int __init psci_probe(void)
 		return -EINVAL;
 	}
 
+	driver_version = ver;
+
 	psci_0_2_set_functions();
 
 	psci_init_migrate();
@@ -514,6 +523,8 @@ static int __init psci_0_1_init(struct device_node *np)
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
+	driver_version = PSCI_VERSION(0, 1);
+
 	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
 		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
 		psci_ops.cpu_suspend = psci_cpu_suspend;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 2a1bfb890e58..5b5dcf176aa6 100644
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
+int psci_driver_version(void);
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.29.2.222.g5d2a92d10f8-goog

