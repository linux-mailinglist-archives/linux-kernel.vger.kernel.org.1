Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35292C039E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgKWKqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgKWKqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:46:51 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:46:51 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so22623312ejm.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bf3Dad1zscNI33FoKwPu/py5sOPRwrYDQb8QYdxZRy4=;
        b=VyY/UaY2A1uZvQ9rve79LjJiOJL1CI3dvsrV3swg09sAABwIgosjjta5q8zhkrPoZZ
         5zImlhFEsF3ai58SF4irPNNvGoRzCyvQztYAx8s+zLmSXjGZPa4RtMzUBMMT0cLt23/C
         yHjZ1Yj8/hds3Ex7rjyXLJLmFMIi2ICX9C4t2uVm1Fse395iKjIwzbqEi+10ZfRgT6Iq
         sAq6GIQrrm5vWPAyO3ox79zmrxHRCEhXPNxlT816oaz9+2B3VFo0jHrGboJxWIB/PPoG
         7W+5YxoOUheRkD5Zysd3l0azMFn4ne6mj/iIiaJTmtMLK+ufVDO7sVGtP0KrUy8Hs0Lm
         QdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bf3Dad1zscNI33FoKwPu/py5sOPRwrYDQb8QYdxZRy4=;
        b=SKTCvOUi9rTxqJp+LW5fE0JEMvd1GEScJc7deXAqsFhcjxGUu7M/APdemV91MDfuJo
         BUz8T8hcot4TXycV6FSdba4WCwD0yuzkgfi51zoyTykybVaq9ukdBoTfX24Sy1RTLJaX
         KBR9VcisE/u9qMAo7GixlRqfVj6gMNFrZkBwO4z8QmhTJDX6yFxQu9pK0h47KAMvVgYy
         0oAGFw2j89IktENZ83NVW4IiDzEG6zN2h9uKA/aANxUvOWNPO/ksoOBZCdhEmxbAQeL+
         HkiL0stcrALLW4qknebTJUz29GAvvVI2X83AvHX4Ydy+jtDQ6BFJwJznfI82J1yszNi/
         wtYg==
X-Gm-Message-State: AOAM531LqN6G/FpUfmHyAZI5ORcGL2dXW0MpW/CJLY7TbWrfJ0Tgz2dp
        I05FJPmRr8ffhvDcdSHf0cPfZg==
X-Google-Smtp-Source: ABdhPJyMBnVAkcORAG/kSFMYC3vQyJU5E/KKGMO0DHSQoIjEO9c+wUaT0pEXyAB7B9n3QJvhfEnEuQ==
X-Received: by 2002:a17:906:468d:: with SMTP id a13mr45376085ejr.253.1606128409768;
        Mon, 23 Nov 2020 02:46:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:f25:a362:ce86:20d])
        by smtp.gmail.com with ESMTPSA id gf9sm4792416ejb.18.2020.11.23.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:46:49 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Peter Collingbourne <pcc@google.com>
Cc:     Alistair Delva <adelva@google.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1] drm/bridge: lt9611: Fix handling of 4k panels
Date:   Mon, 23 Nov 2020 11:46:16 +0100
Message-Id: <20201123104616.1412688-1-robert.foss@linaro.org>
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

