Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F7272B35
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgIUQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgIUQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:11:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB7DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:11:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so9440001pgo.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jN92Mz9LhRgMy6R9r5bCTsDXQ/6vWkXL7O/cDsot2BM=;
        b=N2RvolYFayc5fsOh1gJB3DMK8oIMyBLRgMfxg0FMJLL7xfLAZBP01+r5QYj+1GffUM
         9BxtINmxg9fRU+P1ec6xIBuRVD0tqNgD2LTsF3vyOHR5mYyDOOjr01s0CP9v9JCMZGQF
         QA9oxgiD7HKR4dOk3wBA93ftpmen3Zowd7yd58R2TufsBRIds7Ij3caLJWNI6n66MFoJ
         MZhOZpDv6Ao0RNg6HFEfyLQE7V/MSJZxG+VeFCZwqLkpPp4lEIoMNmmSWpVZKDzg2J0O
         NZotg/bCnTmE06vbBS7PbT3MZfyvR2+uaptpqg4YwTRWBYv2lbwSW57Gq78Aaqo+1vu7
         iQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jN92Mz9LhRgMy6R9r5bCTsDXQ/6vWkXL7O/cDsot2BM=;
        b=pCEngQ0kb9k2XE4BTkPS4XXwRMaWpFi6D5PRNs8fnJkn2G8xX5ozxi2sLktGqmQFaf
         qzNph1+FfbaRf7gBHoR1kRVirSXHXxBA46EdU+U1LPLNkfyfvxOJq18aKJjNPj+yuM/V
         TMv6qa7Myl8KOVZWC+cQNE/7pbC8eJUi7ESus12TESeZSOz89dEwtDW6mLf0N2uOrUnX
         tNd/zP4qW+fuarB0VRV+C8ZhvnPGJfN4X+Q+UtciIUTbDPFCU9311WBhtFacedaeOREy
         71R2JUdmVo43PKgBJvQnTw267Jrv1wHeA98prM5CQcfeqPUPMmT9ZnPIQ4WpU1Tlo/gC
         yHig==
X-Gm-Message-State: AOAM530L7YGO1e3An/cE0pJLkVLMn4eJNsHedFMW/vfxOukM3CiAJGAT
        O6ip8WLFUnKng9L08D9uaL/n
X-Google-Smtp-Source: ABdhPJw8SItFJiNDC55yGBHXRfsp10m1RmOM+ZPdNrLv6b91hudCqSZkRXGKp2kqd4I6H8Ssmr6RcA==
X-Received: by 2002:a17:902:c394:b029:d2:4ca:2e22 with SMTP id g20-20020a170902c394b02900d204ca2e22mr621403plg.77.1600704699579;
        Mon, 21 Sep 2020 09:11:39 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6d03:bd12:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f4sm9204577pgr.68.2020.09.21.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:11:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 18/18] bus: mhi: core: Fix the building of MHI module
Date:   Mon, 21 Sep 2020 21:38:15 +0530
Message-Id: <20200921160815.28071-20-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
References: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kbuild rule to build MHI should use the append operator. This fixes
the below warning reported by Kbuild test bot.

WARNING: modpost: missing MODULE_LICENSE() in
drivers/bus/mhi/core/main.o
WARNING: modpost: missing MODULE_LICENSE() in drivers/bus/mhi/core/pm.o
WARNING: modpost: missing MODULE_LICENSE() in
drivers/bus/mhi/core/boot.o

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
index 12c57ab3724c..c3feb4130aa3 100644
--- a/drivers/bus/mhi/core/Makefile
+++ b/drivers/bus/mhi/core/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_MHI_BUS) := mhi.o
+obj-$(CONFIG_MHI_BUS) += mhi.o
 
 mhi-y := init.o main.o pm.o boot.o
 mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
-- 
2.17.1

