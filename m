Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828482C94AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbgLABaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:30:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14712 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLABaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:30:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc59c830000>; Mon, 30 Nov 2020 17:29:39 -0800
Received: from localhost (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 01:29:38 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <nouveau@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, <bskeggs@redhat.com>,
        <rcampbell@nvidia.com>, <dri-devel@lists.freedesktop.org>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] drm/nouveau/svm: Only map migrating pages
Date:   Tue, 1 Dec 2020 12:29:36 +1100
Message-ID: <20201201012936.9046-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606786179; bh=U2FLmjEm94rPLnGodJhcYwZBdpdbhTX9UL1a65sI3bI=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=FhgNlKphVf9oOOynU0gD9eLLDsorI+EotpUqSf8jOBf+GNKe/PnzOUBfizzEXTZ6I
         Nk2lDdBcBE7zxrOZjniP9rtuTSUCFME1er5nTEM75pUcTtcTQ3QLnqhLm2q+nsdqXN
         kF3WgO2Lohicz68fGDinflQYxSGiXwk56VWviw1uhu0Xhkmb3WKpFyyLBD/aJqBeKz
         ABVnrPp+jkKOOTGRzo36dPdcqFVHkGM5kOCbANft6wiXJiurj5C6YQ0VBGC5S5t4M1
         VHKDQEHYji1fG2224bbE6e5isZWjW4gxqO97RAZ9rGUmjL7AsUVv3P5l6Whqtf02V+
         OyIp/3rhTN6Uw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only pages which were actually migrated should be mapped on the GPU.
migrate_vma_pages() clears MIGRATE_PFN_MIGRATE in the src_pfn array, so
test this prior to mapping the pages on the GPU. If any pages failed to
migrate don't install any mappings - the GPU will demand fault any as
required.

Fixes: e3d8b0890469 ("drm/nouveau/svm: map pages after migration")
Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index 92987daa5e17..a2169644f114 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -618,8 +618,9 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_d=
rm *drm,
 		dma_addr_t *dma_addrs, u64 *pfns)
 {
 	struct nouveau_fence *fence;
-	unsigned long addr =3D args->start, nr_dma =3D 0, i;
+	unsigned long addr =3D args->start, nr_dma =3D 0, i, npages;
=20
+	npages =3D (args->end - args->start) >> PAGE_SHIFT;
 	for (i =3D 0; addr < args->end; i++) {
 		args->dst[i] =3D nouveau_dmem_migrate_copy_one(drm, svmm,
 				args->src[i], dma_addrs + nr_dma, pfns + i);
@@ -631,7 +632,16 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_=
drm *drm,
 	nouveau_fence_new(drm->dmem->migrate.chan, false, &fence);
 	migrate_vma_pages(args);
 	nouveau_dmem_fence_done(&fence);
-	nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i);
+
+	for (i =3D 0; i < npages; i++)
+		if (!(args->src[i] & MIGRATE_PFN_MIGRATE))
+			break;
+
+	/* If all pages were migrated successfully map them on the GPU. If any
+	 * failed just let the GPU fault to create the mapping.
+	 */
+	if (i =3D=3D npages)
+		nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, npages);
=20
 	while (nr_dma--) {
 		dma_unmap_page(drm->dev->dev, dma_addrs[nr_dma], PAGE_SIZE,
--=20
2.20.1

