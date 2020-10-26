Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6902993F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788031AbgJZRfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:35:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3626 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788000AbgJZRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:35:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKhnT1Ct6zLnB3;
        Tue, 27 Oct 2020 01:35:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 01:35:27 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <robin.murphy@arm.com>
CC:     <xiyou.wangcong@gmail.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/4] iommu/iova: Solve longterm IOVA issue
Date:   Tue, 27 Oct 2020 01:31:37 +0800
Message-ID: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a patch to solve the longterm IOVA issue which
leizhen originally tried to address at [0].

Along with this, I included the following:
- A smaller helper to clear all IOVAs for a domain
- Change polarity of the IOVA magazine helpers
- Small optimisation from Cong Wang included, which was never applied [1].
  There was some debate of the other patches in that series, but this one
  is quite straightforward.

Differences to v1:
- Add IOVA clearing helper
- Add patch to change polarity of mag helpers
- Avoid logically-redundant extra variable in __iova_rcache_insert()

[0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
[1] https://lore.kernel.org/linux-iommu/4b74d40a-22d1-af53-fcb6-5d70183705a8@huawei.com/

Cong Wang (1):
  iommu: avoid taking iova_rbtree_lock twice

John Garry (3):
  iommu/iova: Add free_all_cpu_cached_iovas()
  iommu/iova: Avoid double-negatives in magazine helpers
  iommu/iova: Flush CPU rcache for when a depot fills

 drivers/iommu/iova.c | 66 +++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

-- 
2.26.2

