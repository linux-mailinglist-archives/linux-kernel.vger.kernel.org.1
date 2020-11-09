Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F6F2AB736
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgKILgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbgKILd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:27 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:25 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so3908366wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ng0v5HeSJQOeKhcFpXVkzmD2sfhDn/uEl/qiO47ffRU=;
        b=nXf0x2ZQSANVYisqiO9zumbyu9XHWzxdyz1ZSIY8GyuKuYfxct4fnI5pSbGiSTFOKJ
         mveF3t9cZcHU35ZFthj7l3KTs3ZcYkKdoe3VKEu83Sfd5kxl+FtXCFTOixquF4EcYCgw
         EH0rMfup2e0PVd7xLQh+emTzeQ/efWcJu+mp62Fe+olt7hUpIucBmUJATKQb/DAJa7b0
         XskNC0gzRIE8PphGvVPd2oXvFvUt/iF9drRDgP9i7TwTUi1unqdrwycwXbWED+9mzRWy
         kNVDQRYVy53qymYwRdxJpoF98BHEStzuuxGL2CLfGvP7cUiWsVkbQbbzm86kWZ9LMPPT
         4fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ng0v5HeSJQOeKhcFpXVkzmD2sfhDn/uEl/qiO47ffRU=;
        b=YCkuSAVjSzxU+vVg8TxEcgAa4zsa0S7kbLio80/n5Yn6QhQnKMrx0s/oXBi8CunDPl
         AI8SpEaGfuyEP6RrWTUuHUkR4DaUH8RsNlM0w0vXcJEgCIKk2h22r7NVSEqoCVONlcA2
         Kl+N22pFZXNiBYaTgh6oaLyDw730M8pow1EKo+PlzaystwrOKtESUnuug7EV7GR1qaEX
         FUlwI1RVQxMVKtuPnwR/epa1DJitAUFhWFicnTukaodmUuJnEDLmLb1sqSW6N5y44PZl
         Xv5I5F8h4m+kBFs34N9D6zlSytzLT5TchLH1ixwQxyNSrfyyM7lIyXOF4KZQ1ajG+0d+
         9dqQ==
X-Gm-Message-State: AOAM533SxTanPQwE5cmfeabSSBhGD9Wgz6Gx2HJ1xCCgzRzMc+pjY4tn
        e3eSmTOtvGdo3CcuQyjYJ2r9IA==
X-Google-Smtp-Source: ABdhPJwGtO+bLBkGK5zcf5ADJI23gPkHLtLWoYJFJD2sI6sOe+pvFe7IA5c+39hGs9VXzBBrk6IBZQ==
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr4853268wrs.331.1604921604594;
        Mon, 09 Nov 2020 03:33:24 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id d3sm12903725wre.91.2020.11.09.03.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:23 -0800 (PST)
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
Subject: [PATCH v1 22/24] kvm: arm64: Keep nVHE EL2 vector installed
Date:   Mon,  9 Nov 2020 11:32:31 +0000
Message-Id: <20201109113233.9012-23-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
index 452a01afaf33..574aa2d026e6 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1431,7 +1431,8 @@ static void _kvm_arch_hardware_disable(void *discard)
 
 void kvm_arch_hardware_disable(void)
 {
-	_kvm_arch_hardware_disable(NULL);
+	if (!is_kvm_protected_mode())
+		_kvm_arch_hardware_disable(NULL);
 }
 
 #ifdef CONFIG_CPU_PM
@@ -1474,11 +1475,13 @@ static struct notifier_block hyp_init_cpu_pm_nb = {
 
 static void __init hyp_cpu_pm_init(void)
 {
-	cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
+	if (!is_kvm_protected_mode())
+		cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
 }
 static void __init hyp_cpu_pm_exit(void)
 {
-	cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
+	if (!is_kvm_protected_mode())
+		cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
 }
 #else
 static inline void hyp_cpu_pm_init(void)
@@ -1576,7 +1579,8 @@ static int init_subsystems(void)
 	kvm_coproc_table_init();
 
 out:
-	on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
+	if (err || !is_kvm_protected_mode())
+		on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
 
 	return err;
 }
-- 
2.29.2.222.g5d2a92d10f8-goog

