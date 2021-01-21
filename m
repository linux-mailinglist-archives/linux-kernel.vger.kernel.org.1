Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6292FE8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbhAULY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730208AbhAULVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:21:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FBBC0617AA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:19:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s15so1094321plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sc4RKhDP//JPOMDhY7YCUQxeEMkiC/uPecJg02H/C7o=;
        b=l+IAUYm7EFFo4t2J9K9y1homcgzoofuLPhJewoVATAFKtJg6FXyHwS2xW0rpFUTRHV
         0VKWEJvRNqSxZWuzsLNt/c0JLq2Cpa0y6HOD3slSw3e3u01OJT4ei9LtHA+9mAS4E+e0
         ZrW068O3VrMsNGnFvp6u2l0/u9WAI8YevpehexN1DMnm1c3YG//LXbjknAvqtN/oOpFH
         EZ1gSzViZvXX1doq/J5KOHLewT76zw0MOY/tM6Mvx2FezcifiP/0cHUjZ5pGAhTd2XYC
         UIlHo2ZP06GzddxHR81p+DeIXuMc4gRZzrAoMDgmg0JP7gIK5KRDPPgZxZUKYZhtePem
         HQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sc4RKhDP//JPOMDhY7YCUQxeEMkiC/uPecJg02H/C7o=;
        b=VCbtiYu0xV5wQmNee1OTbItdUiIfAInSNKoNDa6mUP/9qOoxTREKAgYHQHPNeZm0rj
         v6qKPFGdO2gaZXqXIr87Dvhp1qT8/LtmISbuU2jLzOt3H6AwgGZForDsssf7gO43954B
         uY5XlWV0S/NFts5BzmRX3XwLnHS9Ba1GmPtTVaG1DRqJYXe7nKCvtPrUhNBAkZn/63TY
         i0o3iib0t6a4s9qbso9dEwMUoxI3VzAZEUioXL9HTUwv83fxXAG6V1Qgg2EEIw0k7Sqp
         fQsPVJBuDiazuR1Z7Lf+hQCa5Q/V4XQZln8mc4u3JGJep61TvvNtfvkSA2B+UkMeqfOZ
         l+iQ==
X-Gm-Message-State: AOAM533pScsNJsIY6rzuW4/aZHoPIupUotbCd8SxAZpVPJdd5qNr0zw4
        PErEP+C/Efan3r4AnY6pmzF6xg==
X-Google-Smtp-Source: ABdhPJyINtEI3nSzz0ay/vase6wWA+XDS1j1/V24hIEgbqObHoCTROQExJ2ifEGydCT5glp9WAX8vw==
X-Received: by 2002:a17:90a:ad48:: with SMTP id w8mr11326968pjv.48.1611227955542;
        Thu, 21 Jan 2021 03:19:15 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id ge16sm5827745pjb.41.2021.01.21.03.19.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:19:14 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 11/13] devfreq: tegra30: Migrate to dev_pm_opp_set_opp()
Date:   Thu, 21 Jan 2021 16:47:51 +0530
Message-Id: <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_set_bw() is getting removed and dev_pm_opp_set_opp() should
be used instead. Migrate to the new API.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 117cad7968ab..d2477d7d1f66 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -647,7 +647,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 		return PTR_ERR(opp);
 	}
 
-	ret = dev_pm_opp_set_bw(dev, opp);
+	ret = dev_pm_opp_set_opp(dev, opp);
 	dev_pm_opp_put(opp);
 
 	return ret;
-- 
2.25.0.rc1.19.g042ed3e048af

