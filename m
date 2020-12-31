Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7312E7FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 13:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgLaM32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 07:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgLaM31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 07:29:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225BEC061573
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:28:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t16so20008970wra.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fvCa6iOZY2KymvtycX2BW6Wl2+CUVw4rHZaH2yq9Io8=;
        b=D1u2RsFpSq249yS08YyIDcnltrFgrb2HPwijlYkTTwYhHe0/LOqd7rOK4qN0k8HP+a
         d8wCqSVX7GeN/CxFCPRogIRYXmJ5+at86ancFCA0QCJWYY4fDsFLPfYUFSAhrjTnLBYl
         MFEETsDktUbT2qKHDclRrQdcUg2nFwPfolyVIU85ebH+gqV+/Z66PW39S9uCXPbcJJwj
         v8+LjmBgmK8oiwDC1UKZHSLqLQtsNvdPCrgFbwM4Ipwl6gh3uRp11CQJUCxyePQJY4kT
         /Bka1gSIv8hKoBG7CeIH247IeVvogUoGRcBM1gUm7t+NdojD7LeU5raUN1zfcJgaYz1k
         4JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fvCa6iOZY2KymvtycX2BW6Wl2+CUVw4rHZaH2yq9Io8=;
        b=bK38K29VbkVLJTPTiMF8E54NDXqYCHO/1Bz6uCWC76G7UtXjXdNtNluUC1cCqZB3Rc
         pmy8PY04OmvvhcgU1iP2r7iofYER2iTySBk+r3fVoZdpGi4M5MIN+wCkpk+kuWsAcVNp
         UVaqym2MTFFtFe319OUewRyzz6DabVtUTlpeOHthAwY+1LuZvyYvdxw5BRyCn4BMhL/N
         tr+Fic4wnr2gUCb7YOY+QD6wwDGswZ2gzbvxlXSAmQHDLZ8Dql0MAhKAslxYk1KFUNw+
         6gRo/yKhI6ldvf3AlGzVuegYunTS4ke8nkZRNrNY+WmEAPNelNcAOxidwbL6cU489yEU
         E9/w==
X-Gm-Message-State: AOAM5328x/+2ZbipEmOWXlBym7/DmcsT2Z/vuGK84LNjDc13+jP/FJ4U
        zwl4WhRbaWzliJWRyKwh7k0=
X-Google-Smtp-Source: ABdhPJy6lUh10rPp+OH0owSgISkZsQ20JiE0pOOdWuL1UJEgbyn4cRpY1TbWhitvL5D/ZxhWZ2UWgg==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr64061499wru.410.1609417725874;
        Thu, 31 Dec 2020 04:28:45 -0800 (PST)
Received: from stormsend.localdomain ([2a01:e35:242b:e030:3cc4:754f:94e2:ab2a])
        by smtp.googlemail.com with ESMTPSA id c20sm12500619wmb.38.2020.12.31.04.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:28:45 -0800 (PST)
From:   Redha Gouicem <redha.gouicem@gmail.com>
Cc:     Redha Gouicem <redha.gouicem@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Krzysztof Piecuch <piecuch@protonmail.com>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tsc: export tsc_khz to sysfs
Date:   Thu, 31 Dec 2020 13:28:18 +0100
Message-Id: <20201231122819.13980-1-redha.gouicem@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the frequency of the tsc clock to user space. This is particularly
useful for benchmarking purposes because it allows to convert tsc cycles
into time. The value is available at:
     /sys/devices/system/cpu/tsc_khz

Signed-off-by: Redha Gouicem <redha.gouicem@gmail.com>
---
 arch/x86/kernel/tsc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 49d925043171..6ea991516d08 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
+#include <linux/cpu.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -1412,6 +1413,15 @@ static int __init init_tsc_clocksource(void)
  */
 device_initcall(init_tsc_clocksource);
 
+/* sysfs file to export tsc_khz */
+static ssize_t tsc_khz_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", tsc_khz);
+}
+
+struct kobj_attribute tsc_khz_attr = __ATTR_RO(tsc_khz);
+
 static bool __init determine_cpu_tsc_frequencies(bool early)
 {
 	/* Make sure that cpu and tsc are not already calibrated */
@@ -1530,6 +1540,19 @@ void __init tsc_init(void)
 	detect_art();
 }
 
+static int __init tsc_khz_sysfs_init(void)
+{
+	int ret = sysfs_create_file(&cpu_subsys.dev_root->kobj, &tsc_khz_attr.attr);
+
+	if (!ret)
+		pr_info("tsc_khz exported in sysfs\n");
+	else
+		pr_warn("tsc_khz failed to be exported in sysfs\n");
+
+	return ret;
+}
+late_initcall(tsc_khz_sysfs_init);
+
 #ifdef CONFIG_SMP
 /*
  * If we have a constant TSC and are using the TSC for the delay loop,
-- 
2.30.0

