Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254A8258548
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 03:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIABqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 21:46:49 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35196 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgIABqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:46:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7UN03A_1598924801;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7UN03A_1598924801)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 09:46:42 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v4 0/7] mm/hugetlb: code refine and simplification
Date:   Tue,  1 Sep 2020 09:46:29 +0800
Message-Id: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following are some cleanup for hugetlb.

Simple test with tools/testing/selftests/vm/map_hugetlb pass.

v4:
  * fix a logic error for patch 7, thanks Mike
v3:
  * rebase on v5.9-rc2 which adjust the last patch a little
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
  mm/hugetlb: narrow the hugetlb_lock protection area during preparing
    huge page
  mm/hugetlb: take the free hpage during the iteration directly

 mm/hugetlb.c | 73 ++++++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

-- 
2.20.1 (Apple Git-117)

