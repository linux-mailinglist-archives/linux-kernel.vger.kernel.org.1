Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792F02FECFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbhAUOfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:35:43 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:53454 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbhAUOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:35:33 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10LEU6cG004315;
        Thu, 21 Jan 2021 14:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=0MXIu+iQRzEA0DF9ZZBMhu5WrA+bTTc3Keto/yNgckI=;
 b=SdGf8GDmXai84lQhYDHo39IAJROpq1KIyl0N5mcZKyUZ/99+IgmIGe2bl7r3DzapvKF0
 irhG5GmjvM0/wgikvQYu97u9n/jKvCQv/1UB3TUzgxtTqsMfI94oVROBW3TsXZHHpkcF
 gtf0ZocE8M4Cr4bXYcMXXQHqlWn/mhry+AAsWGRADIiZkc6KMPfYOQdecdM+Set8HM8a
 3s+ELsgECa8Ws5uX+wj8uCe2hUbvxnC4Jau9Adfib/NWknKvxIXQ3k+WcKzZpAcsHTuY
 Sv9FNUTbMB3tnJ32ipekfJKhAF+j5JYXAkAhHfCmh0o1mNSHOR5+wJQ2hoEYoZcj7b7l vQ== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 3668raffxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 14:34:18 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 1BA5260;
        Thu, 21 Jan 2021 14:34:17 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id F2F2846;
        Thu, 21 Jan 2021 14:34:15 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav_Petkov_ <bp@alien8.de>,
        Thomas_Gleixner_ <tglx@linutronix.de>,
        Ingo_Molnar_ <mingo@redhat.com>,
        Steve_Wahl_ <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Georges Aureau <georges.aureau@hpe.com>,
        Dimitri_Sivanich_ <dimitri.sivanich@hpe.com>,
        Russ_Anderson_ <russ.anderson@hpe.com>,
        Darren_Hart_ <dvhart@infradead.org>,
        Andy_Shevchenko_ <andy@infradead.org>,
        "H._Peter_Anvin_" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Add more to slave cpu kdump info
Date:   Thu, 21 Jan 2021 08:33:47 -0600
Message-Id: <20210121143347.439867-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_06:2021-01-21,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 clxscore=1011
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add call to run_crash_ipi_callback() to gather more info of what the
slave cpus were doing to help with failure analysis.

Excerpt from Georges:
'It is only changing where crash slaves will be stalling after having
taken care of properly laying down "crash note regs". Please note that
"crash note regs" are a key piece of data used by crash dump debuggers
to provide a reliable backtrace of running processors.'

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Georges Aureau <georges.aureau@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/uv/uv_nmi.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index eafc530c8767..811997b16b42 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -24,6 +24,7 @@
 #include <asm/kdebug.h>
 #include <asm/local64.h>
 #include <asm/nmi.h>
+#include <asm/reboot.h>
 #include <asm/traps.h>
 #include <asm/uv/uv.h>
 #include <asm/uv/uv_hub.h>
@@ -834,28 +835,35 @@ static void uv_nmi_touch_watchdogs(void)
 	touch_nmi_watchdog();
 }
 
-static atomic_t uv_nmi_kexec_failed;
-
 #if defined(CONFIG_KEXEC_CORE)
+static atomic_t uv_nmi_kexec_failed;
 static void uv_nmi_kdump(int cpu, int master, struct pt_regs *regs)
 {
+	/* Check if kdump kernel loaded for both master and slave CPUs */
+	if (!kexec_crash_image) {
+		if (master)
+			pr_err("UV: NMI error: kdump kernel not loaded\n");
+		return;
+	}
+
 	/* Call crash to dump system state */
 	if (master) {
 		pr_emerg("UV: NMI executing crash_kexec on CPU%d\n", cpu);
 		crash_kexec(regs);
 
-		pr_emerg("UV: crash_kexec unexpectedly returned, ");
+		pr_emerg("UV: crash_kexec unexpectedly returned\n");
 		atomic_set(&uv_nmi_kexec_failed, 1);
-		if (!kexec_crash_image) {
-			pr_cont("crash kernel not loaded\n");
-			return;
+	} else {
+		/* If kdump kernel fails, slaves will exit this loop */
+		while (atomic_read(&uv_nmi_kexec_failed) == 0) {
+			/*
+			 * If crash exec sets "crash_ipi_issued",
+			 * ... slaves do not return from callback function.
+			 */
+			run_crash_ipi_callback(regs);
+			mdelay(10);
 		}
-		pr_cont("kexec busy, stalling cpus while waiting\n");
 	}
-
-	/* If crash exec fails the slaves should return, otherwise stall */
-	while (atomic_read(&uv_nmi_kexec_failed) == 0)
-		mdelay(10);
 }
 
 #else /* !CONFIG_KEXEC_CORE */
-- 
2.21.0

