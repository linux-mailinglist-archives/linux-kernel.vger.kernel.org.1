Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B7F27F31B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgI3URy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:17:54 -0400
Received: from services.gouders.net ([141.101.32.176]:36860 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3URx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:17:53 -0400
Received: from localhost (ltea-047-066-024-155.pools.arcor-ip.net [47.66.24.155])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 08UKDTXo012906
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 22:13:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1601496810; bh=nbpVWczMKXUHrhJcmLicD7YzKPBTHReBM4qXyPiYXcw=;
        h=From:To:Cc:Cc:Subject:Date;
        b=ucSkaD41prDSKeFK9qaYPUxF+lef3JueHF0Pl1PKO8aHsuafQwxGLCJX/Ao6d2EA2
         5fAQEyRpcmP/4LZPEfM6OVlA3PZoVzff6FJAfCeOOzQ2rPmeBe0ZC5DUfpo2HLafn5
         OHdW5j5RFOmWjHWfu8bx/BIrXjLp+MJm5hv0MHRI=
From:   Dirk Gouders <dirk@gouders.net>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     amd-gfx@lists.freedesktop.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: BUG: amdgpu: NULL pointer dereference introduced in 5.9-rc1
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 30 Sep 2020 22:13:23 +0200
Message-ID: <ghmu1758gs.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
introduced a NULL pointer dereference when booting with
amdgpu.discovery=0.

For amdgpu.discovery=0 that commit effectively removed the call of
vega10_reg_base_init(adev), so I tested the correctness of the bisect
session by restoring that function call for amdgpu_discovery == 0 and with
that change, the NULL pointer dereference does not occur:

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 84d811b6e48b..2e93c5e1e7e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -699,7 +699,8 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
                                         "fallback to legacy init method\n");
                                vega10_reg_base_init(adev);
                        }
-               }
+               } else
+                       vega10_reg_base_init(adev);
                break;
        case CHIP_VEGA20:
                vega20_reg_base_init(adev);

Dirk
