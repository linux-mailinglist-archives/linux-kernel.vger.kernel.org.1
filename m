Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788D12A9F86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgKFVvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgKFVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:03 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:03 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so1779579wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vkQ+EXF2yvxMQDq5My2ZO6G3Ve/ySfBy90ygkHt2VtU=;
        b=Gzq3IRI0uTFVZlLkG4qnK9tDKHmeGHf2mKcsxo5k/h1Bg2Tv8V54kdCY9AHxJgSEPs
         r+ddfC6UKgvuGktLUD0J4MeReXJRe8D9mj8jmxwpjda+Blbkmmo/NxejuMXZKnmqryPV
         tOsi1wq4BJ6Ix3M2w7sZ5r2Mq9Xk+iazjCRbiP4qCoYmVzorxIgZMMyZQ9MEgPs/9zvF
         TwCO+hl7gCCuh8YRq88MEFHPz7Te9KdEsbrLCjKGDkMsG4rypxZFbZ27YEaobgDFV4WB
         iMpXoWS9j+cBHUnPyuPpO22zo/9LPEyWSS2QNNcMyESyZYCS7f4/GglC1fKpXEZcZcwS
         5JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkQ+EXF2yvxMQDq5My2ZO6G3Ve/ySfBy90ygkHt2VtU=;
        b=UNv2pWpj7DoWgfUHiZrwKpjh/JbmdS2onlKpLsuxBj7RYI3ijtdUBAX+AkKtihl5AJ
         lpREyfXQT9B5+IJw/DcB9v3+EIMW1/Pm9AxKzQGbXj8MDeR5oohKhU5wUZ8hsn4Vznhk
         +d47WnJ8zZEf9UiBzqZeQLJdsmw/8ZKu8J17thEuNeqvhrWpJVVMr2lyeZqDUdh7y9Vk
         PkwPju5Pi3SHNvdRAUP4pRkEUFlOVJVdstgbkOtHqOVdU68c1Rpketm22SXKfRDtGi0Y
         52RjI0gw3a31FJ670IGLHP5Cc6uqOOIn2lvNcurPXZN5eYUCqvj6uh/JaAjl82b3PQUZ
         lfJQ==
X-Gm-Message-State: AOAM533ePMU6qOg1YmyOHZ9voy1dwD7G0MGLD5Tr2w9RsQkjq+xx+4Bq
        fcE/2wjNbyLAwkfB8tWYzyL2fA==
X-Google-Smtp-Source: ABdhPJyU7EH8mAlQbHj5iVCt1SHByf4Au5dpPrxdGJurg0RZZ8Yrc6araI0XkYSkWnrx8DEC2UDlNQ==
X-Received: by 2002:a1c:9e93:: with SMTP id h141mr1524494wme.153.1604699402333;
        Fri, 06 Nov 2020 13:50:02 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/19] drm/radeon/radeon_kms: Include header containing our own prototypes
Date:   Fri,  6 Nov 2020 21:49:37 +0000
Message-Id: <20201106214949.2042120-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_kms.c:61:6: warning: no previous prototype for ‘radeon_driver_unload_kms’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/radeon_kms.c:104:5: warning: no previous prototype for ‘radeon_driver_load_kms’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/radeon_kms.c:618:6: warning: no previous prototype for ‘radeon_driver_lastclose_kms’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/radeon_kms.c:633:5: warning: no previous prototype for ‘radeon_driver_open_kms’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/radeon_kms.c:704:6: warning: no previous prototype for ‘radeon_driver_postclose_kms’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/radeon_kms.c:755:5: warning: no previous prototype for ‘radeon_get_vblank_counter_kms’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/radeon_kms.c:825:5: warning: no previous prototype for ‘radeon_enable_vblank_kms’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/radeon_kms.c:852:6: warning: no previous prototype for ‘radeon_disable_vblank_kms’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 99ee60f8b604d..0d8fbabffcead 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -40,6 +40,7 @@
 
 #include "radeon.h"
 #include "radeon_asic.h"
+#include "radeon_drv.h"
 
 #if defined(CONFIG_VGA_SWITCHEROO)
 bool radeon_has_atpx(void);
-- 
2.25.1

