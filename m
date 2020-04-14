Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28D1A85E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440667AbgDNQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440403AbgDNQtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E612085B;
        Tue, 14 Apr 2020 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882959;
        bh=/HLIzKDPShz5RaDjsvp0+ObKOoCgb0n4Y+Ygpd+4qOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+deYr2vjnl3GJp9SEW0MiOhOm6KH7epX3MNvdNjyAdPAes90aO5j3TogOYg/mLsr
         WwPj4Sy6QXhSzSDi393M8k6CNBkKXfi8BI3X4HYVwrWv7JFvk9qHSOjgJ90FS4G5Kt
         i446vmsrlVkAfy85q02YZe2DzyOxySKcwX8Sgk0w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Geffon <bgeffon@google.com>
Subject: [PATCH 06/15] tools headers UAPI: Sync linux/mman.h with the kernel
Date:   Tue, 14 Apr 2020 13:48:45 -0300
Message-Id: <20200414164854.26026-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")

Add that to 'perf trace's mremap 'flags' decoder.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from latest version at 'include/uapi/linux/mman.h'
  diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/mman.h | 5 +++--
 tools/perf/trace/beauty/mmap.c  | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index fc1a64c3447b..923cc162609c 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -5,8 +5,9 @@
 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
 
-#define MREMAP_MAYMOVE	1
-#define MREMAP_FIXED	2
+#define MREMAP_MAYMOVE		1
+#define MREMAP_FIXED		2
+#define MREMAP_DONTUNMAP	4
 
 #define OVERCOMMIT_GUESS		0
 #define OVERCOMMIT_ALWAYS		1
diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 9fa771a90d79..862c8331dded 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -69,6 +69,7 @@ static size_t syscall_arg__scnprintf_mremap_flags(char *bf, size_t size,
 
 	P_MREMAP_FLAG(MAYMOVE);
 	P_MREMAP_FLAG(FIXED);
+	P_MREMAP_FLAG(DONTUNMAP);
 #undef P_MREMAP_FLAG
 
 	if (flags)
-- 
2.21.1

