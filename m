Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC622CDF07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgLCTeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC448C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:26 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so3063591wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IcrbosIo88RCz78dFLOwZkXbKw4vhmH8pk/1uvx4IWI=;
        b=IBOyNvkR+iM3qWU4D+BzKSCKoVefYR0BW7w5lXEr263kOBCPSBrjQR7BMIg8kXwJsA
         NRY09+PNckV1lNcOMwRq/qeuNInXYmmLQU/763Wfgs83oGPsF7r7bJEFTyJi9XRJe5Us
         YyRog7JLX9TlST4cDVC4umb3iLM+wxdBPFZQQn4BGMzXDZX9GKIWRz98SJ0diizy4QqX
         8C4Sj1+B6AQQg9Po6rWs7tsvvvSZYn8KC0ZieD49ZfwF+XW3K/I8sHqUnI4uLJQ0Dshh
         VBCuVtEjNFAfsfa8QE0UZHpjahiDdd9mPO1YqgGJexLlrgHDik5Glv4j6qUcSBKcXlXT
         rq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcrbosIo88RCz78dFLOwZkXbKw4vhmH8pk/1uvx4IWI=;
        b=XyCFQFSRX2lUaJM6BGWHembeVI0P3Eqz9dc1uokf5gUfj8Zx0KquoX5XtOEZxB/0ot
         H+5H/hBMu39kBzAAqUEoOukRUxr8R2HGqJzP/vnvCuLl4qGCju+d+RyaFG0mZ3woVOH9
         KLrX8ipJT7yVP/rbUi2XZrhgWpetlm2FXovWKWs1qcxML2I4JnwAP8C9psevp2cmBTL2
         Yh81DAqWw4VWUFkma6VzDdWTunM/JSEPzPE7v2KzCxxvfxSDuPTvA3WPVeJo3cT55qqY
         JdlyxVdIk3n7mdF/BE3YaUlN3djF4/DEZVmQhuBKHnlttdcW2t7SpmXi8Dwz/BJWYWvv
         lQHA==
X-Gm-Message-State: AOAM530kAF8TAqCLv4Ypl2zHEAeOUOzcYnROUw8bI+xEjDuwvYpWxg6f
        L2x8VoyLSt/jknsBtCoWIdC6Mg==
X-Google-Smtp-Source: ABdhPJzh9dXttRTofOGynaTo89bHvmO1m0+Md1YkvMljCmP5Ddkih1WD0qi8QmPwpYhemG34Si1sfQ==
X-Received: by 2002:a5d:4c49:: with SMTP id n9mr883238wrt.30.1607024005346;
        Thu, 03 Dec 2020 11:33:25 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:24 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] clocksource/drivers/sp804: Use clk_prepare_enable and clk_disable_unprepare
Date:   Thu,  3 Dec 2020 20:32:51 +0100
Message-Id: <20201203193301.2405835-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Directly use clk_prepare_enable and clk_disable_unprepare.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201029123317.90286-3-wangkefeng.wang@huawei.com
---
 drivers/clocksource/timer-sp804.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 22a68cb83cf3..d74788b47802 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -68,17 +68,9 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 		return PTR_ERR(clk);
 	}
 
-	err = clk_prepare(clk);
-	if (err) {
-		pr_err("sp804: clock failed to prepare: %d\n", err);
-		clk_put(clk);
-		return err;
-	}
-
-	err = clk_enable(clk);
+	err = clk_prepare_enable(clk);
 	if (err) {
 		pr_err("sp804: clock failed to enable: %d\n", err);
-		clk_unprepare(clk);
 		clk_put(clk);
 		return err;
 	}
@@ -86,8 +78,7 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	rate = clk_get_rate(clk);
 	if (rate < 0) {
 		pr_err("sp804: clock failed to get rate: %ld\n", rate);
-		clk_disable(clk);
-		clk_unprepare(clk);
+		clk_disable_unprepare(clk);
 		clk_put(clk);
 	}
 
-- 
2.25.1

