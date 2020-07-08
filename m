Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBBA218431
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGHJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 05:50:47 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49998 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgGHJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:50:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0U26GSJh_1594201842;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U26GSJh_1594201842)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 17:50:43 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, yang.shi@linux.alibaba.com, thomas_os@shipmail.org,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        richard.weiyang@linux.alibaba.com, peterx@redhat.com,
        aneesh.kumar@linux.ibm.com, willy@infradead.org,
        thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: [Patch v4 0/4] mm/mremap: cleanup move_page_tables() a little
Date:   Wed,  8 Jul 2020 17:50:24 +0800
Message-Id: <20200708095028.41706-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_page_tables() tries to move page table by PMD or PTE.

The root reason is if it tries to move PMD, both old and new range should be
PMD aligned. But current code calculate old range and new range separately.
This leads to some redundant check and calculation.

This cleanup tries to consolidate the range check in one place to reduce some
extra range handling.

v4:
  * remove a redundant parentheses pointed by Kirill

v3:
  * merge patch 1 with 2 as suggested by Kirill
  * add patch 4 to simplify the logic to calculate next and extent

v2:
  * remove 3rd patch which doesn't work on ARM platform. Thanks report and
    test from Dmitry Osipenko

Wei Yang (4):
  mm/mremap: it is sure to have enough space when extent meets
    requirement
  mm/mremap: calculate extent in one place
  mm/mremap: start addresses are properly aligned
  mm/mremap: use pmd_addr_end to simplify the calculate of extent

 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        |  8 +-------
 mm/mremap.c             | 27 ++++++++++-----------------
 3 files changed, 12 insertions(+), 25 deletions(-)

-- 
2.20.1 (Apple Git-117)

