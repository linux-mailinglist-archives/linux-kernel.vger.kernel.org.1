Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2451B2A29C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgKBLq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgKBLqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:46:08 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21686C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:46:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so10892231pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MUHxFreF4fdTU7bboIWPPhRLi/D8nJxSl4ZDICONfD4=;
        b=ha5Oh0/yhwqxHYqeV2xZYGNZplQTwHBBADatw0eeG45ZZoigfIGoiJvN6h/BlE8LyJ
         D3wjSjKFh5pBsUJ8H/tdFo7x5DNFMUeiTbC+6i/Y4qSByeviCKuXNBo0wv8LXjAk236J
         11byt/UYRUypr9OWtDMsLG/JvZAsueXssqR2zD/ndCPX1qvrB6pz06lSqlA34SzlHjFt
         JM+jXLycY1kYGYlc7ONLsn3wiRKXpJFulqZdXJmBqCbhgZqtFSM1fNWsd72mB/hQWkK6
         +JVzv6M2lFVlGa6xgfEzE8mGb2TNkrxlW2sgIiWGSsWxseIr5bPLPEuf3e7I8WETSzaL
         a0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MUHxFreF4fdTU7bboIWPPhRLi/D8nJxSl4ZDICONfD4=;
        b=h31BT4Se53jhLcAUPk7NWoTeoRd/kxT1lDHEyJOEm4r587jYB2OPtxF3h/qBP9VLcb
         9M/ltKcHXliASKufc3oFR1u7Fhb7n+yLOqSAgeV6mU1RvcZUY49oUy1TBJoi6jCUZ3X/
         9DWFoDbh0K2vJhCvGRDfz5vdYDFGe1At8wz+V2C9ShDuLNPbRyMR+aylFMKPmKh/q1Ar
         pIZgpjSkM/42uuQhcPbpZNlHzNQVRW/zYArLKYp/qrf8xC6FZfKrOSzvETSUIPdRuvQ0
         EzlJrIsWiWI1oZTqBtvXutfefe+kwv5g9qUAQERiFwG1A9Op1dZIQTr5SALi4Xx9tBZV
         VYNA==
X-Gm-Message-State: AOAM530PAOjuWXwW6WSs0j4WNCXOQslw+oLh5mWb/zWaZCG4Qc/DvgzR
        8neAPm0IlUruZZBBKencXqSotw==
X-Google-Smtp-Source: ABdhPJzuTgLuJa5NAjhe4lsISCMZZ15d16sBXJrpQCV0RydcHlai82EJu+jYTzX8/Ljhe8k6GBnDog==
X-Received: by 2002:a63:ff5b:: with SMTP id s27mr13157734pgk.383.1604317566593;
        Mon, 02 Nov 2020 03:46:06 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id y5sm14276184pfq.79.2020.11.02.03.45.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 03:46:05 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        daniel.thompson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v7 3/7] arm64: smp: Assign and setup an IPI as NMI
Date:   Mon,  2 Nov 2020 17:14:43 +0530
Message-Id: <1604317487-14543-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
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

