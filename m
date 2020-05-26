Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D61B086F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgDTL4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 07:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgDTL4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC8E20724;
        Mon, 20 Apr 2020 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383781;
        bh=irZ+OOlmNaliH/5qXRCwQzny4eYI1NGTZ269pIljA7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFWdIZjd958hIjt09mcLts76g01lUfbFQVPWLXK2U5oKAmAtcCGwdRGoZWAi7kX6+
         6wu9RYzpxyyJs61OXNT0M+WShk06bttrR555SY+wwohspAGRfupVL6e1BrezO8VoAO
         u5/1dGF4SP60BzoBzx53xn4knqeRxXLv6ZXsRtak=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/60] perf evlist: Allow multiple read formats
Date:   Mon, 20 Apr 2020 08:52:56 -0300
Message-Id: <20200420115316.18781-41-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Tools find the correct evsel, and therefore read format, using the event
ID, so it isn't necessary for all read formats to be the same. In the
case of leader-sampling of AUX area events, dummy tracking events will
have a different read format, so relax the validation to become a debug
message only.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1548237b6558..82d9f9bb8975 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1131,8 +1131,10 @@ bool perf_evlist__valid_read_format(struct evlist *evlist)
 	u64 sample_type = first->core.attr.sample_type;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (read_format != pos->core.attr.read_format)
-			return false;
+		if (read_format != pos->core.attr.read_format) {
+			pr_debug("Read format differs %#" PRIx64 " vs %#" PRIx64 "\n",
+				 read_format, (u64)pos->core.attr.read_format);
+		}
 	}
 
 	/* PERF_SAMPLE_READ imples PERF_FORMAT_ID. */
-- 
2.21.1

