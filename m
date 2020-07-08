Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9A218211
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGHIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 04:16:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44413 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGHIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:16:46 -0400
Received: from [221.218.144.55] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1jt5Fw-0005Kj-QZ; Wed, 08 Jul 2020 08:16:42 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mapengyu@gmail.com, aaron.ma@canonical.com
Subject: [PATCH] drm/amd/display: add dmcub check on RENOIR
Date:   Wed,  8 Jul 2020 04:16:22 -0400
Message-Id: <20200708081622.3109902-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RENOIR loads dmub fw not dmcu, check dmcu only will prevent loading iram,
it breaks backlight control.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=208277
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 10ac8076d4f2..db5e0bb0d935 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1358,7 +1358,7 @@ static int dm_late_init(void *handle)
 	struct dmcu *dmcu = NULL;
 	bool ret;
 
-	if (!adev->dm.fw_dmcu)
+	if (!adev->dm.fw_dmcu && !adev->dm.dmub_fw)
 		return detect_mst_link_for_all_connectors(adev->ddev);
 
 	dmcu = adev->dm.dc->res_pool->dmcu;
-- 
2.25.1

