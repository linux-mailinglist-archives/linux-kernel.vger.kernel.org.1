Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4661D2D4588
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgLIPgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLIPgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:36:17 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26670C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 07:35:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 91so2202102wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NyznDPS+potp54SZ8vXhKxNkqaQy2TwObORIS4uz01k=;
        b=Kf+OH8cEA1M0oMUKxOimRjomrUM1OT3bBuEgBhvosuc/kv6TiUjOoaZOr0Gd+uWX8h
         YkpSaxUv8tKgAM/4YZy52+gv6PgiEroIFcWq/gvVIW8ogML7LEDM4nEkYlah33VEVNpZ
         4jnhvrfzxl9gG0cy4uy4mb1rMEIeNhRMaJ5uxbktDyUfDlWdh0dboCGHdf7RdNPL8dpG
         3Tm1fSlZJ2se6iyovuQDgLXqJKAmV7A3lhrVeokhA+bK6BP4yc1XboHAYwchOpzBcx3D
         oscTKaAKObz86YxBe6NFsNY6UgN2KcUUwFffQorz+EKHPqIJ0f2aif0wfTgm0ONaWZ1a
         MEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NyznDPS+potp54SZ8vXhKxNkqaQy2TwObORIS4uz01k=;
        b=QnZmIR1svsJJy1INCzbQantxGxhLic950KFoma+r4G61YbRG4o8THiAAfuFJ5+nv6V
         cBw+ZxD0KoSy55DZjlMyHizCUWtn+GDkz8mLgBV9vJekTy8pG4WrjZbGueaRTGCmqa1I
         zZLphPIPDffOig+fM31pQEoq+UFrAjqcqEF5IFKqrAZeslBT9M5M7B4UoZtZGMVftGOj
         hpITfHHjN5MDuoItH6VU/yiDQFz0Hao+O/d607dyzOxKQO7XzQKdDxtEghR0/i3rlWDE
         65P5YIIMy8oAzUxQoENhv/zL6w0iql+p8SOCULIq6VJWaGfuflUSYsCKfacTJpBGN+Jm
         ZzOg==
X-Gm-Message-State: AOAM533/l+CXTh9Dn4/6imBHLHPoVmcJx7mwmSaFg+1BavWf39Up+QHr
        kqrtLO5EwjzfNrJwHKvIO76nmA==
X-Google-Smtp-Source: ABdhPJz+6pTf/2KSIDYp2SZ71j6nm5XHjV5loSbYfxsAmvSiQ2En++MeKUw+luBaGjPCiTCU8DjxBg==
X-Received: by 2002:adf:a4cc:: with SMTP id h12mr1039614wrb.391.1607528100738;
        Wed, 09 Dec 2020 07:35:00 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id l8sm4208382wmf.35.2020.12.09.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:34:59 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, srinivas.pandruvada@linux.intel.com,
        kai.heng.feng@canonical.com
Subject: [PATCH RFC 4/4] thermal/core: Remove notify ops
Date:   Wed,  9 Dec 2020 16:34:40 +0100
Message-Id: <20201209153440.27643-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209153440.27643-1-daniel.lezcano@linaro.org>
References: <20201209153440.27643-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the remove of the notify user in a previous patch, the ops is no
longer needed, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 3 ---
 include/linux/thermal.h        | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0366f3f076cc..8a47369f0432 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -406,9 +406,6 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
 	trace_thermal_zone_trip(tz, trip, trip_type);
 
-	if (tz->ops->notify)
-		tz->ops->notify(tz, trip, trip_type);
-
 	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
 		tz->ops->hot(tz);
 	else if (trip_type == THERMAL_TRIP_CRITICAL)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 125c8a4d52e6..7e051b4cf715 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -77,8 +77,6 @@ struct thermal_zone_device_ops {
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *, int,
 			  enum thermal_trend *);
-	int (*notify) (struct thermal_zone_device *, int,
-		       enum thermal_trip_type);
 	void (*hot)(struct thermal_zone_device *);
 	void (*critical)(struct thermal_zone_device *);
 };
-- 
2.17.1

