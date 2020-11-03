Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1382A49A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKCP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgKCP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:24 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61359C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:23 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a9so18972858wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zC5D2p/xr7Fk60uw7MynDrZ9h8BCpXQy0RvjfGe+1nQ=;
        b=L81ntYaHpJVSVMwlmCDVHWhzMT5mZEkEYb3TfZT54dRDZbF/2fAmBH/tYn+EHe8f/N
         qRqOBPhCq5HPuPqW3ZywOTOxQ/e2lhdmE92/+ffTDLoPus0xSi9MrD8xsJcbflQ6skHS
         7oIVUwnfoczrgMSgnR4f1zsJcYliqfJTnCV28/GbcBMWs7zOUEsUkOvl9U3FgQginXRa
         /iF9OQSomCNG16BNWWmuvQ1a4rfE0oxUJF+Bua0lGe/lL/rbwRmbzWkAPzkVi8Hr8Ulw
         xCX0khVc7K7QxFb9AxfZpoTNOm9Cx7N16w3iEjaB0DZz+oVcSqUTWfeCLWPvefLn0gSB
         2Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zC5D2p/xr7Fk60uw7MynDrZ9h8BCpXQy0RvjfGe+1nQ=;
        b=adb0jW0EftG1xFtbUg903YY9+jIr64gr8yWxTeStg01mgrrjCdF0btG8haoACzDdu5
         Vj8tIQVniPTbGj46WlwLqid55WR19fMAQUMtoqMVQnf+f8Czrl+maxeYwOUHX9qCYR5i
         oVcKN/RHyZ3Y4Tx2qVIyGHOsCW3gYSnBLQVQvmaTIGBzoFGWA+4KfQLsUIZs7ReB6gX4
         VP8j9oShJkoy9N4UyZscQctyBaeK3NpF4knrvqLWo9PNT0kESkRrAQs1qKT1pvZCPMOV
         +inUbRHoExPQ/HAs59d9xftlT+1sPOgmN8WK2yGSDsPxp5X8eCBgFTR8+U/d505hhv/0
         lIxQ==
X-Gm-Message-State: AOAM532BMPAXtCWK5sjhrl+TEJbrgundC4v+betXaZYnJVlYi42FO9w1
        08Y4RFy+LlwTF9/ItPq3sM0btg==
X-Google-Smtp-Source: ABdhPJwedN3NHZaPzKkzJC8epN0pbExQPzAYf4Qio8MK0dC0y0OkpHqydACglCuTMBSdkqkxI7grAQ==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr28774236wrn.271.1604417362112;
        Tue, 03 Nov 2020 07:29:22 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: [PATCH 09/25] soc: ti: pm33xx: Remove set but unused variable 'ret'
Date:   Tue,  3 Nov 2020 15:28:22 +0000
Message-Id: <20201103152838.1290217-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/ti/pm33xx.c: In function ‘am33xx_do_sram_idle’:
 drivers/soc/ti/pm33xx.c:138:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/ti/pm33xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index d2f5e7001a93c..9c0670ab6be6f 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -135,13 +135,11 @@ static int am33xx_push_sram_idle(void)
 
 static int am33xx_do_sram_idle(u32 wfi_flags)
 {
-	int ret = 0;
-
 	if (!m3_ipc || !pm_ops)
 		return 0;
 
 	if (wfi_flags & WFI_FLAG_WAKE_M3)
-		ret = m3_ipc->ops->prepare_low_power(m3_ipc, WKUP_M3_IDLE);
+		m3_ipc->ops->prepare_low_power(m3_ipc, WKUP_M3_IDLE);
 
 	return pm_ops->cpu_suspend(am33xx_do_wfi_sram, wfi_flags);
 }
-- 
2.25.1

