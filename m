Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE43011FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbhAWBY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:24:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11852 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbhAWBYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:24:54 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DMz041rlnz7W7l;
        Sat, 23 Jan 2021 09:23:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 09:23:59 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] =?UTF-8?q?drm/nouveau:=20remove=20set=20but=20not=20used?= =?UTF-8?q?=20variable=20=E2=80=98pdev=E2=80=99=20in=20nouveau=5Fbios=5Fin?= =?UTF-8?q?it?=
Date:   Sat, 23 Jan 2021 09:30:14 +0800
Message-ID: <20210123013014.3815870-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix follow warning:
drivers/gpu/drm/nouveau/nouveau_bios.c:2086:18: warning: variable ‘pdev’ set but not used [-Wunused-but-set-variable]
  struct pci_dev *pdev;
                  ^~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_bios.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index 7cc683b8dc7a..e8c445eb1100 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -2083,13 +2083,11 @@ nouveau_bios_init(struct drm_device *dev)
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvbios *bios = &drm->vbios;
-	struct pci_dev *pdev;
 	int ret;
 
 	/* only relevant for PCI devices */
 	if (!dev_is_pci(dev->dev))
 		return 0;
-	pdev = to_pci_dev(dev->dev);
 
 	if (!NVInitVBIOS(dev))
 		return -ENODEV;
-- 
2.25.4

