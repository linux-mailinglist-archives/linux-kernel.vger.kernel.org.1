Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C112A2261
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgKAXbO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 Nov 2020 18:31:14 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:39024 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727062AbgKAXbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:31:14 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-wDTTpkwsND-Vvdlwn1gjXg-1; Sun, 01 Nov 2020 18:31:09 -0500
X-MC-Unique: wDTTpkwsND-Vvdlwn1gjXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16468107AFD1;
        Sun,  1 Nov 2020 23:31:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3018462A14;
        Sun,  1 Nov 2020 23:31:04 +0000 (UTC)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/2] perf tools: Initialize output buffer in build_id__sprintf
Date:   Mon,  2 Nov 2020 00:31:02 +0100
Message-Id: <20201101233103.3537427-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We display garbage for undefined build_id objects,
because we don't initialize the output buffer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 8763772f1095..6b410c3d52dc 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -102,6 +102,8 @@ int build_id__sprintf(const struct build_id *build_id, char *bf)
 	const u8 *raw = build_id->data;
 	size_t i;
 
+	bf[0] = 0x0;
+
 	for (i = 0; i < build_id->size; ++i) {
 		sprintf(bid, "%02x", *raw);
 		++raw;
-- 
2.26.2

