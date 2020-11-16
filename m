Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB152B4E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbgKPRoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbgKPRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:56 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18069C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:56 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so19674290wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEyFJOSSbdvLfYxo1nswzgxPyZwwh2XfGKJvNAOyE+k=;
        b=gjEJWyJwzFrX7dC3f76aducJiYprGZ51SMUFwBK0DQrAv2ywbkD8FzspryEi7eqbmU
         NXN1+uLfqPrmytc1nA4abMsKa57dKeJvezW7Rwn+7yCHAylw/EoLcg9k6NvPlYerc67F
         QHekoEKTHsinLMc3sfH0j8TI3MZbJXOfA58QULxB4oq1DmI1kEj8W8/yjoiry5RfRYjb
         hwxFEINkJg6rRbF27qnkxPUEz2B1K+Gwpmg8fZp/SXQRDZKiHYeHpXXTyxGIKh40CdHu
         Wp26Nhmd141+vPVeDCootPazEl9rUNZH5qUXvPTcRM89akPJGhDuAYOv8WSU2mHvgXfy
         4dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEyFJOSSbdvLfYxo1nswzgxPyZwwh2XfGKJvNAOyE+k=;
        b=U+8ORzwWq8Znfa10Hs78ggXspppU0BSTpxBCxH0+W3H2NZs+iKd5r4fezdEQ0ffocj
         4uds1puqYDktO00rTgCw3a0aeJXQZH3InKCFM5nFx1nUJ71Xx0WHR4aUk6EBqYc8TysM
         fJVC40bOWhzEhdesqDxX0wycq2ynWmgr1SiLRQYsI3NYC66i/EV4jRBYhUwYTY6QvD2Q
         MD7vAWbKMXgfQVoWj+lgxXRZc0iyuI7hex/5SZ91Ihdl5bdPOIFWT9HG2Fn6+qRBEZ6N
         jq/FLiU/cleiQN2w/q5bMzowqWjfGJgprkLNZPHuTw5yZmVay7JDvLRAySCVVCQzy6gn
         d/Ng==
X-Gm-Message-State: AOAM530k3bVZEhpQE4lAfu0ClhEYhVfWgxypHFqTSxeLRyOW4pjblN3o
        FfAjewWBwd5+qsyTuVrwtZj2aw==
X-Google-Smtp-Source: ABdhPJzEz6hKtbXBg6S6mlCSEzioxtEnXfOHuGEg87lALXMzEVHRmwq7gEtk9990PpeLgnNOh0pLRQ==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr20117453wrj.162.1605548514868;
        Mon, 16 Nov 2020 09:41:54 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:54 -0800 (PST)
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
Subject: [PATCH 24/42] drm/rockchip/dw-mipi-dsi-rockchip: Demote non-conformant kernel-doc headers
Date:   Mon, 16 Nov 2020 17:40:54 +0000
Message-Id: <20201116174112.1833368-25-lee.jones@linaro.org>
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

