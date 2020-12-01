Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250DE2CADE3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgLAU5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgLAU5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:57:11 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE5C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:56:31 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id bj5so1878415plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM5B4nr3Cj96c0CMfrS63GcaQxQ7JoKbUXWDaO/w/hc=;
        b=jUifm+7nuTwCtKljBq98E3+TtyCZjBN4r9vPGtA31KmOsul01hRCH97eUQXC8GwbH/
         C7i2rq9nkTRhgrCCtcZ3S8D+p6rmrYPGAkI8qxzpck3qL0M1i729OQVh44jnWLEebkeg
         yiaS6qnZVJTF8Mmd5RmWbKpwhyf/lYAdIGlDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM5B4nr3Cj96c0CMfrS63GcaQxQ7JoKbUXWDaO/w/hc=;
        b=IAbAwP9iNMmP0KoR1/sn/QtXjaEWNnHyG+EaxStxQzk55aN+A8uD5m3/0D4sUeT1t+
         Ie62f+rQotr9hiPOjvfrs81GNhqcnlW3v2TyouCUwlL1RJitE2ucBpUgKZg4Bb8GHibM
         HT1Q/FSGQLq9DGAY4i2T4M6NkCUwnXzGLb7M9SEY+IfiJU+Vt1JsseYYAI8lDrbHVklu
         TKZmWdki2BzQVBFmtFrMUP1qYzsI2GgYWk9e//Q2EIepDMhUUR7jhlaVEKg8WgPMfkoY
         trMyYrnxA20ljFJrAoDsnkbUtCYwj29dwE3Ha9WMjwDww0IX/lOKE2J7HDdqex5ne2Tj
         nojw==
X-Gm-Message-State: AOAM530EmzOunhamJmGtDWdooP24RTLeppRgTSXBLi+/DQlXD6DGFabq
        f/KfWQr7yorUeRk264SHqd83N3gajXC5ow==
X-Google-Smtp-Source: ABdhPJzfzvwqmVM12Vqk1uIjHAiXcS/yoSMaRMutHljDGn8QBGiS4fmDmcSk67ItGQUDkZMQd6Ntfg==
X-Received: by 2002:a17:902:8e81:b029:d9:f1a8:54ac with SMTP id bg1-20020a1709028e81b02900d9f1a854acmr4434841plb.69.1606856191096;
        Tue, 01 Dec 2020 12:56:31 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id l1sm534205pju.48.2020.12.01.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:56:30 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: panel: add flags to BOE NV110WTM-N61
Date:   Tue,  1 Dec 2020 12:56:11 -0800
Message-Id: <20201201125554.v2.1.I8a7bfc0966e803ab91001c9e6d01a736950c4981@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to add these when posting up the support for BOE
NV110WTM-N61.  Add them now.

Fixes: a96ee0f6b58d ("drm: panel: simple: Add BOE NV110WTM-N61")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
---

Changes in v2:
- Apply to the correct struct

 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 216cde33b5c4..1db4c10b4480 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1407,6 +1407,7 @@ static const struct drm_display_mode boe_nv110wtm_n61_modes[] = {
 		.vsync_start = 1440 + 3,
 		.vsync_end = 1440 + 3 + 6,
 		.vtotal = 1440 + 3 + 6 + 31,
+		.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
 	},
 	{
 		.clock = 138500,
@@ -1418,6 +1419,7 @@ static const struct drm_display_mode boe_nv110wtm_n61_modes[] = {
 		.vsync_start = 1440 + 3,
 		.vsync_end = 1440 + 3 + 6,
 		.vtotal = 1440 + 3 + 6 + 31,
+		.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
 	},
 };
 
-- 
2.29.2.454.gaff20da3a2-goog

