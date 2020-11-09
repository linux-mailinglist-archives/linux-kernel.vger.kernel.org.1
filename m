Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A152AC3A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgKISWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730557AbgKISWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:44 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60581C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:44 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id o15so1971049wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BETgmjiznwAwz+PFWQvItK4BeS3oYpLH+kOS2zV1poE=;
        b=tEK5zw7BKPfGyu8anHIQT7g5BzYN9V+7Ibfk9LUdpgcdPW8HrXOmNWrFhkwoCayZpS
         U0HmR6dxuP5rQ98USaAzLkneRscuHkc4cndi1Qw/HRkiatfylGA3B1We/FJdPyJ5B0BH
         cGvf91kHyzC6Zf/DCQb5H2zA460LvFgbHsVtbcYGP0qbPhEYbEaxPyGG5UdDy3WBBr8J
         AGDJvM2PkMFLnUOb2kTq7HU5P0Up0heVthk6tDgt5plEQfH1ntCSBb/V6o5UKu6Cb98P
         EDJTo6L8Py8CXuU0heeSDKnr3FtSPQ749jMwf0F+8bSOZ8fFZMPaDxQbF3ZCm8TiCQCy
         ql+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BETgmjiznwAwz+PFWQvItK4BeS3oYpLH+kOS2zV1poE=;
        b=RhddxT9t6YPm5pDpP/weNdMIQB0jndvP2P/2N9kGJLITJPNr6IxWXd3Ugi5VbaTiC7
         6avIGBupNhLXAwKTXItJSrwJfVttQp2jvFXPntjMQIIjSTBX0U0GAnu5R2ssp5SEcNI2
         zRyBWwdkRaM4AyZu8nw7F+yxcBj3t6anjgXCh1TDlqYlTTA4WaoZmTpjqgPmHXQ3rm19
         0/EWm74b5JT8Hq2NHnOpX4/RmJs/eAjNZgJLV6KekOg+TsPO1gLPCqkH7uEJFRj8CI/H
         fCV581HgqFIKbtAxfjcKeHBoBPPrARnbJ2vD58uG2/BVHw6g906rTsflzIfR3pYjvR04
         890w==
X-Gm-Message-State: AOAM530YjraZ5BTwZMFI3/HVRHNEwkJ+mIHGzsvLQwxLekRhUx/TXBMI
        JQLWXzWMGgC2MIDdf86UHtSebg==
X-Google-Smtp-Source: ABdhPJxx5vbIKT+B2Vdg99H/wUCSxi32bcw/2t1h08rRTDbqIu5u1i68o66DhK3MkL44ciR3Za7SEw==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr1576130wrs.170.1604946163113;
        Mon, 09 Nov 2020 10:22:43 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 16/23] mtd: rawnand: cafe_nand: Remove superfluous param doc and add another
Date:   Mon,  9 Nov 2020 18:21:59 +0000
Message-Id: <20201109182206.3037326-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
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

