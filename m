Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3895F299840
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgJZUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:55:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8587 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgJZUzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:55:13 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9737b80000>; Mon, 26 Oct 2020 13:55:20 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 20:55:12 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 20:55:12 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2] nouveau: fix the start/end range for migration
Date:   Mon, 26 Oct 2020 13:54:58 -0700
Message-ID: <20201026205458.26215-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603745720; bh=OeU1mLcGHpoa7taY3czV717YOabXDAPB+mEOU5azouY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=b+mQ2kBNj0fOTpgXpBy/XibnA/NfHligzkXnCmRMK3AydRc7QSfNSGn/ZSLoGcDNm
         ZoHrncZDC4Xjb4onnPwrMSNsuzQLlNozg3odtfkYQcozqTyJtg6acgK55zPRkUkh2y
         qIJ/610vHqtSybNMhbv1aJLdBljFlF1eJ593+z8mZjskqL1hp/16NjklfrZ6Jn+cLw
         WLhAlpL/W1iAi97nQTMDHdQ0Fl1GEtIwykPdHn9y3AZNjJ6WtouiSYkyarksqTe+Ks
         KhJ+Jn1W0/KpknFCApst68XO9OqDYycqWmA+SrLCuqClifX/lNoiQQSAVxMbJfCBBu
         hnrrIvRHeL+wg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user level OpenCL code shouldn't have to align start and end
addresses to a page boundary. That is better handled in the nouveau
driver. The npages field is also redundant since it can be computed
from the start and end addresses.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

I thought I sent this out earlier but I don't see any record of that so
I'm resending it. It applies cleanly to linux-5.10.0-rc1.

This is for Ben Skegg's nouveau tree.

I have been working with Karol Herbst on the OpenCL mesa changes for
nouveau which will be merged upstream soon.
With or without those changes, the user visible effect of this patch
only extends the range by one page (round up vs. round down to page
boundary).

Changes in v2:
I changed the start/end check to require a size so start has to be less
than end.

 drivers/gpu/drm/nouveau/nouveau_svm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 2df1c0460559..4f69e4c3dafd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -105,11 +105,11 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 	struct nouveau_cli *cli =3D nouveau_cli(file_priv);
 	struct drm_nouveau_svm_bind *args =3D data;
 	unsigned target, cmd, priority;
-	unsigned long addr, end, size;
+	unsigned long addr, end;
 	struct mm_struct *mm;
=20
 	args->va_start &=3D PAGE_MASK;
-	args->va_end &=3D PAGE_MASK;
+	args->va_end =3D ALIGN(args->va_end, PAGE_SIZE);
=20
 	/* Sanity check arguments */
 	if (args->reserved0 || args->reserved1)
@@ -118,8 +118,6 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 		return -EINVAL;
 	if (args->va_start >=3D args->va_end)
 		return -EINVAL;
-	if (!args->npages)
-		return -EINVAL;
=20
 	cmd =3D args->header >> NOUVEAU_SVM_BIND_COMMAND_SHIFT;
 	cmd &=3D NOUVEAU_SVM_BIND_COMMAND_MASK;
@@ -151,12 +149,6 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 	if (args->stride)
 		return -EINVAL;
=20
-	size =3D ((unsigned long)args->npages) << PAGE_SHIFT;
-	if ((args->va_start + size) <=3D args->va_start)
-		return -EINVAL;
-	if ((args->va_start + size) > args->va_end)
-		return -EINVAL;
-
 	/*
 	 * Ok we are ask to do something sane, for now we only support migrate
 	 * commands but we will add things like memory policy (what to do on
@@ -171,7 +163,7 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
=20
-	for (addr =3D args->va_start, end =3D args->va_start + size; addr < end;)=
 {
+	for (addr =3D args->va_start, end =3D args->va_end; addr < end;) {
 		struct vm_area_struct *vma;
 		unsigned long next;
=20
--=20
2.20.1

