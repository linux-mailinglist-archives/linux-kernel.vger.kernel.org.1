Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796291A4C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 00:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJW6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 18:58:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52679 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJW6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:58:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jN2az-00083H-Mj; Fri, 10 Apr 2020 22:57:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Clements <john.clements@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: ensure device_list is initialised before calling list_add_tail
Date:   Fri, 10 Apr 2020 23:57:57 +0100
Message-Id: <20200410225757.97473-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the call to list_add_tail will access an the uninitalised
device_list.prev. Fix this by ensuring device_list is initialized before
adding items to it.

Addresses-Coverity: ("Uninitialized pointer read")
Fixes: b3dbd6d3ec49 ("drm/amdgpu: resolve mGPU RAS query instability")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b0aa4e1ed4df..caa4969bd46f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1447,6 +1447,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
 		device_list_handle = &hive->device_list;
 	} else {
+		INIT_LIST_HEAD(&device_list);
 		list_add_tail(&adev->gmc.xgmi.head, &device_list);
 		device_list_handle = &device_list;
 	}
-- 
2.25.1

