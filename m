Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EFF2A8192
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbgKEOxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731464AbgKEOw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:29 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E6FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so2077397wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msUJv3g77jRfXUZFInWbo08oOqamqaMF7n9SOzCcjkY=;
        b=r7IG/ZJuEPCMH4rRLkfuGlHBB4SlDlKJBOj/G97StXC4XJk2dMx6attzaVaNp5vWCQ
         LlVdWwEyqS22BVqDUXVugsP5iYpT/Lm/IvVDSZ2s/WC+RtTgnoEgW7RJE5Sw38gcm7b1
         B/B8xAIuwPcq6sm8QPMvbH1l5jBPls4ndV/ntH7W1GVpUxzoEkl3JS9gbUSEWuVbRAia
         Ai6PwdULfSyuWv5lcXDpVwRbj7Y8MJwknqHx0g29KlYuZ80PFKciu3XjdnWh2TIG7ght
         w0H8Hz3ptmwLg95uJLIp9jEDf7/+ciI3fBsYFv2WHqn+5UiNFGfBSCFr9PowwJshpQhl
         79ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msUJv3g77jRfXUZFInWbo08oOqamqaMF7n9SOzCcjkY=;
        b=HQ8W0Z4ZpQkjJiI6+XreRinLRbMELAEtDgq8L4d6v0e6fWvIg8sQNd56l2K0WqeaYd
         ycVMTpZVkC2G7c7zZdsfhRJ3PRFGSemXUik6SWOsdLQwLGVuKid79IjE50nQKN84yxYa
         xiZYMIFjVhENJqpn2I+Wf211ciJctlilo0ydOx4sxIFeY4JB57uwLvoewgYk3WCU+9iv
         4F0HjOvxYMyH6MIPa5w1mjBDh04ZbzkqG/H22N6NO0WBmkY/yQLVCOq9FRjSemYfP4NZ
         I6O+BqNPtYRG2jZeZ+D8pzEH1HQQlAiG8K34jw2hPvkgAm84rCxb1KBUzJkw95JSFD/z
         IUrw==
X-Gm-Message-State: AOAM530J0Pa6AlZV1ryVvKTlybGmj7B1GWDrIhbIi7/y9t0FHmTmTvNy
        Cb+ruGxMOV9nky4gTDahN+UV7Q==
X-Google-Smtp-Source: ABdhPJwOCFph5hs/qG6yS2bZ9ZwIw/eSKDawsUf80Zrt7pTiS+RF1hawBHfFt7P9n2O5VPET+RJlAw==
X-Received: by 2002:adf:e682:: with SMTP id r2mr3425322wrm.184.1604587948243;
        Thu, 05 Nov 2020 06:52:28 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/19] gpu: drm: panel: panel-simple: Fix 'struct panel_desc's header
Date:   Thu,  5 Nov 2020 14:45:09 +0000
Message-Id: <20201105144517.1826692-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct headers should start with 'struct <name>'

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/panel/panel-simple.c:42: warning: Cannot understand  * @modes: Pointer to array of fixed modes appropriate for this panel.  If

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8b82ec33f08ae..1327df0bddbd6 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -39,6 +39,7 @@
 #include <drm/drm_panel.h>
 
 /**
+ * struct panel_desc
  * @modes: Pointer to array of fixed modes appropriate for this panel.  If
  *         only one mode then this can just be the address of this the mode.
  *         NOTE: cannot be used with "timings" and also if this is specified
@@ -53,6 +54,7 @@
  * @delay: Structure containing various delay values for this panel.
  * @bus_format: See MEDIA_BUS_FMT_... defines.
  * @bus_flags: See DRM_BUS_FLAG_... defines.
+ * @connector_type: LVDS, eDP, DSI, DPI, etc.
  */
 struct panel_desc {
 	const struct drm_display_mode *modes;
-- 
2.25.1

