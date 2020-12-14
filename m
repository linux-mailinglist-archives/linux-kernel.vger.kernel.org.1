Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810FD2DA44D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgLNXmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgLNXlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:41:03 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E13C061248
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:40:01 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c133so3271341wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vw6zXAVb14wYNaSbzDr0/nxXdw6EsBX7NJU8sXRM6aI=;
        b=f0g8Uw1Cgwv+yIrfOsY4jCzbXBoIw7JjgtgY4EsnRINvE1qvXl5DzItAGzHfavvWmx
         Jek0Anymic0OdGaHMyxPP5Uw0jxtUhK6dZG5a16Mzm8Jkfgijq/Og0uYX0oMIYdZRqAS
         Cg3ufEp08+FpYgua4YJFKbz8GYbDkDWzUZDOHQrEW3hPRsDcxK/2Hw3BSw8jVyYOoHUe
         VW2sGsh7HDRnK6lpYze7a5TdkAJAr5zfoMBnIyAjhjq6TpZHM3TCznwmZgd4Zw/flG7H
         8xCdoJqi3YisO6ynAePqxRm2qHhVd3qTGvMsPj8aG4SSE5oHfkvf+GIWMxtpwIkfTv1L
         UG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vw6zXAVb14wYNaSbzDr0/nxXdw6EsBX7NJU8sXRM6aI=;
        b=YVRXOIA6jto7v1lQZOsLsNMMVIf+yOFSdQsVL+FIk8jvVwb8fPIe9MvoHirshVr5cr
         FyIFtx4WC9LigdweUYl8UpCvq+0peGZTVUxUDlnK9tblv9wddHjIz5QJj8zu3VyN/+DK
         eRKkJ/E1tu5dFxlEATPaB+VKi3onmgwiQya4w5fgf4rZ+QxSOkf+jCwaSXEpfmiFhxnh
         a80qjLORP4y+Giu2x2f3RKwnocn3QT38Yp5XL9IRamwUP3VSCTE3Ubrq1sMf9JrHh1Tc
         w1SzlCRW92NRfDdaccfu5WICkkSMxbDMJ8b+JpbI1QvVgoSueIcgddiqRI9y2RsLTA5Y
         GQqg==
X-Gm-Message-State: AOAM532iRzO181LFdvZBb8iMssLstk4fR5w4ceDc7IS89lPH9uD2i75H
        zHQTnTbbU/4nwF2ENcei83SmZA==
X-Google-Smtp-Source: ABdhPJz/TXdVSmSV9uuN9MKZOBy/WrOLpNpW4epEuhuCbLNQk+aSlDQU3niNx/VMxzXzAl4huVGIUA==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr30789973wmj.115.1607989200619;
        Mon, 14 Dec 2020 15:40:00 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e842:4086:6f24:55a6])
        by smtp.gmail.com with ESMTPSA id h3sm34145075wmm.4.2020.12.14.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:39:59 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org
Subject: [PATCH 3/6] thermal/core: Remove pointless test with the THERMAL_TRIPS_NONE macro
Date:   Tue, 15 Dec 2020 00:38:06 +0100
Message-Id: <20201214233811.485669-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214233811.485669-1-daniel.lezcano@linaro.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The THERMAL_TRIPS_NONE is equal to -1, it is pointless to do a
conversion in this function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 4e7f9e880d76..345917a58f2f 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -875,10 +875,7 @@ trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
 	instance =
 	    container_of(attr, struct thermal_instance, attr);
 
-	if (instance->trip == THERMAL_TRIPS_NONE)
-		return sprintf(buf, "-1\n");
-	else
-		return sprintf(buf, "%d\n", instance->trip);
+	return sprintf(buf, "%d\n", instance->trip);
 }
 
 ssize_t
-- 
2.25.1

