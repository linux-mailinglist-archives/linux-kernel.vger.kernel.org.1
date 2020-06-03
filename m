Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54A91ECA64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFCHT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 03:19:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:54519 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgFCHT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:19:27 -0400
IronPort-SDR: rGwGPhXSM5/dn80h6lM0plq4aF1RAc/vRfDQ9ey8XjJ+hvWoWOroCkc+aaXSD9vDlLQrf2yJ9C
 5sEuH2jf7e4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 00:19:27 -0700
IronPort-SDR: Yyl9KM/4BH8YDORSPS8aPRUDVd45t282Vv6JqhEp+3M9F8OJHnZM2qMC0PwlIr7sc8Xw7TSkeA
 2KEjhPrZouhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="444996268"
Received: from lkp-server02.sh.intel.com (HELO 8f84dc34deca) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2020 00:19:22 -0700
Received: from kbuild by 8f84dc34deca with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgNgH-000034-1X; Wed, 03 Jun 2020 07:19:21 +0000
Date:   Wed, 3 Jun 2020 15:18:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Barry Song <song.bao.hua@hisilicon.com>, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        catalin.marinas@arm.com
Cc:     kbuild-all@lists.01.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Jonathan.Cameron@huawei.com,
        john.garry@huawei.com
Subject: [RFC PATCH] dma-direct: dma_contiguous_pernuma_area[] can be static
Message-ID: <20200603071859.GA64477@6bb44d8ad825>
References: <20200603024231.61748-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603024231.61748-2-song.bao.hua@hisilicon.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 contiguous.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 4b10d0ca0456d..2094c8e0590ac 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -37,7 +37,7 @@
 #endif
 
 struct cma *dma_contiguous_default_area;
-struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
+static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
