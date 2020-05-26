Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5441CD9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgEKM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgEKM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:26:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2318CC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so3867831pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCql4ooAUuTgN/g+9s2UxdAjQ5xNIc09/Y+I6KcFQUQ=;
        b=CChggZOiOF6wPGfz67tGwkSY/b0IOdy3G10yE5YLYsA9sOtR0HAb1ajPJXGbKpTH5/
         mRtrv5vjwUK0eviQAVLCQfl2707XNgYBMRaqfgKAvZJ6lyyphBlVjKRwupbgmXasAPs7
         kzvc19w6B/op1OO1ERMqzl9GQo7c6lLpRYuZIS6EHf8l9ZjzvJDuoGMHvzMUxx46uVsY
         Cw3M8SZZIzLVdwaiqfBE2amFqhMcePNjvBL504W9a2jbzau2x76EyVcnPmtLc4W54AA3
         6YTnXVtAHx4ir4BjCk2P7C7Tbyghv/Lza8HepXuuG/c9TxiYXSb5hZJsbGSvV1duIJoi
         Mqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCql4ooAUuTgN/g+9s2UxdAjQ5xNIc09/Y+I6KcFQUQ=;
        b=dn8hS+e+GWxYVSLclVJOnFVtAZQgDNEnZuu7AkeCMqBSvuMT9/UaCLZblhZYw84iOz
         fbyhEXdrRH/xJXuoCJR37nDvFhQSKvLmydqe7QHKkWdapw/9CvRC0bE3Gh2i3Ch9POmk
         YjGjrQzvFo28ObdEYe1g03PCzdoIygylplE/2Sj/7BDfTa70274Yjn+0DSH+HBnbhxP7
         PF+WKfUKKCFF6yGDKjQRa39Yl5RNPUrz319/MDYPkMXse9qqcn1XjNcXgoMXirwQCM5Y
         iFC05OS8ROWD0209z+HwTnsjsZrwZ81GCUwQxUFOGLCEDoM1pkiUyFdIK6gxYTp6LlxR
         /stg==
X-Gm-Message-State: AGi0PuYXCJFFUhjuHEfIvcIQWNwA1oaRN3jIBt5S9sBBcYzEFdeZ8cPa
        Z/p+647gAS/Syxa5UX3FD4lFsqHJqqI=
X-Google-Smtp-Source: APiQypKPC1afq3Uf7CysVIw0pp3L8MnJhqmgDKdlfuFIa4EB7N8f7T9aJ/vqMRmxqNKOQwG9rbq/0w==
X-Received: by 2002:a17:90a:1b4c:: with SMTP id q70mr21828271pjq.55.1589199960240;
        Mon, 11 May 2020 05:26:00 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id d7sm8656036pfa.63.2020.05.11.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:59 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 07/14] thermal/drivers/clock_cooling: Sort headers alphabetically
Date:   Mon, 11 May 2020 17:54:55 +0530
Message-Id: <f8e1258fd8b882bab018de63c7e713b4334fec30.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort headers to make it easier to read and find duplicate headers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/clock_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/clock_cooling.c b/drivers/thermal/clock_cooling.c
index 7cb3ae4b44ee..fd6bc6eefc88 100644
--- a/drivers/thermal/clock_cooling.c
+++ b/drivers/thermal/clock_cooling.c
@@ -12,6 +12,7 @@
  *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  */
 #include <linux/clk.h>
+#include <linux/clock_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -20,7 +21,6 @@
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
-#include <linux/clock_cooling.h>
 
 /**
  * struct clock_cooling_device - data for cooling device with clock
-- 
2.20.1

