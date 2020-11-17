Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E122B5CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgKQKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:30:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8104 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgKQKaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:30:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cb2Hm0JxfzLmCh;
        Tue, 17 Nov 2020 18:29:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 18:29:51 +0800
From:   John Garry <john.garry@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <xiyou.wangcong@gmail.com>, <linuxarm@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
Date:   Tue, 17 Nov 2020 18:25:30 +0800
Message-ID: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
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

A sieved kernel log is at the following, showing periodic dumps of IOVA
sizes, per CPU and per depot bin, per IOVA size granule:
https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test

Notice, for example, the following logs:
[13175.355584] print_iova1 cpu_total=40135 depot_total=3866 total=44001
[83483.457858] print_iova1 cpu_total=62532 depot_total=24476 total=87008

Where total IOVA rcache size has grown from 44K->87K over a long time.

Along with this patch, I included the following:
- A smaller helper to clear all IOVAs for a domain
- Change polarity of the IOVA magazine helpers
- Small optimisation from Cong Wang included, which was never applied [1].
  There was some debate of the other patches in that series, but this one
  is quite straightforward.

Differnces to v2:
- Update commit message for patch 3/4

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

