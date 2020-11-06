Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727262A9F37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgKFViD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgKFVhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:24 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE9FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:24 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v5so2819274wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc+oP6vugsB/NFox5ee2E+FED0ZhjBIzS6GFVD2ExkM=;
        b=j4KGRdPEohicZL6AoYC4Hdrh+N2e2xqMn+HVwrhX4+LirOMr4k8k4c3gBDb4TBe/Ej
         CCNbwys4IwnHNxIlOHzM44fECTrBZyrnvu6wGNldLEOX5C0IV51hvmGa3DZ64QTdSztT
         JMzNSCxsfs0jj9G5p/P9vly6Pl7fBkTElXddglJPv+rP98dwOOJ+IKCbT6CLyPFC5vEd
         +DidaTOsKuw1WVQmAHdmZUkK9FguedLqNF8z6FX/NFi4lSNfjfxlyuEJXGUWmR59gTh7
         krSCjn5tLcgzi7iQT8YV/v3z5ktHaKNGMpbPN0tWJSjZZwC9CHdE650upzC28RW1L9jJ
         y1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc+oP6vugsB/NFox5ee2E+FED0ZhjBIzS6GFVD2ExkM=;
        b=EiQCfG/BSimR/yQdY6ne+mh2VQjcdMUHD3RXUuLQUMLAfRrapiZnKi929IcK2+8HSg
         y5rC9/tA1ctQ4rL2pockOI0lJpn1N90i1NB2RHUal7IVvBShXJttubl1dl84OQTAs72m
         WmnxemxNLkavmH/M72xhybjwBI0Fizx+EvG/U2T1gFVSXYgipiBY2r6uoI41qPEBVhqJ
         Kt/9sSh12K9dBoY4q5LZjPI0tOY3mkhO8V71j6K4TmF153q6x5Gwp2LBdJZuoImXNDFq
         5qQvkwHG1P/M2b+sp+ZjY7PddxPNu2OO+aqYiftQpd8NhUnuaHzccXZLCeIfyv2THigW
         9kpA==
X-Gm-Message-State: AOAM532+tEXLmq4v+a+3TLKIWkSFCJvHvGmvrCQKQWCVFdbvZ7h6cVTH
        BHiPIz0DmxH+zq38E1+adc33xA==
X-Google-Smtp-Source: ABdhPJx+Gg7TbjUnEsKHvVRaccOTl2/Z21JqzqTfeRd2E5eRubD7f2fqYKN+VHTN1B56U5EWIUyz0w==
X-Received: by 2002:a7b:cf31:: with SMTP id m17mr1571554wmg.62.1604698642984;
        Fri, 06 Nov 2020 13:37:22 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 18/23] mtd: nand: raw: omap_elm: Finish half populated function header, demote empty ones
Date:   Fri,  6 Nov 2020 21:36:50 +0000
Message-Id: <20201106213655.1838861-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_steps' not described in 'elm_config'
 drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_step_size' not described in 'elm_config'
 drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_syndrome_size' not described in 'elm_config'
 drivers/mtd/nand/raw/omap_elm.c:440: warning: Function parameter or member 'info' not described in 'elm_context_save'
 drivers/mtd/nand/raw/omap_elm.c:488: warning: Function parameter or member 'info' not described in 'elm_context_restore'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/omap_elm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 4b799521a427a..550695a4c1ab0 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -96,6 +96,9 @@ static u32 elm_read_reg(struct elm_info *info, int offset)
  * elm_config - Configure ELM module
  * @dev:	ELM device
  * @bch_type:	Type of BCH ecc
+ * @ecc_steps:	ECC steps to assign to config
+ * @ecc_step_size:	ECC step size to assign to config
+ * @ecc_syndrome_size:	ECC syndrome size to assign to config
  */
 int elm_config(struct device *dev, enum bch_ecc bch_type,
 	int ecc_steps, int ecc_step_size, int ecc_syndrome_size)
@@ -432,7 +435,7 @@ static int elm_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-/**
+/*
  * elm_context_save
  * saves ELM configurations to preserve them across Hardware powered-down
  */
@@ -480,7 +483,7 @@ static int elm_context_save(struct elm_info *info)
 	return 0;
 }
 
-/**
+/*
  * elm_context_restore
  * writes configurations saved duing power-down back into ELM registers
  */
-- 
2.25.1

