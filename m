Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D42A3B24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKCDtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:49:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42568 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgKCDtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:49:13 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kZnJn-0002Sw-0h
        for linux-kernel@vger.kernel.org; Tue, 03 Nov 2020 03:49:11 +0000
Received: by mail-pl1-f200.google.com with SMTP id n10so9868685plk.14
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 19:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RliCu92b3IQig0c2jWKF3VuVRgf8DqyL8AZCCs07qII=;
        b=Xm0reo7AGvfYjJnavMFvn6y9zmK/uNijkeyJ8gOvLfVdHDAjvsSiEX2UCZrOFTcGVV
         qnUqkJFn/qMPJ+Dm60u9VgHsa4ppwG3WUB0tIUVl/SV1V/1oQGoekCGel42y27pkilFz
         C3PEadez14V4pHOXZIsgC2zbzDftRqLsx8SRWgnMo+9y5sR/sxyG6w1Ir1IlphjOAFqL
         zKOAB+Lcc9ZQ9OxOL1PSt14yMEuwidvlFesafttZP/dMfLLfjMnEGFK/g6OGEf/kUGkd
         pIxmf86njRfzSxWz69PTi0k3/ySQ9gsigZV7Oqi5lsydm65OhTGX9AGOSAZVENzPBAr6
         8WVA==
X-Gm-Message-State: AOAM531GFI2QqMB8b+Hl7W5MTxzg1d1C5YHq7D6eSja264GkpRt+DgRo
        KDUMtdECp87POoSZIudMe+VGTAtczX6BqGQ7/FXIHQQJ9ygHqfKIm7WEf67HFNdcNRx1HycFCo7
        nMpIBWbN7ZPXrbqnrLtnlsE/V1CwsSw19QkyhUrLLIA==
X-Received: by 2002:a17:90a:9dcb:: with SMTP id x11mr1573628pjv.132.1604375349510;
        Mon, 02 Nov 2020 19:49:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxMUJNCcKeQ5cbFEtLT37uvAni0nkfgOfDYBkeExp0+DP5RBRtEs3L8WFEYJXQpLDtt7bPZA==
X-Received: by 2002:a17:90a:9dcb:: with SMTP id x11mr1573609pjv.132.1604375349231;
        Mon, 02 Nov 2020 19:49:09 -0800 (PST)
Received: from canonical.com (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id jy19sm1072088pjb.9.2020.11.02.19.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 19:49:08 -0800 (PST)
From:   Koba Ko <koba.ko@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/dp_mst: Retrieve extended DPCD caps for topology manager"
Date:   Tue,  3 Nov 2020 11:49:07 +0800
Message-Id: <20201103034907.72129-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ad44c03208e46b83e4ae3269e32c9e524aa71cf8.

Currently DRM driver assume the source device caps is higher than the MST device
caps. With this commit, this statement would be broken.

e.g. the source device only support DP1.2 and the mst device support DP1.4.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 153b6065ba29..e87542533640 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3686,10 +3686,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		WARN_ON(mgr->mst_primary);
 
 		/* get dpcd info */
-		ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
-		if (ret < 0) {
-			drm_dbg_kms(mgr->dev, "%s: failed to read DPCD, ret %d\n",
-				    mgr->aux->name, ret);
+		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
+		if (ret != DP_RECEIVER_CAP_SIZE) {
+			DRM_DEBUG_KMS("failed to read DPCD\n");
 			goto out_unlock;
 		}
 
-- 
2.17.1

