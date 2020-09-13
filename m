Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70946268155
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgIMVFo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:05:44 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:37675 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbgIMVFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:05 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-U6y8yudRMgKyQqaI_rSoJw-1; Sun, 13 Sep 2020 17:04:58 -0400
X-MC-Unique: U6y8yudRMgKyQqaI_rSoJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00215802B70;
        Sun, 13 Sep 2020 21:04:56 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88C181002388;
        Sun, 13 Sep 2020 21:04:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 21/26] perf tools: Add machine__for_each_dso function
Date:   Sun, 13 Sep 2020 23:03:08 +0200
Message-Id: <20200913210313.1985612-22-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-1-jolsa@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding machine__for_each_dso to iterate over all dso
objects defined for the within the machine. It will
be used in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 12 ++++++++++++
 tools/perf/util/machine.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 863d949ef967..f8e8d0d80847 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3181,3 +3181,15 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 	*addrp = map->unmap_ip(map, sym->start);
 	return sym->name;
 }
+
+int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv)
+{
+	struct dso *pos;
+	int err = 0;
+
+	list_for_each_entry(pos, &machine->dsos.head, node) {
+		if (fn(pos, machine, priv))
+			err = -1;
+	}
+	return err;
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index a3c1d0bf89e5..504c707f22bb 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -252,6 +252,10 @@ void machines__destroy_kernel_maps(struct machines *machines);
 
 size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp);
 
+typedef int (*machine__dso_t)(struct dso *dso, struct machine *machine, void *priv);
+
+int machine__for_each_dso(struct machine *machine, machine__dso_t fn,
+			  void *priv);
 int machine__for_each_thread(struct machine *machine,
 			     int (*fn)(struct thread *thread, void *p),
 			     void *priv);
-- 
2.26.2

