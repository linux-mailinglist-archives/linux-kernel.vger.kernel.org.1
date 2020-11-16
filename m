Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FBD2B4E16
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgKPRmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387786AbgKPRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE07C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:57 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so19622369wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIBIVuzBlrGyaebIimJgPfSPXPdePz/jLOplaNl77Uc=;
        b=dJjWPHa3XSW+Ks76T1YqjrP8Dal9w+IUPXB7B0WHSP7xUCjZgNZc1GMjFypJy45vz9
         iRTaxjVnCRfTzngcfrS/4Refr2BTlaNkKolSVU5w93MFZHZvZtYlw/GYpoPROQ3wieWI
         4/bncU60X4rvtrzb0eVCC5XTG+4wcKsdWumjKq9VnsyeKq+eyPfQ/2JJAQgU/QnLrjlq
         wm3lnnvmPZHgysqF5d5pd3mSZMy5/H0Fco7jajp+mDVA6a1Y+Uo5R6jJtticd68vu3r0
         YwT4a3Qsyysuyt2/3Xd7BVvi/t3DjsfVrjNQSldCF3NNn0JZO36Y8iz6FdKQ+aUEFuMO
         ektw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIBIVuzBlrGyaebIimJgPfSPXPdePz/jLOplaNl77Uc=;
        b=Zxj92DAhlCTkvsyAxLKcRy6yYRCI2qQmBVXF4OYD5dZ0WlR805EOjrlZnCUbwIzIep
         UUZO1TZ0+yHxvxXuz/YznImY4dplcOnuOXCpiGn8e25m38gfwBzn+nIr5ncWdlQA8enG
         MbWA24I61soKC7ToIJPundf2zr8lS86NMgM+i1QPfS6eOQiavZE8yE4crvYsSfi4pdUS
         UOgjSqLng/DrdzLMLSwdpp6xwKi4szl5peEDdUkxhwxbItiFFDcts8rfBmJhOA3EsmWu
         aAAjNwmQRax1qDquNRRf78dBHZhW2ZAN0djKyRehDRzrfb65lmS/SRqnOBjpYy0r0QIL
         ErjQ==
X-Gm-Message-State: AOAM532w1DfUhAcX5SWZRIlQWt+GZUm91w7ER41TP+t0c7E7HXHhd+PZ
        P+fXshByL7urMeojVix+9K5ajA==
X-Google-Smtp-Source: ABdhPJxDDINDffKvoqG3eEdIP5lWfvrdKvY5h8rEXr/nMWkPCPHtkoWbEr/dVNpmPZeeG4ec1Xg7cw==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr20186302wru.45.1605548516035;
        Mon, 16 Nov 2020 09:41:56 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 25/42] drm/rockchip/rockchip_rgb: Consume our own header
Date:   Mon, 16 Nov 2020 17:40:55 +0000
Message-Id: <20201116174112.1833368-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

