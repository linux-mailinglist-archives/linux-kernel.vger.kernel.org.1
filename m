Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE6263F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 10:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgIJIYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 04:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgIJINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB0C0617A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so2642559pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAMkA/3aTQh3mdGZj/s1RlXHfKX+QtUH/LE8w7z4tNM=;
        b=PvWbMzOnFtWQG7qRDUDebIfvp3b0vep5Vm+TYLouDMuStueEpBGd9QWdcTD4jmPET0
         X4zjzDbVchMg/rUagEeQ1yc4Ixkob9NFN0BnNHZJUUQ5F2Aw48QDKfPb7PzzxLJJFZFW
         GDMV6APA7h0vtqlPfh/xgG8pdQXyE8S2HubJAfAZ3Fuw13Fu1PEZIEyUeERbred3sBxQ
         rdmqLaqm0b8ER/rmj+QxM7Y+7gcj3welCaMFl8WtDQZcMUSp1kCdIdkQ2L1W08SBjeKX
         1VMTa3vI0+Zg8KuhDU6o3asro/KMBqYZ/PJElUvbL2NoSQki1UH4EcUJusRZHMuvXKDS
         qZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAMkA/3aTQh3mdGZj/s1RlXHfKX+QtUH/LE8w7z4tNM=;
        b=MbvRZJFLw7Lqn1SFsB4wrCR4NutC0TMh2zQrlGbxU9BoJRjC8hXN0Nv9XODGdysGgi
         sFjLMKfNcXxQLbO+82BKFtOabMTN+8Plp0sZIXGxTZ5PZm3CzMY3jdUzdLdCbf8gqfwJ
         nC0G1A8+FvqZ0Tw5CWENMR0r2dwTV1A8Q7mq2eQjjn8UNIW4xi8qGtHH9Ahhuj3AoCxO
         jpVv1Y7D63dCysVbH8bn+frntgkbmjszB/468CHqMNwnxIV8j7q23mCeZTMKSlvEhaQ7
         x85saROVsl275kH73PDy/51KNOckHWeXWQ0aeVTipybICv7+uo/eI1U4ErhYW6V4egf+
         IPkg==
X-Gm-Message-State: AOAM532+VGwgcMJiBsAHL3/vAGvXEMNBh2M1TMGp5fxiwTRNWAULsXP2
        cn7ay3KMdVg1els/HE/piQ1VQQ==
X-Google-Smtp-Source: ABdhPJy8nneeaWVGjwiPRu79njgkLzOSXvUGKyeGFNacBm2bYWxvlsvTKJ8s3tl5ESmpSz7GBadkvg==
X-Received: by 2002:a17:902:7c07:: with SMTP id x7mr4303470pll.119.1599725594937;
        Thu, 10 Sep 2020 01:13:14 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:14 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Han-Kuan Chen <hankuan.chen@sifive.com>
Subject: [RFC PATCH v7 18/21] riscv: Optimize vector registers initialization
Date:   Thu, 10 Sep 2020 16:12:13 +0800
Message-Id: <7214a2bb57fc9711b38a49f398780241389e73aa.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch optimizes the initialization or invalidation of vector
registers. It can reduce the code sizes of vector_flush_cpu_state()
and reset_regs().

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
---
 arch/riscv/kernel/head.S               | 30 +-----------------------
 arch/riscv/kernel/kernel_mode_vector.c | 32 ++------------------------
 2 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 74f2fd8430e0..2fbb4df368b1 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -375,39 +375,11 @@ ENTRY(reset_regs)
 
 	li	t1, SR_VS
 	csrs	CSR_STATUS, t1
-	vsetvli t1, x0, e8, m1
+	vsetvli t1, x0, e8, m8
 	vmv.v.i v0, 0
-	vmv.v.i v1, 0
-	vmv.v.i v2, 0
-	vmv.v.i v3, 0
-	vmv.v.i v4, 0
-	vmv.v.i v5, 0
-	vmv.v.i v6, 0
-	vmv.v.i v7, 0
 	vmv.v.i v8, 0
-	vmv.v.i v9, 0
-	vmv.v.i v10, 0
-	vmv.v.i v11, 0
-	vmv.v.i v12, 0
-	vmv.v.i v13, 0
-	vmv.v.i v14, 0
-	vmv.v.i v15, 0
 	vmv.v.i v16, 0
-	vmv.v.i v17, 0
-	vmv.v.i v18, 0
-	vmv.v.i v19, 0
-	vmv.v.i v20, 0
-	vmv.v.i v21, 0
-	vmv.v.i v22, 0
-	vmv.v.i v23, 0
 	vmv.v.i v24, 0
-	vmv.v.i v25, 0
-	vmv.v.i v26, 0
-	vmv.v.i v27, 0
-	vmv.v.i v28, 0
-	vmv.v.i v29, 0
-	vmv.v.i v30, 0
-	vmv.v.i v31, 0
 	/* note that the caller must clear SR_VS */
 #endif /* CONFIG_VECTOR */
 
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 108cfafe7496..b84618630edf 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -86,39 +86,11 @@ static void vector_flush_cpu_state(void)
 	long tmp;
 
 	__asm__ __volatile__ (
-		"vsetvli %0, x0, e8, m1\n"
+		"vsetvli %0, x0, e8, m8\n"
 		"vmv.v.i v0, 0\n"
-		"vmv.v.i v1, 0\n"
-		"vmv.v.i v2, 0\n"
-		"vmv.v.i v3, 0\n"
-		"vmv.v.i v4, 0\n"
-		"vmv.v.i v5, 0\n"
-		"vmv.v.i v6, 0\n"
-		"vmv.v.i v7, 0\n"
 		"vmv.v.i v8, 0\n"
-		"vmv.v.i v9, 0\n"
-		"vmv.v.i v10, 0\n"
-		"vmv.v.i v11, 0\n"
-		"vmv.v.i v12, 0\n"
-		"vmv.v.i v13, 0\n"
-		"vmv.v.i v14, 0\n"
-		"vmv.v.i v15, 0\n"
 		"vmv.v.i v16, 0\n"
-		"vmv.v.i v17, 0\n"
-		"vmv.v.i v18, 0\n"
-		"vmv.v.i v19, 0\n"
-		"vmv.v.i v20, 0\n"
-		"vmv.v.i v21, 0\n"
-		"vmv.v.i v22, 0\n"
-		"vmv.v.i v23, 0\n"
-		"vmv.v.i v24, 0\n"
-		"vmv.v.i v25, 0\n"
-		"vmv.v.i v26, 0\n"
-		"vmv.v.i v27, 0\n"
-		"vmv.v.i v28, 0\n"
-		"vmv.v.i v29, 0\n"
-		"vmv.v.i v30, 0\n"
-		"vmv.v.i v31, 0\n":"=r"(tmp)::);
+		"vmv.v.i v24, 0\n":"=r"(tmp)::);
 }
 
 /*
-- 
2.28.0

