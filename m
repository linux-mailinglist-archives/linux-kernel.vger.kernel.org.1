Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC092F57D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbhANCIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:08:55 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:42760 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbhANCGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:53 -0500
Received: by mail-ot1-f50.google.com with SMTP id x5so3876812otp.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjdlDe1r8PWcI8CJTWfGrTFm/qYeuvm3S8MlLSmS6yU=;
        b=ftwPuy6DZ4mgJ6javl+RaXRtZuKVwYwqaeCj9+9iW56Eedbrm6GCUYDlVrED5N4msg
         0prCs/z4O/toNTi5pNyN5UBsq1JDbLy69L8hLNVSxeCLn8KvhpmZ7Rj0bkUaNxlKPikM
         KSxPRSBswOuMhMjWJWvCj/4n1LviX02qPtncfivZqxiJw72YhAvnZbBqgRKLOi/waBqp
         KrUi9Cbe3u1F++xicaS69WAHH/F1KFqhJc/I+MaUCP+PGehPrMiA+4VnMNMzcdBIA2Eq
         cS6fD0geGZDJ7J2A6HuUEEXpLkyCbW+jZL+vLrtNsrc5Z5jcRyzExs9a7A9rR/afXVZg
         cuCA==
X-Gm-Message-State: AOAM5330FICmGSYq1E1Bgwanp6Mbda70IP7PQUYaIsBUlLLiFocn5zVU
        Hj28gw1dxo2c5NMy/ibVvg==
X-Google-Smtp-Source: ABdhPJwQpwEW4ekRbw2RIkUs4KFaLnTel80fWDSmHIbhxUS8lcWM4UYb0B7qo8yEkwz0iyCcFotU9Q==
X-Received: by 2002:a9d:749a:: with SMTP id t26mr3119716otk.277.1610589972628;
        Wed, 13 Jan 2021 18:06:12 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x20sm814272oov.33.2021.01.13.18.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:06:11 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v5 3/9] tools/include: Add an initial math64.h
Date:   Wed, 13 Jan 2021 20:05:59 -0600
Message-Id: <20210114020605.3943992-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114020605.3943992-1-robh@kernel.org>
References: <20210114020605.3943992-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.27.0

