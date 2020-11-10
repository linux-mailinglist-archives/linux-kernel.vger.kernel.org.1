Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06B02AD0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgKJIDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:03:30 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:21877 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKJIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:03:30 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 287A8667105;
        Tue, 10 Nov 2020 16:03:25 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>, hersen wu <hersenxs.wu@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] amd/display/amdgpu_dm: delete same check in if condition
Date:   Tue, 10 Nov 2020 00:03:13 -0800
Message-Id: <20201110080318.36305-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGENJSkJMSE9LGh5DVkpNS09CQk5PS05OS0tVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NE06Vgw*MD8tShEKDi0eEh8M
        IRAKCRZVSlVKTUtPQkJOT0tNS01JVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSUJNQjcG
X-HM-Tid: 0a75b12e56aa9373kuws287a8667105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function amdgpu_dm_connector_get_modes, drm_edid_is_valid
will check weather (!edid), no need to check again in the if
branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e93e18c06c0e..0a283d07fe10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6352,7 +6352,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 
 	encoder = amdgpu_dm_connector_to_encoder(connector);
 
-	if (!edid || !drm_edid_is_valid(edid)) {
+	if (!drm_edid_is_valid(edid)) {
 		amdgpu_dm_connector->num_modes =
 				drm_add_modes_noedid(connector, 640, 480);
 	} else {
-- 
2.29.0

