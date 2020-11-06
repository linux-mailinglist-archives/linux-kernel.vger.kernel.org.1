Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423352A9F3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgKFViO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgKFVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:16 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E2C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:16 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so2754181wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWKR6uPZUpsHw9fLiQN+tCUhIOQtuUG869jNO4i86ZY=;
        b=zCmBXWoZlo8vnNneonA3NxVse4nc66IFq3VJno4tNAO9re9sUKd3L+Z0guEB98fPy8
         FXZetQdRlCWWl9rFiJQ3R+KeyJRs6Q/Z2dderjA8IfoAJGeW8LLrqnCaqhU596rbt3y7
         +c/KIIa7L7NTs39+FFknisOw843ETmBr/7dgtFzQUcRFxtSbbCdGVu4zKXJcO0ZycnNq
         M8ZcObc29z8SeR5e2m9PZajksMspnAxoA1waBuVq8MxsOiykte5wSO4cAJyOvldrxnIT
         sFFWlVHie1kacdJh4CN/bktqpiBcbAO5QTQEeoQULugFILLEPeoG8UJ32hbXOWqSnI/j
         fsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWKR6uPZUpsHw9fLiQN+tCUhIOQtuUG869jNO4i86ZY=;
        b=bDi8IORwD7YqOg9EWkQjaYjDRmOCWk4V3TWGP6YiYuWNy+pYv+gADXG81CZyssgJ/+
         PSmdQHsdOJ3HmZS7w72a5Tam6iKs22wrDRVL8KX7GiZ0we/E+2L7EDaobLQLOykOTLzj
         p/DcpYtQxW1rkS0jFOzB6zZEcZs8MoSAvGeJ+Indr9tDmX3GJl6e4iTEgY6fbTma/n9u
         Y4YBf0Q2JAOUTOE5Bn0xQ+72uYwzXB5V6Pbs6hg7/oX6l3+xYUY+qXdLb1SG1OgbEwaA
         hcpk/R/fr7SNkxYvIO4HXZMH0t9E2ON3Gtbl38LZV15mpcqqOHjKdo3oq4TDtse7m5Wt
         s5hQ==
X-Gm-Message-State: AOAM530VQxPvHprGRoce0PToqtvHJP54Vw18GYuKZWvrH7tPJBTkUaUa
        JxnZDYeo1mJlyh7QdUpM+xzgNA==
X-Google-Smtp-Source: ABdhPJweVRaOimv0frmutNHY+oLFUNaM/mHyKdwpisa5upsBks7KcYIHwklqCW0McKts/tHL+IxIfA==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr4705484wrn.253.1604698634708;
        Fri, 06 Nov 2020 13:37:14 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 11/23] mtd: ubi: eba: Fix a couple of misdocumentation issues
Date:   Fri,  6 Nov 2020 21:36:43 +0000
Message-Id: <20201106213655.1838861-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/eba.c:1304: warning: Function parameter or member 'vidb' not described in 'ubi_eba_copy_leb'
 drivers/mtd/ubi/eba.c:1304: warning: Excess function parameter 'vid_hdr' description in 'ubi_eba_copy_leb'
 drivers/mtd/ubi/eba.c:1483: warning: Function parameter or member 'ai' not described in 'print_rsvd_warning'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/eba.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 0edecfdbd01f3..892494c8cb7c7 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -1290,7 +1290,7 @@ static int is_error_sane(int err)
  * @ubi: UBI device description object
  * @from: physical eraseblock number from where to copy
  * @to: physical eraseblock number where to copy
- * @vid_hdr: VID header of the @from physical eraseblock
+ * @vidb: data structure from where the VID header is derived
  *
  * This function copies logical eraseblock from physical eraseblock @from to
  * physical eraseblock @to. The @vid_hdr buffer may be changed by this
@@ -1463,6 +1463,7 @@ int ubi_eba_copy_leb(struct ubi_device *ubi, int from, int to,
 /**
  * print_rsvd_warning - warn about not having enough reserved PEBs.
  * @ubi: UBI device description object
+ * @ai: UBI attach info object
  *
  * This is a helper function for 'ubi_eba_init()' which is called when UBI
  * cannot reserve enough PEBs for bad block handling. This function makes a
-- 
2.25.1

