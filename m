Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2D12E88C7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhABWFq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:05:46 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:52247 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726731AbhABWFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:05:45 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-u_PNsaqoNvWBPvPtypIr2Q-1; Sat, 02 Jan 2021 17:04:51 -0500
X-MC-Unique: u_PNsaqoNvWBPvPtypIr2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B63AA59;
        Sat,  2 Jan 2021 22:04:48 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DE4A19727;
        Sat,  2 Jan 2021 22:04:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 01/22] perf tools: Make perf_config_from_file static
Date:   Sat,  2 Jan 2021 23:04:20 +0100
Message-Id: <20210102220441.794923-2-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-1-jolsa@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not used outside config.c object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/config.c | 2 +-
 tools/perf/util/config.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6969f82843ee..20be0504fb95 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -489,7 +489,7 @@ int perf_default_config(const char *var, const char *value,
 	return 0;
 }
 
-int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
+static int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
 	FILE *f = fopen(filename, "r");
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index 8c881e3a3ec3..2f753b2a034b 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -27,7 +27,6 @@ extern const char *config_exclusive_filename;
 
 typedef int (*config_fn_t)(const char *, const char *, void *);
 
-int perf_config_from_file(config_fn_t fn, const char *filename, void *data);
 int perf_default_config(const char *, const char *, void *);
 int perf_config(config_fn_t fn, void *);
 int perf_config_int(int *dest, const char *, const char *);
-- 
2.26.2

