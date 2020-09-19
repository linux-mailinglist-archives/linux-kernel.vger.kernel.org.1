Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B1270D72
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgISLHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:07:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgISLHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:07:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06206967FD2073886B18;
        Sat, 19 Sep 2020 19:07:36 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 19:07:27 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/1] libnvdimm: make sure EXPORT_SYMBOL_GPL(nvdimm_flush) close to its function
Date:   Sat, 19 Sep 2020 19:07:07 +0800
Message-ID: <20200919110707.4021-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move EXPORT_SYMBOL_GPL(nvdimm_flush) close to nvdimm_flush(), currently
it's near to generic_nvdimm_flush().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
v1 --> v2
1. add "Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>"

v1:
https://lkml.org/lkml/2020/8/20/904

 drivers/nvdimm/region_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 7cf9c7d857909ce..5df7c22df1529eb 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1186,6 +1186,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(nvdimm_flush);
+
 /**
  * nvdimm_flush - flush any posted write queues between the cpu and pmem media
  * @nd_region: blk or interleaved pmem region
@@ -1217,7 +1219,6 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nvdimm_flush);
 
 /**
  * nvdimm_has_flush - determine write flushing requirements
-- 
1.8.3


