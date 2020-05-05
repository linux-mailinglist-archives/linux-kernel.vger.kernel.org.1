Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61281C4D82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 06:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEEE6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 00:58:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726610AbgEEE6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:58:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7DDD594BE2A050E65587;
        Tue,  5 May 2020 12:58:27 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 12:58:20 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH -next] drm/radeon: fix unsigned comparison with 0
Date:   Tue, 5 May 2020 12:57:37 +0800
Message-ID: <20200505045737.185143-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes warning because pipe is unsigned long and can never be negtative

vers/gpu/drm/radeon/radeon_kms.c:831:11: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (pipe < 0 || pipe >= rdev->num_crtc) {
drivers/gpu/drm/radeon/radeon_kms.c:857:11: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (pipe < 0 || pipe >= rdev->num_crtc) {

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 372962358a18..c5d1dc9618a4 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -828,7 +828,7 @@ int radeon_enable_vblank_kms(struct drm_crtc *crtc)
 	unsigned long irqflags;
 	int r;
 
-	if (pipe < 0 || pipe >= rdev->num_crtc) {
+	if (pipe >= rdev->num_crtc) {
 		DRM_ERROR("Invalid crtc %d\n", pipe);
 		return -EINVAL;
 	}
@@ -854,7 +854,7 @@ void radeon_disable_vblank_kms(struct drm_crtc *crtc)
 	struct radeon_device *rdev = dev->dev_private;
 	unsigned long irqflags;
 
-	if (pipe < 0 || pipe >= rdev->num_crtc) {
+	if (pipe >= rdev->num_crtc) {
 		DRM_ERROR("Invalid crtc %d\n", pipe);
 		return;
 	}
-- 
2.22.0

