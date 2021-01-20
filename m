Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251B22FD9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392683AbhATTiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392545AbhATTfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:35:04 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE009C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:34:23 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c132so15906485pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tbk7yHyGNuhhNy9mGITFNfxFfq9eBFRj4HEH2Ap7pmk=;
        b=HYPjob6T7eNm2+SlcWblb6ub3i8ydG1NS+XvkvHPa5ZQzIhoP4ByQVolCXhGFeto/k
         by2VJJxQg0wA1SywVXRo1SN5umYuv/Boh08TCaZxFLMI7Iv5f5RDWhUcsrBWJZIZ1efO
         MIYg90ljUV/hX2e1qEIWPl046ENF72Q/717pzF2MGvbszN72BmVJblcr+XMHAzTAZFAB
         YPfq9UUx+tyUTYl+T9jqKd5ndQoTVgowO4kDDPOiRerle/Ed16g0pEP21n1fARXMQWxo
         xeuACxnZmBl/B0+DljZ2YtwMvVlw2DuFrlWaFRxWk5Z7nZDBiV4q/OdeUME3Cr6L6jmF
         4tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tbk7yHyGNuhhNy9mGITFNfxFfq9eBFRj4HEH2Ap7pmk=;
        b=F0Fsf3goezejbAeNDN1LYAOb5Kxm37Il10YIlSTzm3AVOajXYPBUe1tP2aZv5bzcRn
         46wX9scpiSOVKNUus+OafXmM6WsOakz4h9/0twzm8s44QXwbd7G86S5JVl1nsG/17Lhh
         pGSMdOspDO6xmBLtWqO8VLvxhbVGUYXVnitMturoNTi1SY5NqkO3jcgh683TzyDf7JEw
         4axzRaD9+R02MLs5755RqQlHJTn89K4HhMbDtOhMzguZ61yZNpgKryX/+cx6mXx0wIRw
         wWNCuNNMVL6csw0ASRf9MXOxqdlJBJWQxqjEkB5oG3B1WKE5RwqEq56ZSXt/iS2IiPjn
         SYYQ==
X-Gm-Message-State: AOAM530AT+AutDwY7sorBO1261ACHjICh9FKvpVZ4gwnVQHbwDdPNRHq
        mxTX333zdjN4tTS1r8mx9Fw=
X-Google-Smtp-Source: ABdhPJxYTPIAKNZKB2OiHav39dJbc7ChBCYJI8k8qhDa3ZUG+ADwbbR72BbEHLXVgDFyLFVrXdgcog==
X-Received: by 2002:aa7:9f91:0:b029:1b9:8f9b:b1af with SMTP id z17-20020aa79f910000b02901b98f9bb1afmr9425253pfr.3.1611171263168;
        Wed, 20 Jan 2021 11:34:23 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v19sm3242345pjg.50.2021.01.20.11.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 11:34:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: bcm: brcmstb: Remove soc_is_brcmstb()
Date:   Wed, 20 Jan 2021 11:34:07 -0800
Message-Id: <20210120193414.2588790-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have no in tree or out of tree users of this function, remove it and
the header providing its prototype.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/common.c | 17 -----------------
 include/soc/brcmstb/common.h     | 12 ------------
 2 files changed, 29 deletions(-)
 delete mode 100644 include/soc/brcmstb/common.h

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index d33a383701dd..e87dfc6660f3 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -11,8 +11,6 @@
 #include <linux/soc/brcmstb/brcmstb.h>
 #include <linux/sys_soc.h>
 
-#include <soc/brcmstb/common.h>
-
 static u32 family_id;
 static u32 product_id;
 
@@ -21,21 +19,6 @@ static const struct of_device_id brcmstb_machine_match[] = {
 	{ }
 };
 
-bool soc_is_brcmstb(void)
-{
-	const struct of_device_id *match;
-	struct device_node *root;
-
-	root = of_find_node_by_path("/");
-	if (!root)
-		return false;
-
-	match = of_match_node(brcmstb_machine_match, root);
-	of_node_put(root);
-
-	return match != NULL;
-}
-
 u32 brcmstb_get_family_id(void)
 {
 	return family_id;
diff --git a/include/soc/brcmstb/common.h b/include/soc/brcmstb/common.h
deleted file mode 100644
index e4fe76856de9..000000000000
--- a/include/soc/brcmstb/common.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright © 2014 NVIDIA Corporation
- * Copyright © 2015 Broadcom Corporation
- */
-
-#ifndef __SOC_BRCMSTB_COMMON_H__
-#define __SOC_BRCMSTB_COMMON_H__
-
-bool soc_is_brcmstb(void);
-
-#endif /* __SOC_BRCMSTB_COMMON_H__ */
-- 
2.25.1

