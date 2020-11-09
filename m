Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E462AC3B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgKISXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbgKISWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB91C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:46 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so9004457wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkJ226wW4T/WFBWAXYAYxSOD3N/A9uUc453pKIqhWNc=;
        b=hnIv3xHQzK4vGHqLPgeKIlXEoxGlX40FuncVJiGSRcaWOMt6IjHpgKwD0EH4POESnm
         6mZYdUgIB4Krx0LuV3VIHbnNSdX5+/gJ5wBJc8HvoZyix/37Nusji2mRqtPKGmx/rjX6
         E7M1WhQJT0Ei+AXyGJNPeI8WDJo8itEjTgi3KFI7vl8zNWYxwwREaS7T+Dqz209xE4yk
         oualc01T7JcNNjacXTYXNZkakn8qfoZfdRkbLFOBrr1S5tx8sI3hnHVjxCnIvSVMNaSJ
         yAIrr8SLVSIbBnLA6mhM5UPNkBEyz+/E9zS8ei+kHp0IHvHIdRh0SItSjLN17df7FUMG
         J2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkJ226wW4T/WFBWAXYAYxSOD3N/A9uUc453pKIqhWNc=;
        b=B9zi7X9xoY1WMXXaQwwljMwyU64G5Od7OZNuSqACN/Zc1rD2lhga7tzLS3c3mVZBnG
         frWWh+WHeJMsl3N+t8Bci+Lbdfg/aUj4jVSQUmpArH7Mc0Tsgr/VPu3q9mfUhJXuDf2U
         6r9KyMDflNJSINwJSVqYnHfbAMFaw+WewQbIbvjiujO4Jc6Z6T5MufUINmc4xCSIS75g
         WEMdCivYhbnGze19e10PzodIrxV97kAF5I7aYhKhCuvyu2d2jrhlCQ8PKKhjC/echCOC
         O31UBf+4rxPMTzGUH+3yhDN1AWmnlSECGu/kxjTA9lQkGBjh6LL7edGbBP8K0QVkTBau
         mScA==
X-Gm-Message-State: AOAM5302wydlKpwc7QSm14iwvmMIRafwnb8ql6uzkucqGvcOeLpE0DCh
        D7XPQ//AvZPfBDm7UKRWfpzvLA==
X-Google-Smtp-Source: ABdhPJyeWbF4IXe3J+rChMedpclviC8/eufVt3JW57d/2S+UA46Kq8Z4Wfo6mzD+v6wBNgAyYwk7sg==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr20826857wrw.201.1604946165213;
        Mon, 09 Nov 2020 10:22:45 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ben Dooks <ben@simtec.co.uk>, linux-mtd@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 17/23] mtd: rawnand: s3c2410: Add documentation for 2 missing struct members
Date:   Mon,  9 Nov 2020 18:22:00 +0000
Message-Id: <20201109182206.3037326-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct 'controller' typo while we're at it.

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/s3c2410.c:172: warning: Function parameter or member 'controller' not described in 's3c2410_nand_info'
 drivers/mtd/nand/raw/s3c2410.c:172: warning: Function parameter or member 'freq_transition' not described in 's3c2410_nand_info'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: linux-mtd@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/raw/s3c2410.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index cb2d1b4e278cb..f0a4535c812aa 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -133,7 +133,8 @@ enum s3c_nand_clk_state {
 
 /**
  * struct s3c2410_nand_info - NAND controller state.
- * @mtds: An array of MTD instances on this controoler.
+ * @controller: Base controller structure.
+ * @mtds: An array of MTD instances on this controller.
  * @platform: The platform data for this board.
  * @device: The platform device we bound to.
  * @clk: The clock resource for this controller.
@@ -145,6 +146,7 @@ enum s3c_nand_clk_state {
  * @clk_rate: The clock rate from @clk.
  * @clk_state: The current clock state.
  * @cpu_type: The exact type of this controller.
+ * @freq_transition: CPUFreq notifier block
  */
 struct s3c2410_nand_info {
 	/* mtd info */
-- 
2.25.1

