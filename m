Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E925B2A6CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgKDSgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbgKDSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:36:44 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E5AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:36:43 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so2459597wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMYzxJDYxfHlXJHNbiZJ0RtJwPETqciyv+NsXmdBd5Y=;
        b=GjufsStQ+HyoPB83S7Ba9wxZeSrIRXkcXxAxPID7JhjR+e70vcnGKegRMVIYfysv7o
         Aqy9GF51B2tXn8u3oe9zVHDNUbK2UjEYfUl0ImJtzs/qCnSFhbV8uAm01P1AEnwJSTKY
         886tVk2x+NqZ5mbipyudrXGoKPfd75Ue1T3DpW0nxqJunhv6vnfS3Iwujj+lpucAL2j2
         j0mudlvRcrcyi0KAqUQGnQDvtN05+8dSDdGl/vWDpoo8shIIkYtCVWQ7JrYQpG8Ud1tT
         DFeM3GX/XIeyX0MPssEYN6d5bp19EuNjOd7hRYPB3gs5DyH308XmOGyqTzEtvSLxC8S/
         jr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMYzxJDYxfHlXJHNbiZJ0RtJwPETqciyv+NsXmdBd5Y=;
        b=ktj5hDScBuUldv2b41fhgk385ehTBwHRy99aZeNi8ylO/5KVfle4iXQIR1HPZiffC0
         8GpENez+/FkkAvGRk0/tJTHYON2k7TjgOQsysyvdwJR0A/X52CgUaOoIi84WGKRPXfkj
         Pc+EjwxRYXxvuBVHXDkENrDEXy+GEXBSeA5GGEHyvggxQ3HWzjSiwIrrhXBz6qJ67cL8
         4FPXXfIQX5x0NuOijpL+OTnNyCXyguXpv9V+SpOnsmnevfDFTzSKUNaQTPp9+wBXAs0P
         N6bTsmXKaE8nl4/y+bIn1Jcm7AONliyf+q2lT0+EcWpW/fpjwt346ILSI4oXePhypU26
         Iq5A==
X-Gm-Message-State: AOAM533T99NHVfAK373TEg1fL5Xg7qXrMirgX7u6gsf1D5yHQlrD3m9O
        MdsqxJqKewyhpaY0yHJ5xrbxQw==
X-Google-Smtp-Source: ABdhPJxe5MqDZ8brVsIs/z3j+gd8UQSoF3AlIuXpflyiQYSloiegdjfrS3Wak4Mz8sQzKefo8pVKsw==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr6054631wmk.32.1604515002281;
        Wed, 04 Nov 2020 10:36:42 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id u10sm4014080wrw.36.2020.11.04.10.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:41 -0800 (PST)
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
Subject: [RFC PATCH 02/26] psci: Export configured PSCI function IDs
Date:   Wed,  4 Nov 2020 18:36:06 +0000
Message-Id: <20201104183630.27513-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function IDs used by PSCI are configurable for v0.1 via DT/APCI. If the
host is using PSCI v0.1, KVM's PSCI proxy needs to use the same IDs.
Expose the array holding the information.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 10 +---------
 include/linux/psci.h         | 10 ++++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index ff523bdbfe3f..ffcb88f60e21 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -60,15 +60,7 @@ typedef unsigned long (psci_fn)(unsigned long, unsigned long,
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
-static u32 psci_function_id[PSCI_FN_MAX];
+u32 psci_function_id[PSCI_FN_MAX];
 
 #define PSCI_0_2_POWER_STATE_MASK		\
 				(PSCI_0_2_POWER_STATE_ID_MASK | \
diff --git a/include/linux/psci.h b/include/linux/psci.h
index cb35b90d1746..877d844ee6d9 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -29,6 +29,16 @@ bool psci_has_osi_support(void);
  */
 extern int psci_driver_version;
 
+enum psci_function {
+	PSCI_FN_CPU_SUSPEND,
+	PSCI_FN_CPU_ON,
+	PSCI_FN_CPU_OFF,
+	PSCI_FN_MIGRATE,
+	PSCI_FN_MAX,
+};
+
+extern u32 psci_function_id[PSCI_FN_MAX];
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.29.1.341.ge80a0c044ae-goog

