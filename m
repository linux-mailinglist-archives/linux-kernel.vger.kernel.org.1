Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18AF28DFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbgJNLNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387430AbgJNLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:13:05 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EBCC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:13:05 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p11so1581331pld.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EUkHDvfGVE/Mcc9y3ck7YoAw/1fhaX3NtNSY/g0jhfY=;
        b=FYmcxhvH0YuLvemO1AyMtpefAmnRpXGpQXtcK0AOZ7sP5KXApkDaiAxscIbi25/JS7
         oub8Nuu9A7q/RCNQ4DsUKWc+34EOV/1Eekj5w/Oxz5qL3/jAJjrpVCKWi8dCbv6jVjo/
         3loFSiCsh4GLzrebFVrFKst9Afli9pXjJ7VsPDNN/L/6oSpaWDtwSHxhGKl3D9l6HLLV
         ruPFCUKH/09wjzTZn+a2Z0CpJy0lxl6UnKDYkRPE7TRtWvgBMKFB4K8k7pKeFDLz7Len
         R4887268UA0WpU6UxYBP5N99gQrZHa96GMl6+Jy7F88LVtmVll9z5F384pI/oSbI+7mZ
         xecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EUkHDvfGVE/Mcc9y3ck7YoAw/1fhaX3NtNSY/g0jhfY=;
        b=BNRtiBN8RAsr5T3GAHCoxUd4O9LGCjc4pYBdAOHzGWAAGQesfIW9NpdCEUz2UBCv7y
         NL2L68jWcGcvhE6hWlCMbSivW0CmoTGDJA4MVtk3Isk5h//dzkPsF7PZ0eTFLVjdeaTg
         OFUmk6JtSWNmpo4ldZY9rQOPSY/DueGcwUZ4la/MvfOv1KVhR2XnRutUwUR/9MRnwFfo
         LHo4JOqDSJdB7ia3xeUgMvQlOaEZWY85uWf2ODMmvlb/6n2xSlCVtzJgQ7RE51w5Xusi
         xt29/c2sLbmR7uBW6VRrjqPYwYA4uVqeSrtftNWrCyhxlmJF7/Wowd2JZg9jikMwdNU3
         teLQ==
X-Gm-Message-State: AOAM532SJ5I499MJAhPTzcH7/I6r5/oLoXVsp+O5Di+XaVAVTRBGbFBq
        KeXKcmMUqe7FizZ6KEJ+oQDoDQ==
X-Google-Smtp-Source: ABdhPJw/CZvq+k4z2trU3PIw1LtcMHYqbyozAmkwTA7XP6H6ZXN05RSuiZF6PfflggOwwVnj6abBpQ==
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr3083885pjb.129.1602673984880;
        Wed, 14 Oct 2020 04:13:04 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id f21sm3060102pfk.169.2020.10.14.04.12.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:13:04 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 3/5] arm64: smp: Allocate and setup IPI as NMI
Date:   Wed, 14 Oct 2020 16:42:09 +0530
Message-Id: <1602673931-28782-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate an unused IPI that can be turned as NMI using ipi_nmi framework.
Also, invoke corresponding NMI setup/teardown APIs.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 82e75fc..129ebfb 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -43,6 +43,7 @@
 #include <asm/daifflags.h>
 #include <asm/kvm_mmu.h>
 #include <asm/mmu_context.h>
+#include <asm/nmi.h>
 #include <asm/numa.h>
 #include <asm/processor.h>
 #include <asm/smp_plat.h>
@@ -962,6 +963,8 @@ static void ipi_setup(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		enable_percpu_irq(ipi_irq_base + i, 0);
+
+	ipi_nmi_setup(cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -974,6 +977,8 @@ static void ipi_teardown(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		disable_percpu_irq(ipi_irq_base + i);
+
+	ipi_nmi_teardown(cpu);
 }
 #endif
 
@@ -995,6 +1000,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
 	}
 
+	if (n > nr_ipi)
+		set_smp_ipi_nmi(ipi_base + nr_ipi);
+
 	ipi_irq_base = ipi_base;
 
 	/* Setup the boot CPU immediately */
-- 
2.7.4

