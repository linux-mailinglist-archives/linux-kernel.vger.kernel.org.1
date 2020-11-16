Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19DF2B5311
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbgKPUoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbgKPUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:11 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A5C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:10 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so20321470wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CFjz03HJxHtdKmmeq3XI0pgEGq835KLMY12UZ/ZKTg=;
        b=l51oR3keMoKmPq/v1ISAlqHy4p/t+CQYtMrQtrP9vZnPMcERdLP/QHt+d0CT9gA/Ed
         SobfYR2CeQyAX0dOJWwTVbuhvYtnVgveuYzP3rbl3Ij8p3MCRVh0iYc64p9ZQqwbsVdV
         +HDWxeSVum9m9sMkdtyDTKxiyK3NR6dpkI87nPOBs5gP20q5woGOaKJipnSGcOaCr/3f
         qvW0h4o5auBjfBRhZWRRACLhjwctmBp3xNbSSrb6KhF3xlCw/QkGVQgs5PsluJQVitm3
         fTprBP4rfDAsllrSEZg8y2fla9YfmqspG3gOWIvViQaQQlcvL/gp6db9g1rHt5WazShs
         ffbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CFjz03HJxHtdKmmeq3XI0pgEGq835KLMY12UZ/ZKTg=;
        b=GEoutyc2H/9+tClojlM8MufO7uVjC8mDFkWtGLEu8OiUQ8oy74rN7oEgw0uJfCgiAK
         0YSFsdsDt4LQ0w8dXpcpLt1qoR86fapWHpxBTxPjyv4DS2qUYh+cV/ID1PFJWU4IYXW5
         yya+e2e/9gVIEmwhGZ9epKxWN2KG5ia57mY9nxbWnl6Xxu3wejZEzvk7AsE4EME1xAI2
         rf3HQjiMUhhAGE187fRRj4/ZDyxPNEHpVsl1GMbhA3Hy4ugrmGDjTV4HubIjPHUz8Q6f
         nrLmTh0rZJfcaqj337c4Uz0lNVLtWRIZZ7ZMlUizm0IJC1FlywNmjkmIiY7jasECFzZ7
         2X5g==
X-Gm-Message-State: AOAM532ey4hhuqZgQTEKLF+SmHxzc7nGBKGoq+/7angRMgv9HkG/MKwZ
        I9Iy5QQV0NMYHNye0AM7h7Cshw==
X-Google-Smtp-Source: ABdhPJwTVhg+IzYsedYHZXpYNdeAAlF6a3bNz+Xk9NrjYPSf6yZ7lt0OUtSGjKuG7foETNcuKLqMKA==
X-Received: by 2002:adf:c3c8:: with SMTP id d8mr21152047wrg.366.1605559449547;
        Mon, 16 Nov 2020 12:44:09 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id i6sm531311wma.42.2020.11.16.12.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:44:08 -0800 (PST)
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
Subject: [PATCH v2 22/24] kvm: arm64: Keep nVHE EL2 vector installed
Date:   Mon, 16 Nov 2020 20:43:16 +0000
Message-Id: <20201116204318.63987-23-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
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
index 49d2474f2a80..45bc7a6b9e0b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1443,7 +1443,8 @@ static void _kvm_arch_hardware_disable(void *discard)
 
 void kvm_arch_hardware_disable(void)
 {
-	_kvm_arch_hardware_disable(NULL);
+	if (!is_protected_kvm_enabled())
+		_kvm_arch_hardware_disable(NULL);
 }
 
 #ifdef CONFIG_CPU_PM
@@ -1486,11 +1487,13 @@ static struct notifier_block hyp_init_cpu_pm_nb = {
 
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
@@ -1575,7 +1578,8 @@ static int init_subsystems(void)
 	kvm_coproc_table_init();
 
 out:
-	on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
+	if (err || !is_protected_kvm_enabled())
+		on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
 
 	return err;
 }
-- 
2.29.2.299.gdc1121823c-goog

