Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A649421B5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGJNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 09:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgGJNLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:11:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C012085B;
        Fri, 10 Jul 2020 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594386678;
        bh=Z0rzoebkrun4QkIOjaIwhwBxcdtbv5cqIFQrPSEFu6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6NRy+c1vraxTB2bZhVCuAhf4zCMPfaFT+yxbgvyNAG9wqRx1K0UhjMQ/qhJkCkas
         R2y8m66OG3jXLdyNNUefQUxkap9siFX8R+dY1p/xeKS0KZCva/21FYQ3iKgqhp6yYk
         BHHkJKNoXCSJLukpp7OFmKmI0ALbTNOu7FVDD/gM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 2/4] perf-probe: Fix wrong variable warning when the probe point is not found
Date:   Fri, 10 Jul 2020 22:11:13 +0900
Message-Id: <159438667364.62703.2200642186798763202.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159438665389.62703.13848613271334658629.stgit@devnote2>
References: <159438665389.62703.13848613271334658629.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a wrong "variable not found" warning when the probe point is
not found in the debuginfo.
Since the debuginfo__find_probes() can return 0 even if it does not
find given probe point in the debuginfo, fill_empty_trace_arg() can
be called with tf.ntevs == 0 and it can warn a wrong warning.
To fix this, reject ntevs == 0 in fill_empty_trace_arg().

E.g. without this patch;

  # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
  Failed to find the location of the '%di' variable at this address.
   Perhaps it has been optimized out.
   Use -V with the --range option to show '%di' location range.
  Added new events:
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)

  You can now use it in all perf tools, such as:

  	perf record -e probe_libc:memcpy -aR sleep 1

With this;

  # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
  Added new events:
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)

  You can now use it in all perf tools, such as:

  	perf record -e probe_libc:memcpy -aR sleep 1


Reported-by: Andi Kleen <andi@firstfloor.org>
Fixes: cb4027308570 ("perf probe: Trace a magic number if variable is not found")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 tools/perf/util/probe-finder.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 55924255c535..9963e4e8ea20 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1408,6 +1408,9 @@ static int fill_empty_trace_arg(struct perf_probe_event *pev,
 	char *type;
 	int i, j, ret;
 
+	if (!ntevs)
+		return -ENOENT;
+
 	for (i = 0; i < pev->nargs; i++) {
 		type = NULL;
 		for (j = 0; j < ntevs; j++) {

