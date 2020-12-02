Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CAD2CB969
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgLBJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388474AbgLBJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:11 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065F5C08E864
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:43:30 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so840654plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrPaCWKtGUJVYezpsd+8q+kGL2gwIXJvLaxfTN6qvNo=;
        b=usxNVmK6NkD1z1QZur0mj6TGTOwqQpBGST9yfR3GOnc2JqiHYPLppiT0RLJ0RiQEPu
         RQyCKHBHp+CrIeskswVJCyVC1iGLKeM5Qng19quXatToSLQIBc0N0uWR1gcifaU+uUkD
         Ums/C9YSk6VSwotdOCxY/51tX8HLo0yJQyavi46kvGzboaoWKU+TSC6uu6bQFfpewbkX
         99ciFfdN1SjG898eLl2NXlKFHL45cow9SKpRF7hOSP3YdLkmv4f8g4XxVPJiVE+j2mo9
         4dIi3lVyq/72uXZ8v/SG9kxy3tRe2s6CLiyurTg1LckX7fl29vPvjEFgtOhTo3mvcfkj
         wVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrPaCWKtGUJVYezpsd+8q+kGL2gwIXJvLaxfTN6qvNo=;
        b=c9s4wKm1O2Xky9OuGFRqw6Dp7IC/fPJrzxWM6qMXz6J1Umq9QwfBfCCJ4vSW+n5o9z
         bH0XF7U+PiBAjdjJpq7oBvyqei/43iaw822S96fH3OcU5fl5g+2KPDtwygO/Qp86dneZ
         6fyhA77wed8dRivC02+VeGCBmqHBWO1arNDJ5T9gxp90xVM//zsqAMs/qhhT/B0KsQ/u
         DR0fQErxvAC3G562uQ0c4lOQmvV3aZy60+rc3KTVqvzJ0vk95iNjPzvtcvlqFADKI21o
         bgnJwgk1aVN9bhBfPG52t/8ENE8ihkv7jVKgipCkPY6xQwEbE79xSVW1/GOXtar3sYug
         33zQ==
X-Gm-Message-State: AOAM532FKa6OVU0Up9QesSQs8G9615F5pgUa9cp/mKd7p6ti8bWQHp7N
        588cYr1ZY0HAkH8OPp+L6rwr
X-Google-Smtp-Source: ABdhPJz+ULQExLHmiy0hI8R90ISmCgu3d4CGM4fIg1TlxXlEZqEPQYMDr/9BLtclNLBfMAA3krqHfA==
X-Received: by 2002:a17:902:7488:b029:da:6be9:3aac with SMTP id h8-20020a1709027488b02900da6be93aacmr1756772pll.59.1606902209554;
        Wed, 02 Dec 2020 01:43:29 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:43:28 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 16/29] bus: mhi: core: Move to SYS_ERROR regardless of RDDM capability
Date:   Wed,  2 Dec 2020 15:11:46 +0530
Message-Id: <20201202094159.107075-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

In some cases, the entry of device to RDDM execution environment
can occur after a significant amount of time has elapsed and a
SYS_ERROR state change event has already arrived. This can result
in scenarios where MHI controller and client drivers are unaware
of the error state of the device. Remove the check for rddm_image
when processing the SYS_ERROR state change as it is present in
mhi_pm_sys_err_handler() already and prevent further activity
until the expected RDDM execution environment change occurs or
the controller driver decides further action.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index f953e2a6d58a..91f8b8d05a62 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -737,11 +737,6 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			{
 				enum mhi_pm_state new_state;
 
-				/* skip SYS_ERROR handling if RDDM supported */
-				if (mhi_cntrl->ee == MHI_EE_RDDM ||
-				    mhi_cntrl->rddm_image)
-					break;
-
 				dev_dbg(dev, "System error detected\n");
 				write_lock_irq(&mhi_cntrl->pm_lock);
 				new_state = mhi_tryset_pm_state(mhi_cntrl,
-- 
2.25.1

