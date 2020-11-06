Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597782A9F39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgKFViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgKFVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17222C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:23 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p19so1763391wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkJ226wW4T/WFBWAXYAYxSOD3N/A9uUc453pKIqhWNc=;
        b=wwgnNdAOe+PD9Q3GFnTFboZRLNCbOK5iVRKNDH4UXAYgMLHljsAHyjvrv6vbTyOCZe
         dg/K1CprVU+/O4DDaVm1Q+Yl4MJCTCuT34V0Jt4cxix4CQacddo5nu1MYPQTNDC0iMYm
         AlHrtess6Cen09LCHigFMCj5/t/4j7v/Av4gBeejtdmnwI4q0Ebxs1Q4VHxWTZlcW4e7
         7NeObc0e0V9f7epYzSlrUje8JSJM/4bE/QQXHBdt2qQVEUZWORq5pWExrJPw9MpiTo2Y
         4Cnd3lzwwtYjdxZ9ZtI4OLosLvd7QDLk27k8xoQ9yHG8uWrozz7XOhHG7f2vEZo37d3L
         HCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkJ226wW4T/WFBWAXYAYxSOD3N/A9uUc453pKIqhWNc=;
        b=UrtVmZTWJeUXQGP40q6jEUP4pdJkzsxSRMV/jUS+XoZ08r3XNKbW3yKTz+v7t5iK8y
         YcoE6d2RCRE/yUF2Jb2ypM7+90jCwlZKpItkqqMyJIG1DJns/xnEpF5AW/TYbqYI0DRp
         wGKxxAZRv5P+6cyMWp1b3lr5zTMaBrC5KQI9J3zQjqstmTvOigx0nben7KYey/3HeoDM
         QuE4kDxsG6PLx2VWIgrWyt0ROtzXnS44l4xzr/L398+BK8w22AytOaH4iEEZTAkSAVLA
         jtHbZ3JRNn4GTe/SHLceI7uqhJ3yphdJl1SRzHDBW5PKTphkZSROB8Mf/FFLxSyVuib7
         XfkA==
X-Gm-Message-State: AOAM533I1UfS3aYt0kvrIet68g4x9ueJnVd6pNiMQ5bpWWKvaE4UvFw5
        BxR13AY+jtasyWPtPqbZ/81rXw==
X-Google-Smtp-Source: ABdhPJywbY9m/AfB8+o1a2jvP+ApAocKvACDEgH2J3sDHJEx/A+oIVBnlqIrqIacyAvInCsMahP8pA==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr1687461wmc.32.1604698641856;
        Fri, 06 Nov 2020 13:37:21 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:21 -0800 (PST)
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
Subject: [PATCH v2 17/23] mtd: nand: raw: s3c2410: Add documentation for 2 missing struct members
Date:   Fri,  6 Nov 2020 21:36:49 +0000
Message-Id: <20201106213655.1838861-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
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

