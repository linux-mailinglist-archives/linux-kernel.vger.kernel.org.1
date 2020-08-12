Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A35242599
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 08:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHLGq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 02:46:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42690 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLGq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 02:46:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k5kX9-00023x-Ed; Wed, 12 Aug 2020 06:46:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf bench: fix a couple of spelling mistakes in options text
Date:   Wed, 12 Aug 2020 07:46:47 +0100
Message-Id: <20200812064647.200132-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes in the text. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/bench/find-bit-bench.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index fa90f3e9d368..73b5bcc5946a 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -17,9 +17,9 @@ static unsigned int inner_iterations = 100000;
 
 static const struct option options[] = {
 	OPT_UINTEGER('i', "outer-iterations", &outer_iterations,
-		"Number of outerer iterations used"),
+		"Number of outer iterations used"),
 	OPT_UINTEGER('j', "inner-iterations", &inner_iterations,
-		"Number of outerer iterations used"),
+		"Number of inner iterations used"),
 	OPT_END()
 };
 
-- 
2.27.0

