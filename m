Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105F92CD044
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgLCHSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgLCHSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:18:33 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE227C061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:17:52 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k10so1745838wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 23:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJeEoDEeYHBeUS2YirOFrUkbP35JeO1CRiL+bErAeW0=;
        b=MMbAufQgXWEWIlC7G8WRrz7dEqThM6CoOO8uQqW+P4myef9EZ7C41l7Clbo7RlvoNX
         6UEEx0XDqmBn6aVotTntdsujfXxNyYPeNI4/wZMQ9QXaG01yncMkh5dtO7Si/GXwJ0XF
         Eig8HtsAX86KYi5uEnNrZ2uwbXdHrKTjNq/8wnvo+k2dSz7qb5OF+OaUALyJcT7gEBoQ
         NxcLe3+JR2jVTpAnQheo0svi2UpXO1oDgLeod9hCAcwM+tg/DtL0dq3JLeGfzgrLmKiL
         0G8s47ZM32iGKDeoGlldCJkVP18KbE7hI5J8Byp956oLmIT+UN7/7vkcwPOYj/jbhaRG
         vLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJeEoDEeYHBeUS2YirOFrUkbP35JeO1CRiL+bErAeW0=;
        b=gl74ayOJjzy2LAN7OJ8zhFPQuiTEGk27Zb7AkZBH4U9zHZA1rdpRYucwLYfbtPwUhb
         zmY8iylAvvUYkBPCPDBTEqsqIzAeBRWAYcoK1o8+EM26SKoGqLaT5mc8Vg34b1+wJM3e
         4l69BcIta14DIGKR5tcIEksF6uOKg88Pv82paHEl/plWwVGpUpkiaas6zKTbig8YhNZl
         YYW4s2cSzRIgYUpijktocr6piSg1CcmgABXt2g/LWPC+2gIsUuYUtoXKe3fndbz8CbRd
         ltKAbw20k0nh7U8NZ9zlQ2w7CQwApFS2kmyifPMKYcztTEakt9O2VF1SLZlAbf8POT0W
         dzCA==
X-Gm-Message-State: AOAM531Wvba9Arv3rXPvWq/obqx3DgY9IpKLyUhs4gpdujKUbolGLghR
        3MAgeg1tRftaMwez1ExgsIQsJi7eu+8fmw==
X-Google-Smtp-Source: ABdhPJybr33A0LI0IEFV+moS2TtDU+XzHLd5dNlJyV1jx39j4QjN2WgaDXeM74HPA6IsPQgIntln9g==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr1692022wmi.153.1606979871290;
        Wed, 02 Dec 2020 23:17:51 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2])
        by smtp.gmail.com with ESMTPSA id s13sm230402wmj.28.2020.12.02.23.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 23:17:50 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, peter@piie.net, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] platform/x86/drivers/acerhdf: Use module_param_cb to set/get polling interval
Date:   Thu,  3 Dec 2020 08:17:37 +0100
Message-Id: <20201203071738.2363701-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module parameter can be set by using ops to get and set the
values. The change will allow to check the correctness of the interval
value everytime it is changed instead of checking in the get_temp
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/platform/x86/acerhdf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 44b6bfbd32df..19fc8ff2225c 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -84,8 +84,6 @@ static struct platform_device *acerhdf_dev;
 
 module_param(kernelmode, uint, 0);
 MODULE_PARM_DESC(kernelmode, "Kernel mode fan control on / off");
-module_param(interval, uint, 0600);
-MODULE_PARM_DESC(interval, "Polling interval of temperature check");
 module_param(fanon, uint, 0600);
 MODULE_PARM_DESC(fanon, "Turn the fan on above this temperature");
 module_param(fanoff, uint, 0600);
@@ -824,3 +822,11 @@ MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
 
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
+
+static const struct kernel_param_ops interval_ops = {
+	.set = param_set_uint,
+	.get = param_get_uint,
+};
+
+module_param_cb(interval, &interval_ops, &interval, 0600);
+MODULE_PARM_DESC(interval, "Polling interval of temperature check");
-- 
2.25.1

