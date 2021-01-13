Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5B2F414A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbhAMBl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:41:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50808 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhAMBlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:41:55 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kzV9t-0002fz-9f
        for linux-kernel@vger.kernel.org; Wed, 13 Jan 2021 01:41:13 +0000
Received: by mail-pl1-f199.google.com with SMTP id p19so209806plr.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0qke6RiDqH8X2MkuYVX3XxIIT1dCpS1MvePoGipk34=;
        b=lme/30ebnb95MB2WocnXnXf1mM95hGUbiJHi6ni5RZ1WIwPTyC0XnyhObBcDeeox5z
         sEQSOcr/H7lW/0XFFAI4eiDaejiR67oVSzXabJc7rQpuzGgXemlj4MawKKUzuIPYsXUm
         Uzfd0+3KM9sd7vPk8LUdoY49uGfupr+9PabbJlwtvgnlVYTvhmR1LCoYjYeo8M9+2f3p
         RqhJfo+9nWMIVVwnvNfC4t+vSuanVu3Vo+ekMw32hDH/R3WJKgFc4Qmc0L8Q0hSYzgeJ
         dtHMhnIQ/Rp/3X8QHJOX0YCiEngdZQtzqgcdkJckHReXcPW2gr90b1oJAP0lhHDn4Sz1
         9A+A==
X-Gm-Message-State: AOAM532ZplvcC+Xr4IV9wcZ92UMvJtxignpC7zOZFkOxPv0Xqr+jHfry
        joQrepajxELs3zeFXHZcfGs9/CrxkFhPr72TLzNv4MlMdhE1bdDf6vEl3fbu9ninuVPXqEqEe6u
        QihLqkNc0mM2MFGGzOo/H+rfcRZfm1AvMU+ssQZtZRA==
X-Received: by 2002:a63:f512:: with SMTP id w18mr1958240pgh.154.1610502071779;
        Tue, 12 Jan 2021 17:41:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOeRDHDSY/QLh1+XtdjXRCHURPz0Q/OPScWD7mclZCGN6n6gxmvgz9mSVJ1i09OajxeS9LHw==
X-Received: by 2002:a63:f512:: with SMTP id w18mr1958217pgh.154.1610502071526;
        Tue, 12 Jan 2021 17:41:11 -0800 (PST)
Received: from canonical.com (36-229-237-19.dynamic-ip.hinet.net. [36.229.237.19])
        by smtp.gmail.com with ESMTPSA id x27sm394824pfr.122.2021.01.12.17.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 17:41:11 -0800 (PST)
From:   Koba Ko <koba.ko@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/dp_mst: Align mst link rate with soure rate
Date:   Wed, 13 Jan 2021 09:41:05 +0800
Message-Id: <20210113014105.28110-2-koba.ko@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113014105.28110-1-koba.ko@canonical.com>
References: <20210113014105.28110-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After read the link rate from MST hub, align with
maximum source rate.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c   | 8 ++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 7 +++++++
 include/drm/drm_dp_helper.h             | 8 ++++++++
 include/drm/drm_dp_mst_helper.h         | 4 ++++
 4 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 6982ecbf30b5..e7ceae97be85 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3672,6 +3672,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 {
 	int ret = 0;
 	struct drm_dp_mst_branch *mstb = NULL;
+	unsigned int max_link_rate_tbl[MAX_DRM_DP_MAX_RATE + 1] = {
+		DP_LINK_BW_1_62, DP_LINK_BW_2_7, DP_LINK_BW_5_4,
+		DP_LINK_BW_8_1, DP_LINK_RATE_TABLE
+	};
 
 	mutex_lock(&mgr->payload_lock);
 	mutex_lock(&mgr->lock);
@@ -3693,6 +3697,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 			goto out_unlock;
 		}
 
+		if (mgr->max_source_rate < MAX_DRM_DP_MAX_RATE)
+			mgr->dpcd[1] = max_link_rate_tbl[mgr->max_source_rate];
+
 		mgr->pbn_div = drm_dp_get_vc_payload_bw(mgr->dpcd[1],
 							mgr->dpcd[2] & DP_MAX_LANE_COUNT_MASK);
 		if (mgr->pbn_div == 0) {
@@ -5422,6 +5429,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	mgr->aux = aux;
 	mgr->max_dpcd_transaction_bytes = max_dpcd_transaction_bytes;
 	mgr->max_payloads = max_payloads;
+	mgr->max_source_rate = MAX_DRM_DP_MAX_RATE;
 	mgr->conn_base_id = conn_base_id;
 	if (max_payloads + 1 > sizeof(mgr->payload_mask) * 8 ||
 	    max_payloads + 1 > sizeof(mgr->vcpi_mask) * 8)
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 469e765a1b7b..a89b4c823123 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5392,6 +5392,13 @@ intel_dp_configure_mst(struct intel_dp *intel_dp)
 	intel_dp->is_mst = sink_can_mst &&
 		i915->params.enable_dp_mst;
 
+	if (intel_dp_source_supports_hbr3(intel_dp))
+		intel_dp->mst_mgr.max_source_rate = DRM_DP_MAX_RATE_HBR3;
+	else if (intel_dp_source_supports_hbr2(intel_dp))
+		intel_dp->mst_mgr.max_source_rate = DRM_DP_MAX_RATE_HBR2;
+	else
+		intel_dp->mst_mgr.max_source_rate = DRM_DP_MAX_RATE_HBR;
+
 	drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
 					intel_dp->is_mst);
 }
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 6236f212da61..ef2b328469cd 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -183,6 +183,14 @@ struct drm_device;
 #define DP_SUPPORTED_LINK_RATES		    0x010 /* eDP 1.4 */
 # define DP_MAX_SUPPORTED_RATES		     8	    /* 16-bit little-endian */
 
+enum drm_dp_max_link_rate {
+	DRM_DP_MAX_RATE_RBR = 0,
+	DRM_DP_MAX_RATE_HBR,
+	DRM_DP_MAX_RATE_HBR2,
+	DRM_DP_MAX_RATE_HBR3,
+	MAX_DRM_DP_MAX_RATE
+};
+
 /* Multiple stream transport */
 #define DP_FAUX_CAP			    0x020   /* 1.2 */
 # define DP_FAUX_CAP_1			    (1 << 0)
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index f5e92fe9151c..e7d8c899fea0 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -593,6 +593,10 @@ struct drm_dp_mst_topology_mgr {
 	 * @max_payloads: maximum number of payloads the GPU can generate.
 	 */
 	int max_payloads;
+	/**
+	 * @max_source_rate: maximum link rate of source.
+	 */
+	int max_source_rate;
 	/**
 	 * @conn_base_id: DRM connector ID this mgr is connected to. Only used
 	 * to build the MST connector path value.
-- 
2.25.1

