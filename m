Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E72B0D57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKLTC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgKLTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:42 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F132C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so6420936wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEyFJOSSbdvLfYxo1nswzgxPyZwwh2XfGKJvNAOyE+k=;
        b=luGD853vRdhiDvEzMuqlML/DI46z1HchP7kIYP7123hCXjIDgT+HMOCnSJrjwbOs5T
         dyI9rFHG0jjrNjVTuoAMKToPrIkva/LkzsMRcVNzK9cBSG2xBrrMOPXjo/YLDV+uHCjF
         H7vK6vwlbKYitJyuncaAeAWzP2EWg44x3fmsTEpg53cocdLYVkxg3dTjJzwp9W717Bbf
         m9syiXJiuReemJUapLpUUPWPavpT6L8UOkIrtVnpFmG1FGBdZvF3DcldZyWeqB3hxnnK
         eNzI7U1bN53rVphSw0qjmtxO0V1pGzv6KhP75YnlQNU7GvWZJiHb0QSUJwnj1C6EckMd
         hDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEyFJOSSbdvLfYxo1nswzgxPyZwwh2XfGKJvNAOyE+k=;
        b=Ozkn7OephihgHb8NOk53T2ox5jHq/IqB9h9KaoMrXtaKNyAYYHXEJ97v/xa2i6yv1g
         C03uklbFKZZLzmBTvKkTIPosoyb3VTiC1Y2I/xSR4dJ9n04spelKwfr0z8RmMEgoD9mD
         AQydSTpoR1WkAmLoovMfPKBvMKLXRxw1dQ0YTYqeFjg2mZQysoVOmk9+wB+FVCVI7tKE
         U1VcWwnAFyB+teRYd2jmY79TT6rT2lkEx4PFKjPwSB8EHvcpH/UmOb4U+t/yuy2NIkyR
         W9MjqcjoDJNmdsDodXN0ZIXeue+oVCSFi/sluqi2a5/yL/c+JMoI8x8+D9XzYvYEBNz9
         TwcQ==
X-Gm-Message-State: AOAM533DuY7qrLSdEz3/JzRK2LFybDhSeMsUlXG30Cta3oxcbItJP5I+
        uihjq++NBfnRqeBSlLkkrHcJDA==
X-Google-Smtp-Source: ABdhPJzJ0+Yyv/37xYPSl7RKQhEM9Vy9lp/Wn8yEAkQh4vhITJTf2t4B9xuaXBBI/2x2qd6o8Gl7Dg==
X-Received: by 2002:a1c:1d82:: with SMTP id d124mr1156353wmd.12.1605207699167;
        Thu, 12 Nov 2020 11:01:39 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Zhong <zyw@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 22/30] drm/rockchip/dw-mipi-dsi-rockchip: Demote non-conformant kernel-doc headers
Date:   Thu, 12 Nov 2020 19:00:31 +0000
Message-Id: <20201112190039.2785914-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:357: warning: Function parameter or member 'dsi' not described in 'ns2bc'
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:357: warning: Function parameter or member 'ns' not described in 'ns2bc'
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:365: warning: Function parameter or member 'dsi' not described in 'ns2ui'
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:365: warning: Function parameter or member 'ns' not described in 'ns2ui'

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Nickey Yang <nickey.yang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 542dcf7eddd66..e84325e56d980 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -350,7 +350,7 @@ static void dw_mipi_dsi_phy_write(struct dw_mipi_dsi_rockchip *dsi,
 	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
 }
 
-/**
+/*
  * ns2bc - Nanoseconds to byte clock cycles
  */
 static inline unsigned int ns2bc(struct dw_mipi_dsi_rockchip *dsi, int ns)
@@ -358,7 +358,7 @@ static inline unsigned int ns2bc(struct dw_mipi_dsi_rockchip *dsi, int ns)
 	return DIV_ROUND_UP(ns * dsi->lane_mbps / 8, 1000);
 }
 
-/**
+/*
  * ns2ui - Nanoseconds to UI time periods
  */
 static inline unsigned int ns2ui(struct dw_mipi_dsi_rockchip *dsi, int ns)
-- 
2.25.1

