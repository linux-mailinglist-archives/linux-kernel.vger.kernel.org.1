Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121871ECBB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgFCImC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:42:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgFCImC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:42:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E0C7CDB02565211492AB;
        Wed,  3 Jun 2020 16:41:58 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.66) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 3 Jun 2020 16:41:49 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <guro@fb.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 0/2] mm: fix the names of general cma and hugetlb cma
Date:   Wed, 3 Jun 2020 20:40:23 +1200
Message-ID: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the current code of CMA can only work when users pass a const string as name
parameter. we need to fix the way to handle names in CMA.
On the other hand, to avoid name conflicts after enabling CMA_DEBUGFS, each
hugetlb should get a different CMA name.

Barry Song (2):
  mm: cma: fix the name of CMA areas
  mm: hugetlb: fix the name of hugetlb CMA

 mm/cma.c     | 13 ++++++-------
 mm/cma.h     |  4 +++-
 mm/hugetlb.c |  4 +++-
 3 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.23.0


