Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71729A85A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896114AbgJ0Jvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896035AbgJ0Jvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:43 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B7BD2242B;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=64A7EVfDlXLbjve/Xc7YXb+7i96EZIpaeNvqEPZFM6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugc5YPlRgxzutZ+xamDxawGWBYXMPKcu8mZd4C4ze7MyhqprJVYGGQnj2IMTE1S9z
         M6kVNrRlAhLQUVZupcEbMiAH9WY3uYZJdLxs1/LgaWQoi61y8nWiqGxaYJ6yZuOwyO
         JzfsF2zF5l3zo5bT+R0uD5mJsxeWKFrXImGgyumw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FEv-A6; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/32] drm/dp: fix a kernel-doc issue at drm_edid.c
Date:   Tue, 27 Oct 2020 10:51:16 +0100
Message-Id: <7f4d6c3ff6df63ebd006eb90a5108006c23e2168.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the argument is different, causing those warnings:

	./drivers/gpu/drm/drm_edid.c:3754: warning: Function parameter or member 'video_code' not described in 'drm_display_mode_from_cea_vic'
	./drivers/gpu/drm/drm_edid.c:3754: warning: Excess function parameter 'vic' description in 'drm_display_mode_from_cea_vic'

Fixes: 7af655bce275 ("drm/dp: Add drm_dp_downstream_mode()")
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index a82f37d44258..631125b46e04 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3741,7 +3741,7 @@ drm_add_cmdb_modes(struct drm_connector *connector, u8 svd)
 /**
  * drm_display_mode_from_cea_vic() - return a mode for CEA VIC
  * @dev: DRM device
- * @vic: CEA VIC of the mode
+ * @video_code: CEA VIC of the mode
  *
  * Creates a new mode matching the specified CEA VIC.
  *
-- 
2.26.2

