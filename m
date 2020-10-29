Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC2229EEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgJ2O6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgJ2O6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:58:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:58:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z1so1397618plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MUHxFreF4fdTU7bboIWPPhRLi/D8nJxSl4ZDICONfD4=;
        b=I5prQNYU5tqab1IAfmZ0Npzyxgasjwchz+CCyq076+/YxECJ9irL5REQHWRDrYdShV
         jM2Y9CHbIKhcjSTBzw49Xd7cj0kjYmyK6qSFFodBZuF0Vw/gVdCgm2pRnigrLwoaikAM
         NfPhzzzlvNCLa6OnTOdYnw7RyWOUzfu5Xaj5f9LVIb3Kea34JJqKoDVQwQzZDIiBfxvg
         hbK3AjBepCXhJ+bQPSwLFS9LeRaGFvViqvSWt4d0+hWKSKdGYSM06UStkCFRe22FTcL3
         jWEwctUzQpa7fU1nexbrqOK4C0QbYl1lx2kdPLoTUaKtFJIQjZeJCKZrav9GONuYdtTv
         Jjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MUHxFreF4fdTU7bboIWPPhRLi/D8nJxSl4ZDICONfD4=;
        b=Q+rEmqLwLBI3xuJg89gAyLOEP9LdzdHsFzH9TtqJzGAQJUVuRJtoAslOEZMKDUC60S
         6lBWB5NwcYcbbZEMKItmReymHSP+rR84QGrNkXhaCwx+t/FVrLGWdbmvHV/otuxl0h7q
         vxr/B0X9Pf4TztCVBULWWHkqWqY9KQIy3iy0rqz4WY1vtb1+i+OWoAp61IcTtdBnkbRA
         QzTm91musbsL/3rYNlnrgC/WkxNgsZg3FiNIRuVSYJKMPikVhEj8OLNNKasLFCQRZNEL
         A/NQOagzjiVk9AQvMS62H4Ywo2NEFf1aiP8fHZx6HrlGR0gxksWCmhEd6/bBKZt04yLU
         jBnw==
X-Gm-Message-State: AOAM533oGj9G5ufbkKKWjgw80/bDr728wEW6lzagURRBbi+QWcU0eys4
        BOfHxL8zUBniaJl8r/M1GSSftQ==
X-Google-Smtp-Source: ABdhPJwqp0xpo/eiBJyVtR3vcK/b8J0sVo6R8J+CU3LZlp/xmNnniW8nrAxtjB/bf7UgrPh+AotL+w==
X-Received: by 2002:a17:902:7d89:b029:d5:cfb6:e44 with SMTP id a9-20020a1709027d89b02900d5cfb60e44mr4658355plm.28.1603983513751;
        Thu, 29 Oct 2020 07:58:33 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.231])
        by smtp.gmail.com with ESMTPSA id j11sm3085082pfc.64.2020.10.29.07.58.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:58:33 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, msys.mizuma@gmail.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 3/7] arm64: smp: Assign and setup an IPI as NMI
Date:   Thu, 29 Oct 2020 20:26:23 +0530
Message-Id: <1603983387-8738-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign an unused IPI which can be turned as NMI using ipi_nmi framework.
Also, invoke corresponding dynamic IPI setup/teardown APIs.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 82e75fc..2e118e2 100644
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
+	dynamic_ipi_setup(cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -974,6 +977,8 @@ static void ipi_teardown(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		disable_percpu_irq(ipi_irq_base + i);
+
+	dynamic_ipi_teardown(cpu);
 }
 #endif
 
@@ -995,6 +1000,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
 	}
 
+	if (n > nr_ipi)
+		set_smp_dynamic_ipi(ipi_base + nr_ipi);
+
 	ipi_irq_base = ipi_base;
 
 	/* Setup the boot CPU immediately */
-- 
2.7.4

