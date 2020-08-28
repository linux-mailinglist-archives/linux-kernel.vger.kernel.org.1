Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EC3255353
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 05:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgH1Dcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 23:32:52 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50465 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgH1Dcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:32:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U736V19_1598585570;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U736V19_1598585570)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 11:32:50 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v2 0/7] mm/hugetlb: code refine and simplification
Date:   Fri, 28 Aug 2020 11:32:35 +0800
Message-Id: <20200828033242.8787-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following are some cleanup for hugetlb.

Simple test with tools/testing/selftests/vm/map_hugetlb pass.

v2:
  * drop 5/6/10 since similar patches are merged or under review.
  * adjust 2 based on comment from Mike Kravetz

Wei Yang (7):
  mm/hugetlb: not necessary to coalesce regions recursively
  mm/hugetlb: remove VM_BUG_ON(!nrg) in
    get_file_region_entry_from_cache()
  mm/hugetlb: use list_splice to merge two list at once
  mm/hugetlb: count file_region to be added when regions_needed != NULL
  mm/hugetlb: a page from buddy is not on any list
  mm/hugetlb: return non-isolated page in the loop instead of break and
    check
  mm/hugetlb: narrow the hugetlb_lock protection area during preparing
    huge page

 mm/hugetlb.c | 77 +++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 43 deletions(-)

-- 
2.20.1 (Apple Git-117)

