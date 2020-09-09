Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B33262FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgIIOVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 10:21:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729521AbgIINAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:00:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 24E8A3E76549727629C5;
        Wed,  9 Sep 2020 21:00:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:00:27 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 7/8] drm/amd/amdgpu: fix comparison pointer to bool warning in amdgpu_atpx_handler.c
Date:   Wed, 9 Sep 2020 21:07:19 +0800
Message-ID: <20200909130720.105234-8-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200909130720.105234-1-zhengbin13@huawei.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c:619:15-49: WARNING: Comparison to bool
drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c:629:15-49: WARNING: Comparison to bool

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 3e35a8f2c5e5..7abe9500c0c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -616,7 +616,7 @@ static bool amdgpu_atpx_detect(void)
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
 		vga_count++;

-		has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
+		has_atpx |= amdgpu_atpx_pci_probe_handle(pdev);

 		parent_pdev = pci_upstream_bridge(pdev);
 		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
@@ -626,7 +626,7 @@ static bool amdgpu_atpx_detect(void)
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
 		vga_count++;

-		has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
+		has_atpx |= amdgpu_atpx_pci_probe_handle(pdev);

 		parent_pdev = pci_upstream_bridge(pdev);
 		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
--
2.26.0.106.g9fadedd

