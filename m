Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69E1CF44B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgELMXW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 May 2020 08:23:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729336AbgELMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:23:20 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-nNL0z_51Ooqf9-uGLT0vjQ-1; Tue, 12 May 2020 08:23:15 -0400
X-MC-Unique: nNL0z_51Ooqf9-uGLT0vjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C76C6461;
        Tue, 12 May 2020 12:23:13 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBC657055E;
        Tue, 12 May 2020 12:23:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH perf/urgent] perf tools: Fix is_bpf_image function logic
Date:   Tue, 12 May 2020 14:23:10 +0200
Message-Id: <20200512122310.3154754-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 4
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian reported that is_bpf_image is not working the way it was
intended - passing on trampolines and dispatcher names. Instead
it returned true for all the bpf names.

The reason even this logic worked properly is that all bpf objects,
even trampolines and dispatcher, were assigned DSO_BINARY_TYPE__BPF_IMAGE
binary_type.

The later for bpf_prog objects, the binary_type was fixed in bpf load event
processing, which is executed after the ksymbol code.

Fixing the is_bpf_image logic, so it properly recognizes trampoline
and dispatcher objects.

Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8ed2135893bb..d5384807372b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -738,8 +738,8 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
 
 static int is_bpf_image(const char *name)
 {
-	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) ||
-	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1);
+	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
+	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
 }
 
 static int machine__process_ksymbol_register(struct machine *machine,
-- 
2.25.4

