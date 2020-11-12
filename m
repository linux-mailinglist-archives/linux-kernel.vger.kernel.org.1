Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5768B2B0D56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgKLTCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgKLTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:42 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2028BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:42 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so7136937wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIBIVuzBlrGyaebIimJgPfSPXPdePz/jLOplaNl77Uc=;
        b=S9tZWZNQXIkRV9mPM6OEmeVeYu0c4QMcShen80UEKoX4pqHBh/GmCzilomqYNxV5r+
         Gvfd1aJzgRPBkD/CPATnf//LEkjmtVu73Mvst7Yw5of7zAwHLJiLWbOtttCx5SQ0HFYd
         HRAKO81DLHM+HxOmmHNxqpv4R5H1NdLISE28IMLAp83hNQ96sMDrtPXh3rhl1ZRlosu4
         3sd6MsCuUE/vPrKmay52fIdQIi0vi0tOvBK04HHiUj+In+L8e08Qlzamx2gTq+STIq5G
         HGbFhB8xc0BlejFY8N8U+27dYAqSatMBbQPiyHrOuFIw0XjG2VeuIN7LeOTTFKJ6XrWu
         fB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIBIVuzBlrGyaebIimJgPfSPXPdePz/jLOplaNl77Uc=;
        b=dm/j9OKH0l5w7xo11Vr8dQsWZruXMDgwaEPEgTKd32z2QNmar/VI5OgsBU3B00AMWP
         Bx7H/GCavX2AEwdd3qHThfF4FqwHCqVxke7jX/pT8cfnaRB7Ibj0yr1V1INyP9rer6e7
         4XpDdW+iIt0p3R5zjGKr5f4WKwKf3EHzkHo1xwF3CgMf07ecFm5c1cO6vLC28hcKQcEd
         F6Pna6Xj7NW5qmOJ0/HaBhBcXz/0SQp7nQEkeRE5b8Z6lR2sVdxzieA35cSkgq9dzCxF
         sfwpXt/DHWwZoCzvYVio8jc/upakV0UVBQ7zXzcUhmO3juV4sHpIa56GjBXSeAtGOrjF
         5Q8w==
X-Gm-Message-State: AOAM531BP03F5MdwuHzmVoyQF3pk6fv+kCX68aNNWWd9cbsPEP2AS1TV
        DZKs+0V6TbxGlkwt1pjH207/nQ==
X-Google-Smtp-Source: ABdhPJzi00lpmiu98Uws9+8H0DTTCUdhvJWoWsZRfmSHcUmZJrPN5bkxKIJNvHUJveEjzIibaQ/d5A==
X-Received: by 2002:a05:6000:110c:: with SMTP id z12mr1108335wrw.214.1605207700757;
        Thu, 12 Nov 2020 11:01:40 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 23/30] drm/rockchip/rockchip_rgb: Consume our own header
Date:   Thu, 12 Nov 2020 19:00:32 +0000
Message-Id: <20201112190039.2785914-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/rockchip/rockchip_rgb.c:71:22: warning: no previous prototype for ‘rockchip_rgb_init’ [-Wmissing-prototypes]
 drivers/gpu/drm/rockchip/rockchip_rgb.c:159:6: warning: no previous prototype for ‘rockchip_rgb_fini’ [-Wmissing-prototypes]

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 9a771af5d0c95..c079714477d8a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -18,6 +18,7 @@
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
+#include "rockchip_rgb.h"
 
 #define encoder_to_rgb(c) container_of(c, struct rockchip_rgb, encoder)
 
-- 
2.25.1

