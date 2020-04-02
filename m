Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8919C40A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbgDBO2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:28:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40037 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbgDBO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:28:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id s8so2310020wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VU+xqIYUTfSvHhAUSB6IALHNuMd3fiGTEeSEcx6bLyc=;
        b=ZQ7d6GqzAsfbjd/MDsta02mPMBsWG2DWMtHQBcag5uJzvizQXTWes+lpcRIKs897Cz
         0ekiMSVf/i4tYpoD4j5pQ9zU0j6qdaJcVbvSlKeU+BnlI5IMB7FfenFk4tAuDNY7D9qb
         YYEOBCdVMf9p2nI6AdHUXtJH4tGV7csYlbxkda4ht10qKDHngS+rpfjhLaisr+Q83GZN
         du6thyKJ9Ox1zEcizCAJXf66hsMBmhu2vHfspOo/RgwHxobTtKZ5vyWv8vWAagWcCSlo
         s+L47YHN88sSsewX0BA16l+uqYK8RbGfA6ePDsLJSkxCzNtSyaFixmF9iT52VUgP0l4v
         lTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VU+xqIYUTfSvHhAUSB6IALHNuMd3fiGTEeSEcx6bLyc=;
        b=CYrLDy7xpgOTbMKxZ/vgMNG2kc3Nf4mcosqGZNpXMlMBlooIKWZJB3BiZEhR31s0Pc
         QMb7b1949SUDnQ01uNl6DqfPp2jN6ZO9YI9VTk4tmQSA4IVkljuMa3MGoDKiYsI1OTCW
         8ybTYLOEWeBVHnP9B1vQL/6mdVgheDob2n/nCVdAhhPgKHLKjkb1/n8W8DC2xiLmKhm6
         rY0hTDrqLrYfJcLdqEUiwLKdAZsALS7hNkIlkFpS2H0yKapbkPHsIJOGeTpOPbn+dm9X
         cXRDJe6qF+SH7XW02TFNIOSomEEsYVx00hrIqWzoqjiuJw5JnOnzCtuRPSRcQAukngUc
         aSsg==
X-Gm-Message-State: AGi0PubgFRLqIdJVdM0UKLwELB6q02oPL2Oj2cSpLmruTiWt0uem2ALs
        Ey77exE8HAB+xmbFeB10Strr+w==
X-Google-Smtp-Source: APiQypLT5yw5tziJRrxbLM60c69A4QnjkhFlp8iihyXSDhdHB/OsoJrERJNAbcAMyfJhp9htuqZXQw==
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr4090462wrx.210.1585837690305;
        Thu, 02 Apr 2020 07:28:10 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 8/9] thermal: Remove stubs for thermal_zone_[un]bind_cooling_device
Date:   Thu,  2 Apr 2020 16:27:46 +0200
Message-Id: <20200402142747.8307-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of the functions depends on THERMAL, it is pointless to
define stubs. Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 12df9ff0182d..7b3dbfe15b59 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -426,16 +426,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
 static inline void thermal_zone_device_unregister(
 	struct thermal_zone_device *tz)
 { }
-static inline int thermal_zone_bind_cooling_device(
-	struct thermal_zone_device *tz, int trip,
-	struct thermal_cooling_device *cdev,
-	unsigned long upper, unsigned long lower,
-	unsigned int weight)
-{ return -ENODEV; }
-static inline int thermal_zone_unbind_cooling_device(
-	struct thermal_zone_device *tz, int trip,
-	struct thermal_cooling_device *cdev)
-{ return -ENODEV; }
 static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 					      enum thermal_notify_event event)
 { }
-- 
2.17.1

