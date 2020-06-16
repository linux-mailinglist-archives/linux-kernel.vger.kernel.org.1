Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6111FC193
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 00:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFPWdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 18:33:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbgFPWdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:33:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0C1FEA5F092C63276926;
        Wed, 17 Jun 2020 06:33:19 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.10) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 06:33:10 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 0/2] mm: fix the names of general cma and hugetlb cma
Date:   Wed, 17 Jun 2020 10:31:29 +1200
Message-ID: <20200616223131.33828-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.10]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the current code of CMA can only work when users pass a const string as name
parameter. we need to fix the way to handle names in CMA.
On the other hand, to avoid name conflicts after enabling CMA_DEBUGFS, each
hugetlb should get a different CMA name.

-v2:
  add acked-by and reviewed-by
  rebase to 5.8-rc1

Barry Song (2):
  mm: cma: fix the name of CMA areas
  mm: hugetlb: fix the name of hugetlb CMA

 mm/cma.c     | 13 ++++++-------
 mm/cma.h     |  4 +++-
 mm/hugetlb.c |  4 +++-
 3 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.23.0


