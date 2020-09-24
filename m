Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D452D2773CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgIXOVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:21:03 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:60403 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgIXOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600957262; x=1632493262;
  h=to:cc:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=AXfCp1SiddQmAtKsdozKcAnnSiVqTWsFP9hnxw69msY=;
  b=cUBotEzSki0Jc+pjtFKv78oMhAVaizhY732drj82syQAQ0TJPVYMSzKU
   Maj8lbLxRhqjDLzAecX6hOuEgtb2a5Pw84g78d5xnv5ee5dlP5pSRlav6
   myDnOj57T3Lzdgyy3N6FWgLceCQAzWKmhjdLnL8J3lOHnug59z9ic9hRF
   U=;
X-IronPort-AV: E=Sophos;i="5.77,298,1596499200"; 
   d="scan'208";a="55840363"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Sep 2020 14:21:01 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id B2731A081C;
        Thu, 24 Sep 2020 14:20:59 +0000 (UTC)
Received: from EX13D12UWC002.ant.amazon.com (10.43.162.253) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 24 Sep 2020 14:20:59 +0000
Received: from [192.168.7.67] (10.43.162.133) by EX13D12UWC002.ant.amazon.com
 (10.43.162.253) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Sep
 2020 14:20:58 +0000
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
From:   George Prekas <prekageo@amazon.com>
Subject: [PATCH v2] scripts/gdb: fix list_for_each
Message-ID: <4ae23bb1-c333-f669-da2d-fa35c4f49018@amazon.com>
Date:   Thu, 24 Sep 2020 09:20:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.162.133]
X-ClientProxiedBy: EX13D47UWA001.ant.amazon.com (10.43.163.6) To
 EX13D12UWC002.ant.amazon.com (10.43.162.253)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the list is uninitialized (next pointer is NULL), list_for_each gets
stuck in an infinite loop. Print a message and treat list as empty.

Signed-off-by: George Prekas <prekageo@amazon.com>
---
  scripts/gdb/linux/lists.py | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
index c487ddf09d38..bae4d70b7eae 100644
--- a/scripts/gdb/linux/lists.py
+++ b/scripts/gdb/linux/lists.py
@@ -27,6 +27,11 @@ def list_for_each(head):
          raise TypeError("Must be struct list_head not {}"
                             .format(head.type))

+    if head['next'] == 0:
+        gdb.write("list_for_each: Uninitialized list '{}' treated as 
empty\n"
+                     .format(head.address))
+        return
+
      node = head['next'].dereference()
      while node.address != head.address:
          yield node.address
-- 
2.16.6

