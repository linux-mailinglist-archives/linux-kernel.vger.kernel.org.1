Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49EC266A53
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgIKVwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:52:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32909 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgIKVv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:51:29 -0400
Received: by mail-io1-f68.google.com with SMTP id r25so12711054ioj.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUUj1yA5C8gIyhmtCGBnAf4j9JtfhjGcWKZGvC9mD28=;
        b=Mz02Idu9ezuC6AildO42SVHY02NRH68qFo1TWwOx+5yU5doGvkJuKK5S/vPy68ZROf
         s5pfP8ZgbEclTz5oaBDgISEWwOaZQj99CtEbV0pCySF5JG+UB+2/y+qZrxiqZghR5Ruk
         iC6Ka2QO55zXuYoBKCHn8NpmRp2buIm7CVNR2+P/eSAHn8Gj0HFH3RPFyZwKg158UQNz
         2I9IcezeBhTMB7BYSNqVRjew6MjMbLRlgVRp8irAUIlEM9X94UY1kHkbqjeH+E3U+LCH
         hVEnVrTylIyZ0FNHGtqtNxn6PAXZ+UVElkEY7DBW2UAeBWoQIcrEgu8h09NAG18oX/9r
         U42g==
X-Gm-Message-State: AOAM533p4GWLwfOkNJrnMzom/rDOoi/NGW8NCwmHIPDfBFppPBVFF9jU
        r7bN8rJzXhnX+TAW+KXoPA==
X-Google-Smtp-Source: ABdhPJx7DKaHLDj9Hlp1rbhOIcjYpaUy+dpBE1m+gw8Ux+APxrX75i0BhdUAVB/ATjAoyp+cEZKKjg==
X-Received: by 2002:a5e:c70b:: with SMTP id f11mr3517630iop.140.1599861086588;
        Fri, 11 Sep 2020 14:51:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id a20sm1927966ilq.57.2020.09.11.14.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:51:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v3 04/10] tools/include: Add an initial math64.h
Date:   Fri, 11 Sep 2020 15:51:12 -0600
Message-Id: <20200911215118.2887710-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911215118.2887710-1-robh@kernel.org>
References: <20200911215118.2887710-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an initial math64.h similar to linux/math64.h with functions
mul_u64_u64_div64() and mul_u64_u32_shr(). This isn't a direct copy of
include/linux/math64.h as that doesn't define mul_u64_u64_div64().

Implementation was written by Peter Zilkstra based on linux/math64.h
and div64.h[1]. The original implementation was not optimal on arm64 as
__int128 division is not optimal with a call out to __udivti3, so I
dropped the __int128 variant of mul_u64_u64_div64().

[1] https://lore.kernel.org/lkml/20200322101848.GF2452@worktop.programming.kicks-ass.net/

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/include/linux/math64.h | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 tools/include/linux/math64.h

diff --git a/tools/include/linux/math64.h b/tools/include/linux/math64.h
new file mode 100644
index 000000000000..4ad45d5943dc
--- /dev/null
+++ b/tools/include/linux/math64.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MATH64_H
+#define _LINUX_MATH64_H
+
+#include <linux/types.h>
+
+#ifdef __x86_64__
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	u64 q;
+
+	asm ("mulq %2; divq %3" : "=a" (q)
+				: "a" (a), "rm" (b), "rm" (c)
+				: "rdx");
+
+	return q;
+}
+#define mul_u64_u64_div64 mul_u64_u64_div64
+#endif
+
+#ifdef __SIZEOF_INT128__
+static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
+{
+	return (u64)(((unsigned __int128)a * b) >> shift);
+}
+
+#else
+
+#ifdef __i386__
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	u32 high, low;
+
+	asm ("mull %[b]" : "=a" (low), "=d" (high)
+			 : [a] "a" (a), [b] "rm" (b) );
+
+	return low | ((u64)high) << 32;
+}
+#else
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	return (u64)a * b;
+}
+#endif
+
+static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
+{
+	u32 ah, al;
+	u64 ret;
+
+	al = a;
+	ah = a >> 32;
+
+	ret = mul_u32_u32(al, b) >> shift;
+	if (ah)
+		ret += mul_u32_u32(ah, b) << (32 - shift);
+
+	return ret;
+}
+
+#endif	/* __SIZEOF_INT128__ */
+
+#ifndef mul_u64_u64_div64
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	u64 quot, rem;
+
+	quot = a / c;
+	rem = a % c;
+
+	return quot * b + (rem * b) / c;
+}
+#endif
+
+#endif /* _LINUX_MATH64_H */
-- 
2.25.1

