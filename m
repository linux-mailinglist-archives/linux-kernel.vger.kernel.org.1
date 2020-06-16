Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9291FAA19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgFPHkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 03:40:11 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14448 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPHkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592293211; x=1623829211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lNFxVu5oHwO1aOURXAUvUJJi5lK2SkZMFrjh4Wym42s=;
  b=unUPdX3tiFdK36WtTu5EtzmnPD/+VuC2yyk5kuxZwpotLnVaOrJrhUR6
   9LAdZ0qBYuTL6f5LLB8EUm2coaGaNI8KV4WYKaF7LbgYXFcmyHTPVTBX3
   JS/L1nuE8FPf3zoSmuli1sxBELbIH3tpoOSwWwvgwhmpNaSH31mKtRnTX
   w=;
IronPort-SDR: pzYbNPctHnGw6iR+GwbRLdOrXezsKGARNWo+A6ajx28wgZTWrfQjSUGnXCO9bH0isGNYCiyiMZ
 MXRMl+XQ36IQ==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="51259311"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 16 Jun 2020 07:40:08 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id EC442A22FB;
        Tue, 16 Jun 2020 07:39:54 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 07:39:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.248) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 07:39:18 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v12 1/8] mm/madvise: Export do_madvise() to external GPL modules
Date:   Tue, 16 Jun 2020 09:38:21 +0200
Message-ID: <20200616073828.16509-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616073828.16509-1-sjpark@amazon.com>
References: <20200616073828.16509-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.248]
X-ClientProxiedBy: EX13D22UWC004.ant.amazon.com (10.43.162.198) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit exports 'do_madvise()' to external GPL modules, so that
other modules including DAMON could use the function.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1ad7522567d4..fcd951694ebc 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1171,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 
 	return error;
 }
+EXPORT_SYMBOL_GPL(do_madvise);
 
 SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
-- 
2.17.1

