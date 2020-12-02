Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0082CC585
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgLBSmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgLBSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:42:49 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A604C061A48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:41:35 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so5090469wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTPYqEMEJVYu7EDLdYK8M/9yDaVtcEHoKzFLwQ3C9WQ=;
        b=G9nRp1NClO5ThaoHR0FfWTTV1jX37+O++dpEWQ5M8ktTDAMpJeJccyh4QbRtPHzrgj
         3p0wDTK1oNkUPBZWEB48xqyd1DpiPlza78uG3UJmd0FRgJoXsvYEFC5/dJ6p1PDADnej
         JzxUan8mUbqcytiT8Xsbq58HdA7MIJPBZrBTgotHo8Pn9CTEZK8UNEMPbhDMlXHR7m1s
         PDfiRnDCZkEazv3nGY2YNAECEwG/U/mnyvg+RXProtzJE1N/fcd9LDxLtq4B8OclAb90
         fHQNn4wIZufUltwam9z0S7haohHxuJjP1yQ/G1kC05DlOQE4unx7Y8oRzB8xond/u6h2
         YkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTPYqEMEJVYu7EDLdYK8M/9yDaVtcEHoKzFLwQ3C9WQ=;
        b=moFlRCyfjEXnM1CWwKBX8Io7x5kzZMILYPtod9wgEqlYOItzD6bOQAdR417kIDgnBP
         apgrLy+VB5M7QDZpURDvSD7FkBc4/7R9AeMLBxvYElCXj+v+EsSzOI3CbML0TLiLDGlV
         CpjBeyWnHfHx/yFVxlFoRTQTWZhMK9pvL5yhaf1XXbn7PkO+IM86VoanwzdY3iXe65Yg
         d+NdYHwohbZSGoVUNOJ4nRAhZzqWCZzFfAQTXEK6vhVLGqt0W7gjM7MbhvyGFAhqUQ1U
         J4S89BwFdx0/dyfOA3GbFczPUaGPsRkhjPbVX6L3zGgAfilGIRQLBXFdP/3GeRBqWb7j
         FmAQ==
X-Gm-Message-State: AOAM53237k7M/f+s024p35fAaGbanwvZeRE8xVv6ejgm6H/YTynQXpJD
        QMy4qrvF7pz3I1tiHBGF8m/oKA==
X-Google-Smtp-Source: ABdhPJziIgLZ0tc/W8uCPyhlwdgytrCa5jtp+4HLbEeMEMxZ9Y3AuJ3UEdaL+P3G5xYsvTsXBF1VmQ==
X-Received: by 2002:a5d:4610:: with SMTP id t16mr5088666wrq.391.1606934493917;
        Wed, 02 Dec 2020 10:41:33 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id r21sm3315301wrc.16.2020.12.02.10.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:41:32 -0800 (PST)
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
Subject: [PATCH v4 03/26] psci: Support psci_ops.get_version for v0.1
Date:   Wed,  2 Dec 2020 18:40:59 +0000
Message-Id: <20201202184122.26046-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
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

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 00af99b6f97c..ace5b9ac676c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -146,7 +146,12 @@ static int psci_to_linux_errno(int errno)
 	return -EINVAL;
 }
 
-static u32 psci_get_version(void)
+static u32 psci_0_1_get_version(void)
+{
+	return PSCI_VERSION(0, 1);
+}
+
+static u32 psci_0_2_get_version(void)
 {
 	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
 }
@@ -421,7 +426,7 @@ static void __init psci_init_smccc(void)
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
-	psci_ops.get_version = psci_get_version;
+	psci_ops.get_version = psci_0_2_get_version;
 
 	psci_function_id[PSCI_FN_CPU_SUSPEND] =
 					PSCI_FN_NATIVE(0_2, CPU_SUSPEND);
@@ -450,7 +455,7 @@ static void __init psci_0_2_set_functions(void)
  */
 static int __init psci_probe(void)
 {
-	u32 ver = psci_get_version();
+	u32 ver = psci_0_2_get_version();
 
 	pr_info("PSCIv%d.%d detected in firmware.\n",
 			PSCI_VERSION_MAJOR(ver),
@@ -514,6 +519,8 @@ static int __init psci_0_1_init(struct device_node *np)
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
+	psci_ops.get_version = psci_0_1_get_version;
+
 	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
 		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
 		psci_ops.cpu_suspend = psci_cpu_suspend;
-- 
2.29.2.454.gaff20da3a2-goog

