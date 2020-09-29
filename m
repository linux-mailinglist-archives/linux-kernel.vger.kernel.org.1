Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D68327D503
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgI2Rwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgI2Rwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:52:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B71C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d9so5328003pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GocdqLYTODm0NoMZyaUYMh/e3m0B19dnr1p1DXm0VJA=;
        b=aRQslGHMAeFni2VsdJTxi6d/DZka///48BBsRpkLIkDMdrfdJm50w1bgWkIvfVisbe
         KpM1PzpNzKTI66g6xYn8t0nyzL7P9SGXXn9v5mCs+FiKRIa7a3gz8hZN/G+/uqVxpsUh
         qjd6XMohve35b6uN/AhLaH5FjEApkLqm0c51uFjyBoZkzOW9+zbk6DGR4432SEVkFneN
         zQ+b0WJuIaFZK+ZeK3U9Xc4dql+9IIEd/PmPAvgpiG6HreWNqTMlXmgRVdyvu4lTyDPt
         Ikp5wXCI9pBw2Tue8N1SLD6hkfSbSwUO22Yd+ujXuik8DrNWdqYpEdI09RRtv6JvgI6G
         pEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GocdqLYTODm0NoMZyaUYMh/e3m0B19dnr1p1DXm0VJA=;
        b=OSBxWKC/wdyT3GzwHf0tcAKcApuWy4QI7AlN71OQ7to7ZLm6XZQs/KpmTySsPH9d00
         IuHnsxgNXuG7LefxC9w85gc3nLmmRVMv7mrAe/P5SbR4xR525gefVSJpcv3GKc0aw3Jk
         qbwux3+v/cX2K0Vbb3vgX6VksGNuTwnJWPA9vWftedQFruZyUmyjYG4GDSnN2O1Ofq5R
         RH01Taf445Fn6Y1tgcfZtQwhcY3HTZmMsVh07bfMvyCGv8+8piNZgqeSJpXfjgYmYhLr
         IDTfZi7SFDY35MBPgg76lAipWnQzsYSvj38+QXBHafrC9HJH/8YGm6T2xCSCFdJpiiCH
         MQww==
X-Gm-Message-State: AOAM532FEVLVUK5v0zTRZ18xp76zrq5tYVXD8oh9/zSvURXtY1vhvMWk
        bTZbDaoby8+OxMvq6HUv42Jg
X-Google-Smtp-Source: ABdhPJz8qZHVFBt7Yr2IMsD1khhXNppN/ZKG0zMuuYPY73GPMaNnSXYMkkIIzgwYv7frL44wM9Ymyg==
X-Received: by 2002:a63:e441:: with SMTP id i1mr4263442pgk.221.1601401963210;
        Tue, 29 Sep 2020 10:52:43 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:52:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 03/19] bus: mhi: core: Abort suspends due to outgoing pending packets
Date:   Tue, 29 Sep 2020 23:22:02 +0530
Message-Id: <20200929175218.8178-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
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

