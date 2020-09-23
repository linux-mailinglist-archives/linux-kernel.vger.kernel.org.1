Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A01275B07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIWPAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:00:54 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:15590 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600873253; x=1632409253;
  h=to:cc:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=ncTiycxbLLLABb828Z5CFC0O0VQndKnHSZDh9Pb2FUA=;
  b=rTmFAlorAGGAk+ILKIy10Y1JeVgXeMpaEnaYjejtXbzJCtfUxxXkp2hR
   IeF+b4vChQD82MagQ0hvshtJ9I+nuXv/ltJUhXltE5V6SdBu0BZSYiSUi
   wosUIlLQ7vIjmm795DSWyY2r1TmCBiqj6lBD7o6REiPBpcTRrrPaZohlX
   Q=;
X-IronPort-AV: E=Sophos;i="5.77,293,1596499200"; 
   d="scan'208";a="55868833"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 23 Sep 2020 15:00:49 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 63C8F222BE2;
        Wed, 23 Sep 2020 15:00:45 +0000 (UTC)
Received: from EX13D12UWC002.ant.amazon.com (10.43.162.253) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 23 Sep 2020 15:00:45 +0000
Received: from [10.95.178.71] (10.43.161.71) by EX13D12UWC002.ant.amazon.com
 (10.43.162.253) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Sep
 2020 15:00:43 +0000
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Kaitao Cheng <pilgrimtao@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
From:   George Prekas <prekageo@amazon.com>
Subject: [PATCH] latency improvement in __smp_call_single_queue
Message-ID: <281da382-4511-e1df-6917-154a5914dd43@amazon.com>
Date:   Wed, 23 Sep 2020 10:00:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.161.71]
X-ClientProxiedBy: EX13D48UWB004.ant.amazon.com (10.43.163.74) To
 EX13D12UWC002.ant.amazon.com (10.43.162.253)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an interrupt arrives between llist_add and
send_call_function_single_ipi in the following code snippet, then the
remote CPU will not receive the IPI in a timely manner and subsequent
SMP calls even from other CPUs for other functions will be delayed:

     if (llist_add(node, &per_cpu(call_single_queue, cpu)))
         send_call_function_single_ipi(cpu);

Note: llist_add returns 1 if it was empty before the operation.

CPU 0                           | CPU 1                     | CPU 2
__smp_call_single_q(2,f1)       | __smp_call_single_q(2,f2) |
   llist_add returns 1           |                           |
   interrupted                   |   llist_add returns 0     |
       ...                       |   branch not taken        |
       ...                       |                           |
   resumed                       |                           |
   send_call_function_single_ipi |                           |
                                 |                           | f1
                                 |                           | f2

The call from CPU 1 for function f2 will be delayed because CPU 0 was
interrupted.

Signed-off-by: George Prekas <prekageo@amazon.com>
---
  kernel/smp.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index aa17eedff5be..9dc679466cf0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -135,6 +135,8 @@ static 
DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);

  void __smp_call_single_queue(int cpu, struct llist_node *node)
  {
+    unsigned long flags;
+
      /*
       * The list addition should be visible before sending the IPI
       * handler locks the list to pull the entry off it because of
@@ -146,8 +148,10 @@ void __smp_call_single_queue(int cpu, struct 
llist_node *node)
       * locking and barrier primitives. Generic code isn't really
       * equipped to do the right thing...
       */
+    local_irq_save(flags);
      if (llist_add(node, &per_cpu(call_single_queue, cpu)))
          send_call_function_single_ipi(cpu);
+    local_irq_restore(flags);
  }

  /*
-- 
2.16.6


