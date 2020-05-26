Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80C1A84CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbgDNQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391545AbgDNQ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:27:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37777C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:27:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so13669294wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1LHaTJUSb6YlKNJo8uEXGOXHLnntD8wG0lKLYJJal8o=;
        b=asG7ZBqoRWoen0EhesYcUDuNHZ64mVYuDlESxkQtESEpYgzpIoltmbMvIkJwym3WfO
         2AklxzEPMWgE7nie+BTaMUQfmCTQGyGJdyODxxnw42vkqKO5CEroNxRTWuvzMN7xG70O
         dohNpdTqoTZfLtu4damkH5LbrNPWhK6YvpXOVDTxRijPXg8n2vkr0e0KEGDO2j9/xkSD
         48EVFBCaexm8uKohNu/q7UTdYZ0tw4qBf2yR9Dea96u6CI3rwdbAI822abZ4iBGTAdT8
         ojp/na+NR+Wsh63P61V7jL2KsnmEuuZauGX8tpdr27rDCS6qRzCWQx8AtUwkBAQAf7Td
         zFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1LHaTJUSb6YlKNJo8uEXGOXHLnntD8wG0lKLYJJal8o=;
        b=ahfjLiiM599y1TG0sDzRqr7TYIpjkKqgESDJk8BDjCUTQ/Vwf/pdm3JYYPtk5lU71M
         6I/OpUoKE8WT00U1Kt3uEW5GYR1VJNa4NOB/fLeUWjLjPWgkbNO0SmI3S9KVzslHPOSi
         spG5s2xuXQYxXi9cA0Eg0bTGar02TwjTccXL8Wt0L/gvWNCQgOZUziUlyHKIOABIUbxW
         8i5VMIBzhEoJsEnBWYpEY3kWcoRss7oI63b44/JM7TLxyZlXutM3GJNSitdu5Lu412yI
         VUNJuEMuZgHGcx2LCQZ5rY40pBBeOyQbY4yXHJsOEU9uU+aDsFbs56fyPhelqxx89vvR
         nzDw==
X-Gm-Message-State: AGi0PuYybN4yLY5XZ3RWhSlBRcIZ31FjDCvW1Gn7QhcPhEML1T8sPpgU
        xnsRPUbPkfh4OCR5I9u5wxXhfQ==
X-Google-Smtp-Source: APiQypIXhFiwhUI+LtSucAg5Mlgn4tl6tvKseJNoeacHZGV9fpdzkJsacrRP9EA+xeqbcNM8KdrTlw==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr637319wmk.120.1586881622774;
        Tue, 14 Apr 2020 09:27:02 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id s14sm20199388wme.33.2020.04.14.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:27:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (open list:CPUIDLE DRIVER - ARM
        PSCI)
Subject: [PATCH v2 4/4] thermal: cpuidle: Register cpuidle cooling device
Date:   Tue, 14 Apr 2020 18:26:29 +0200
Message-Id: <20200414162634.1867-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414162634.1867-1-daniel.lezcano@linaro.org>
References: <20200414162634.1867-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuidle driver can be used as a cooling device by injecting idle
cycles. The DT binding for the idle state added an optional

When the property is set, register the cpuidle driver with the idle
state node pointer as a cooling device. The thermal framework will do
the association automatically with the thermal zone via the
cooling-device defined in the device tree cooling-maps section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c  | 5 +++++
 drivers/cpuidle/cpuidle-psci.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 9e5156d39627..2406ac0ae134 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -124,6 +125,10 @@ static int __init arm_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	ret = cpuidle_cooling_register(drv);
+	if (ret)
+		pr_err("Failed to register the idle cooling device: %d\n", ret);
+
 	return 0;
 
 out_kfree_drv:
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index edd7a54ef0d3..8e805bff646f 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -305,6 +306,10 @@ static int __init psci_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	ret = cpuidle_cooling_register(drv);
+	if (ret)
+		pr_err("Failed to register the idle cooling device: %d\n", ret);
+
 	return 0;
 
 out_kfree_drv:
-- 
2.17.1

