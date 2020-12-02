Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F02CB964
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbgLBJoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbgLBJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:01 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303FC061A55
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:43:02 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id e5so710114pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwdaP394uCZh/YGWGEmp+8FEBT4NPzYLWZ37cgF2aZU=;
        b=cq6dXcRTLlO5i4JVNBzbod0fguBXG1bAzZM+E6zRc9Pq8SiAV1zbUWtGpdI11JdOhn
         H7B3YFPe96zOW6zCttdZrr37Ij79fuEXV5JmC2oMipMSobJ697O28ds1MttSI57rehAU
         ztKxdnyd9B8PgJV1EZy4zXwH9xeN2ipaD5hJidb41drCt3nZ0kir0Qgbmjou3AEL7WFA
         quDD3y0IrXltGpoqqzV+zZi1V+ehMbdRXWVTHqpd3Du+/q65juqmDS5eXzbFfL3riTaU
         toclbfOqgB+939EAiXWyl3X3K9Is2uJEtscKn9iEGkYAPucvdITYkyIYO0GGRygSardf
         KDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwdaP394uCZh/YGWGEmp+8FEBT4NPzYLWZ37cgF2aZU=;
        b=ov6rKMRltbCunDYO69lfA+hhB0uOsmZp0JUJpFJwiiAp9Xl9hq1qtFrqbTigmvax3A
         1H366yV7pEHf5sF3nR1TovRFd7CekLV1hDeEahWHhTg7qg1O/r9ier6oY9qd6esTQlrW
         EY8KlGGI8UM1b7iPnA621YoqJvno0mG9HjPXe/LgadReVpznLRu12+i3Iir7N5zl3pMX
         Q9k9jetsGqJcfYQJTc1DlDzK3VHbTBVlChYtdIavlrH8FB9HT3OOs20ECKzOu80FFPWa
         Exy7C7kVbiMegIA338FHxmPDkvyKYAzKSOq8pn0wUI8q5aeBk73n2Kb5XgAvL2evjwWE
         UT8A==
X-Gm-Message-State: AOAM531/2RlXjHxvVHxUSRekEYnlD2r13stQHsLvlyGy4rRpmKsbw51j
        WVO1RwdHtfe4UK1vIqpcHfMC
X-Google-Smtp-Source: ABdhPJwsLI8MpfztxyBMsnnUM4bjgWRrFiy6WxCtSMlDZ8O7QFtbDl7T2qJBOw81kkVSEwZbLVn+uw==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr1619594pjx.81.1606902182388;
        Wed, 02 Dec 2020 01:43:02 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:43:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/29] bus: mhi: core: Expose mhi_get_exec_env() API for controllers
Date:   Wed,  2 Dec 2020 15:11:39 +0530
Message-Id: <20201202094159.107075-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

The mhi_get_exec_env() APIs can be used by the controller drivers
to query the execution environment of the MHI device. Expose it
so it can be used in some scenarios to determine behavior of
controllers.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/internal.h | 1 -
 drivers/bus/mhi/core/main.c     | 1 +
 include/linux/mhi.h             | 6 ++++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 78e4e84d6743..d8af8a702493 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -609,7 +609,6 @@ enum mhi_pm_state __must_check mhi_tryset_pm_state(
 					struct mhi_controller *mhi_cntrl,
 					enum mhi_pm_state state);
 const char *to_mhi_pm_state_str(enum mhi_pm_state state);
-enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
 int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
 			       enum dev_st_transition state);
 void mhi_pm_st_worker(struct work_struct *work);
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 6ecaacaa8b54..f953e2a6d58a 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -123,6 +123,7 @@ enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl)
 
 	return (ret) ? MHI_EE_MAX : exec;
 }
+EXPORT_SYMBOL_GPL(mhi_get_exec_env);
 
 enum mhi_state mhi_get_mhi_state(struct mhi_controller *mhi_cntrl)
 {
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d4841e5a5f45..9225d5551d69 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -658,6 +658,12 @@ int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic);
  */
 int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl);
 
+/**
+ * mhi_get_exec_env - Get BHI execution environment of the device
+ * @mhi_cntrl: MHI controller
+ */
+enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
+
 /**
  * mhi_get_mhi_state - Get MHI state of the device
  * @mhi_cntrl: MHI controller
-- 
2.25.1

