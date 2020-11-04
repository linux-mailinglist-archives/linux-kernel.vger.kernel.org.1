Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87412A6CEB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbgKDShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732597AbgKDShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:32 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9117DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:31 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so3288185wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXNwt+3vSlZrX0Tc14BJDd1gNrfJjl5kGrrEIH8XAj4=;
        b=Wd2U/unpY3ZmVHfcTbXAiJY7KLJhty+qkCnEOe1v+9gF7Tk+esJECns+5NE7xRADVQ
         rb4jMmrIrDFF3Uqc+kw+TsQP0kUBbP0Q60mBlfNxiHzEXnQZF440tMQx2el8T+naYfSe
         nl6S2po85sezmLtPjaY/udhRbTngUIYz9zKldqnrNaoNQummnBHmMim25jYYlhSDGnMB
         Cuq7Q+xfCJoLb+/MPsBLXPPSxHnCmLW/mhKnoYOoXXFQRNHjTAzA522j5kTSmzHtOXCP
         IKtntiI2vPQxFCCjANt2TbA2A8r58wUouHeIdCcZ/vjLL7AFsxzBAHJM1tvSTiqOAKAb
         /xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXNwt+3vSlZrX0Tc14BJDd1gNrfJjl5kGrrEIH8XAj4=;
        b=pJDbsyRFs4JFfXsFfZQ1QuCm1+0z+r4bFBuXVAMxyv7HNRlO0s2RYAXxU4GPEySihi
         /9ZpJuE3tYHUsJKJ5YC6Nq7xt+/boafnBFOoYSkPQfjrUgQyIPjr+9SAXFsoLNoNc1jR
         ZqNY1WDiwCk5DEMsLLfA+GC1IH4YjGvp0s0cTo4M2aGEFTwB2BTG+aW/++7j0JmfrIof
         6x1KZp13qKe9Tkay3wfKJoIB/n/ztny2fM3uSTSI783DUU0rd1bjehujsQSi9bkX+JFp
         jWyNLlZeu6XKnxBD05Mu6Ij7HbEHOUvwgDaROf5bkC9wbwsROZXYxEp42HWJURnz2e1j
         AbkQ==
X-Gm-Message-State: AOAM530+/vqNpolSjY7Ycs442XDnvXw2JfauGxQnfqsMQYgnLF8z8Nst
        1Jerk6jQhUYNd+3RDLtx90T/TQ==
X-Google-Smtp-Source: ABdhPJwYR8Ha03TCz1M7oXikmCAwIAt1jt3ItFF9iYz0IjOXIOyB9xrETMaJm4+yQW9aUe1KTMy7ig==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr5901008wmi.120.1604515050112;
        Wed, 04 Nov 2020 10:37:30 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id h4sm3635371wrp.52.2020.11.04.10.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:28 -0800 (PST)
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
Subject: [RFC PATCH 24/26] kvm: arm64: Keep nVHE EL2 vector installed
Date:   Wed,  4 Nov 2020 18:36:28 +0000
Message-Id: <20201104183630.27513-25-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM by default keeps the stub vector installed and installs the nVHE
vector only briefly for init and later on demand. Change this policy
to install the vector at init and then never uninstall it.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6fbda652200b..3dff6af69eca 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -64,6 +64,11 @@ static bool vgic_present;
 static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
 DEFINE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
+static bool keep_hyp_installed(void)
+{
+	return !is_kernel_in_hyp_mode();
+}
+
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
@@ -1430,7 +1435,8 @@ static void _kvm_arch_hardware_disable(void *discard)
 
 void kvm_arch_hardware_disable(void)
 {
-	_kvm_arch_hardware_disable(NULL);
+	if (!keep_hyp_installed())
+		_kvm_arch_hardware_disable(NULL);
 }
 
 #ifdef CONFIG_CPU_PM
@@ -1473,11 +1479,13 @@ static struct notifier_block hyp_init_cpu_pm_nb = {
 
 static void __init hyp_cpu_pm_init(void)
 {
-	cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
+	if (!keep_hyp_installed())
+		cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
 }
 static void __init hyp_cpu_pm_exit(void)
 {
-	cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
+	if (!keep_hyp_installed())
+		cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
 }
 #else
 static inline void hyp_cpu_pm_init(void)
@@ -1580,7 +1588,8 @@ static int init_subsystems(void)
 	kvm_coproc_table_init();
 
 out:
-	on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
+	if (err || !keep_hyp_installed())
+		on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
 
 	return err;
 }
-- 
2.29.1.341.ge80a0c044ae-goog

