Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6427D23E9A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHGI66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 04:58:58 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43835 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgHGI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:58:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5.DkTU_1596790735;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5.DkTU_1596790735)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 16:58:55 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [RESEND Patch 0/2] trivial cleanup for get_count_order[_long]
Date:   Fri,  7 Aug 2020 16:58:35 +0800
Message-Id: <20200807085837.11697-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches cleanup get_count_order[_long] a little.

The lib/test_bitops pass with these two patches.

Wei Yang (2):
  bitops: simplify get_count_order_long()
  bitops: use the same mechanism for get_count_order[_long]

 include/linux/bitops.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

-- 
2.20.1 (Apple Git-117)

