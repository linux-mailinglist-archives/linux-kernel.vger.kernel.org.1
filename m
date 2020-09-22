Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A59273B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgIVGxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:53:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57291 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbgIVGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:53:19 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kKcAv-0003zg-Ho
        for linux-kernel@vger.kernel.org; Tue, 22 Sep 2020 06:53:17 +0000
Received: by mail-pf1-f199.google.com with SMTP id k13so10548515pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w9iqaz4NmjNGwlYOvyMuR9M9SYy/rnYZVpOGW5l2Yx8=;
        b=b5cXLXZalNMTOQl61Qu/00+r8U8GC8Oc01YCOar4DTn5jKWzaeP7wE/oGxFYzsSWkE
         qxwSd6iGLS/xRbyyVKxjUtbtG7CnLOblm42x/Fo9a8U6xWqc1DrgbJ2bun9TERYjbeI9
         7nvpun6yhjiKx9sr1GoFv6tRBwn9u7oBj4zS2wBakmyjQT7jHA/ae5kJH3JfIxYa69by
         aVsEBgkCt0uRptfmA+1XOCw7I9UtckFNQQ2rriag1XDyimiEwBt6v0pcmLvu5Vh7DIU+
         MflFh/ufs/vrMgBaE9MsYsnEI6DuA5VFfPtin9fmO8N0Fjoj1Ll1BhQjCE8YyC3j2Bt2
         Yo0A==
X-Gm-Message-State: AOAM530xzueh39qvscN0DEWy7VpPrmGeTBGWLdE4bGvSZUQjULRgjc9d
        tvUB5rVTbyUQe/KEz7UgGfdO9WNppM60MZPGoLG+OLVH69ingJ/GJiP+UWtDdjNiFKsHcZVVAvK
        Ezf0Yls+DfR6xkL14HwY5bWF6cP5gvS0m/2eho/NVTA==
X-Received: by 2002:aa7:93a2:0:b029:142:2501:39f4 with SMTP id x2-20020aa793a20000b0290142250139f4mr2866563pff.67.1600757596151;
        Mon, 21 Sep 2020 23:53:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNg1FrNUOYNUMcUorUSwdMpymWxJcD36ivwwRqyApLFMfCl7hC/L7diiu9Fxoog4xeBBrkfw==
X-Received: by 2002:aa7:93a2:0:b029:142:2501:39f4 with SMTP id x2-20020aa793a20000b0290142250139f4mr2866542pff.67.1600757595700;
        Mon, 21 Sep 2020 23:53:15 -0700 (PDT)
Received: from canonical.com (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id y12sm7046142pga.53.2020.09.21.23.53.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 23:53:15 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     anthony.wong@canonical.com
Subject: [PATCH V4] drm/dp_mst: Retrieve extended DPCD caps for topology manager
Date:   Tue, 22 Sep 2020 14:53:13 +0800
Message-Id: <20200922065313.4794-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1,read the DP_DP13_DPCD_REV to
get the faster capability.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0,read DP_DPCD_REV.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index e87542533640..63f8809b9aa4 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3686,9 +3686,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		WARN_ON(mgr->mst_primary);
 
 		/* get dpcd info */
-		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
-		if (ret != DP_RECEIVER_CAP_SIZE) {
-			DRM_DEBUG_KMS("failed to read DPCD\n");
+		ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
+		if (ret < 0) {
+			drm_dbg_kms(mgr->dev, "failed to read DPCD, ret %d\n", ret);
 			goto out_unlock;
 		}
 
-- 
2.17.1

