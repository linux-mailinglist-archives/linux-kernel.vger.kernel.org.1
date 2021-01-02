Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851332E88CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbhABWF7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:05:59 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:23748 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbhABWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:05:58 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-No25tMEvOBSCo439uliZvQ-1; Sat, 02 Jan 2021 17:05:04 -0500
X-MC-Unique: No25tMEvOBSCo439uliZvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38346180A08A;
        Sat,  2 Jan 2021 22:05:02 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21F501A353;
        Sat,  2 Jan 2021 22:04:58 +0000 (UTC)
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
Subject: [PATCH 05/22] perf tools: Make perf_config_system global
Date:   Sat,  2 Jan 2021 23:04:24 +0100
Message-Id: <20210102220441.794923-6-jolsa@kernel.org>
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

Making perf_config_system global, it will be used
outside the config.c object in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/config.c | 2 +-
 tools/perf/util/config.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 34fe80ccdad1..4e0455a6bb5f 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -521,7 +521,7 @@ static int perf_env_bool(const char *k, int def)
 	return v ? perf_config_bool(k, v) : def;
 }
 
-static int perf_config_system(void)
+int perf_config_system(void)
 {
 	return !perf_env_bool("PERF_CONFIG_NOSYSTEM", 0);
 }
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index d6c4f80f367c..bf68e4acea73 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -38,6 +38,7 @@ int perf_config_bool(const char *, const char *);
 int config_error_nonbool(const char *);
 const char *perf_etc_perfconfig(void);
 const char *perf_home_perfconfig(void);
+int perf_config_system(void);
 
 struct perf_config_set *perf_config_set__new(void);
 struct perf_config_set *perf_config_set__load_file(const char *file);
-- 
2.26.2

