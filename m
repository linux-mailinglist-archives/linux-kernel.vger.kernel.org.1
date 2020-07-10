Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2121B929
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgGJPOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 11:14:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:38267 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgGJPL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:11:59 -0400
IronPort-SDR: qXvGvUOR1+N7FQzZv56CeltwP/rnqrRw4KhTl+lt4Jyllj6NHfnywVIHTSAXOy5CW61FDwpgW9
 wDxNw/QqwKZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686258"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686258"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:11:54 -0700
IronPort-SDR: hVHkHox+nXGDWjka3glF5KsyLNePY6iKQOss3xu3l+7F9Vk3E9sTaHohtaK0gu5N1CmR8X8A/N
 5REEZawpYCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675484"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:11:53 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/12] perf auxtrace: Add missing itrace options to help text
Date:   Fri, 10 Jul 2020 18:10:56 +0300
Message-Id: <20200710151104.15137-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing itrace options o, G and L.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 142ccf7d34df..e3ce5fb03ca0 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -604,13 +604,15 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 				 struct evsel *evsel);
 
 #define ITRACE_HELP \
-"				i:	    		synthesize instructions events\n"		\
+"				i[period]:    		synthesize instructions events\n" \
 "				b:	    		synthesize branches events (branch misses for Arm SPE)\n" \
 "				c:	    		synthesize branches events (calls only)\n"	\
 "				r:	    		synthesize branches events (returns only)\n" \
 "				x:	    		synthesize transactions events\n"		\
 "				w:	    		synthesize ptwrite events\n"		\
 "				p:	    		synthesize power events\n"			\
+"				o:			synthesize other events recorded due to the use\n" \
+"							of aux-output (refer to perf record)\n"	\
 "				e:	    		synthesize error events\n"			\
 "				d:	    		create a debug log\n"			\
 "				f:	    		synthesize first level cache events\n" \
@@ -618,7 +620,9 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				t:	    		synthesize TLB events\n" \
 "				a:	    		synthesize remote access events\n" \
 "				g[len]:     		synthesize a call chain (use with i or x)\n" \
+"				G[len]:			synthesize a call chain on existing event records\n" \
 "				l[len]:     		synthesize last branch entries (use with i or x)\n" \
+"				L[len]:			synthesize last branch entries on existing event records\n" \
 "				sNUMBER:    		skip initial number of events\n"		\
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
 "				concatenate multiple options. Default is ibxwpe or cewp\n"
-- 
2.17.1

