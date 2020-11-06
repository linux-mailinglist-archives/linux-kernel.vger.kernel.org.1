Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC22A9BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgKFSXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:23:37 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C61C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:23:35 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so1039778plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MKkOBZCmnnkkfq2sk1W6OI+c0KeKPWrWrNvTYxozK1s=;
        b=CUtPNhiUbyf4LAxR3iB7+8f0eR01VjThFFHigtTXQDEpl1W4/mzT+Y6H7YAxNxeebG
         bisDa+MxdvPHuBkhNRk7GmV5nKOoW3Ek70KEvgUKT0WSt3MVkHiLKTlTGXg/Q5jDADhD
         /GKCJoyUk46p5u79M4NGVTmhUPMgx9W8vK6F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MKkOBZCmnnkkfq2sk1W6OI+c0KeKPWrWrNvTYxozK1s=;
        b=sf3Xqb4czzrXfqyMBuEwhjXUpJ7qyV5Ig0tLX2VIwu8bf+S9M7betuybRzLgW4Q5Eb
         R20CD5dAdYF8dYTHUUAfmT2hqfJhKQKx+zwOttjYhbx96vbO+FIKppDMN6j4dKFBLR+j
         uKQkvq82DXXI+GonHlRZ57nmX+wmttk9zgCdcHBYQHdgiTchdHhotDInKGiRFQ7n/ohk
         Zu7AY1nBctbzqonBV+WLgC5PCcTcdNFNQJzmfwBu8tMrgh9fqOmi+XD/D5CXFmaMlSCx
         ngP8zw1hAy8D85fkclPDCRZwquGT5KQRW4DFA9H6TAG9SWbNER3t8xLxEVoj7YVjfbKz
         NGfw==
X-Gm-Message-State: AOAM530gtRilI0CcMqbXvzg+YqXXBdJ76h0tjpQI9RYPIqHs3J6VNLtZ
        pyATxMNj+jgRc2vaiycWDwN3OaHqnfRSIA==
X-Google-Smtp-Source: ABdhPJx8SHmXEBAV4mYFoSkHkoNGFAU9lOKSyzausqixRvZOoByFEpE5ebvABCnULHLDEAx1cBAepg==
X-Received: by 2002:a17:902:708a:b029:d6:c412:db4f with SMTP id z10-20020a170902708ab02900d6c412db4fmr2646285plk.69.1604687015297;
        Fri, 06 Nov 2020 10:23:35 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k8sm2979131pfh.6.2020.11.06.10.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:23:34 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] drm/panel: simple: Add flags to boe_nv133fhm_n61
Date:   Fri,  6 Nov 2020 10:23:33 -0800
Message-Id: <20201106182333.3080124-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the EDID of this panel shows that these flags should be set. Set
them so that we match what is in the EDID.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: b0c664cc80e8 ("panel: simple: Add BOE NV133FHM-N61")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2be358fb46f7..204674fccd64 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1327,6 +1327,7 @@ static const struct drm_display_mode boe_nv133fhm_n61_modes = {
 	.vsync_start = 1080 + 3,
 	.vsync_end = 1080 + 3 + 6,
 	.vtotal = 1080 + 3 + 6 + 31,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
 };
 
 /* Also used for boe_nv133fhm_n62 */

base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
Sent by a computer, using git, on the internet

