Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3055A2613A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 17:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgIHPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 11:36:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10847 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730205AbgIHPfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9275A3EFE096A39CE752;
        Tue,  8 Sep 2020 21:32:17 +0800 (CST)
Received: from localhost (10.174.151.129) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 21:32:10 +0800
From:   Ming Mao <maoming.maoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-mm@kvack.org>, <alex.williamson@redhat.com>,
        <akpm@linux-foundation.org>
CC:     <cohuck@redhat.com>, <jianjay.zhou@huawei.com>,
        <weidong.huang@huawei.com>, <peterx@redhat.com>,
        <aarcange@redhat.com>, <wangyunjian@huawei.com>,
        Ming Mao <maoming.maoming@huawei.com>
Subject: [PATCH V4 0/2] vfio: optimized for hugetlbf pages when dma map/unmap
Date:   Tue, 8 Sep 2020 21:32:02 +0800
Message-ID: <20200908133204.1338-1-maoming.maoming@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series deletes the for loop in dma_map/unmap for hugetlb pages.
In the original process, the for loop could spend much time to check all
normal pages.If we use hugetlb pages, it is not necessary to do this.

Changes from v3
- add a new API unpin_user_hugetlb_pages_dirty_lock()
- use the new API to unpin hugetlb pages

Ming Mao (2):
  vfio dma_map/unmap: optimized for hugetlbfs pages
  vfio: optimized for unpinning pages

 drivers/vfio/vfio_iommu_type1.c | 373 ++++++++++++++++++++++++++++++--
 include/linux/mm.h              |   3 +
 mm/gup.c                        |  91 ++++++++
 3 files changed, 450 insertions(+), 17 deletions(-)

-- 
2.23.0


