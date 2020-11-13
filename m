Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91A22B1E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKMPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:06:33 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51479C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:06:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so8783043wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6O+JmTd7OSlnPV06boaBBFveFRRN3XWMhK2wrrY0xg=;
        b=F94NbCxB+lEMiO4/fwMQDTjCdnAmBRCjHfAtrinB3kQ4+7+SXEH5wNUza7BtqAR2FN
         qK19yOApXiI4xMQhnVwkidB4uCW7XIhYXrhUd7sYDj8emMPJ1oMq1BMQKdUEC8c6jo1W
         16O2fnlp3CN+kb92H9umJ7BWwO9QfevuY37g09l1w/dPKi0zAun2K2bHYkeL2FkGl5vN
         n3T3w/9kcDCsJz1tjQi6legJd3qBRPFxcuNyfmQOKMmMkeyI67dnjmb9u/IGdm1JKmBA
         uwx6l55RvKF3A6WqryCQ7QLWtjaAm6el5xd9kQBwXu8WADu6+4cWACSnJjLrrC9OH2Qb
         SnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6O+JmTd7OSlnPV06boaBBFveFRRN3XWMhK2wrrY0xg=;
        b=IAudnuzyiE/olqIJ6az+OsRCGiZ4GX+p48NIG1csUpraInNIL6rXi7vcCGWVIwpBbM
         wpcclmlAVB1DnwIH2D+w6gaZBs1O3PyfIn3b0mqkLG0L8yxzku9B7T40SZ6+D5lT21Fp
         yeE8fVPoOdr2iD4N7qjAl1R4om5NOLWf3Ktq6/Kd0rGNiJa9aO/UTvsbQNN2ZdSTj6zN
         /Kr+Bql1Qth1A7WlcJ0AwHl9YE744oqvCyF4r6YBkZaZZ3wGoMpNMaurtqV7aDQjKz+S
         tH0iB2004nop9qWUL95h3eJif4G8G4HU3lN6X34XmD4HohcfZaKNuTra9UORgY66VHSO
         dVKw==
X-Gm-Message-State: AOAM532vLZq6Qh+IxZQpGP0Vp4/Vr81wGycwOuTjGGJ5W20a2A1vuAg5
        Cw2cuWqr4+XQRKA3F/Yl9Ejx5Q==
X-Google-Smtp-Source: ABdhPJzHvZod0Kx4nTCcJrjfewRNR3UUkzGDyxxrfPKrY7LkIsnrAzrAuKKvv5sw6VTrry+15Q0NaA==
X-Received: by 2002:a1c:a555:: with SMTP id o82mr3009941wme.188.1605279977972;
        Fri, 13 Nov 2020 07:06:17 -0800 (PST)
Received: from arch-thunder.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id m22sm11615092wrb.97.2020.11.13.07.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:06:17 -0800 (PST)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH] optee: add writeback to valid memory type
Date:   Fri, 13 Nov 2020 15:06:04 +0000
Message-Id: <20201113150604.426784-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only in smp systems the cache policy is setup as write alloc, in
single cpu systems the cache policy is set as writeback and it is
normal memory, so, it should pass the is_normal_memory check in the
share memory registration.

Add the right condition to make it work in no smp systems.

Fixes: cdbcf83d29c1 ("tee: optee: check type of registered shared memory")
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>

---
 drivers/tee/optee/call.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 20b6fd7383c5..c981757ba0d4 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -534,7 +534,8 @@ void optee_free_pages_list(void *list, size_t num_entries)
 static bool is_normal_memory(pgprot_t p)
 {
 #if defined(CONFIG_ARM)
-	return (pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC;
+	return (((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC) ||
+		((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEBACK));
 #elif defined(CONFIG_ARM64)
 	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
 #else
-- 
2.29.2

