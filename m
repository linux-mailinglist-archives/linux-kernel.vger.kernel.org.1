Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A865E19C40F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbgDBO2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:28:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39299 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387997AbgDBO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:28:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so4453486wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TUk4BQq7C9D9BTCs4+bHpz+dkPgArjMTN2O/LGAf+9E=;
        b=Hm+Tmi0tmk9FkdP/xSgzU53oqODfsMV6xJkTvo0iL75gG9thnJgVXcTUkIza3foeOU
         x/Co/kmapMn77EM4sUDxwraJvYK8P7u88OvB6SiQJCBmNsS1OubF3zyjDwjghhGzWnh9
         Y2xW7K+pVBhy45HEbiwI4qPKrvrSrDiyQ47FkqERh6NepyCuio1nO5EAb3j2GTiQOZp+
         mClWjYkIglg8p8GSIYruiwATJpjlTvEKvgSvelvZe+R1y+cbNij0PXgzSdoiKJKTHAhG
         p6oxY0XbWqZtcrQ+czI+0GZ3TWdiIb77a8cX0tlW3baXV2NlMFSTib6F3Mtrqoqz15V0
         1SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TUk4BQq7C9D9BTCs4+bHpz+dkPgArjMTN2O/LGAf+9E=;
        b=ZpZRHeB9LDVKwDjlnUmTVhwHhFULQ8x/yLBcotANXYQdiEMuvORV20EEq692FpfC/s
         guLANIZmR5OCF7C7BgVV2DAvvcxtr5E5HOHKZk5LzPTWR6uIrNMBdQadaorG+LT+Fl1u
         5AX7Ix8e+vJrErofEWEL3oGpyi4lIeP0os2JpsfnETuyRNk/K51nchnPsOrYc4T/JXGH
         neqC5QpOhZXRO4U7OHXpFIFOLL/OKlbZhuvSttBbuuzEX4Hu6MIaQl4FpTfXRIDZEviJ
         B6ADMmpGME8uENZrXOE7Kp5w43TZrPTYR190XH9nEah75X/YnnnI7aF4w4sGDlIeSp5p
         npUw==
X-Gm-Message-State: AGi0PuZVG/0uXz3MoCwqlm7IWiLF7JYV+IwA7+L2kXwAwFb0LMFEBd8R
        jrWB/e2aosC3c7mWXNfOJJm6RnauuHw=
X-Google-Smtp-Source: APiQypJliHbT0J/IZy5q+5JZe7zqwUmR8pqKIG1bOf49bCksoVzvmqE93UscXuf30ZX2WMatg03nqQ==
X-Received: by 2002:a5d:5586:: with SMTP id i6mr1368496wrv.23.1585837689096;
        Thu, 02 Apr 2020 07:28:09 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 7/9] thermal: Change IS_ENABLED to IFDEF in the header file
Date:   Thu,  2 Apr 2020 16:27:45 +0200
Message-Id: <20200402142747.8307-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework can not be compiled as a module. The IS_ENABLED
macro is useless here and can be replaced by an ifdef.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 47e745c5dfca..12df9ff0182d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -383,7 +383,7 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 
 #endif
 
-#if IS_ENABLED(CONFIG_THERMAL)
+#ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
 		struct thermal_zone_params *, int, int);
-- 
2.17.1

