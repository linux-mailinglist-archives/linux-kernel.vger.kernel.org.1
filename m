Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0822356A3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgHBLQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 07:16:31 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44822 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728132AbgHBLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:15:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U4T30DO_1596366936;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4T30DO_1596366936)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:37 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
        stylon.wang@amd.com, roman.li@amd.com, mikita.lipski@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
Subject: [PATCH] drm/amd/display: Fix wrong return value in dm_update_plane_state()
Date:   Sun,  2 Aug 2020 19:15:36 +0800
Message-Id: <20200802111536.5246-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an error exit path, a negative error code should be returned
instead of a positive return value.

Fixes: 9e869063b0021 ("drm/amd/display: Move iteration out of dm_update_planes")
Cc: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 710edc70e37e..5810416e2ddc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8182,8 +8182,7 @@ static int dm_update_plane_state(struct dc *dc,
 				dm_old_plane_state->dc_state,
 				dm_state->context)) {
 
-			ret = EINVAL;
-			return ret;
+			return -EINVAL;
 		}
 
 
-- 
2.26.2

