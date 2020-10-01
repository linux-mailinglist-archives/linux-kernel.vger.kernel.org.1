Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF42280831
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgJAUCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:02:08 -0400
Received: from services.gouders.net ([141.101.32.176]:53159 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:02:08 -0400
Received: from lena.gouders.net (ltea-047-066-024-155.pools.arcor-ip.net [47.66.24.155])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 091JtVtU012416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 1 Oct 2020 21:55:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1601582134; bh=Ctcg+UIz5/6JiLTMTFXfdVAgfet3Y/GfA39of6MSzr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WolxGcANP45H7W4siC/GpvpArvgd9LvcrFUQM0rFFYHKLTfC669JIG4M+muTbYj/n
         yrW/uwJKgJnxkRL0KlC3E/LpaHiMamj77W2BJA2iPpMbkYERvXfX2SOFmemEw0H+6C
         Sl2eY9NudUquDM1hU+JXYk+Zvvp8JVkEn82nkBz0=
From:   Dirk Gouders <dirk@gouders.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: fix NULL pointer dereference for Renoir
Date:   Thu,  1 Oct 2020 21:55:25 +0200
Message-Id: <20201001195525.3477-2-dirk@gouders.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
References: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
introduced a NULL pointer dereference when booting with
amdgpu.discovery=0, because it removed the call of vega10_reg_base_init()
for that case.

Fix this by calling that funcion if amdgpu_discovery == 0 in addition to
the case that amdgpu_discovery_reg_base_init() failed.

Fixes: c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
Signed-off-by: Dirk Gouders <dirk@gouders.net>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 84d811b6e48b..f8cb62b326d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -694,12 +694,12 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
 		 * it doesn't support SRIOV. */
 		if (amdgpu_discovery) {
 			r = amdgpu_discovery_reg_base_init(adev);
-			if (r) {
-				DRM_WARN("failed to init reg base from ip discovery table, "
-					 "fallback to legacy init method\n");
-				vega10_reg_base_init(adev);
-			}
+			if (r == 0)
+			  break;
+			DRM_WARN("failed to init reg base from ip discovery table, "
+				 "fallback to legacy init method\n");
 		}
+		vega10_reg_base_init(adev);
 		break;
 	case CHIP_VEGA20:
 		vega20_reg_base_init(adev);
-- 
2.26.2

