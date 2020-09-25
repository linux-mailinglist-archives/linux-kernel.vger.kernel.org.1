Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C357527944E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgIYWot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgIYWos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:44:48 -0400
Received: from agrajag.zerfleddert.de (agrajag.zerfleddert.de [IPv6:2a01:4f8:bc:1de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A68C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:44:48 -0700 (PDT)
Received: by agrajag.zerfleddert.de (Postfix, from userid 1000)
        id 249275B2098B; Sat, 26 Sep 2020 00:44:47 +0200 (CEST)
Date:   Sat, 26 Sep 2020 00:44:47 +0200
From:   Tobias Jordan <kernel@cdqe.de>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] drm: of: fix leak of endpoint
Message-ID: <20200925224447.GA27832@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The for_each_child_of_node loop in drm_of_lvds_get_remote_pixels_type
bails out in two occasions. Originally, both were calling of_node_put to
clean up, but (probably a typo) for the wrong variable.

One of these typos was fixed in commit 4ee48cc5586b ("drm: of: Fix
double-free bug"), but that missed the leak of the original endpoint
and also the first error path which was obviously wrong as well.

Fix the leak of endpoint in the error path by calling of_node_put on
it.

Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
Signed-off-by: Tobias Jordan <kernel@cdqe.de>
---
Sorry for the confusion, it seems it's not that easy to get the variable
name right. Please disregard the patch sent a few minutes ago, this is
the right one.

 drivers/gpu/drm/drm_of.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index ca04c34e8251..997b8827fed2 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -315,7 +315,7 @@ static int drm_of_lvds_get_remote_pixels_type(
 
 		remote_port = of_graph_get_remote_port(endpoint);
 		if (!remote_port) {
-			of_node_put(remote_port);
+			of_node_put(endpoint);
 			return -EPIPE;
 		}
 
@@ -331,8 +331,10 @@ static int drm_of_lvds_get_remote_pixels_type(
 		 * configurations by passing the endpoints explicitly to
 		 * drm_of_lvds_get_dual_link_pixel_order().
 		 */
-		if (!current_pt || pixels_type != current_pt)
+		if (!current_pt || pixels_type != current_pt) {
+			of_node_put(endpoint);
 			return -EINVAL;
+		}
 	}
 
 	return pixels_type;
-- 
2.20.1

