Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D872C03FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgKWLT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKWLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:26 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72F2C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:25 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b6so18232781wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZm3HjDLtuJtZU/XUCLzOUL6uLBwe5Uw6r19LFGVc9A=;
        b=bmCfHxZJ1vAkBYRpM/TJqbpjN3yQIiw6Ll3iX6wkxuI8OSLnT++wMOyhXAGOSa207/
         9dmUzZzcImyF/HxDtNRp2NJrhQErZx/29kkI/jQGOz4eqGgCj5IxH78nRIxI8GLLRvA7
         Xqgljx5855/GXYD9i/gx+o6tTuHJARHSzgqwjIF6Mfru8W2jm8mGAS2XywvDyVEvDIdN
         HuLEtfpKLBl5gXhF/mTVbf/GDxRZB0aWa1LmYe0k+Dw2hcQkRexBQ5viKK6mcu32KzCh
         XDqYcnQowCiNtR9Xm1JT/hOf6PDs4eU3SmxURpKV2V/CY2HYB4beM2egWgC8qFK2SHAl
         k8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZm3HjDLtuJtZU/XUCLzOUL6uLBwe5Uw6r19LFGVc9A=;
        b=IsXGxxdSwdtMLk5CJafUYSoVaQCDpo2pQ5ij5IOM5ZZLczrcZhTebxvRG54gzGZK8m
         TilF0FmZDlBII0un7XWlLnw7qMGrCSx7KXFPot/aXFrPHVnkfctD/MlZy0JTGBm+rPuL
         HYXSUKSfaoQOds6/bMxlRVi8a6hNg1Az1oX5ng+fHSWcw9+dIyO4w4VqK8E53/gpDLjg
         tZU9UbuMZSdVzCjw4Cr3kOA7c7qJJQ55jKMt4aAy4VeQZtN36t/kkp5nxqz2TPHc2U/r
         bYtDJPTPN25915LP+Xkv6GnLKe/NDQOtwPZMPC52Kq/fhRzz37o9k4SwT8Tkl5W7dQhd
         5ayQ==
X-Gm-Message-State: AOAM531XMqhOhfsV5lAjXc9I1xLF0y8VpVmrD5fxyDmxzH6ul9Blc3Ut
        LkWOL3+Te66tXpE40t4bWfvYRA==
X-Google-Smtp-Source: ABdhPJxPBCZyllGUhZ7EDFlbon05niAgISM1TfU092j3FBydqizzyNzorBFzF6SxdKtD3NZF4RiAJg==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr29521329wrr.194.1606130364573;
        Mon, 23 Nov 2020 03:19:24 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/40] drm/radeon/radeon_device: Consume our own header where the prototypes are located
Date:   Mon, 23 Nov 2020 11:18:40 +0000
Message-Id: <20201123111919.233376-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_device.c:637:6: warning: no previous prototype for ‘radeon_device_is_virtual’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 7f384ffe848a7..ad572f965190b 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -42,6 +42,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/radeon_drm.h>
 
+#include "radeon_device.h"
 #include "radeon_reg.h"
 #include "radeon.h"
 #include "atom.h"
-- 
2.25.1

