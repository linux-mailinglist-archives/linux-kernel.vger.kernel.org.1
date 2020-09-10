Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008A6263D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 08:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgIJGgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 02:36:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48640 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgIJGgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:36:47 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kGGCK-0006uX-IZ
        for linux-kernel@vger.kernel.org; Thu, 10 Sep 2020 06:36:44 +0000
Received: by mail-pj1-f72.google.com with SMTP id ic18so3082279pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jn9Jem5r6BEp8pI1f0WJBxWG1XIwYaN+OR+bwtjFIhI=;
        b=YmDCvhAbekeOmwTgaHLoztdTMRSphxhrsDyvVeTZfXIrCRFsX2A5sPbdqyXlkc9XK1
         B82XgGwrhX1s3KCUu69FMpd5GYVUNq7n26N4QKZoNA00bzQdTX9MD3Wkczz5qUlff4UV
         MMTLbDecn4ntZWjeOp9n9CXVpE87Qpj+LAygJC1rqCVaJkmelGB/mPU4uKI0eiGmEWsK
         z+KQS6u1+U33WF2a6oialLe5txxxTjPGmf5WYmorpBKxTRTY1Q37D6WlXm33m8upRQ8e
         8VdW+DlhmzpVIrsDGQFCFnTBZwmFSAF1mNLGO2yDIQy9fUQmCQuu2QUQMU1F4/453F75
         HQRg==
X-Gm-Message-State: AOAM530jzs0GJeq3vhpl2mOA2X8lw/P3ngweBzhDJAndJ6RO558zhRwQ
        retMjBUzHDOHGv25LZIrxLUQgZC+kdHIRTGDvpI+c1oDyuel2swj+eEL1EItsV4bjco7Sok3HSM
        IVTKBp6Xt67csatt5DRP2l46kD6gb6N57MUHpEek5Fw==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr4222703plr.24.1599719802979;
        Wed, 09 Sep 2020 23:36:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVXJSJqtSyUbzWKlYyhW0mTxoi/ulhvQkfQjVkVkwZkuKcTn71S+DXLIeEl1YwVQyIguNXgw==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr4222673plr.24.1599719802575;
        Wed, 09 Sep 2020 23:36:42 -0700 (PDT)
Received: from canonical.com (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id j9sm4529045pfe.170.2020.09.09.23.36.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 23:36:42 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     anthony.wong@canonical.com
Subject: [PATCH] V2: Currently, DRM get the capability of the mst hub only from DP_DPCD_REV and get the slower speed even the mst hub can run in the faster speed.
Date:   Thu, 10 Sep 2020 14:36:40 +0800
Message-Id: <20200910063640.21519-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the DP_DP13_DPCD_REV to
get the faster capability.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
ChangeLog:
1. use drm_dp_read_dpcd_caps instead.
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 7753c718ddf9..293f71d0ae90 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3694,8 +3694,8 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 			((dpcd_ext & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT) ?  DP_DP13_DPCD_REV : DP_DPCD_REV);
 
 		/* get dpcd info */
-		ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
-		if (ret != DP_RECEIVER_CAP_SIZE) {
+		ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
+		if (ret < 0) {
 			DRM_DEBUG_KMS("failed to read DPCD\n");
 			goto out_unlock;
 		}
-- 
2.25.1

