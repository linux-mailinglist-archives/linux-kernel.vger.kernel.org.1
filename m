Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487325DB18
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgIDONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 10:13:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44846 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbgIDNpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:45:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200904133511euoutp018a78ee150055106be05fbf79d1cc75bd~xmAn1ywyL0722107221euoutp011
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:35:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200904133511euoutp018a78ee150055106be05fbf79d1cc75bd~xmAn1ywyL0722107221euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599226511;
        bh=xw6Uqswd7WHaRkaUiL5EjLFx27XSMmDCF+NgXqXXIkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ViBcznyMcYpPhEGvk78/v0XC+FUGq5tpLugyZSv7Eh+bhkbqMJBFLqsetFpfhgjk0
         uSvVwB7AHyTcbSawA8t202gcgs6eqXcmMNMCEUE6eg8lQW+AbaoF++LYaG9j/LXOB9
         ZjmWe6tAB0pQRkHR9JcLLnT/gAJLP/6R7WUgyfds=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200904133510eucas1p28cb3ab11e0cd8252df9971f2b6538bb0~xmAnisOUN0694006940eucas1p2r;
        Fri,  4 Sep 2020 13:35:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E1.76.05997.E82425F5; Fri,  4
        Sep 2020 14:35:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9~xmAnJ01ij1156611566eucas1p1N;
        Fri,  4 Sep 2020 13:35:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904133510eusmtrp211be072e4bd9dc8f560679e64325523b~xmAnJLXC90977009770eusmtrp2Z;
        Fri,  4 Sep 2020 13:35:10 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-7e-5f52428e5c8e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.B0.06017.E82425F5; Fri,  4
        Sep 2020 14:35:10 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133509eusmtip126e2d5705c6ff916666e9063e629bd26~xmAmkb-_D1683216832eusmtip1Z;
        Fri,  4 Sep 2020 13:35:09 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH v10 27/30] rapidio: fix common struct sg_table related
 issues
Date:   Fri,  4 Sep 2020 15:17:08 +0200
Message-Id: <20200904131711.12950-28-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzu3Lu7XYeT25Q8WSoMeqj4jrygaKnQJXuY/wRF2sqbim7aro+U
        KMtezAdTCZ/ZCsXynelMw9Tlq8wVKmrp0qUJxkzJpRTl2rqz/vvO7/u+833nx8FRYQfmgMdJ
        k2mZVJwg4vI5qv4fGve84IgoL32BL5mreYWQn2omUfJJcSNGGlX5KDn2fZlLPq7tQ0hllz9p
        GNMhZPPcOEaOdpRzyfpeLY+8+3YdJXtW5rEDAqquog5QnWtKDtVequVROfobGNW2NotRM9kD
        CPW08io1tTGHUoWT1YB6/j6TS+W11ABqtdkp3PoUPyCaTohLpWWegWf5sYXGeiwpb9ulaxNa
        LBNUCeXACofEPmjIyubIAR8XEo8A1JZNIWZCSBgA1H0DLLEK4OfBbnTTcS9nGGWJagDfdI1a
        VCbHeJOCY1ZxCW8oX5JzzdiOuAngYK61GaPEVwT2rrqasS1xHFYVT/29lUPsgtmLLBYQgbCh
        fILDpjnD2iY22co0by2ex8xhkHjNgz1dGoQVhULj7TxLPVv4ZaCFx+Kd0Nh+H2ENWab3aOp5
        7CEHwNHrxYBV+cNpzU9TVdxUzwU2dniaISQOQkX/BRbawMmlrWx/G1igKkLZsQDeuWVZ425Y
        OtDwL7Xn3YilDQX1fTrLfvIBrPy9gCqAc+n/LCUANcCeTmEkMTTjI6XTPBixhEmRxnicT5Q0
        A9OPGtoYMDwDHb/OqQGBA5G1YEtQRJQQE6cy6RI1gDgqshMEDw9FCgXR4vQMWpYYJUtJoBk1
        2IFzRPYC34eLZ4REjDiZjqfpJFq2ySK4lUMmcIt0CKc8/S8eHhpacWpTrAU06FXLM15Gbgnj
        ta5zWrm8vTWkKEP1QX2yCwkcmQ4NKxKUfIxGlNnGHFWYW4ALGeEuda6O1ce3V/A6y2Tdjmn9
        I/sXrhT6yMsUubl7ZtP8SpQ2R4IcrblK/d6llpd+h1wqTzwI6Tn2ou7o6UZ1p4jDxIq9XVEZ
        I/4DUX+Zmk0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7p9TkHxBqvmSFn0njvJZPFo1Q1m
        i40z1rNa/N82kdniytf3bBYrVx9lsliw39riy5WHTBabHl9jtbi8aw6bxdojd9ktpp7/zmxx
        8MMTVgdejzXz1jB67P22gMVj56y77B49b1pYPbZ/e8Dqcb/7OJPH5iX1Hrf/PWb2mHxjOaPH
        7psNbB59W1YxenzeJBfAE6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CXMfn/WtaCPrGKxut3WRsYlwp1MXJySAiYSMztOcvcxcjFISSwlFHiWNdp
        FoiEjMTJaQ2sELawxJ9rXWwQRZ8YJSZdXQtWxCZgKNH1FiIhItDJKDGt+yM7iMMs8I1JYtLS
        W2wgVcICvhI7vneBjWIRUJXofnmbGcTmFbCTWDfnOtQ6eYnVGw6AxTmB4ltnPAGrFxKwlfgw
        ZzHLBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjZtuxn1t2MHa9Cz7EKMDBqMTD
        y2AfFC/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYSTc4HxnRe
        SbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGtujVfkKbjgZeeiWg
        PyF3wYfOSXzNXFEzbcSEu1ziz8Q7XBbmYG2wdEryFSp99PCXxPpP3isyX/Hfcb4q7djrW3Jy
        8YKU5R5FJguan6Zz/Vh7S2CeudDOU/t1N3BVuV6dEPgv8Ju88x6m6QtDT3XZRa6dN/v8Dsbt
        DjUOiR3uDltXbyg6pZuqxFKckWioxVxUnAgABjvtbLECAAA=
X-CMS-MailID: 20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
        <CGME20200904133510eucas1p1e737f5cbb9b95846806766bd7b813bf9@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
returns the number of the created entries in the DMA address space.
However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
dma_unmap_sg must be called with the original number of the entries
passed to the dma_map_sg().

struct sg_table is a common structure used for describing a non-contiguous
memory buffer, used commonly in the DRM and graphics subsystems. It
consists of a scatterlist with memory pages and DMA addresses (sgl entry),
as well as the number of scatterlist entries: CPU pages (orig_nents entry)
and DMA mapped pages (nents entry).

It turned out that it was a common mistake to misuse nents and orig_nents
entries, calling DMA-mapping functions with a wrong number of entries or
ignoring the number of mapped entries returned by the dma_map_sg()
function.

To avoid such issues, lets use a common dma-mapping wrappers operating
directly on the struct sg_table objects and use scatterlist page
iterators where possible. This, almost always, hides references to the
nents and orig_nents entries, making the code robust, easier to follow
and copy/paste safe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index a30342942e26..89eb3d212652 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -573,8 +573,7 @@ static void dma_req_free(struct kref *ref)
 			refcount);
 	struct mport_cdev_priv *priv = req->priv;
 
-	dma_unmap_sg(req->dmach->device->dev,
-		     req->sgt.sgl, req->sgt.nents, req->dir);
+	dma_unmap_sgtable(req->dmach->device->dev, &req->sgt, req->dir, 0);
 	sg_free_table(&req->sgt);
 	if (req->page_list) {
 		unpin_user_pages(req->page_list, req->nr_pages);
@@ -814,7 +813,6 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 	struct mport_dev *md = priv->md;
 	struct dma_chan *chan;
 	int ret;
-	int nents;
 
 	if (xfer->length == 0)
 		return -EINVAL;
@@ -930,15 +928,14 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 				xfer->offset, xfer->length);
 	}
 
-	nents = dma_map_sg(chan->device->dev,
-			   req->sgt.sgl, req->sgt.nents, dir);
-	if (nents == 0) {
+	ret = dma_map_sgtable(chan->device->dev, &req->sgt, dir, 0);
+	if (ret) {
 		rmcd_error("Failed to map SG list");
 		ret = -EFAULT;
 		goto err_pg;
 	}
 
-	ret = do_dma_request(req, xfer, sync, nents);
+	ret = do_dma_request(req, xfer, sync, req->sgt.nents);
 
 	if (ret >= 0) {
 		if (sync == RIO_TRANSFER_ASYNC)
-- 
2.17.1

