Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC652A9F30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgKFVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgKFVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:23 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w14so2748853wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BETgmjiznwAwz+PFWQvItK4BeS3oYpLH+kOS2zV1poE=;
        b=nffO+72FegtWIuRQmVOjyQ3YSiqmz16iu6IDBvNnyWD51uId9oSzigR7mWrDp28h2q
         b1ci3TdGgL2M4lLtpOTLekGXKiYt+60aXo5YqXNe1XYYTOAqVyGyz8CVToiqiFTweNaX
         FsN52+nl19OXuJmO/u/zcARgVagxc8IQIZtN2jG6H79hpAPYvuHc077940+7qYcgvwOW
         NN/OIydgWJjGB8SKr5n8OvLQ/k4OInYT0d6kbBXMowEzwX3L3aNCr002eFVOXKvmKub9
         AJ2hR/oU9E6TombBZ0VhBI8XbaTrDRJrKKLUJc9o96j7xfweHYxc1mgHGVcWJSYXf0+T
         rfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BETgmjiznwAwz+PFWQvItK4BeS3oYpLH+kOS2zV1poE=;
        b=ICr0WaY64VICzfdhPB5WJATThtLEAGHuAlfO8cVSEFHvFEjRZvmN6fUlHbOVUtfTDZ
         pgaAgW/jsAH9Ecw5+kT0yjhEqcTDJbz9fWvq2inJu7zepCEU8Wm265oKOJXvL/9t3JUk
         GilGynfIqqODJZImZ1K480ghQoW8dvEWleE2sfuIV/iMt5nR0LBX2bl3ZB6AnsHjg4tS
         7w7SEfPwuXLnFSy4FoYfjc6jMelUb+axEvSio5t5ztG55OU4kj8TX9oIjZAdwGT3WoVD
         sC9ZSo14AfAmojtYF55lFqayuUfKGCNJTl3mYEz3pEUCuH9QhyyUccDCqj6wYznB+EK4
         z3tA==
X-Gm-Message-State: AOAM5313P868roQoTLPmoQ/xv/fzx9eThgAn170rYKRoKh/hJ1MZHTKu
        vfWsnnuzw9IPDb0H1at947qsEQ==
X-Google-Smtp-Source: ABdhPJyVEKkwXeg3F+JfX7J/ase1Dpn0AEKSB+i4LnGqyQzbUXXYNF3TUjX8D8K/i5s9EEgPuw1cXg==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr3250741wrp.276.1604698640687;
        Fri, 06 Nov 2020 13:37:20 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 16/23] mtd: nand: raw: cafe_nand: Remove superfluous param doc and add another
Date:   Fri,  6 Nov 2020 21:36:48 +0000
Message-Id: <20201106213655.1838861-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
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

