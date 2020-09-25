Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8EC278476
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgIYJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:56:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbgIYJ4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF78663B340DED11E1FA;
        Fri, 25 Sep 2020 17:55:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 25 Sep 2020 17:55:47 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        <xiyou.wangcong@gmail.com>, <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] iommu/iova: Solve longterm IOVA issue
Date:   Fri, 25 Sep 2020 17:51:07 +0800
Message-ID: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
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

I also included the small optimisation from Cong Wang, which never seems
to be have been accepted [1]. There was some debate of the other patches
in that series, but this one is quite straightforward.

@Cong Wang, Please resend your series if prefer I didn't upstream your
patch.

[0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
[1] https://lore.kernel.org/linux-iommu/4b74d40a-22d1-af53-fcb6-5d70183705a8@huawei.com/

Cong Wang (1):
  iommu: avoid taking iova_rbtree_lock twice

John Garry (1):
  iommu/iova: Flush CPU rcache for when a depot fills

 drivers/iommu/iova.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.26.2

