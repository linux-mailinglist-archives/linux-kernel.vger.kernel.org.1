Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F1E2F4149
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbhAMBlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:41:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhAMBlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:41:52 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kzV9q-0002fM-Ft
        for linux-kernel@vger.kernel.org; Wed, 13 Jan 2021 01:41:10 +0000
Received: by mail-pl1-f200.google.com with SMTP id w19so228133pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzdOF8J+GZRgyyD73mbL6B1kdprEKDDRyev/uww/1pM=;
        b=ug2SoC3cYvhQeMDeUBEE8XsmvWpmp5c65H0zK42kc7ozkGib4FHZRiASHOAvz9CQoC
         peYUY/gDbRC37dMyPzpj7OmR7MKMiKbbcvoyC+O3+keoHU/WfnQ06OcbnEUMWYMfW6gz
         5B2/kiRK6AHDoEWc6t2KgNQdKHuPpnqZVzEYZlhEPPTEy+olFkLOlHX5jCvprkI/BLeP
         nceBfnWkswQOFfPhm3t2lvZe62LuQlxBXiDE4KQzSn9OQXpUpuLCOQkDPA45AOXpI1a4
         RJCaeWIbiiuZSxlytWU1JKtQnuLwhcViDB0ypS+LBqlXvxdu5XSjgBiIewJxMKllyX8P
         smmQ==
X-Gm-Message-State: AOAM531/quUXDzs9q1DuFFp+FOx672ICBIJ0lNMPj1K9C7wPz+cKtts7
        3+2GFtg/n92g9Oe06ayZteyfNq2vuZjYS+tV1+8S+vGnfl41pfkeFJGbxUiko1vihCFlYQpwIUS
        tQAcIRxxetdm6CoMmCXk1FtVIPOrb7v/pcXmPUzbiJQ==
X-Received: by 2002:aa7:9782:0:b029:19e:b084:f0a9 with SMTP id o2-20020aa797820000b029019eb084f0a9mr18582pfp.28.1610502068905;
        Tue, 12 Jan 2021 17:41:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7piFkV3OCXWidUjdkxc1oP640g6yICBb7f9TEClAaEm7gncz9ccnwqqyMKqt/HWSmzMJvWw==
X-Received: by 2002:aa7:9782:0:b029:19e:b084:f0a9 with SMTP id o2-20020aa797820000b029019eb084f0a9mr18549pfp.28.1610502068269;
        Tue, 12 Jan 2021 17:41:08 -0800 (PST)
Received: from canonical.com (36-229-237-19.dynamic-ip.hinet.net. [36.229.237.19])
        by smtp.gmail.com with ESMTPSA id l7sm323837pjy.29.2021.01.12.17.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 17:41:07 -0800 (PST)
From:   Koba Ko <koba.ko@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/dp_mst: Retrieve extended DPCD caps for topology manager
Date:   Wed, 13 Jan 2021 09:41:04 +0800
Message-Id: <20210113014105.28110-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1,read the DP_DP13_DPCD_REV to
get the faster capability.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0,read DP_DPCD_REV.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
[added aux name to drm_dbg_kms() call]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200922065313.4794-1-koba.ko@canonical.com
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 0401b2f47500..6982ecbf30b5 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3686,9 +3686,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		WARN_ON(mgr->mst_primary);
 
 		/* get dpcd info */
-		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
-		if (ret != DP_RECEIVER_CAP_SIZE) {
-			DRM_DEBUG_KMS("failed to read DPCD\n");
+		ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
+		if (ret < 0) {
+			drm_dbg_kms(mgr->dev, "%s: failed to read DPCD, ret %d\n",
+				    mgr->aux->name, ret);
 			goto out_unlock;
 		}
 
-- 
2.25.1

