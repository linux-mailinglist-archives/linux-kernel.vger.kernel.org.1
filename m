Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8929127E699
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgI3K2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:28:31 -0400
Received: from crapouillou.net ([89.234.176.41]:52810 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgI3K2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601461707; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=N6zScjoElk/0srLgAKNsWnU8nZwt1zHmH6tZPRQ7bWI=;
        b=xrn918b6QUwV0Chrk0RERJfYJpld+15JXoCeobawiOBLshA//FWE0Bvic+Mbci2smNkCEY
        RsE0w0tk3D8LWoenvOQ8PX+TYXavZ+ODuW9pborHEiCHh3d67C9F90wlk9M0FTJR1viY2o
        ly+O+gQjnSuLmdrzXNGtRLmnwKz78H8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     od@zcrc.me, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] cma: decrease CMA_ALIGNMENT lower limit to 2
Date:   Wed, 30 Sep 2020 12:28:21 +0200
Message-Id: <20200930102821.26421-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an embedded system with a tiny (1 MiB) CMA area for video memory, and
a simple enough video pipeline, we can decrease the CMA_ALIGNMENT by a
factor of 2 to avoid wasting memory, as all the allocations for video
buffers will be of the exact same size (dictated by the size of the
screen).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 kernel/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 847a9d1fa634..f15e782e19ca 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -162,7 +162,7 @@ endchoice
 
 config CMA_ALIGNMENT
 	int "Maximum PAGE_SIZE order of alignment for contiguous buffers"
-	range 4 12
+	range 2 12
 	default 8
 	help
 	  DMA mapping framework by default aligns all buffers to the smallest
-- 
2.28.0

