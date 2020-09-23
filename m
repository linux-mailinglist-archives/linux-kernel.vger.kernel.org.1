Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6227520E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIWHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIWHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:00:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D2CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 00:00:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j7so6321595plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4oRwmR3EhcJbAFucNH/94gqJmXyc3Ivz1Uey2cJmuPM=;
        b=KnK7Yrl5N78RVstfT4p+cHqser1Rh3nceDzmrZ9asUN8ZJdo0tbpjiCa0qEf5iMDlN
         g1lXCGvY88a8cVIypjS//QW+6FIeK2n1vWRhrhFPnragCHv5lxfx0y76pjYusiVViGPN
         vXq8jofjEMP2H8IcVmi+cjvG5M3HTmwqTOjiMml3dElEIY0uscYjv/xOf4CU81TNau3N
         LsLFtz7eU5n6uYTbOiak194H8+DJEjOFpffvb+JB6oXdqoV+5zDwkofhsyH71yEFeZ3h
         oPnf7Uf0qKUNdfpBXOWEU8M6FjK1Igh+Cqr4bgZaFoItzAd8avdZwmo7OJvDGiTtHujR
         dOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4oRwmR3EhcJbAFucNH/94gqJmXyc3Ivz1Uey2cJmuPM=;
        b=sBhJ9/SxUJY1Vuknuh0PvjgVHM/C9Ogh023WO1rBsm/2eOkfkf53aTSamMkCDDQ7p/
         7PhgKlujxtm4NG9+XL3gPZU43tawOBIwZqDeAKTIAS0PinApQv3c1fU4E22wTzDnYicP
         QGcpuCodPtes8/KXrXImSGT0scFgEdUgpj51QeIxDm44SXclawz2nJThNqBFDwwj3Zg7
         Zr0P6TglVnHrfm5YoZwQyLdq2fGBGcbeyP9xqGA4vEjaimA2ExbPR+HA0RQhf00gpSs/
         cK4grvSDKKqIUgWl3DtyldGaJXMkycOpoY2UW/ayRXgZRQt3rgbQdzhAvUoQiwix+Ics
         8w9Q==
X-Gm-Message-State: AOAM532Nr4nnDZypIOTDEosvEXhPBeqBGBq2HeM5HLVsFcidfR/DSkgA
        NCWRUY5S+BI5mTz7MB3pZ1J7VA==
X-Google-Smtp-Source: ABdhPJz3kVpgSu//J46x/GTqCeisWVwS2nfBoJ8yAFUJqHmANvefDc9kzIAfNXlfMpEbuZT0p9avNw==
X-Received: by 2002:a17:902:8695:b029:d2:29b:991a with SMTP id g21-20020a1709028695b02900d2029b991amr8436516plo.80.1600844443090;
        Wed, 23 Sep 2020 00:00:43 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id j18sm16090095pgm.30.2020.09.23.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 00:00:42 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] drm/rockchip: skip probed failed device
Date:   Wed, 23 Sep 2020 14:59:00 +0800
Message-Id: <20200923065900.658666-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAPpJ_efHX70Ej0uzRi-iRf7N0n6ZO5sMN-wK_YpszvVD-Un9RQ@mail.gmail.com>
References: <CAPpJ_efHX70Ej0uzRi-iRf7N0n6ZO5sMN-wK_YpszvVD-Un9RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cdn-dp sub driver probes the device failed on PINEBOOK Pro.

kernel: cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* missing extcon or phy
kernel: cdn-dp: probe of fec00000.dp failed with error -22

Then, the device halts all of the DRM related device jobs. For example,
the operations: vop_component_ops, vop_component_ops and
rockchip_dp_component_ops cannot be bound to corresponding devices. So,
Xorg cannot find the correct DRM device.

This patch skips the probing failed devices to fix this issue.

Link: http://lists.infradead.org/pipermail/linux-rockchip/2020-September/022352.html
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 0f3eb392fe39..de13588602b4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -331,6 +331,12 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
 
 			if (!d)
 				break;
+			if (!d->driver) {
+				DRM_DEV_ERROR(d,
+					      "%s did not probe successfully",
+					      drv->driver.name);
+				continue;
+			}
 
 			device_link_add(dev, d, DL_FLAG_STATELESS);
 			component_match_add(dev, &match, compare_dev, d);
-- 
2.28.0

