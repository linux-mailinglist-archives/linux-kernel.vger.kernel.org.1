Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A61CD47C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgEKJHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 05:07:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbgEKJHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:07:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 109BF807BACE51F335EB;
        Mon, 11 May 2020 17:06:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 17:06:48 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <jiongwang@huawei.com>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] perf tools: Fix perf.data doc trivial typo
Date:   Mon, 11 May 2020 17:02:56 +0800
Message-ID: <1589187776-64126-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a trivial typo.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index b0152e1095c5..cd3c6a60b031 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -43,7 +43,7 @@ struct perf_file_section {
 
 Flags section:
 
-For each of the optional features a perf_file_section it placed after the data
+For each of the optional features a perf_file_section is placed after the data
 section if the feature bit is set in the perf_header flags bitset. The
 respective perf_file_section points to the data of the additional header and
 defines its size.
-- 
2.16.4

