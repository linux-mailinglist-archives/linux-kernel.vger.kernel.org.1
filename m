Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4E1FF870
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 18:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgFRQBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 12:01:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43622 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgFRQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:01:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200618160121euoutp0284c83b9904906f93dcb605d20d1703cc~Zrr_sG3QW2497024970euoutp02X
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:01:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200618160121euoutp0284c83b9904906f93dcb605d20d1703cc~Zrr_sG3QW2497024970euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592496081;
        bh=Q6nmdHxiLcADSmmOczfWQ1kCLD9EfF+zt7aqe3afHuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FaM4R6h/1wQ2+FHQCJnS7+FathW2IZKJjpwutCurOEg6h45s7KLfV7Gpv51DBCUup
         J7rCIfYl4j/tVGm0/T1Xyaf7YJXYSpd8kl9PaWTVA0yImIhugXhe481W8IxYVS49g9
         xmbuS//EvQcHWZjeWKifhd7Ag7HEsXetzGhrbmEU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200618160121eucas1p25152fd9c21e6f800fe9f095d79056daa~Zrr_Wk0ia2423724237eucas1p2B;
        Thu, 18 Jun 2020 16:01:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.52.60698.1DF8BEE5; Thu, 18
        Jun 2020 17:01:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200618160120eucas1p20b771c3b6dc06549c7f4a4d569c3e0ec~Zrr98WwZc1444214442eucas1p2T;
        Thu, 18 Jun 2020 16:01:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200618160120eusmtrp19b1f7bc59472a1a799da9bbde8edea03~Zrr97nA460376803768eusmtrp1W;
        Thu, 18 Jun 2020 16:01:20 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-8e-5eeb8fd1154a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.E0.08375.0DF8BEE5; Thu, 18
        Jun 2020 17:01:20 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200618160119eusmtip2b6913e0a93ea45b7293f1adb592e0866~Zrr9SQydu3011030110eusmtip21;
        Thu, 18 Jun 2020 16:01:19 +0000 (GMT)
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
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v6 36/36] drm: xen: fix common struct sg_table related
 issues
Date:   Thu, 18 Jun 2020 18:01:11 +0200
Message-Id: <20200618160111.3045-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzm7O5uV3Nym8IOKgoLgwQ1M9YFH1go3b+0PwIha7rypqKbsunK
        CvKRj5aPfKGZ1Qxf+X6smZqllm6yWpoPtAw1g3w0lJzTLDS3a/bf932/7zvfOT8OhnBfog5Y
        jCSRkkpEcXyWNVM99EvvPpq/Ijyu2kKJXP0wg2gra0GJXXUBQoxvrLKIZw2DDEL52ocwjs8z
        iPaFSZQY665gEU1vv7CJtYZVlOhf+4YSm6oiRgCHbHzcCMiZ6i5A9pqUTLLTNIeSs/c0DLKj
        6jb5eWcBIYumagH5Zm2cSfZMp7DIPFU9INfbnc/ZXLD2jaTiYuSU1NM/wjq6V5HFSMizvV46
        mg5SgOGQAmAYxE/Cd/VBCmCNcfE6AOc3qtg0MQKYP6hk0WQdwK9LKXvEypLo/D0F6EEtgN+7
        PjAPIj/qjYjZxcK9oMKgsCTs8QwAtbk2ZhOCbzGgvkbLNg/s8BCYWlJnCTBxV1ij1FkwB/eF
        LTMrKF3nAhta+yy6Fe4PdZoM1HwQxPVsmKldQmhTIOxcN7FpbAeXNap97AR1RTlMOpC+9zx9
        E5smOQCOpZUB2uUDZ/TbLPM+EPwYbOn2pOXTsHioD6XXZAunDIfNMrIHC9WlCC1zYHYml3Yf
        heWa5oPa/pGP+1cjobaydH+pBQAaFidZ94FL+f8yJQD1gEclycRRlMxbQl3zkInEsiRJlMeV
        eHE72PtTuh3Nxgvw6s/lAYBjgG/DWTy/IuSiIrksWTwAIIbw7Tln3uuEXE6kKPkGJY0PlybF
        UbIB4Igx+TyO99OlS1w8SpRIxVJUAiX9N2VgVg4pICIQGAOC56Sb7md9gyrzhKkNwlO7bab+
        R/JbMcHO8k9d2ppQTmx/XLzT8JGb8rCHjuH5RE/qT9OD6cxWQUsejwirdK14oveLHLnTszzh
        1pw9LxE8LRS0dcwuq65GxyanPbe7q145kbo25BfCq1ZOFWQ184p3xKG9E9uCkovhlXymLFrk
        5YZIZaK/qYRK+08DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7oX+l/HGeyYpGbRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFh9Wv2e1OPjhCavF
        9y2TmRx4PdbMW8PocWfpTkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj8MfrrB4
        7L7ZwObRt2UVo8fnTXIBPFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
        NimpOZllqUX6dgl6GXu72pkK+vgqpl9sZmxgfMvdxcjJISFgIrH99w3GLkYuDiGBpYwSt5c1
        sEMkZCROTmtghbCFJf5c62KDKPrEKPHt7iYmkASbgKFE11uIhIhAJ6PEtO6P7CAOs8A/JokT
        e7eDVQkL+Eocf7iXDcRmEVCVWLbgNDOIzStgI7H+zmuoFfISqzccAItzCthJnD7eChYXErCV
        eP6hjW0CI98CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgXGz7djPzTsYL20MPsQowMGo
        xMP7IuR1nBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8Y
        03kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjbVuhEzl6UNU/i
        eVq+64SElclV7bJ3Tc+FbT302Gmj5pdNVZMWxnnM1GZQS9qTyyGvEbT84ctn70XF3Kdv7w6t
        eXWAb1t1TMrcDsfgtwvLvlx+qJwk/kDq7fs3T95/v6cY7mZef3vDTRmp4AlTj7a8EwlL/fmS
        71BQFp9t6wdTQWWbmLrqy5OVWIozEg21mIuKEwG7wX5nsQIAAA==
X-CMS-MailID: 20200618160120eucas1p20b771c3b6dc06549c7f4a4d569c3e0ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618160120eucas1p20b771c3b6dc06549c7f4a4d569c3e0ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618160120eucas1p20b771c3b6dc06549c7f4a4d569c3e0ec
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618160120eucas1p20b771c3b6dc06549c7f4a4d569c3e0ec@eucas1p2.samsung.com>
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

Fix the code to refer to proper nents or orig_nents entries. This driver
reports the number of the pages in the imported scatterlist, so it should
refer to sg_table->orig_nents entry.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index f0b85e094111..ba4bdc5590ea 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -215,7 +215,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
 		return ERR_PTR(ret);
 
 	DRM_DEBUG("Imported buffer of size %zu with nents %u\n",
-		  size, sgt->nents);
+		  size, sgt->orig_nents);
 
 	return &xen_obj->base;
 }
-- 
2.17.1

