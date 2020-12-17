Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27C2DD29E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgLQOK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:10:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC8C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:09:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u19so28800283edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8d/TrR8rvr+bpGWFgQdRm4zLwdG7yWhGu84jcm2/M6g=;
        b=p/AItOzqqm4kqQMm0GgotlTXHPU2f50aB8mZ0r4vvT3PH9dE5ERqKtHkP/dZMwW9du
         Zoa5eVKoGJZKWD0W1XaeP6WI8mREKXn1pMkNa27jeqW/i4Lu4NjEqfIfOzxiemq4QQdu
         qP8xtB9RUiSRoHVTjlyi4M+xT3WoXb4By9kXGuDQ0W4ECrdVEs6/hKsZjCFoS241HeXx
         a8ZJdjfAszQV/EHrNP1cQD/NIkJYAAk/O2LeVUsBSa5/cZYfrQ5Zn2BICEIOABNuFiBl
         6wQrGsdq2KdQNdcLOk1tAMeQmKPjFz4MM/jqxQ4KV72gXNpQndfe0YwCDRgsBIQVvM+m
         vd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8d/TrR8rvr+bpGWFgQdRm4zLwdG7yWhGu84jcm2/M6g=;
        b=JMyDgqHPH7U+uqvxccjBFYMC1ToGwjDTLCDC74TUSyA1D2/Jrakwawi5LNl4mMsdqs
         t+BeQLamjFETNEA0659stiXjGRManD4qSi2dXd4c+JyNDwxkyGZxQxWuyc/anmzX1MJA
         XXY3LRgpFkV4ocaZkIfBI9cYF91hcPbCTDLlogh/JKZRURwb+jmTWwN9LUt2l4fBh6Y2
         CzDbyWHA0mr1ZJVrrfNfmV5xgwETSlk+8ohI4mc/1OoiKxtGuu66Hl1z/QVYJqae+akZ
         +LMv6nQZiFz1728COCHRU7sZce0+sSb3GXB4EuMFx1YRSH9LFVgk+WAPluHf40H1JoXf
         IN1A==
X-Gm-Message-State: AOAM533sNm4slgCgzFEFd5KIQZnU/1MVuyBy7D7YxvhwGtAEaMGL4L4z
        /KOZynV+yjmtUqbutcFClt7dXQ==
X-Google-Smtp-Source: ABdhPJwo9weeh2cNDezfXpAADFtKDt9giKVLlbwvcvNBuXhKuNyS7tXZpR72+bUa807SRZwtdHYDnw==
X-Received: by 2002:a05:6402:104e:: with SMTP id e14mr25376272edu.316.1608214186984;
        Thu, 17 Dec 2020 06:09:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:f0ff:2796:69b1:324])
        by smtp.gmail.com with ESMTPSA id pk19sm3864078ejb.32.2020.12.17.06.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:09:46 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2] drm/bridge: lt9611: Fix handling of 4k panels
Date:   Thu, 17 Dec 2020 15:09:33 +0100
Message-Id: <20201217140933.1133969-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4k requires two dsi pipes, so don't report MODE_OK when only a
single pipe is configured. But rather report MODE_PANEL to
signal that requirements of the panel are not being met.

Reported-by: Peter Collingbourne <pcc@google.com>
Suggested-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Anibal Limon <anibal.limon@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
Tested-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index d734d9402c35..e8eb8deb444b 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -867,8 +867,14 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
 						     const struct drm_display_mode *mode)
 {
 	struct lt9611_mode *lt9611_mode = lt9611_find_mode(mode);
+	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
 
-	return lt9611_mode ? MODE_OK : MODE_BAD;
+	if (!lt9611_mode)
+		return MODE_BAD;
+	else if (lt9611_mode->intfs > 1 && !lt9611->dsi1)
+		return MODE_PANEL;
+	else
+		return MODE_OK;
 }
 
 static void lt9611_bridge_pre_enable(struct drm_bridge *bridge)
-- 
2.27.0

