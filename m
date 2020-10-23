Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970A42974B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbgJWQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465725AbgJWQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:48 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D7662465A;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=jPkos43ebBchJ0cJAuho9ta3O5oQ0vR/j86QNsaEpvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmlwZ8gQUQhG9g0twS3MdeT1RjxduPdyQxQF8NtpS9JB1drggSsfT7/b4ddbSbyB6
         hU2BZOza5z4bl1EhsYoDbwgzcWPnwMuH5/rUdMTa3XLocx6lykW6uh3hLDP2VkPkZs
         SK1vvV4LbGfTMH6QACI9gyNk6y+q/vxQIQ+agLG0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002AvQ-My; Fri, 23 Oct 2020 18:33:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eryk Brol <eryk.brol@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>, Stylon Wang <stylon.wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hersen wu <hersenxs.wu@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/56] drm: amdgpu_dm: fix a typo
Date:   Fri, 23 Oct 2020 18:32:49 +0200
Message-Id: <31341a0175f0aa4ec160d10b27a91703bdd9a036.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	dm_comressor_info -> dm_compressor_info

The kernel-doc markup is right, but the struct itself
and their references contain a typo.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bb1bc7f5d149..48ec0535d92f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -583,7 +583,7 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct dm_comressor_info *compressor = &adev->dm.compressor;
+	struct dm_compressor_info *compressor = &adev->dm.compressor;
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
 	struct drm_display_mode *mode;
 	unsigned long max_size = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 34f6369bf51f..a8a0e8cb1a11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -86,7 +86,7 @@ struct irq_list_head {
  * @bo_ptr: Pointer to the buffer object
  * @gpu_addr: MMIO gpu addr
  */
-struct dm_comressor_info {
+struct dm_compressor_info {
 	void *cpu_addr;
 	struct amdgpu_bo *bo_ptr;
 	uint64_t gpu_addr;
@@ -148,7 +148,7 @@ struct amdgpu_dm_backlight_caps {
  * @soc_bounding_box: SOC bounding box values provided by gpu_info FW
  * @cached_state: Caches device atomic state for suspend/resume
  * @cached_dc_state: Cached state of content streams
- * @compressor: Frame buffer compression buffer. See &struct dm_comressor_info
+ * @compressor: Frame buffer compression buffer. See &struct dm_compressor_info
  * @force_timing_sync: set via debugfs. When set, indicates that all connected
  *		       displays will be forced to synchronize.
  */
@@ -324,7 +324,7 @@ struct amdgpu_display_manager {
 	struct drm_atomic_state *cached_state;
 	struct dc_state *cached_dc_state;
 
-	struct dm_comressor_info compressor;
+	struct dm_compressor_info compressor;
 
 	const struct firmware *fw_dmcu;
 	uint32_t dmcu_fw_version;
-- 
2.26.2

