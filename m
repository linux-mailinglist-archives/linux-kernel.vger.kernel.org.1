Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5667123E9DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHGJNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 05:13:31 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:59972 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgHGJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:13:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5.Rnug_1596791595;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5.Rnug_1596791595)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 17:13:15 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 00/10] mm/hugetlb: code refine and simplification
Date:   Fri,  7 Aug 2020 17:12:41 +0800
Message-Id: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following are some cleanup for hugetlb.

Simple test with tools/testing/selftests/vm/map_hugetlb pass.

Wei Yang (10):
  mm/hugetlb: not necessary to coalesce regions recursively
  mm/hugetlb: make sure to get NULL when list is empty
  mm/hugetlb: use list_splice to merge two list at once
  mm/hugetlb: count file_region to be added when regions_needed != NULL
  mm/hugetlb: remove the redundant check on non_swap_entry()
  mm/hugetlb: remove redundant huge_pte_alloc() in hugetlb_fault()
  mm/hugetlb: a page from buddy is not on any list
  mm/hugetlb: return non-isolated page in the loop instead of break and
    check
  mm/hugetlb: narrow the hugetlb_lock protection area during preparing
    huge page
  mm/hugetlb: not necessary to abuse temporary page to workaround the
    nasty free_huge_page

 mm/hugetlb.c | 101 ++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 57 deletions(-)

-- 
2.20.1 (Apple Git-117)

