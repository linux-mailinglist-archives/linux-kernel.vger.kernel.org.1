Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4566E274EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgIWCO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWCO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:14:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D84C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:14:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so6013784plt.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNa2dm3fhSu/kO1AHNUeoooQdDAxpXsqSbh5Zlmjvlg=;
        b=V3j39mj4oLrHFwOz+exT805RYUtYchcvjy/huA0mvzjSdjVSysR3QNM0Q+XuDQoJnq
         UfWpR5eKNpg+vGjIM0fjq72XKrc68lvBwoMBfOhi09jTTrT8Q9ncRQ/TVoope69vAB0f
         ry0C/RCJrz0c5RUyCrG82rMxmrbS0HGyBQpoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNa2dm3fhSu/kO1AHNUeoooQdDAxpXsqSbh5Zlmjvlg=;
        b=rwxdepBMUjSobm01jtBQus6zO82h7UjsxuObJLajSziAgD7kRuwYQtdyqGS3oW4A1T
         AlejF9CQuxsswvP8GZN8YS2PapexMFyyEnOuEU+A4/a9BK+E7elwQMkODmepU4xgWP/F
         hVmri8cxVRu7b4kIkvSV4lQq0Oav4QEQR5ItL6B4tqOj4Tgu8qDVpj2Ji8sabC2NTXRz
         AVVmWRdyl4SOvIqDEmh9p4/HUeuisVoxKTlmhgJW+xKweX9Fsb8qYht3C4/Ivm0VScfi
         Lhxk0cGaxTyWBLbRZFupH2JlsNBGzFAILOt56auuUuFOdrV+qBPJAJd5fT30o/FOovAz
         NYbw==
X-Gm-Message-State: AOAM5327uvyUda+R8svW/D6Lk2tYQJfc94ZCiQn5VbzZAof8pw2z+rJA
        6H7K9CVE6dIGvtrTo9c1MDib1s+ofMtq4Q==
X-Google-Smtp-Source: ABdhPJwPbdYRIScjSDYsvKXBL9n/d9LpGV5xZ6g3zyl6g0PiM7S/HMZTbcAdsJBN4n4mbtDDnwVOiw==
X-Received: by 2002:a17:902:8ecc:b029:d2:42b8:2c5d with SMTP id x12-20020a1709028eccb02900d242b82c5dmr5039857plo.69.1600827265256;
        Tue, 22 Sep 2020 19:14:25 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id n9sm16298737pfu.163.2020.09.22.19.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 19:14:24 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sam McNally <sammc@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/4] drm_dp_mst_topology: export two functions
Date:   Wed, 23 Sep 2020 12:13:54 +1000
Message-Id: <20200923121320.v3.3.I6c917ff82a1d2ae2253a3bd4d750d58879387cac@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

These are required for the CEC MST support.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Sam McNally <sammc@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/drm_dp_mst_topology.c | 6 ++----
 include/drm/drm_dp_mst_helper.h       | 4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 0d753201adbd..c783a2a1c114 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -62,8 +62,6 @@ struct drm_dp_pending_up_req {
 static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
 				  char *buf);
 
-static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
-
 static int drm_dp_dpcd_write_payload(struct drm_dp_mst_topology_mgr *mgr,
 				     int id,
 				     struct drm_dp_payload *payload);
@@ -1864,7 +1862,7 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
  * drm_dp_mst_topology_try_get_port()
  * drm_dp_mst_topology_get_port()
  */
-static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
+void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
 {
 	topology_ref_history_lock(port->mgr);
 
@@ -1935,7 +1933,7 @@ drm_dp_mst_topology_get_port_validated_locked(struct drm_dp_mst_branch *mstb,
 	return NULL;
 }
 
-static struct drm_dp_mst_port *
+struct drm_dp_mst_port *
 drm_dp_mst_topology_get_port_validated(struct drm_dp_mst_topology_mgr *mgr,
 				       struct drm_dp_mst_port *port)
 {
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index c7c79e0ced18..d036222e0d64 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -754,6 +754,10 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 		       struct drm_dp_mst_topology_mgr *mgr,
 		       struct drm_dp_mst_port *port);
 
+struct drm_dp_mst_port *drm_dp_mst_topology_get_port_validated
+(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
+void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
+
 struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
 
 
-- 
2.28.0.681.g6f77f65b4e-goog

