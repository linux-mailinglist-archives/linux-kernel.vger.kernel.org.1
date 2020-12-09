Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8432B2D4610
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgLIPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:55:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8739 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731296AbgLIPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:55:07 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CrhRK2f69zkkLn;
        Wed,  9 Dec 2020 23:53:33 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 23:54:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] IOMMU: Some more IOVA code tidy-up
Date:   Wed, 9 Dec 2020 23:50:16 +0800
Message-ID: <1607529019-229549-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on arm64 for-next/iommu/core

I'll try to bunch this sort of stuff more in future, Thanks

John Garry (3):
  iova: Make has_iova_flush_queue() private
  iova: Delete copy_reserved_iova()
  iova: Stop exporting some more functions

 drivers/iommu/iova.c | 36 +-----------------------------------
 include/linux/iova.h | 12 ------------
 2 files changed, 1 insertion(+), 47 deletions(-)

-- 
2.26.2

