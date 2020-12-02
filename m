Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F572CB962
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbgLBJn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388237AbgLBJnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:43:55 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1FC061A4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:42:46 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id o9so876111pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LsQFaATp5kPNt9O4pgdJHaJ3akqe6fvWiwrf87Kxp4=;
        b=hKj+OAqhvuORH/zH/KUnQJ4X0Kfz7CN0EAUjbcR305J9Bd9GDJ6xEaDjXWCXrmgIJl
         Auqfpwa+o5bQLdGxbWsjL3Uxgc+01hl2lOr9dyQ5a2ON2BoPbHs8RNhqh7Hx5zOdioM3
         s24OnkxpU6gTjh+vtL3EkvT6qvO7vhRCox9av/byOUhe8p8PpJCIcTeL56eBy25bjXtw
         EAmPU4z/SEz4C/HdhEmmAQVu1P16mOU4RV7K2PutZSXjBl3xNff77OTizeHjvQNfMpvC
         nvVQxiHWMdncUjWYnwOCdzcQDGq+A1L2hs/llM0WgHrv4wo0zT9VR99MzPX9Yx76cGWv
         4bPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LsQFaATp5kPNt9O4pgdJHaJ3akqe6fvWiwrf87Kxp4=;
        b=el25SJlIOLdxzOMNGFvjsnfOuTiURjrzi5WwIbjHqtPQwQUj4j7TPViiBmEs2n4mco
         UCzw1tytB2EXIbs6/UAKkckXMnPNk+6Vz97JMiN2ZCDdQSqehUEAUZd4J3wwFjZM78dZ
         sygdkXa9I7Y1FmZCyIrMi65V2Vcy+8ImpLYcJ5A3VUU7ArCFLiWYUfEoQH1wjInksIfL
         4eJF6LN8kzut8fzoEz1qomZmDvm1IhTjYYGP89no2DEzWcSGWtqu7RW/j+N9IftKVxDv
         wEqtoN5Ym2kNSnMQwR2s6kXnflhFUGAJXdnZAJXS/Uv/b47ROz2jHs+6Bb9hTq6ghe9R
         537Q==
X-Gm-Message-State: AOAM530SiVZ7YCudmONFQpP5ZwQBPEm/z7fJxY4z5oy5t53YqjcfYRZS
        832Y9gC009Fah9j6m5IdIX5H
X-Google-Smtp-Source: ABdhPJxzM/KZ32+7NrUU78F19Kze9ehE96bPLJ4y2AYj8CsqDUpXptd5MeIOVuhXUompcKsgCIqH6g==
X-Received: by 2002:a63:211:: with SMTP id 17mr1942020pgc.56.1606902165559;
        Wed, 02 Dec 2020 01:42:45 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:42:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Carl Yin <carl.yin@quectel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/29] bus: mhi: core: Fix null pointer access when parsing MHI configuration
Date:   Wed,  2 Dec 2020 15:11:35 +0530
Message-Id: <20201202094159.107075-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carl Yin <carl.yin@quectel.com>

Functions parse_ev_cfg() and parse_ch_cfg() access mhi_cntrl->mhi_dev
before it is set in function mhi_register_controller(),
use cntrl_dev instead of mhi_dev.

Fixes: 0cbf260820fa ("bus: mhi: core: Add support for registering MHI controllers")
Signed-off-by: Carl Yin <carl.yin@quectel.com>
Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 0a09f8215057..8cefa359fccd 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -610,7 +610,7 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 {
 	struct mhi_event *mhi_event;
 	const struct mhi_event_config *event_cfg;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct device *dev = mhi_cntrl->cntrl_dev;
 	int i, num;
 
 	num = config->num_events;
@@ -692,7 +692,7 @@ static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
 			const struct mhi_controller_config *config)
 {
 	const struct mhi_channel_config *ch_cfg;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct device *dev = mhi_cntrl->cntrl_dev;
 	int i;
 	u32 chan;
 
-- 
2.25.1

