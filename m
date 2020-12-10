Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CCB2D5A31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgLJMQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgLJMQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:16:46 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5965C0611CB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:15:30 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e25so5084628wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SL5r1XlZ94aUm2Qc3ziNrEN/y8mm4mqU/uGHBbVacJ4=;
        b=i4zw3sa/dq3c28aSZyi5OnHK34vamDUVVSCV6CY8XxrU+XUdO3RT+mpYnXsaXu1bu5
         a80zutXQ/Y1muZPG7gR1tk++vAo0E3WV8tQQXbMm4hpm67i1/kh/K/zmwc16nm9/ipk8
         gce7ve5V0smygbfR6piPk7qGAacAABdma9Qu0h08wWhkj20YJSAIOl4LZBRt9cYk6up+
         nmgZF+QSi6vTUZ/qmk8Iv4vgv4MYLUi0x4JJrIA4fTMRZXGa2pkdRJhZ04JT+sZoisl/
         HlSACKXv0O5oDId7y0iXEPegmqvJXiRDCkZV2DbFgYUweySQyyTJ9OBaAblj7LNyxDuk
         LEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SL5r1XlZ94aUm2Qc3ziNrEN/y8mm4mqU/uGHBbVacJ4=;
        b=EOU5ZwBad221e95dg5W/egJXFIAe1OdCOk6SI/qMvMX9YrLazA8a3A+aVXdx09ZHoY
         VOTuE/Y7blJN6VUlhHcLuzHRfjZT0CoT24vjs+BZMW2dq2uRK43zDrhQaLoWBLKsDv9q
         V++LdZHX5z7Z3gPqA5q74MQnS9ZrXkdYX0sOA0Ua6z46x5q5Iqzipj19LxlRDoUaK6p8
         NsXItT8mcruCmKb0muaxQ/z0Dna8WBiWOCY6EcxUgwyJjjnEBzUwEED0/n/s54Fkpqfu
         GTpaIkbCjtUdlnWbyzk0UeccnINlqqf1jaVdSLzPE3v9b1aDAFWRMBysDctxQw5riRPF
         vUew==
X-Gm-Message-State: AOAM530eivnygfEtjuEwhNdz0qAOJVISG2rsThQIn0OzoIRTm3Zr5i+x
        02nEDYAlWb+Ret3Ln42nrAaCMQ==
X-Google-Smtp-Source: ABdhPJx2RWeVI7qUg+ib+fl2n/Npn6imFO13zZdF7zj7PycVeQIFhJbn3dc0VCJx5eUvOgAqZC/RXg==
X-Received: by 2002:a1c:a583:: with SMTP id o125mr7787239wme.91.1607602529494;
        Thu, 10 Dec 2020 04:15:29 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id k6sm8412863wmf.25.2020.12.10.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:15:28 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, lukasz.luba@arm.com,
        srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 5/5] thermal/core: Remove notify ops
Date:   Thu, 10 Dec 2020 13:15:14 +0100
Message-Id: <20201210121514.25760-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210121514.25760-1-daniel.lezcano@linaro.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
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
index cee0b31b5cd7..d7481fdf4e4c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -407,9 +407,6 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
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

