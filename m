Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994841B1B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 04:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDUCIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 22:08:06 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:63855 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgDUCIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:08:06 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id DF450664DB9;
        Tue, 21 Apr 2020 10:08:02 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bernard Zhao <bernard@vivo.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] amdgpu: fixes error branch not return errno issue
Date:   Mon, 20 Apr 2020 19:07:50 -0700
Message-Id: <1587434874-123252-1-git-send-email-bernard@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587202042-115745-1-git-send-email-bernard@vivo.com>
References: <1587202042-115745-1-git-send-email-bernard@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSlVOTE5CQkJCTE5JS09PTFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46MRw4EjgxGgMvA0IzLE5K
        TyEKCjdVSlVKTkNMT0hPQ0NITUpNVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBT05CSDcG
X-HM-Tid: 0a719a7e090d9373kuwsdf450664db9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "if(!encoder)" branch return the same value 0 of the success
branch, maybe return -EINVAL is more better.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

---
Changes since V1:
* commit message improve
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index f355d9a..1f8c6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -474,12 +474,12 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
 		if (!amdgpu_encoder->enc_priv)
-			return 0;
+			return -EINVAL;
 
 		dig = amdgpu_encoder->enc_priv;
 		new_coherent_mode = val ? true : false;
@@ -494,7 +494,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
@@ -509,7 +509,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
@@ -523,7 +523,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
@@ -537,7 +537,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
@@ -551,7 +551,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
-- 
2.7.4

