Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1855C2A6CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgKDSiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbgKDSgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:36:46 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF304C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:36:45 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so23174845wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dretx+OcQnNEgjiOHgLf5xuX2mgx6Pn+lAvUlmv1Umw=;
        b=Q5mK8uSRD63nfgGRd0lH16O0TMipT4yLtqy2sQBbkl08CNUezovnETohG9rebszGq8
         0vdx8lJYS4mB9WRlz3W8/KzhCbjQ8OxW2FhSblN9uLFsDI/rbUQ9TTI97z7HhER3cXxs
         rHjtP/050BQ5K769dm085pH6Q/u7t7rMPpUVYc2OcIcJssNsO6XTa/wlRHRx9mZLv+IW
         Gahyfz5hGR7cT2wErqGNFxxxZEuHR04KSISkvpwR65eArEww7TerLaTFSSjHrDSUinvK
         oHAAy7K8iNU1EnePynpucNkY8ISIBbrT45JUUsnhQXdPmmoGe/ykyJmmKrz6zYHpmisf
         tptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dretx+OcQnNEgjiOHgLf5xuX2mgx6Pn+lAvUlmv1Umw=;
        b=XOTeGaLZGZvBsbRPqYXE6RoT0uUfSJ+JlByZdxQ/iqrOOely7u1+RwrCeGwI5rudPH
         S0IXQ8PcZiw87/hxqrgpBPzx07zYwz+W8hX0ojdYWdQ7vhrmsQmzkVHI2xjkEFN3ac1U
         w/UBFpuo/vGKR1k2r1hBSDtjFuYTVo4LA50nHBK5ELo/5tvksRUYK0jyL18YB4G+eKyZ
         IPVChF3ycYmd5NTvy3EAbAOj9xHb0MvMATLq7rbGJwqnYC4Cm2QMTH+HkHfdkApbI/Wr
         42ZY5bs/lHWWUiJHA7wK253u5D7usljQeuag2+6GQl7SIWaKCHjm26muxr1aG+s/WQUz
         yKLA==
X-Gm-Message-State: AOAM533vzEw3A/fBSYbBkbKP+I5OFgiX9AaSWF18TMTOPIsExTwZWpFW
        6t8rYYLM4mR18RDvVwgZh3RJOg==
X-Google-Smtp-Source: ABdhPJzz9EDjWjSDrVKMul71N2NUVEw1fW+kiKrX84z0zmTkgi3rkWsvlxdP0L2e6xtC+jegDhXbQw==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr34650447wrx.246.1604515004320;
        Wed, 04 Nov 2020 10:36:44 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id l16sm3665022wrx.5.2020.11.04.10.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:43 -0800 (PST)
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
Subject: [RFC PATCH 03/26] psci: Export psci_cpu_suspend_feature
Date:   Wed,  4 Nov 2020 18:36:07 +0000
Message-Id: <20201104183630.27513-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM's PSCI proxy could probe the firmware to establish features
supported for CPU_SUSPEND, but since the kernel's PSCI driver already
does that, and other information about the driver is already exported,
export the value of psci_cpu_suspend_feature as well for convenience.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 2 +-
 include/linux/psci.h         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index ffcb88f60e21..b6ad237b1518 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -71,7 +71,7 @@ u32 psci_function_id[PSCI_FN_MAX];
 				(PSCI_1_0_EXT_POWER_STATE_ID_MASK | \
 				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
 
-static u32 psci_cpu_suspend_feature;
+u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 
 static inline bool psci_has_ext_power_state(void)
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 877d844ee6d9..a5832d91d493 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -29,6 +29,8 @@ bool psci_has_osi_support(void);
  */
 extern int psci_driver_version;
 
+extern u32 psci_cpu_suspend_feature;
+
 enum psci_function {
 	PSCI_FN_CPU_SUSPEND,
 	PSCI_FN_CPU_ON,
-- 
2.29.1.341.ge80a0c044ae-goog

