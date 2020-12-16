Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C82DBCF3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgLPIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:47:16 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:47071 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgLPIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608108435; x=1639644435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=y54T24GyHij+L4YlC4ErOhrawn7/T9RzI2P4TOBHFCI=;
  b=pcydpHuvAyyOcFMSrhVTfpk3d3QQi5FXWiC/XovEi1dFui9NwhaDbmyD
   yTrjNiB2vZEhJpD9algePmJwRXBjJ0jgbu//mDyOZFTAKhnpOBcMz5xqw
   6bOK4gq3zTgdvLAsegAGaMI+EZAotHJeBz0TBeD4jxHZmQQ8LCZXgZlgw
   I=;
X-IronPort-AV: E=Sophos;i="5.78,424,1599523200"; 
   d="scan'208";a="96460580"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 16 Dec 2020 08:46:26 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 67F5DA1890;
        Wed, 16 Dec 2020 08:46:23 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.102) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Dec 2020 08:46:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v15.1 6/8] selftests/damon: Add 'schemes' debugfs tests
Date:   Wed, 16 Dec 2020 09:44:02 +0100
Message-ID: <20201216084404.23183-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216084404.23183-1-sjpark@amazon.com>
References: <20201216084404.23183-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.102]
X-ClientProxiedBy: EX13D22UWB003.ant.amazon.com (10.43.161.76) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds simple selftets for 'schemes' debugfs file of DAMON.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../testing/selftests/damon/debugfs_attrs.sh  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index c75557e8ba58..61fd3e5598e9 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -97,6 +97,35 @@ fi
 
 echo $ORIG_CONTENT > $file
 
+# Test schemes file
+file="$DBGFS/schemes"
+
+ORIG_CONTENT=$(cat $file)
+echo "1 2 3 4 5 6 3" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo "1 2
+3 4 5 6 3" > $file
+if [ $? -eq 0 ]
+then
+	echo "$file multi line write success (expected fail)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo > $file
+if [ $? -ne 0 ]
+then
+	echo "$file empty string writing fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
 # Test target_ids file
 file="$DBGFS/target_ids"
 
-- 
2.17.1

