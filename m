Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F073327A636
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgI1ELT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgI1ELQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:11:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DAC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so8139841pfn.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jNx5jfKYWZGFzKUONheqZrKSOvFz+O7hWeUKgyZ6/3A=;
        b=rXH/AXxsotOvE6H5ZL1ejX5HIo79s5TxkQkKEEJPSx5mYXQjE6GcLrArrrWubLylPC
         MBkxNfdVAJs/YssxxrOi9h235MtJVY2Pma+/Vy3QuotzklYNC1Rk7D/JelKr47nc4eoS
         4h89AmskTIUZcCKV09rp7W39jE7RpUDS+UKneKvC51jK5SqXTxhU539ln7YhhcnDw10H
         zLYeYDa1kAFJGE6g4ezOr24gGlse7MKrrxxtxGq+6e4bGfcP0rYW841lQHygGksfDK2Q
         SqV2ncEnfGxw71j97dvpQoOPBqhvG7dQL4BON/Eio81mU38YWGH5FZC40o60HdXTfVHr
         BcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jNx5jfKYWZGFzKUONheqZrKSOvFz+O7hWeUKgyZ6/3A=;
        b=ucTl7sw5xAgnIGTpw4gIpAVWHsyWXyvPpu3E914U1jnTLzQU3kiBisNuEwarDWSX+t
         kSm5hhD27uVdiQlcvLI2m8kyA2OEQgxCMdU+WBAd2WRtzFH5NKuENGvDo4/pY97orJNd
         ebqNGrXtRj703zxraZie2nXZsdbnjTz+IO5q3IO31A/c2NcxulRKvBgW2LXeSs1pdDG6
         FXZ2OwDFD3r9OafgLGpkey8SZeqrPxmBs3RC0ONgvoioh+Y+fePlNozmafP2eX9BDkXc
         IJazvfDnFtWRM2/Vp5qzaW8ZoixWFPjVdZKsSa3RSiplC1uyPm0Yq6hLc6TweRwi0qVL
         Glgg==
X-Gm-Message-State: AOAM530rf9oxBYdB55tSSlYQ7jPlEDIuXKb8wjVhmh11R6cMFdOM3/IQ
        Q7rTt/MZEac21aB//jNNhYka
X-Google-Smtp-Source: ABdhPJw7S0V7OPYrtp6V3QMvPbwcNpwIvSx3qX4Vt1Cvi2YF5ONPwVCdVL4Jrb1EXy4ws0u7eWs4Ng==
X-Received: by 2002:aa7:96c7:0:b029:142:38cd:13de with SMTP id h7-20020aa796c70000b029014238cd13demr9100217pfq.66.1601266275512;
        Sun, 27 Sep 2020 21:11:15 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:11:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 11/21] bus: mhi: core: Add const qualifier to MHI config information
Date:   Mon, 28 Sep 2020 09:39:41 +0530
Message-Id: <20200928040951.18207-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

MHI channel, event and controller config data needs to be
treated read only information. Add const qualifier to make
sure config information passed by MHI controller is not
modified by MHI core driver.

Suggested-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 12 ++++++------
 include/linux/mhi.h         |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index f69a2f3d039d..d23293876be8 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -562,10 +562,10 @@ int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
 }
 
 static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
-			struct mhi_controller_config *config)
+			const struct mhi_controller_config *config)
 {
 	struct mhi_event *mhi_event;
-	struct mhi_event_config *event_cfg;
+	const struct mhi_event_config *event_cfg;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	int i, num;
 
@@ -648,9 +648,9 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 }
 
 static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
-			struct mhi_controller_config *config)
+			const struct mhi_controller_config *config)
 {
-	struct mhi_channel_config *ch_cfg;
+	const struct mhi_channel_config *ch_cfg;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	int i;
 	u32 chan;
@@ -766,7 +766,7 @@ static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
 }
 
 static int parse_config(struct mhi_controller *mhi_cntrl,
-			struct mhi_controller_config *config)
+			const struct mhi_controller_config *config)
 {
 	int ret;
 
@@ -803,7 +803,7 @@ static int parse_config(struct mhi_controller *mhi_cntrl,
 }
 
 int mhi_register_controller(struct mhi_controller *mhi_cntrl,
-			    struct mhi_controller_config *config)
+			    const struct mhi_controller_config *config)
 {
 	struct mhi_event *mhi_event;
 	struct mhi_chan *mhi_chan;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 6b987e8cc438..b2c0214bfbd6 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -280,9 +280,9 @@ struct mhi_controller_config {
 	u32 timeout_ms;
 	u32 buf_len;
 	u32 num_channels;
-	struct mhi_channel_config *ch_cfg;
+	const struct mhi_channel_config *ch_cfg;
 	u32 num_events;
-	struct mhi_event_config *event_cfg;
+	const struct mhi_event_config *event_cfg;
 	bool use_bounce_buf;
 	bool m2_no_db;
 };
@@ -545,7 +545,7 @@ void mhi_free_controller(struct mhi_controller *mhi_cntrl);
  * @config: Configuration to use for the controller
  */
 int mhi_register_controller(struct mhi_controller *mhi_cntrl,
-			    struct mhi_controller_config *config);
+			const struct mhi_controller_config *config);
 
 /**
  * mhi_unregister_controller - Unregister MHI controller
-- 
2.17.1

