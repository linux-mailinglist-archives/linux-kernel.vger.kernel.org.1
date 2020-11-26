Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293552C58AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391342AbgKZPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391331AbgKZPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:30 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F108CC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:29 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so2656320wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eBkN6lmfdOZ6y3T4AeVQ2xEMCxfbxxoIUc76Qx59Gw=;
        b=q0DXHENIOaqhJFnVso9J1kN3Eb61iVK8nd3AricHajirGlfnSXv+NmgwWHCMVIELoM
         /xkucGICwySq83LXla7dhpUSyhhrYAX2WyLB2M0GSO+2LUD2XI2l+m2AypGqvHH1oZWj
         ar44f6d4mUGekt4sM2d7YlccV/6w5dO+75q5vS8ABmkgJxt4nsK1E5YYxMSRXHZwtqRw
         CgRzDUSpetP2+yE0F4UC58Vh56PRAdl/j8zQgvJ3gdi0B97IexPJS8ZDk2Z0gcqlwvRq
         +6NN5jRL2/yL9KuYo3aGBfcKHp1j9xVMqkzoFKdL7JrD/vM8UlDrwr99kKCpPxKPalu6
         8LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eBkN6lmfdOZ6y3T4AeVQ2xEMCxfbxxoIUc76Qx59Gw=;
        b=Apzh2aRx+h6SqWGEVPfSr6455xBY0Q7BJ36UWqdm6auHEuRf7MOT7+PppJfRknYtpT
         rfBwcTPIT3NtQeiPvUUlTtRUqDJV2rTzhStnyrYEJfjMOA5/Kd8GakKBKR9Tu9d2AUKR
         4PIbpKJtB3MRqAatiQNVADkYFHvTBRsMrCJOxZ8g8WififeoSuyh/V5QtomcYKhaEUbC
         VQy3jPswrpxTW1gNhOZCKDiqxVEhflw6Hzij0XNEnaZR8VVGEpDurpq6qI1fnLkms5mN
         4mChsP97uh3PU59X42Sx+XbY5fJSXu+VUSBmb7dY9E6eEhUTpr3upRmHdx5HYrDD3MzK
         yhpw==
X-Gm-Message-State: AOAM530fUI35BAmMNh5UZ4Qfmfn5ODVYlikbKjjh2GYewy6YZdRjgPaE
        92E0fISt/noiqGEaOlBsz8Mo2A==
X-Google-Smtp-Source: ABdhPJw/lRW3PEMxi02nhLES66F/ltyrof/LoT+FjVRp6ybB+E4igrjSX8c/nxUUNknF9HL5GfidZA==
X-Received: by 2002:a5d:5482:: with SMTP id h2mr4667449wrv.18.1606406068612;
        Thu, 26 Nov 2020 07:54:28 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id v7sm2637615wma.26.2020.11.26.07.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:27 -0800 (PST)
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
Subject: [PATCH v3 01/23] psci: Support psci_ops.get_version for v0.1
Date:   Thu, 26 Nov 2020 15:53:59 +0000
Message-Id: <20201126155421.14901-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM's host PSCI SMC filter needs to be aware of the PSCI version of the
system but currently it is impossible to distinguish between v0.1 and
PSCI disabled because both have get_version == NULL.

Populate get_version for v0.1 with a function that returns a constant.

psci_opt.get_version is currently unused so this has no effect on
existing functionality.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 00af99b6f97c..213c68418a65 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -146,6 +146,11 @@ static int psci_to_linux_errno(int errno)
 	return -EINVAL;
 }
 
+static u32 psci_get_version_0_1(void)
+{
+	return PSCI_VERSION(0, 1);
+}
+
 static u32 psci_get_version(void)
 {
 	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
@@ -514,6 +519,8 @@ static int __init psci_0_1_init(struct device_node *np)
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
+	psci_ops.get_version = psci_get_version_0_1;
+
 	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
 		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
 		psci_ops.cpu_suspend = psci_cpu_suspend;
-- 
2.29.2.454.gaff20da3a2-goog

