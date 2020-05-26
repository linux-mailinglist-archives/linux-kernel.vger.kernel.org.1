Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538851CD9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgEKM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730042AbgEKM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:26:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C078C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so7778558pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rY1JOMAJv6wVttlYP9KeyPLdulfjmcdiwqnMN+0tcMw=;
        b=EswIUU0mwPJ60q3J+agrtsxLgRaW36AeIg2tZ12LEZ71Hq0mxal8xYW1sDc9SSFGRF
         hj2lEY/kizUWmRCfkp2EJKJSHkze5IZs03woynq0IsWtjITFEGkP+suceVLMA7Ynfch3
         BBxlNS0Cb7KZy78+LzM2DdgstvYwmEhvEqtrh2mDTkDXRrTeGjX4WYZdkBazBu2qbPSl
         +OI55xFZyxgDTrrKPdeP4YVfr1+8d5wmEXD4Iepvuvd3TMNL0qDsLbt5ipdIMxChfWqK
         s9MG8vPjAz9rUX899zzPTFoN8ak07c4/iEAEDirFQWL4yhieJhftxpH3mSsQ0BulvUA0
         PLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rY1JOMAJv6wVttlYP9KeyPLdulfjmcdiwqnMN+0tcMw=;
        b=OQHLEIYKxCXZMWFkxO8whyNpGkW6tOhyMtuM6JL5UDlCIV9Yw3vvRjj/YBKy5qR5O6
         UEAHCXIwbhgHm2Oy6h/BGiNuWUqbxF2fUu2WIkW2cg5dJ9BbJREDL8eBsNKiR8KT5pkP
         WsAz3kvxpRLjBOJ3/FQq9u49haCDrXUAhLR8W1HS6zEb9Xu51s5gb4MC1AnPz+9+I1io
         2EVOCUzZWPdRVmoYJKoUjD9pGi1U5H1fd4IsqqUUZaMaBorA2DULvNa8vycdeljk03yP
         KfE00xYZXJOXtTqLy9aNAEQonU7kRjLqkUllCZAGhbYqsvJzkIcQO6j+SYwOWz8eFjCh
         +dsQ==
X-Gm-Message-State: AGi0PuYhmZE9WKYbcRgugIjz7mgC1kMGywZKOdQJpjKYnstZH++FhDd3
        sPqaI+Qno6B5Zi3oUqBodIsT/iCWTvE=
X-Google-Smtp-Source: APiQypL2yR2ZKxc/eTQV3F2wxog5egsQIyblGquQ3Qg53tNBVvAI268E0+y7jAQHKXUoV4VWgruw3g==
X-Received: by 2002:a17:90a:1181:: with SMTP id e1mr23537379pja.234.1589199986348;
        Mon, 11 May 2020 05:26:26 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id j5sm10314784pjf.0.2020.05.11.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:26:25 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 13/14] thermal/governors: Prefix all source files with gov_
Date:   Mon, 11 May 2020 17:55:01 +0530
Message-Id: <b9a85d3204712f14e320504948c12712dc0b291b.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bang-bang governor source file is prefixed with gov_. Do the same for
other governors for consistency so they're easy to find in the sources.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/Makefile                                  | 8 ++++----
 drivers/thermal/{fair_share.c => gov_fair_share.c}        | 0
 .../thermal/{power_allocator.c => gov_power_allocator.c}  | 0
 drivers/thermal/{step_wise.c => gov_step_wise.c}          | 0
 drivers/thermal/{user_space.c => gov_user_space.c}        | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/thermal/{fair_share.c => gov_fair_share.c} (100%)
 rename drivers/thermal/{power_allocator.c => gov_power_allocator.c} (100%)
 rename drivers/thermal/{step_wise.c => gov_step_wise.c} (100%)
 rename drivers/thermal/{user_space.c => gov_user_space.c} (100%)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8c8ed7b79915..09ff0e259d46 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -12,11 +12,11 @@ thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= of-thermal.o
 
 # governors
-thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= fair_share.o
+thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= gov_fair_share.o
 thermal_sys-$(CONFIG_THERMAL_GOV_BANG_BANG)	+= gov_bang_bang.o
-thermal_sys-$(CONFIG_THERMAL_GOV_STEP_WISE)	+= step_wise.o
-thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
-thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
+thermal_sys-$(CONFIG_THERMAL_GOV_STEP_WISE)	+= gov_step_wise.o
+thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= gov_user_space.o
+thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= gov_power_allocator.o
 
 # cpufreq cooling
 thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/gov_fair_share.c
similarity index 100%
rename from drivers/thermal/fair_share.c
rename to drivers/thermal/gov_fair_share.c
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/gov_power_allocator.c
similarity index 100%
rename from drivers/thermal/power_allocator.c
rename to drivers/thermal/gov_power_allocator.c
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/gov_step_wise.c
similarity index 100%
rename from drivers/thermal/step_wise.c
rename to drivers/thermal/gov_step_wise.c
diff --git a/drivers/thermal/user_space.c b/drivers/thermal/gov_user_space.c
similarity index 100%
rename from drivers/thermal/user_space.c
rename to drivers/thermal/gov_user_space.c
-- 
2.20.1

