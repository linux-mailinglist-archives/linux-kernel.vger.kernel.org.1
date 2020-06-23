Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76930204892
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 06:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgFWESH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 00:18:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgFWESH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:18:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F0189263844760CFAACA;
        Tue, 23 Jun 2020 12:18:01 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.72) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 12:17:53 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <wangzhou1@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <akpm@linux-foundation.org>, <linux-crypto@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 0/3] crypto: allow users to specify acomp hardware from a desired NUMA node
Date:   Tue, 23 Jun 2020 16:16:07 +1200
Message-ID: <20200623041610.7620-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.72]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a typical Linux server, probably there are several hardware modules.
For example, numa node0 has a compressor, numa node2 has a same module.
Some drivers are automatically using the module near the CPU calling
acomp_alloc.
But it isn't necessarily correct. Just like memory allocation API like
kmalloc and kmalloc_node. Similar optimization may be done for crypto.

-v2:
  * fix kern-doc and some codingstyle issues according to Jonathan's comment
  * patch 3/3 is rebased againest "[PATCH] mm/zswap: careful error path
    implementation in comp_prepare"[1]

[1] https://lkml.org/lkml/2020/6/22/347

Barry Song (3):
  crypto: permit users to specify numa node of acomp hardware
  crypto: hisilicon/zip - permit users to specify NUMA node
  mm/zswap: allocate acomp on the numa node committing acomp_req

 crypto/acompress.c                        |  8 ++++++++
 crypto/api.c                              | 22 ++++++++++++++--------
 crypto/internal.h                         | 23 +++++++++++++++++++----
 drivers/crypto/hisilicon/zip/zip.h        |  2 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c |  6 +++---
 drivers/crypto/hisilicon/zip/zip_main.c   |  5 +++--
 include/crypto/acompress.h                | 18 ++++++++++++++++++
 include/linux/crypto.h                    |  2 ++
 mm/zswap.c                                |  2 +-
 9 files changed, 69 insertions(+), 19 deletions(-)

-- 
2.27.0


