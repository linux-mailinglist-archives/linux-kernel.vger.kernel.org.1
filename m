Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304E227A626
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgI1EKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1EKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:10:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C62C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o25so7173971pgm.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GocdqLYTODm0NoMZyaUYMh/e3m0B19dnr1p1DXm0VJA=;
        b=JCDThFoVyxPd9b3A/1MW/Sdi6meq9xj57CE08UCY4B7qIAP8PyoiBYp16E8y1bVavg
         ubsag0KuY+KHZyOyrtjKToCvzVq2EoiZbd+r/hjdQaJdgH9a0rROl1L9Ct+rJLjyUxO9
         fGAC5zZfP3cPNmvcfQEh2f22laEAEBUqRlt9ITfvhbHljYQ8NK+vFywAujHWkNY2dqES
         dKyj9xPsHrl8wlxVwnZjLirxYI947CjqiJBovKyoweHfGedtv0i+P5CAhsUW6RsMsIHp
         gIVD8T6an6PiMCu9riDspMnUL3G/1AUVNiMCCMLMzbHPY07rt7oyFQkdBV9FCDYg1NQc
         pOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GocdqLYTODm0NoMZyaUYMh/e3m0B19dnr1p1DXm0VJA=;
        b=oMvEacFKPuthF8qqbYLSu7/AVbSI2ZstB78dfh486hoRpYiy7YOXjviqeWTsDr+qhz
         g8k+Y7U3BZ+XXFp7giBRexVyq/GG9lzdqPrUSrdzgkNqndXAe9h03w9ijS7EQkp1bl1O
         ZJbt9jfOa4ueZ8TNCUlVHcqlBX+6DlNFsu/+ZURT8sEA7jbJGEkI9ndxvUawklZtSC4X
         E5nnus4aqHWEZx3iwgN96FYmZQB5pGqKYcnYHUQP97cPUZf+gmsztNIUoSjfK+YITnTI
         hrHksNfVGgg8XDga2sRHaIkakjRGlHEEgSYnPfazl4sfmZAR4oECE3ekgXZCKkoQoQdo
         ppXw==
X-Gm-Message-State: AOAM533IrXfa/Xag9+6OtSldLqEOL1HXyN8K/rToysWS7AqcR3omrpWB
        Hhg+nnCIm7bkNhT5lhiYVwwp
X-Google-Smtp-Source: ABdhPJxVT1maMqXRa4scqbmEviqWptyut/JIa0Gzcefg59Q5HEIOuGXBzHyHjrmji/3Vw4wHPkaYow==
X-Received: by 2002:a17:902:9b89:b029:d2:42a6:88f with SMTP id y9-20020a1709029b89b02900d242a6088fmr9695952plp.71.1601266242364;
        Sun, 27 Sep 2020 21:10:42 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:10:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 03/21] bus: mhi: core: Abort suspends due to outgoing pending packets
Date:   Mon, 28 Sep 2020 09:39:33 +0530
Message-Id: <20200928040951.18207-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Add the missing check to abort suspends if a client driver has pending
outgoing packets to send to the device. This allows better utilization
of the MHI bus wherein clients on the host are not left waiting for
longer suspend or resume cycles to finish for data transfers.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 796098078083..661d704c8093 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -686,7 +686,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 
 	/* Return busy if there are any pending resources */
-	if (atomic_read(&mhi_cntrl->dev_wake))
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts))
 		return -EBUSY;
 
 	/* Take MHI out of M2 state */
@@ -712,7 +713,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
 
-	if (atomic_read(&mhi_cntrl->dev_wake)) {
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts)) {
 		write_unlock_irq(&mhi_cntrl->pm_lock);
 		return -EBUSY;
 	}
-- 
2.17.1

