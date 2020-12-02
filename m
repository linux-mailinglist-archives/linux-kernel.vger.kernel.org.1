Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A122CB967
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbgLBJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgLBJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:05 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F815C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:43:06 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x4so816261pln.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W29naHKk3BnHfLKgn8xbt6r59+NsCibowdGwfY8zXY4=;
        b=VLqhulcAQBHXat9sqgUwdDOtS+HV51UPeMPm/BZRSGenqBYga7lEARnnQu9A3FYLDq
         JZbzoHx5BM8ANyOmS5oAO13bUy7Ro2xdyFg4bnbPqZIwD8jT93X53V3NapQGYsElnOAN
         5xUuLM8rELu8XfovoIpH2LmrhRJNibhMVpnvAb3UPWE5refMH8mWqkJZR4BQzRTMp9P+
         E5/w8+OsG/WG4sZFy9coyNG0c2LC+KJMauLHdCtfWuKxj9fSrYwqW5+z5ovu8tiw8yZa
         pyN9zeAA+AwaE/Bmj6JwQcigeV3TwkYkCPAEhRGZZ9JfCodb3xeqIAN9JMRa7AuhLE+w
         jxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W29naHKk3BnHfLKgn8xbt6r59+NsCibowdGwfY8zXY4=;
        b=jOw7vYHX7vEehoyNXi4Yqc3gDmQ/lwdTcqjM5KEvYXz0TwbClUjS8/XLEZDQk/deac
         y5k325StrGlUpa2rU9UBBsh0No4eJ42JxOo0LmLTpPvEPmPHoNHKGh1R2YJYfazyhS0Y
         lyptkdVrI4Ioe8fEUCA6/2Xe6kOpk4baaRk5NRRxLKXxWfqQnSL/Jr3MQ38VQ7zmb+ET
         VX8loOiSKWeMxEuqpLj11zVOmm49SeB4ryV8OOD6yP/WSgsmvfhrMPJLejMvq/bn6e3b
         uN8g7+suFrDreKHfyw0HZO6r3bd7nJY6DXYhO0YXjZAFHViXYXiy+CdJC2EKy6M39ZE8
         SnTQ==
X-Gm-Message-State: AOAM533U10aVCzRTGmUbe7s/6pTL/LwmxcCYJCt1BwQZT6MPQ/BYeNHS
        H2QNZX2ntgpOGwQ+mtEaMkAI
X-Google-Smtp-Source: ABdhPJwIj6TbhsYdA4VMYqurtTRgHoEPilIICwokgslEYZndSuZ59mjkzAq9FQnY8+NVatHRt79oIw==
X-Received: by 2002:a17:90a:b782:: with SMTP id m2mr1529404pjr.185.1606902186186;
        Wed, 02 Dec 2020 01:43:06 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:43:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/29] bus: mhi: core: Remove unused mhi_fw_load_worker() declaration
Date:   Wed,  2 Dec 2020 15:11:40 +0530
Message-Id: <20201202094159.107075-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

The mhi_fw_load_worker() function no longer exists. Remove its
declaration as part of code clean-up.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index d8af8a702493..2df8de5432f9 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -613,7 +613,6 @@ int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
 			       enum dev_st_transition state);
 void mhi_pm_st_worker(struct work_struct *work);
 void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
-void mhi_fw_load_worker(struct work_struct *work);
 int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
 int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
 void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
-- 
2.25.1

