Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD62B4D20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbgKPReH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733039AbgKPReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:34:06 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD38C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:34:06 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so5175wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wySX8cNvv9NUCsmEXsR0JBc7XJM0MHUH49ItqBshbVE=;
        b=fyqsAvQsjtZPgnLlNYuAqgjvLAD2KEzD8fnpw7ksi4Au1TwwXYnRVrsBR/kFuKwr8T
         ay5r44BEiVO6rwJ7s46T5efTy1mn+/E3CdpPp4wq1sdrJ8SItiqm8ofCZVWmE1NUqlJM
         v46lkfvxWS2ekQ5Iua6EGzvtlGIopUbuL6qRgPHdhxTnXuQ8DJr2rqgLDJ2dFJpfcym/
         0J7ykIgHqeohEh1o0dXfzfgUCPb6i2O3o79f5Dake/7UTZhmgEjvFhyW70iMUjct1gm7
         4wn0jmAsn+wN8vfwj2vEvz+ulBbhMT6lQ2ErhB/VWJpnfR8iA5zwaBp4yz5udBx1ZgKS
         oxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wySX8cNvv9NUCsmEXsR0JBc7XJM0MHUH49ItqBshbVE=;
        b=WAZCQABTf/CwqOHiv0654sPBoXpedw3CcCDEpiN1CrHRkoeXsKpMahVKO6hWJM2kbc
         gbgzNhrTmvB2CUSfIPIeLjxPsV+zg7eX1oj24WXA86SuK6hrKamiyFszT/xfX1x1fd1I
         onYPxN16SjU/Mh9ybY/lX7ykgxkkpzk4bibPoTxcZHTURaB5uh+GmDcsHoOV6DahG85S
         n95xtnswP/aoKwDVFynmEUlFqCT51FmRLmnZ0PIuHd28YRqsUsUVxarQnm6whfvSxeXH
         eza1hoyBw/l9CMLWs+kgG4FtU2zKi/zd/jJSM6pAemGGp82SLd6w8x0pcnSwPiEU1Fps
         W6Ow==
X-Gm-Message-State: AOAM5315loSwvC3ctCvSzMRSvva6g8RiuQReG46IH3YiPOM0udjsMiQj
        BQuE3z2J0LGKGWXtDJDCnT4jeQ==
X-Google-Smtp-Source: ABdhPJwSX5AFzZorGf6TwH8mchOVYCT4UcKyoCG6+NQSYnaL2OmELGrklnOK+Vc4wmNeKr0PCqQOrA==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr15783540wmb.99.1605548044818;
        Mon, 16 Nov 2020 09:34:04 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k22sm20178562wmi.34.2020.11.16.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:34:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/42] drm/armada/armada_overlay: Staticify local function 'armada_overlay_duplicate_state'
Date:   Mon, 16 Nov 2020 17:33:16 +0000
Message-Id: <20201116173356.1828478-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173356.1828478-1-lee.jones@linaro.org>
References: <20201116173356.1828478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/armada/armada_overlay.c:329:1: warning: no previous prototype for ‘armada_overlay_duplicate_state’ [-Wmissing-prototypes]

Cc: Russell King <linux@armlinux.org.uk>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/armada/armada_overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index 30e01101f59ed..6346b890279a0 100644
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -325,7 +325,7 @@ static void armada_overlay_reset(struct drm_plane *plane)
 	}
 }
 
-struct drm_plane_state *
+static struct drm_plane_state *
 armada_overlay_duplicate_state(struct drm_plane *plane)
 {
 	struct armada_overlay_state *state;
-- 
2.25.1

