Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680A52DA447
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgLNXln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgLNXlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:41:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9841AC0611CA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:40:03 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 190so5044284wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HR6fxnctcFG0S2fOhN1StND9v+I0KlYE3gnQEW5jseo=;
        b=I4+ur7/JqkDvRM9rhYAD8XbIRYlOOoS5VmC+0o3cupQmlhxvVdRe5zc1ugCTN2c50N
         rUCImwC/t6kBthv1M2bwbWgHCayE1VisBLU4Etxmli/UZw03f3d976Ws99Ep9PcZoQDN
         MEXTGyToiCQh1Y6IhO6g6Y4yY7GOQveUouYtNOk1UMvM0XGxJkxPRvsqmo4UdosctfW8
         pMTaP7uJMLDlFOhOd656vO7TunBRhFr32P3JgME36WPwQSkCrSJE4ldXKhOk1elfhuzc
         4Ozvb0ZZLcQBBvaAv24A8g9JNIOfBNGMc+mpd1WCCDQ1ZZx8aR8mya6qP0gdMWp1jCxs
         EI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HR6fxnctcFG0S2fOhN1StND9v+I0KlYE3gnQEW5jseo=;
        b=Sln7Ww93CNq9vrqHX/AnR9oeFXXhMxVm9ePAQM3ddAqfOW2cdMrgqKx2tWtqbpQ0dk
         5YDiGolE13b12rk/618BpRxAr6KPfBrMSPzTwYrSAFCXnaAW16nznW9oLA+t78XouSYc
         tq1aJ2iQgykiAr0XAgeB+R4A2dn4kYYPkf0VUY1QVNt0tu6z6A632O+UyUJkoEyIoPM7
         u1MVnB+PUlxd6j9F9I6NHuorKodbpwLXvoAJICRxMxfIWBKSXCzXf8oiEk2FHM1glxe6
         JUhMpeXsa4CsoX9mhnk0FMEbqHOYVXjIZB5wF3xvKB4g3Vi4hWOAaUk+68C8pxMl3rO8
         lHhg==
X-Gm-Message-State: AOAM533kUABEuMUz/UDYwVJ0yIgSPoBoHAd1GWvV/zBeSYP2Cjurura4
        MA0D5R1VQZxJao3zLtDCDjNRkQ==
X-Google-Smtp-Source: ABdhPJy7Yk7b8Tx5ebVkN303VPChAZspl2TDmQ7lnf4hy9dgarasNh2bFkcPl+Ftld8ZcrfTN396vA==
X-Received: by 2002:a1c:81d5:: with SMTP id c204mr29695087wmd.156.1607989202159;
        Mon, 14 Dec 2020 15:40:02 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e842:4086:6f24:55a6])
        by smtp.gmail.com with ESMTPSA id h3sm34145075wmm.4.2020.12.14.15.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:40:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER)
Subject: [PATCH 4/6] acpi/drivers/thermal: Remove TRIPS_NONE cooling device binding
Date:   Tue, 15 Dec 2020 00:38:07 +0100
Message-Id: <20201214233811.485669-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214233811.485669-1-daniel.lezcano@linaro.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loop is here to create default cooling device binding on the
THERMAL_TRIPS_NONE number which is used to be the 'forced_passive'
feature. However, we removed all code dealing with that in the thermal
core, thus this binding does no longer make sense.

Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index b5e4bc9e3282..26a89ff80a0e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -764,25 +764,6 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		}
 	}
 
-	for (i = 0; i < tz->devices.count; i++) {
-		handle = tz->devices.handles[i];
-		status = acpi_bus_get_device(handle, &dev);
-		if (ACPI_SUCCESS(status) && (dev == device)) {
-			if (bind)
-				result = thermal_zone_bind_cooling_device
-						(thermal, THERMAL_TRIPS_NONE,
-						 cdev, THERMAL_NO_LIMIT,
-						 THERMAL_NO_LIMIT,
-						 THERMAL_WEIGHT_DEFAULT);
-			else
-				result = thermal_zone_unbind_cooling_device
-						(thermal, THERMAL_TRIPS_NONE,
-						 cdev);
-			if (result)
-				goto failed;
-		}
-	}
-
 failed:
 	return result;
 }
-- 
2.25.1

