Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813322B0D49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKLTBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgKLTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:46 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37CC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:45 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so6182601wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WLjHfl3orvIQYtFk8cWNm313KtEs9zxT+XRuqJ/3Ug=;
        b=s4lVN2Hsx8GQ3TeqOoSE+KsBPJlUyYD142nagiXHMQJgIDfn1bY4BwRFQBD8Vbl9FQ
         O1+Z4SJSb0AKtr0z4NL7sqVeIdUmqJgfibxF7FcTPCDjxi72V/cgW+I45MyNR7hyQatY
         Qq6fLZTJliIXtLc70YQLXh9XCIkxcvBrW28WU+HTtjc9SLVqe0wfSak6HsnGU4+CHXD2
         TLxVHbtf1X+A4xTTQUaJmHS+quv06uqVKJCznn0DlN8LHoqBZKvJ05NZTDOTgolMzCmA
         p7dTjD0sVkTvS3CHvXQSUXtaP5QslSGjSxcJeX6go4uEcgyGTct/hmAMIrOA64HMzKE5
         4F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WLjHfl3orvIQYtFk8cWNm313KtEs9zxT+XRuqJ/3Ug=;
        b=WxVzEmS5XRooulLThigqNEm6YNL57BYsC5jCz4v+yCCRhUpbDOgK3w3cnx+jMrl+oH
         iAzHnpgdlYEe2Sh0oVE+D7dPc1q68NmDYiQNrQ7hDnzd4+g/50sC6WSqRuqLZ9KGaZt/
         HXr/wruZjDwzEwfT7TInKogmJQ6iIvLL5Ur/+B3+gNJFO8Gb8xCqg/bCwAFv3lTdGegZ
         Xq0WdXhKbKmxTEdiQzBZNh+H7XSu27Ra0CFt/xk24hdKBBGRy5kk5FAdW7+AfC6cakEd
         xFZxMl+iT9qJC/VUpAPHwwc+21c3l3UdGCrQMLDoKto8toMdntWaMlKERuZ42w2p6Ejy
         +3cg==
X-Gm-Message-State: AOAM532Q/RdYfhXkvMQjEgXL84DxQ09PgICi05SWpBUhbuvMdPksVsss
        YhfAJuWhSwdqBt8ja5X7oJ3BvA==
X-Google-Smtp-Source: ABdhPJxXaF3jZQ2mBJbDe3b1AG/65HW5oMGlPkeTd6SbS62ThvjaB4q1OUbAYzVP+iDACDMmHv8Kxw==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr999880wma.147.1605207703616;
        Thu, 12 Nov 2020 11:01:43 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Yao <mark.yao@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 25/30] drm/rockchip/rockchip_lvds: Fix struct document formatting
Date:   Thu, 12 Nov 2020 19:00:34 +0000
Message-Id: <20201112190039.2785914-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Must start with "struct <name>"

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/rockchip/rockchip_lvds.c:49: warning: cannot understand function prototype: 'struct rockchip_lvds_soc_data '

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mark Yao <mark.yao@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index f292c6a6e20fb..8658ef82d937b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -42,7 +42,7 @@ struct rockchip_lvds;
 		container_of(c, struct rockchip_lvds, encoder)
 
 /**
- * rockchip_lvds_soc_data - rockchip lvds Soc private data
+ * struct rockchip_lvds_soc_data - rockchip lvds Soc private data
  * @probe: LVDS platform probe function
  * @helper_funcs: LVDS connector helper functions
  */
-- 
2.25.1

