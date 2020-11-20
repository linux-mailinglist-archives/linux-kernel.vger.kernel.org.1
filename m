Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B258F2BB386
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgKTSf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbgKTSf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:35:28 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBCF024137;
        Fri, 20 Nov 2020 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897327;
        bh=6zzE83ypi+aUPwTs/JbDhQIzSKAqyu89X/MUiLx7vOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yrMFp0wm+7qNDbNp6rEUJzfdDk+x5RGdXr6vmCkOmGC0///IaAGXHkgtOO8fuoKpn
         HYoWPOBlW3iYwWur42Oze9Sh4tRVviIyto7mlxkqS1SDZ56jI8FSdp2ztoKo2pxXCQ
         8KHkgpWdRcTs0wlw7G3f0HsONF5bXCC660+8iRiE=
Date:   Fri, 20 Nov 2020 12:35:33 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 082/141] drm/nouveau: Fix fall-through warnings for Clang
Message-ID: <e62f940fbe1d212dfd7aa5157d048eb15d6553a5.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a couple of break statements instead
of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c        | 1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 56b335a55966..037f312c948d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -461,6 +461,7 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
 			break;
 		case TTM_PL_TT:
 			error |= !(domain & NOUVEAU_GEM_DOMAIN_GART);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 8b4b3688c7ae..585344965504 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -157,6 +157,7 @@ nouveau_conn_atomic_set_property(struct drm_connector *connector,
 			default:
 				break;
 			}
+			break;
 		case DRM_MODE_SCALE_FULLSCREEN:
 		case DRM_MODE_SCALE_CENTER:
 		case DRM_MODE_SCALE_ASPECT:
-- 
2.27.0

