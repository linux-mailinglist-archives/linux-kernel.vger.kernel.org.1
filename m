Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D781D2B4216
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgKPLDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:03:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33670 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgKPLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:03:31 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kecI0-0006oY-Jv; Mon, 16 Nov 2020 11:03:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/atomic: avoid null pointer dereference on pointer crtc
Date:   Mon, 16 Nov 2020 11:03:16 +0000
Message-Id: <20201116110316.269934-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Since moving to the new debug helper functions we now have a debug message
that dereferences crtc to print a kernel debug message when crtc is null
and so this debug message will now cause a null pointer dereference. Since
this is a debug message it probably is just simplest to fix this by just
removing the debug message altogether.

Addresses-Coverity: ("Dereference after null check")
Fixes: e3aae683e861 ("drm: convert drm_atomic_uapi.c to new debug helpers")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 9df7f2a170e3..3fd84590560a 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -338,11 +338,6 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 			       "Link [CONNECTOR:%d:%s] state %p to [CRTC:%d:%s]\n",
 			       connector->base.id, connector->name,
 			       conn_state, crtc->base.id, crtc->name);
-	} else {
-		drm_dbg_atomic(crtc->dev,
-			       "Link [CONNECTOR:%d:%s] state %p to [NOCRTC]\n",
-			       connector->base.id, connector->name,
-			       conn_state);
 	}
 
 	return 0;
-- 
2.28.0

