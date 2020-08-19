Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECF82492BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgHSCFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 22:05:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbgHSCFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:05:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC92C1B7B738A14D34C2;
        Wed, 19 Aug 2020 10:05:44 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 10:05:32 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/4] bugfix and optimize for drivers/nvdimm
Date:   Wed, 19 Aug 2020 10:04:59 +0800
Message-ID: <20200819020503.3079-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
1. Add Fixes for Patch 1-2
2. Slightly change the subject and description of Patch 1
3. Add a new trivial Patch 4, I just found that yesterday.

v1:
I found a memleak when I learned the drivers/nvdimm code today. And I also
added a sanity check for priv->bus_desc.provider_name, because strdup()
maybe failed. Patch 3 is a trivial source code optimization.

Zhen Lei (4):
  libnvdimm: fix memmory leaks in of_pmem.c
  libnvdimm: add sanity check for provider_name in
    of_pmem_region_probe()
  libnvdimm/bus: simplify walk_to_nvdimm_bus()
  libnvdimm/region: reduce an unnecessary if branch in
    nd_region_create()

 drivers/nvdimm/bus.c         | 7 +++----
 drivers/nvdimm/of_pmem.c     | 7 +++++++
 drivers/nvdimm/region_devs.c | 5 +----
 3 files changed, 11 insertions(+), 8 deletions(-)

-- 
1.8.3


