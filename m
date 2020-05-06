Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AED1C7465
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgEFPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbgEFPXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F7C20A8B;
        Wed,  6 May 2020 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778622;
        bh=zjR9zuK34XLqz4BV749hIa2qmbnD2kRDLR0jIJwrMXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=movwefnQElU9GrK3JAPsUalfSkTReG0rkZ9tKF3MpFugVa4HY9scCVoIfGUV6jedo
         MP6J/xtXK4ZyXwUUk4AofdY+ICXsYR9Zeq5oZh0LFKR/AMok6oLFwJ6Kl0mRoOTzM2
         VyCOo8wis9luJyKtskAtBAxWVJf7saxTI/VCu9GU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/91] perf report: Fix warning assignment of 0/1 to bool variable
Date:   Wed,  6 May 2020 12:21:19 -0300
Message-Id: <20200506152234.21977-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

Fixes coccicheck warning:

  tools/perf/builtin-report.c:1403:2-34: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1587904683-3510-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0c32767b1c56..7da1342a1f4e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1413,7 +1413,7 @@ int cmd_report(int argc, const char **argv)
 	}
 	if (branch_call_mode) {
 		callchain_param.key = CCKEY_ADDRESS;
-		callchain_param.branch_callstack = 1;
+		callchain_param.branch_callstack = true;
 		symbol_conf.use_callchain = true;
 		callchain_register_param(&callchain_param);
 		if (sort_order == NULL)
-- 
2.21.1

