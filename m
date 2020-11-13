Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9E2B1CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKMNxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgKMNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:59 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29331C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:59 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so9987163wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3wgCBGmvivdJ007ItmhaKztBJ2SUW1onp/hFOY65gg=;
        b=DCwq41Tk7ZmgHAC/3+JoPkDNQ/4pMsacxYcZwe0I8Mhp3Y63vdk5PhXtNsTT1DKnj6
         lOrrm/witkSChNyeh3AmdSDIeiuWBN3AD3PZi96ahopOMhgO5n7Rtx1+spZwtSeX42dm
         tK8AYkULQSFwzudv4l1jezyqiksoFHxS4jHCJ+A8xUfjWX4f0NnICZ6LNb5bQYcf5Y6i
         iLadzB26xmshGMu2bAA7lU9Frx5nJeRKiK1bMvyOonMcwlYjhDZajlwgdZIAF+6+8hL3
         pBeEmtSSgi60N2XjVdnuJ0WhiFifGMogsnFtNuB8md5shdnSFpZ7cYIRu5vHxT6NV13s
         c31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3wgCBGmvivdJ007ItmhaKztBJ2SUW1onp/hFOY65gg=;
        b=jViBYHXfA3GXZ41iNj/hLAtNp1CB3zQbEkPSoCAq7b3WjERjgbksMw6hAb/zk+MG8w
         aRAUj2VThy0SA6SaiB/mcV4iAKOib1Il676+rJMPU/gbNx5piwLJHbQy8jSwThbDAH+m
         WsgArVsCxttxHagn9OJuyy4c00NWjjUcbPkM6OL2hBc+Xm/iukjBBuCgtk4inej/VapS
         Ea38Em0za5xyq7s6UHD0K/BxN/HR8Bmb3mNT+X+P8AwrRxdfXBD5jC0LH4t0bgdPBWkb
         EY4DYYDZsv7A5jxQ4HMT8SVYI+Z5NmQMGvRy9hTL8ALVZqDVK9zC+O2af90l7xOM9Xie
         SXWA==
X-Gm-Message-State: AOAM532eVb0Ti9zLqm2skTdWTvtDb0l+kIkmoFWAVpoL+Cm5rPJ1LKYV
        WupKFAfKJ6fTnFe2CVoIdaeCSQ==
X-Google-Smtp-Source: ABdhPJwoLZn4fi95tBHB/r7/O3Sw4PXT97CSOWLB5WHaG4v8CHxZVWR2ksL5mGMqPIW7yzbKsw7/AA==
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr3583701wrn.165.1605275397854;
        Fri, 13 Nov 2020 05:49:57 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/40] drm/panel/panel-tpo-tpg110: Correct misnaming and supply missing param description
Date:   Fri, 13 Nov 2020 13:49:11 +0000
Message-Id: <20201113134938.4004947-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/panel/panel-tpo-tpg110.c:94: warning: Function parameter or member 'panel_mode' not described in 'tpg110'
 drivers/gpu/drm/panel/panel-tpo-tpg110.c:372: warning: Function parameter or member 'connector' not described in 'tpg110_get_modes'

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/panel/panel-tpo-tpg110.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index d57ed75a977c3..e3791dad6830c 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -76,7 +76,7 @@ struct tpg110 {
 	 */
 	struct drm_panel panel;
 	/**
-	 * @panel_type: the panel mode as detected
+	 * @panel_mode: the panel mode as detected
 	 */
 	const struct tpg110_panel_mode *panel_mode;
 	/**
@@ -362,6 +362,7 @@ static int tpg110_enable(struct drm_panel *panel)
 /**
  * tpg110_get_modes() - return the appropriate mode
  * @panel: the panel to get the mode for
+ * @connector: reference to the central DRM connector control structure
  *
  * This currently does not present a forest of modes, instead it
  * presents the mode that is configured for the system under use,
-- 
2.25.1

