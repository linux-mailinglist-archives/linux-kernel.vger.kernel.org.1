Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228E62A8FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgKFHFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKFHFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:05:31 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD3FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:05:31 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id o129so482977pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPLnUhtQ+dxcmE2HZpN7gVFh2Ut9iquGsDOuyt2kO74=;
        b=u0KpNSdRcvSh+32Vu+x4+8GMjysg6sJiq7B/sGt8ogBO1oSA3jDOLGPpCS1Gd/cAFD
         0OoWP2xdGgLxyacl2f604zjp6ou/DJEvb7GsBBpwq9GNFyEr3i+ft0RYetIgg368pllK
         qyubNricG/aQ37BkTkdxMVIeklBhhk4gfbKt/nnOVGD2VLBE5cY+RfniKlVMt6O4Kl0r
         p9IiJ+DagxIgUTl/1hWMRHfS/mjHy0xK3Md8d+d/W0zZG7OHXDgiICyfm20dMruPyqVX
         5WJgMqWlFH64yHnPunk3djYTru3nfLWKkINRmr900FWq7VLdrUbBXAU5cT2iJp2VraFm
         pyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPLnUhtQ+dxcmE2HZpN7gVFh2Ut9iquGsDOuyt2kO74=;
        b=d5SbX51U73R6qIgyF8O+63DSVVfaZsCxiIYgvO314o9f4p+APLU9glCqkprSmYXh0V
         uuqb8j3Gedn3DerY3ARr0hCGNtt4WhJFEAfpjqgWg8LKki2bCBIl0f62ZDM8Ft/sYX4s
         JPdTl/lAn+2arXnj2dI64mE7wUhMyXmpziZsCITPa82Xok/f7ZeuleM8afEM61kWKKRX
         K02mUxJanEweSBm2Goyk40zc8MGEKjBfdI62Px+/N07pT7adDdF7EBnJgsVjsMh6zA3G
         utril1pQ9qZ7wUc3kXwq3+p79odGd8zs49VJL6Ctlm9GDMN8sGzwh84MnWYhWgRygmts
         fuRA==
X-Gm-Message-State: AOAM532M7mH+/GCvYRYb9V5fOgTE+2lrvwRmH239TbF5owqIaDphXV2i
        TZQiDZNIQ0SwaYlvBCtAPLv8hw==
X-Google-Smtp-Source: ABdhPJyBtb/um3G88EzMU4Kq9QyIxQlTChGUKgp2/W1s9MAQ5iKpigRZ0JWM11UwJXEolvoibo//FA==
X-Received: by 2002:aa7:9ac7:0:b029:18b:36d2:784b with SMTP id x7-20020aa79ac70000b029018b36d2784bmr825878pfp.20.1604646331033;
        Thu, 05 Nov 2020 23:05:31 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 16sm779560pfp.163.2020.11.05.23.05.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:05:30 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] devfreq: exynos: dev_pm_opp_put_*() accepts NULL argument
Date:   Fri,  6 Nov 2020 12:33:24 +0530
Message-Id: <b3c936d862b8c81ab568f38bd7acc438cb7efac8.1604646059.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1604646059.git.viresh.kumar@linaro.org>
References: <cover.1604646059.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
there is no need for us to carry the extra check. Drop them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/devfreq/exynos-bus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 1e684a448c9e..143fd58ec3dc 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -158,10 +158,8 @@ static void exynos_bus_exit(struct device *dev)
 
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
-	if (bus->opp_table) {
-		dev_pm_opp_put_regulators(bus->opp_table);
-		bus->opp_table = NULL;
-	}
+	dev_pm_opp_put_regulators(bus->opp_table);
+	bus->opp_table = NULL;
 }
 
 static void exynos_bus_passive_exit(struct device *dev)
@@ -444,10 +442,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
 err_reg:
-	if (!passive) {
-		dev_pm_opp_put_regulators(bus->opp_table);
-		bus->opp_table = NULL;
-	}
+	dev_pm_opp_put_regulators(bus->opp_table);
+	bus->opp_table = NULL;
 
 	return ret;
 }
-- 
2.25.0.rc1.19.g042ed3e048af

