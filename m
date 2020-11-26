Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1597F2C58CD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403871AbgKZPzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403857AbgKZPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:55:13 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517E7C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:13 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so2867445wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yy/LdNdSlEKXNA1O0CJPP3BR+TLcin0LNTWW2mqA/Ws=;
        b=DW6HRBvH1dMRy9410u25SEcLsIp2cGZuNo6NNar9dsMBlj7Q7JHURHQ2ZWwJ4jXPRq
         FACFV5c1R7NwwKB0Oib/MpTay9RuvI6yCYOXmhbV+Pr3HgDlXdyvlg4UItg4lhdUNGHa
         Ld69QoFi9l+cU2d7Jj3v+urROaKpzMnCR+uXap1CF7z5vcz37pqfkvZgvs19n+L89vHB
         EEJiRfonQQHkdGI2wagoH7mhFUxDpAHkdjQtb7l1WLX+s81JCnUu/JCu2sK0TldwqLJv
         vWKQT0qJDuODF6PdMxt4duYZuW8RI90XbH/vsvYAybJHI2J7TmqDikGk5/EKWk9vYwAn
         9ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yy/LdNdSlEKXNA1O0CJPP3BR+TLcin0LNTWW2mqA/Ws=;
        b=jtrXILkMFSQF5O0BQefH6TR6Iv43FR3+GaLEQbQ/fE54yBjbldxEWsmo7+QGllgtzz
         16JjctNZIebFM2cnWSGGPiHZ6ig/j1xSN1u4S+TpBsS/wZelCimD3GAQFqhqfEdEKVex
         ELCjbtugO7/Vs7rEP90gyjFcsJ/r+tgOH012Cy6+6ar7uj1l6/GsmXToXjW0btqoG/iu
         8vtHfnBwrZpgVcF36Vk51cWpbVC19ltd7P9Jw5mvok6bDFqh8sJSbu3/jC+4ru/mXwCZ
         SO6oozuOBJTUqb4KdfnABLVjLDNo7NlrTrRYi2CyxKUsaGDX7RVEdA4iEBOcLTi+dMvg
         se1Q==
X-Gm-Message-State: AOAM533rdj97oYFbBmp2JCledqGic2TO18W6Pd1cyalFwPb0EFm4KZ1l
        WZ+bj/H1jz9wlaXg6MRllct2Rg==
X-Google-Smtp-Source: ABdhPJzVolDDwaIJ6HnyKtT7uOspSO1I6DuI7m5CXOsy4xcwwUFP5ghKEPUc3bw4ZpFlZEJaa1lvVQ==
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr4165642wmb.152.1606406111903;
        Thu, 26 Nov 2020 07:55:11 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id q25sm10978629wmq.37.2020.11.26.07.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:55:10 -0800 (PST)
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
Subject: [PATCH v3 21/23] kvm: arm64: Keep nVHE EL2 vector installed
Date:   Thu, 26 Nov 2020 15:54:19 +0000
Message-Id: <20201126155421.14901-22-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM by default keeps the stub vector installed and installs the nVHE
vector only briefly for init and later on demand. Change this policy
to install the vector at init and then never uninstall it if the kernel
was given the protected KVM command line parameter.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7a17b5048454..6ec8ddf74643 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1478,7 +1478,8 @@ static void _kvm_arch_hardware_disable(void *discard)
 
 void kvm_arch_hardware_disable(void)
 {
-	_kvm_arch_hardware_disable(NULL);
+	if (!is_protected_kvm_enabled())
+		_kvm_arch_hardware_disable(NULL);
 }
 
 #ifdef CONFIG_CPU_PM
@@ -1521,11 +1522,13 @@ static struct notifier_block hyp_init_cpu_pm_nb = {
 
 static void __init hyp_cpu_pm_init(void)
 {
-	cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
+	if (!is_protected_kvm_enabled())
+		cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
 }
 static void __init hyp_cpu_pm_exit(void)
 {
-	cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
+	if (!is_protected_kvm_enabled())
+		cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
 }
 #else
 static inline void hyp_cpu_pm_init(void)
@@ -1617,7 +1620,8 @@ static int init_subsystems(void)
 	kvm_sys_reg_table_init();
 
 out:
-	on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
+	if (err || !is_protected_kvm_enabled())
+		on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
 
 	return err;
 }
-- 
2.29.2.454.gaff20da3a2-goog

