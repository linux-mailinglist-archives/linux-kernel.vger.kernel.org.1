Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8048A27A641
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgI1ELn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgI1ELm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:11:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1501DC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so7158128pgf.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5NHMOfzoZtUI9mNkF0dRKXjszoqYK7ekBI5K8v9id0=;
        b=FwfRqc2fUQHMLsff4W9Dft9bi2yyvQYDrmzhkFpw/ePGL6JsK5V9BP8YcCCNn0fYrQ
         wbrH0hWZq/8XHqJAB92g+tPafACCwA7Qzr3FWZisvCLR9itF/CTRVEhN8kt4EkgvjfIA
         J2pigzAWswiWIdOiFcuaaSy5vCumaaeXIwRUwXgPu4xqkpG+ePlwtmdf/HM/e0h82fU+
         p3E7kFTasvX84jakIGzFD0eymH0Y6zvCP2y3aKFu6ExHPkYUxshzzGptE2VkhJB2gu0H
         e9h4OsZBJTJy0qyR66wl8skGLTl3VleiwiSYeAkE8yFKM9ZizZO9M08DfGkw0KtRnFCD
         WODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5NHMOfzoZtUI9mNkF0dRKXjszoqYK7ekBI5K8v9id0=;
        b=G2jXHzPtu3BbDIbxz9rEqUAtI397Tec8+0XC3mnOwmdNT3RfexM012bDZtKt0WfFrf
         RLrAKn9HHI4H2jIkmeXlVjsSpd5sJarO7EWfdJZRcdhz0hxPBLksOgVY9uZhmfELVdGL
         O/1ccStrR9U0fv30RyMei3ZvWlxydweKyzT+Zqw/UoC0KzKcF5nxM5hZuDdBcy73LIQM
         dtD2izLWKzIiS0Fluz03sgCVZvVkXns8tMOTfuv0eC/K0jLQjvKork3/QuuCmJ3Rp2TD
         w92+yN3QZeTelczbBkaJOpCM4tgjiGC6C/Vq5lmA7jb7USE5eefgV7Rau8FRacbfjrvy
         4hDw==
X-Gm-Message-State: AOAM531aGnSIrHeboFIByTepPydS7XuKwdniSCzNSy2QCB414EMVjaXD
        ppQ+2dwA/Fqacxkk//kKsRka
X-Google-Smtp-Source: ABdhPJwBP30K9zmOpXBvNlFlCfq6/G/amVrj8J2SLRxb3vgucuwV1w2iD79cymQmb83qh4yZAMds1Q==
X-Received: by 2002:a63:4945:: with SMTP id y5mr7423665pgk.181.1601266301533;
        Sun, 27 Sep 2020 21:11:41 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:11:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 17/21] bus: mhi: Remove unused nr_irqs_req variable
Date:   Mon, 28 Sep 2020 09:39:47 +0530
Message-Id: <20200928040951.18207-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

nr_irqs_req is unused in MHI stack.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 3 ---
 include/linux/mhi.h         | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 103d51f35e28..0ffdebde8265 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -680,9 +680,6 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 		mhi_event++;
 	}
 
-	/* We need IRQ for each event ring + additional one for BHI */
-	mhi_cntrl->nr_irqs_req = mhi_cntrl->total_ev_rings + 1;
-
 	return 0;
 
 error_ev_cfg:
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index fb45a0ff9aa3..d4841e5a5f45 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -312,7 +312,6 @@ struct mhi_controller_config {
  * @total_ev_rings: Total # of event rings allocated
  * @hw_ev_rings: Number of hardware event rings
  * @sw_ev_rings: Number of software event rings
- * @nr_irqs_req: Number of IRQs required to operate (optional)
  * @nr_irqs: Number of IRQ allocated by bus master (required)
  * @family_number: MHI controller family number
  * @device_number: MHI controller device number
@@ -393,7 +392,6 @@ struct mhi_controller {
 	u32 total_ev_rings;
 	u32 hw_ev_rings;
 	u32 sw_ev_rings;
-	u32 nr_irqs_req;
 	u32 nr_irqs;
 	u32 family_number;
 	u32 device_number;
-- 
2.17.1

