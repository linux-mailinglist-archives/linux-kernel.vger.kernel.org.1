Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C792405AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHJMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:18:00 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44128 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgHJMR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:17:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U5MlrY2_1597061872;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U5MlrY2_1597061872)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 20:17:52 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH v2 0/3] mm/slub: Fix count_partial() problem
Date:   Mon, 10 Aug 2020 20:17:49 +0800
Message-Id: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
- Improved changelog and variable naming for PATCH 1~2.
- PATCH3 adds per-cpu counter to avoid performance regression
  in concurrent __slab_free().

[Testing]
On my 32-cpu 2-socket physical machine:
Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
perf stat --null --repeat 10 -- hackbench 20 thread 20000

== original, no patched
      19.211637055 seconds time elapsed                                          ( +-  0.57% )

== patched with patch1~2
 Performance counter stats for 'hackbench 20 thread 20000' (10 runs):

      21.731833146 seconds time elapsed                                          ( +-  0.17% )

== patched with patch1~3
 Performance counter stats for 'hackbench 20 thread 20000' (10 runs):

      19.112106847 seconds time elapsed                                          ( +-  0.64% )


Xunlei Pang (3):
  mm/slub: Introduce two counters for partial objects
  mm/slub: Get rid of count_partial()
  mm/slub: Use percpu partial free counter

 mm/slab.h |   2 +
 mm/slub.c | 124 +++++++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 89 insertions(+), 37 deletions(-)

-- 
1.8.3.1

