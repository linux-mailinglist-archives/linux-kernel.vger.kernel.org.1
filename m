Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60F2B4E14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbgKPRl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387771AbgKPRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:53 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAB3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:53 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so45419wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+170YZVUptUVP8b8DCIuLCBL2J9gnyH4hHHhpysSOuQ=;
        b=rJZgv0r3y1uaooYzLQ77T067OtNBcziJ1kMk4hccmXIIg+vWYcZOw6hRxBvEbvrc0e
         54BY9C/GyH3afuOmhUyh6oT2QBbXnogaeE9MwZ8W5t2+aGcJ3fqzTwm9tMeqqBDsagX9
         9IkPccddWCzGVUmqxsrk1Dhwh1XIH8iyVoIKyOqo0YydsxRfN8zwh930DQ8CFItkCyld
         8XlOZ70+ZtnSKmSDmqzspsXieifAqjySJVAavAWNnzUcekoawVH3eL0zRZC+k2YBSfqQ
         gUpEssUZXiRRFwtseSyNvOhXWtr/4Qbonpf5kRYeA35GUHQD3fpKSDAovTkR3QY/Vhag
         HIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+170YZVUptUVP8b8DCIuLCBL2J9gnyH4hHHhpysSOuQ=;
        b=fvaE/L5qtOZR5w0+huZwCCQz8wioevyAyUcyKD6OgrmLJ+JK4FpaifqmUF3OQWAOoz
         o3CN9KpXRLBLRRfNTyy7Cu7Mc54645VbcS2qJqGAKoUIENS6j/wPkisFrrssZzd28KM1
         PHe+t0wnKlFJ6/12S5OPQmGd1VD3YagD8ayvNveNzfjaPg0BdlCJjJ9mXFP8lH48LsNg
         S1rlCv/NLsMJmXE9Ukf/u0zI0o89TZoNP/TFIMhitxV04yZ6Sp7ZUXXi1R9gNdsWoxgp
         hrnexfKmomOTnmS3nOaFu8bjkpfSesrO7ZGnXykLL53XNpeoShkv924O+rAT/ZQjwdDv
         sCIw==
X-Gm-Message-State: AOAM532j1LeaNwkfx4sZ6r+4KfO+BZ15/EdAix+IK/4GTygkLqzqZnGb
        uDJq5LSL8fC2K8xYVHdeiKhMSw==
X-Google-Smtp-Source: ABdhPJzrdNHfcckGPvTVYiKyOTyfZ8lac3YqV+u13joqzDyl9nbQ+6pDIovDVylNGHeenJsooQOrxA==
X-Received: by 2002:a1c:6704:: with SMTP id b4mr28166wmc.96.1605548512097;
        Mon, 16 Nov 2020 09:41:52 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 22/42] drm/pl111/pl111_display: Make local function static
Date:   Mon, 16 Nov 2020 17:40:52 +0000
Message-Id: <20201116174112.1833368-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/pl111/pl111_display.c:356:6: warning: no previous prototype for ‘pl111_display_disable’ [-Wmissing-prototypes]

Cc: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index b3e8697cafcf1..69c02e7c82b7e 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -353,7 +353,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		drm_crtc_vblank_on(crtc);
 }
 
-void pl111_display_disable(struct drm_simple_display_pipe *pipe)
+static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
-- 
2.25.1

