Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00F72CDDE2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgLCSjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:39:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8244 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgLCSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:39:53 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cn4NW4CTszkkwY;
        Fri,  4 Dec 2020 02:38:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 02:39:01 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <0x7f454c46@gmail.com>,
        <robin.murphy@arm.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH 0/3] IOMMU: Some IOVA code tidy-up
Date:   Fri, 4 Dec 2020 02:34:49 +0800
Message-ID: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some minor tidy-ups by deleting an unreferenced
function and unexporting some functions, highlighted by:
https://lore.kernel.org/linux-iommu/6e09d847-fb7f-1ec1-02bf-f0c8b315845f@huawei.com/T/#med5a019f9d3835c162c16a48f34d05cc0111b0ca

John Garry (3):
  iommu: Delete split_and_remove_iova()
  iommu: Stop exporting alloc_iova_mem()
  iommu: Stop exporting free_iova_mem()

 drivers/iommu/iova.c | 47 ++------------------------------------------
 include/linux/iova.h | 21 --------------------
 2 files changed, 2 insertions(+), 66 deletions(-)

-- 
2.26.2

