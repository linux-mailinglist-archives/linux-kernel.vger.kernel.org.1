Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125DA2B52F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbgKPUn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKPUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:26 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FCDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:26 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so582799wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcAUCdpGWiuobZn7klovZm7k+zA43w4wed6QHZHKZWs=;
        b=t+iNX/paL9tpslCZ4CFA0oCR9xlgnZt6fxJdREt7U7vuSjqq/X58AyBogeLhmb/FgA
         seqQtQzK3lsKx2bZbh9uTqgCQ8BiJKQM1Kkc2l5gBGbgIEIK4ZvLY57zj9qQ575CVNiG
         32YGidIbqGAxwSRCkoTBCJTX6Ck5M4kMXTeTIydXYbK7dk4aWmkCMhjTFoM2M1q438vQ
         eZPIRHbbCtKMUQOnso8i7X8CQ1A5SRPmJh6MDrhmCxrglK8LbcDnHBisKHia+Y65TAWA
         aK5vNo0NXNX1qC+rBXjlsbA88aDmZKhEObSRb3tTXOeFer1H+YDQ8lWIe+INsuGEW9RO
         E6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcAUCdpGWiuobZn7klovZm7k+zA43w4wed6QHZHKZWs=;
        b=I5Apn68M7V9WCuEmWL/7FMn3cQxvoQifa58PX3o9YoPgeZhm1LHnBwtDUi6ZLq/ede
         4oltfQfyHhRVY3cbqj9FHTosOIeOOK48upWd7QMVVT1eEH378Cm+x5oEqdm+h8OGJEq1
         F6jn+LNwROaPggyy9wERxYYlDvZgmalLbW8BOUwZGLvKXYQMIGxTqxE/C7kmGCvViloL
         O9urK5gKLWM5a2+OixFgNwsstEq3xQJjBHYr1+DYG1VTnq6WcOVNqJsviJUXN74JnMRn
         Hmn3fyfrIAbwu58w1o0U2xAkiHaKyd0/TtsZLuzAO1bWyO8yAI0bx1m8Xz7GO6q5JmRw
         gU+w==
X-Gm-Message-State: AOAM5316WDyOfHA4E2W7JLGV7zfEZHi80iWHco4h2fd5H6IhnvRgX0KY
        NZUjKUAznYw7rie71I9Ji8jLbA==
X-Google-Smtp-Source: ABdhPJzgqCTBEHgC/iMbT8zNTaAzAp+KaRl3xN6yFoQabpnmMr3bPo14Jz09qy86PvkRyrjoS3SOvg==
X-Received: by 2002:a1c:4485:: with SMTP id r127mr684535wma.177.1605559405139;
        Mon, 16 Nov 2020 12:43:25 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id p4sm623902wmc.46.2020.11.16.12.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:24 -0800 (PST)
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
Subject: [PATCH v2 01/24] psci: Support psci_ops.get_version for v0.1
Date:   Mon, 16 Nov 2020 20:42:55 +0000
Message-Id: <20201116204318.63987-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
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
2.29.2.299.gdc1121823c-goog

