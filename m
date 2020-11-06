Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439862A9F22
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgKFVhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgKFVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:02 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE60C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:02 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so2620544wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6k1rgmOCefV5rf9QkuupaTuT0YgnMPjbaR9fAX+QknE=;
        b=AvQYLR03xbicnhIfWhXEPPViOHs61cAWDcBBAqxMIf4hhzRHHR1/rYaxTzWUcYQ41l
         jBKu18wordjr8dVoLYX0J0VdnqWCmrXmE0Xxrr5bxuVMV4Li3B6SmzTdS6QnK760I+iC
         r0w56fOvAfzLGwxhPA5akV/jLc0Dor1wwDU+IGgFo8G6vvUHtbf6CmQfUcIwedXCrsrr
         ZVdAgDCcBPe+e+zYqr68HGyPRUgJecO462ljdpDLnm5aFTHMJZpgG6GnBb8KONOTt9g2
         uixz6/8oSZb/9BA8H+UJuX6uzTM8PDk/IV+6Mu592JQN09pGrylflCQvp49U8sseQ+V1
         yRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6k1rgmOCefV5rf9QkuupaTuT0YgnMPjbaR9fAX+QknE=;
        b=CmujsNwEkdAVKbiM9fAccsPI1Y3gu49fRXWmlERFnL1mfNrZgWPPsv01JOb+61JgYC
         dbkOvj6j75sPq9yxM6ttXDAQL/Xjj/8TM/1KF6GjLgHVmAoV4l7cA9Jjc+hLxCIdA/tQ
         2G8keKBFcfQeaixcFQmxV/ZFUdI9gTWC9Qeaaci0dSWf9YQdYxr42j5hPPOUM5WayeUp
         SGG/Y6/EaN8zh2tOBqtfIKGWmP/aM8eY7HAmFDGWolziInhLEdMfmZtFPhMQE1u/W2I8
         l0/9hAEBZo/fLvbJABJpXcZa+MnieuD5lydsv1yrI6y90E7FWRLg4XiuMngplICT6v9O
         IdLg==
X-Gm-Message-State: AOAM530nuqnyeIP90gbX+OJf4CXh6LRE6WPlJspLaasClCAC8kuZ++HF
        dOQqpT5jN8LcEWumAkEdhdcVpQ==
X-Google-Smtp-Source: ABdhPJw7xOxgjhcgn6FMqkKjYsYsVmh6Zz4R7JPa8fQGkd5zlGpQDeGaqfi++qYp1PxK9RHRq9rQ+Q==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr1686324wmc.32.1604698620981;
        Fri, 06 Nov 2020 13:37:00 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thomas Gleixner <gleixner@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 01/23] mtd: mtdpart: Fix misdocumented function parameter 'mtd'
Date:   Fri,  6 Nov 2020 21:36:33 +0000
Message-Id: <20201106213655.1838861-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/mtdpart.c:300: warning: Function parameter or member 'mtd' not described in '__mtd_del_partition'
 drivers/mtd/mtdpart.c:300: warning: Excess function parameter 'priv' description in '__mtd_del_partition'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Thomas Gleixner <gleixner@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/mtdpart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index c3575b686f796..12ca4f19cb14a 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -292,7 +292,7 @@ EXPORT_SYMBOL_GPL(mtd_add_partition);
 /**
  * __mtd_del_partition - delete MTD partition
  *
- * @priv: MTD structure to be deleted
+ * @mtd: MTD structure to be deleted
  *
  * This function must be called with the partitions mutex locked.
  */
-- 
2.25.1

