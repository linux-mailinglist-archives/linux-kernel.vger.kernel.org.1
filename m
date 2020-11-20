Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526842BB383
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgKTSfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbgKTSfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:35:12 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B13F42408E;
        Fri, 20 Nov 2020 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897311;
        bh=tEwej+XKmHYRxR3O5Sm9gb1DyV8ZJayMlHcS2y+l7Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UF/EAzXedkx+PTIdoilHt78qQQS+/iz1chvQCQBHVyTkF/dH3hxellXcFb1cZsN2/
         yUhdMN0FP7qQuS8yorUbhMrHvfLoUNZuVsjElgkmp3vzE0B3b/9JNPbmVr3fRxeLIU
         xVoZTPArh7Zv9nuzwS0V7H3O1lV9IJtRoectzTAE=
Date:   Fri, 20 Nov 2020 12:35:17 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 079/141] drm: Fix fall-through warnings for Clang
Message-ID: <111e9d3d55c686892357aa5269022024b4d48330.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/drm_bufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 7a01d0918861..aeb1327e3077 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -77,6 +77,7 @@ static struct drm_map_list *drm_find_matching_map(struct drm_device *dev,
 			if ((entry->map->offset & 0xffffffff) ==
 			    (map->offset & 0xffffffff))
 				return entry;
+			break;
 		default: /* Make gcc happy */
 			;
 		}
-- 
2.27.0

