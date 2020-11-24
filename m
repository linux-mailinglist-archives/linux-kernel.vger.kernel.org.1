Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334562C3182
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgKXT6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:58:34 -0500
Received: from foss.arm.com ([217.140.110.172]:52128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbgKXT6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:58:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAEB431B;
        Tue, 24 Nov 2020 11:58:33 -0800 (PST)
Received: from dsg-apd-n1sdp-01.cambridge.arm.com (dsg-apd-n1sdp-01.cambridge.arm.com [10.2.76.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265333F718;
        Tue, 24 Nov 2020 11:58:32 -0800 (PST)
From:   Al Grant <al.grant@arm.com>
To:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Al Grant <al.grant@arm.com>, Al Grant <al.grant@foss.arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf inject: correct event attribute sizes
Date:   Tue, 24 Nov 2020 19:58:17 +0000
Message-Id: <20201124195818.30603-1-al.grant@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf inject reads a perf.data file from an older version of perf,
it writes event attributes into the output with the original size field,
but lays them out as if they had the size currently used. Readers see
a corrupt file. Update the size field to match the layout.

Signed-off-by: Al Grant <al.grant@foss.arm.com>
---
 tools/perf/util/header.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index be850e9f8852..0d95981df8dd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3331,6 +3331,14 @@ int perf_session__write_header(struct perf_session *session,
 	attr_offset = lseek(ff.fd, 0, SEEK_CUR);
 
 	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
+			/*
+			 * We are likely in "perf inject" and have read
+			 * from an older file. Update attr size so that
+			 * reader gets the right offset to the ids.
+			 */
+			evsel->core.attr.size = sizeof(evsel->core.attr);
+		}
 		f_attr = (struct perf_file_attr){
 			.attr = evsel->core.attr,
 			.ids  = {
-- 
2.17.1

