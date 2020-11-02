Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A176B2A2A15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgKBLzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgKBLyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:35 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC644C061A48
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:34 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h22so9239921wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BETgmjiznwAwz+PFWQvItK4BeS3oYpLH+kOS2zV1poE=;
        b=dy+sfv06lRH6J0sMDT27XkTFTjVijNlzrQA7FASt1DkRNJh1vprWQntQ1V2bSsYJ3d
         13LNHrfF9wL6Ix+/Z8puRbiEcb61k0dc1DgXVVDPIKuzuhrOxQCNWe/4ayDZzaXZ/rvM
         R/8M19ji90My3vTue9toWMlpuHJ39hSGhjEmRcv8nL9DUG7tjHUFi9bhUld61HKRTCwb
         5i/3Lr1lr1usXG5t4MmXJ6c20yPAsN6ynGiCqvTbZQb/lCRlHhsUKwNE5+w8TM0VuFcs
         81Pf2HuOoi8mNGABlT0v/dDU6uyD6ScMM6ys3OBzZSosdm/ZV6fA9FsZzlqql9m9NqHg
         unng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BETgmjiznwAwz+PFWQvItK4BeS3oYpLH+kOS2zV1poE=;
        b=uQsWo4+dPbMLqFQelixmTPWyA05eJxa2HSWKhrVbL0CHQmVn/H26KhVHnbaoL4TH1w
         NZOqGBrVPWygnSqa4GPtH89pCIy3k/SbjDUfk426ycUMzk/1rLWImRuDP44JRqIZAf5n
         RaXtPyrttJD3fkSIrab+XXuLk9pXu014ZZsWz+SQ+MVgHuCt+4rsCyEiZq6WQglPnd7m
         YvPBtDV3Cucj9TENbJRl3zuuAliOV5Jm2KdOnrGYXINXZP04tV7dUoncC0xMK6jJC0N3
         bYO2ec9oir+bmMP1p+gFVJ9CCOgfOZkcxDEzWfxclAv/TYFNT1MUjL7/ThecxYO90oml
         3cUA==
X-Gm-Message-State: AOAM5334IQRvvE6cDN6GutxZyX60vlz2UqGGU4vtEoWCLDfDlQ1hn3Qe
        nkpUClw63u2U38ACCAPdV+33SQ==
X-Google-Smtp-Source: ABdhPJzinJikxNHvWusiDJvnHuO42K6ns2O0Y/t5ocEKoR3VX0IAc2b/iRqhp50PJT6H7Dh0PQXn8g==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr16382548wmd.146.1604318073681;
        Mon, 02 Nov 2020 03:54:33 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 16/23] mtd: nand: raw: cafe_nand: Remove superfluous param doc and add another
Date:   Mon,  2 Nov 2020 11:53:59 +0000
Message-Id: <20201102115406.1074327-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/cafe_nand.c:372: warning: Function parameter or member 'page' not described in 'cafe_nand_read_page'
 drivers/mtd/nand/raw/cafe_nand.c:372: warning: Excess function parameter 'mtd' description in 'cafe_nand_read_page'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/cafe_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 2b94f385a1a88..d0e8ffd55c224 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -359,10 +359,10 @@ static int cafe_nand_read_oob(struct nand_chip *chip, int page)
 }
 /**
  * cafe_nand_read_page_syndrome - [REPLACEABLE] hardware ecc syndrome based page read
- * @mtd:	mtd info structure
  * @chip:	nand chip info structure
  * @buf:	buffer to store read data
  * @oob_required:	caller expects OOB data read to chip->oob_poi
+ * @page:	page number to read
  *
  * The hw generator calculates the error syndrome automatically. Therefore
  * we need a special oob layout and handling.
-- 
2.25.1

