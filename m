Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B192DBFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgLPLm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgLPLm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:42:59 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5DC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 03:42:18 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id q22so14500938eja.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpFk2jW++o/c5mecPREIAGYZAOvlUctt44C0JGqrkMg=;
        b=X9qwLlVj2vFqyrsO4c4Ef4BcFxY4hXr24RrggjGJfJEACj7B7Q+qFOD5yW+t/h87uq
         6pqc6JCK6ZNBHxTyoRFlhWVdX7wzR0Q/HQzp9u/q486tt73fIFfFMhnUBFn6RI/DsMN2
         MLmWemRc0DE3pO8qVk8LMSLHgx5mcRqtkLWaRBeceIhjtSCf0+ycCgjznPHm+5QQyUvN
         c70Hz945tKQLQ8ql1JVrqyo6leSmw7pw+G06uJCsMVCoC19qtAr48TzN6f1KxJeYTTHG
         Bv8dyjADbkEn5kYa3QfRvS4dbk5ytfsokbGYz8pej6ENBwEOEu8PL/d3GA2qBxqg/at+
         wV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpFk2jW++o/c5mecPREIAGYZAOvlUctt44C0JGqrkMg=;
        b=b8CyK2iZ2AczTQVsiIcYE6/DhWbDwJsqk4Kn8edunzDy7JwCGTpCkNckDEXluXfaTl
         El+XyonQ/s22SlFOcGrsw7EaXjd0aPXLR8cynUH+O0h71Nif+SuU4wZR0YNtVZx9YDt6
         yVZK82cN9MrvKOUlsjczwKEA59SpEfOKaCn06R/TvukU1eT/YxSortbAjvESbBUIPZi3
         b4N7H6MZYnTiduObk6owBQretaUjYY73bn2/O/MDyTMhSKNdDJIKUJTovfvCzRAJp4pi
         u2CqdXTfigLHYkEamWquCi+3TeRuBwqFwpg04AGGoqoDkbz3hil/hWquoLLFjFsc20Dl
         BLYw==
X-Gm-Message-State: AOAM531tK4B48huOPI2xNCTBjFbDCmmY1lft+Y+PHliNtwkdqcCs8Lze
        uY38Jbvn19MW38XLHBLMVbaT9BRStTRXLg==
X-Google-Smtp-Source: ABdhPJxamD2xp7vuL0j9UPK+vAORDA1al7JS8aMaG+jUl6Rk+0gBnwf83HKvOY+En7OXRX1uF5k6Mg==
X-Received: by 2002:a17:906:1916:: with SMTP id a22mr30353517eje.536.1608118937452;
        Wed, 16 Dec 2020 03:42:17 -0800 (PST)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id y17sm1223472ejj.84.2020.12.16.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 03:42:16 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/etnaviv: provide more ID values via GET_PARAM ioctl.
Date:   Wed, 16 Dec 2020 12:42:01 +0100
Message-Id: <20201216114209.276630-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible for the user space to access these ID values.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 12 ++++++++++++
 include/uapi/drm/etnaviv_drm.h        |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index c6404b8d067f..ec16991ba8b6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -156,6 +156,18 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
 			*value = ~0ULL;
 		break;
 
+	case ETNAVIV_PARAM_GPU_PRODUCT_ID:
+		*value = gpu->identity.product_id;
+		break;
+
+	case ETNAVIV_PARAM_GPU_CUSTOMER_ID:
+		*value = gpu->identity.customer_id;
+		break;
+
+	case ETNAVIV_PARAM_GPU_ECO_ID:
+		*value = gpu->identity.eco_id;
+		break;
+
 	default:
 		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
 		return -EINVAL;
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index 09d0df8b71c5..af024d90453d 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -74,6 +74,9 @@ struct drm_etnaviv_timespec {
 #define ETNAVIV_PARAM_GPU_NUM_CONSTANTS             0x19
 #define ETNAVIV_PARAM_GPU_NUM_VARYINGS              0x1a
 #define ETNAVIV_PARAM_SOFTPIN_START_ADDR            0x1b
+#define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
+#define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
+#define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
 
 #define ETNA_MAX_PIPES 4
 
-- 
2.29.2

