Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1171C7458
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgEFPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729614AbgEFPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:22:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74AAE20CC7;
        Wed,  6 May 2020 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778577;
        bh=KPtPuwMrowCZsSzUJwgI6G9tX8MZ+9l+rfTrqJRVdfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bu7UAlBYKJ5l/o6QFSTybyeXGgC2Umnuv11cCQbxVYVpqPlrYkM/ZgqA0Znz0QQlq
         5OdxtcSqATQKAw8xN3rR20l0a5P2+YXiQ3cNsVob5IVSYqHi11YnuiJQ3N3VcXai5y
         MgOfdGkBdo3yD3AOjikgvhyeJPLV0cGgOsTa5lJQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/91] perf script: Avoid NULL dereference on symbol
Date:   Wed,  6 May 2020 12:21:07 -0300
Message-Id: <20200506152234.21977-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

al->sym may be NULL given current if conditions and may cause a segv.

Fixes: d2bedb7863e9 ("perf script: Allow --symbol to accept hexadecimal addresses")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200421004329.43109-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index dc0e11214ae1..f581550a3015 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -626,7 +626,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			ret = strlist__has_entry(symbol_conf.sym_list,
 						al->sym->name);
 		}
-		if (!(ret && al->sym)) {
+		if (!ret && al->sym) {
 			snprintf(al_addr_str, sz, "0x%"PRIx64,
 				al->map->unmap_ip(al->map, al->sym->start));
 			ret = strlist__has_entry(symbol_conf.sym_list,
-- 
2.21.1

