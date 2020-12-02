Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D72CB983
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbgLBJop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388571AbgLBJok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B249AC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:44:01 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t7so407435pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U6tuxJXwhPncIR+38W/QdB/JkWjIPeIUW2URyo+M7Yc=;
        b=xbXswLJ7+f0M/CEswANqTGQd6R/+AlDh+HPlu6bJdxK1gDa8YCcwq5q9zqIwTWiH+r
         Nd0ZQG23ERxLUL7QAx/G2IkcA29X5dkz2nneEJASBL5N1YnA1IROh5OikEOiZutWoeDb
         apL/d4XAKFbvO4fVmSI4nYq8JOb5/ltLJ0e2AqVPaFH8xceocAcp/p0LmkX8xkwgNXLD
         bBmNxqd7JusVyyTz8jezOf9wVD2gRMDbt5viugOXQqrslUNfBfSJoeiIl+ZbCWWAxpXc
         OZ7b37wFDRty/xZC1lnUxN9sH1mKCoWh9zDQVkFgWkkW9l3eiZQzAr921ESUbrnxKUFC
         pkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6tuxJXwhPncIR+38W/QdB/JkWjIPeIUW2URyo+M7Yc=;
        b=JsUrIIZqiOLhuOwYzqhvZXz3UmBh/011t45NDFz6mOcRIuEq0uflPA+Lh4SXFZQ32D
         owy0ZDrtLIXo2BfU7He+vOhZPt2MUgjRGB2x4Z2rPLNwratSpYeBms3YpYsoVw4IOCE6
         4GK4tetyDe0930c7BD6Udr8hHoDu/ej94AGKZ5vl5946LSCDx54yBRDyFRsLwy1DGblQ
         OQJ281yw8WJcB1iFwq4GgvFK7iBctcXiddDmIizjLAhH3XbsbG5pZRY1GmVmdebu87qE
         5NTg7Uin/jAXKjufVr2I+EjXyChwcz5FOeca1GCEejgvUEgW1aqPp4fP1BOmlc1+dyjG
         BY8A==
X-Gm-Message-State: AOAM532e0ntwiujQ1D2JWzE/FY2w6QZuXsJ4AEzy425ulW6jhu0nvroV
        MWgQ5T470Eu99xOH5E6X7rIC
X-Google-Smtp-Source: ABdhPJyrt0H0pNCqoydcDt57Q2P2Al2RG3q7QpgfyZhC8RLhKzM+p1ibrQpUw+jlO/MJv9dAKZrHKw==
X-Received: by 2002:a63:fa0e:: with SMTP id y14mr1901280pgh.225.1606902241222;
        Wed, 02 Dec 2020 01:44:01 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:44:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 24/29] bus: mhi: core: Remove MHI event ring IRQ handlers when powering down
Date:   Wed,  2 Dec 2020 15:11:54 +0530
Message-Id: <20201202094159.107075-25-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

While powering down, the device may or may not acknowledge an MHI
RESET issued by host for a graceful shutdown scenario and end up
sending an incoming data packet after tasklets have been killed.
If a rogue device sends this interrupt for a data transfer event
ring update, it can result in a tasklet getting scheduled while a
clean up is ongoing or has completed and cause access to freed
memory leading to a NULL pointer exception. Remove the interrupt
handlers for MHI event rings early on to avoid this scenario.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index ffbf6f539510..a671f585ce35 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -494,6 +494,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
 		if (mhi_event->offload_ev)
 			continue;
+		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
 		tasklet_kill(&mhi_event->task);
 	}
 
@@ -1164,7 +1165,7 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 	/* Wait for shutdown to complete */
 	flush_work(&mhi_cntrl->st_worker);
 
-	mhi_deinit_free_irq(mhi_cntrl);
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
 
 	if (!mhi_cntrl->pre_init) {
 		/* Free all allocated resources */
-- 
2.25.1

