Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C59274442
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIVO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:28:28 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:47901 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIVO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600784908; x=1632320908;
  h=to:cc:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=chOAFRzhLpeku7MlIinWALn5eKMG3/rsd9Ptm05qR9U=;
  b=FsLXHca/mx2WHXGG3Rq3p/W5uj/whFqsHZbgy26NNKzq7vFKpr4PCeiA
   AIFzVL0HLn3V5d7OHx41W3RAXsOQsvChNXwrMpiyGVpZBYgCr0v4RsJGc
   +otaWyaNZeg+IQJiK7DmIye5Aua2ugtJiNVvImTk97QLcOYj5YVLt2EYC
   0=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="56974341"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Sep 2020 14:28:26 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id BDB27A0669;
        Tue, 22 Sep 2020 14:28:24 +0000 (UTC)
Received: from EX13D12UWC002.ant.amazon.com (10.43.162.253) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 14:28:24 +0000
Received: from [10.88.31.162] (10.43.161.85) by EX13D12UWC002.ant.amazon.com
 (10.43.162.253) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Sep
 2020 14:28:23 +0000
To:     <linux-kernel@vger.kernel.org>
CC:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
From:   George Prekas <prekageo@amazon.com>
Subject: [PATCH] scripts/gdb: fix list_for_each
Message-ID: <3b382958-9f1d-a3d2-a239-09ba084227e6@amazon.com>
Date:   Tue, 22 Sep 2020 09:28:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.161.85]
X-ClientProxiedBy: EX13D01UWA003.ant.amazon.com (10.43.160.107) To
 EX13D12UWC002.ant.amazon.com (10.43.162.253)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the next pointer is NULL, list_for_each gets stuck in an infinite
loop.

Signed-off-by: George Prekas <prekageo@amazon.com>
---
  scripts/gdb/linux/lists.py | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
index c487ddf09d38..424a91c1aa8b 100644
--- a/scripts/gdb/linux/lists.py
+++ b/scripts/gdb/linux/lists.py
@@ -27,6 +27,8 @@ def list_for_each(head):
          raise TypeError("Must be struct list_head not {}"
                             .format(head.type))

+    if head['next'] == 0:
+        return
      node = head['next'].dereference()
      while node.address != head.address:
          yield node.address
-- 
2.24.3.AMZN


