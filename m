Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18AC29E46D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgJ2HYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgJ2HYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F5DC08EAC1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x23so877966plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=l+4yrvm04pvaGM8x9mUWzu4YkEJ8S6Hljp9KCCoum80/kUfzNgDK6NoEPHa0iV7ftM
         F8jXFE7jhFUugZhvLliy3+/u+GR2L6G8HrzMlT5bhRsaJapElGz0Ie5MtypihxcIDDMf
         b70igM+ALm4Jq2LSnXE7hJX6L1XPvdwTrEAJyiWZ0BUBPV7drNGiK9e+HxkKxCoQlOW+
         0C510c3nvZv8n+181rpAcnk7yfkY8WBGFs+fGUhJbzLcvZEirx4b9N5d4IqNwZs9N5X9
         8x1p/iDICQRkHe4i4/ZRKMg7UOLPe270BCcAPDyi7emc/MySnE2qTCRgrEa0WYdaYs0G
         Be0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=bWCuNOP4zL2apVKNXM4qucH8pG5hfDCSqxn9miZ//DwPoWeESbWBiel+pcq6P404n4
         9dleNwf39+c8CaagN0BQ3mmqzh/Wfby1AqHyFsWV3FzG617vn+kat4dzoY9PssaTN/Ek
         du4+UVMq+vMdN5ops13GQCwCYgkbZgYLjfEoCvKOGo8T77HwmNItEaa2DVFx73Eocrjo
         i0QKvZ7kfrwYbj4ozpNV5EhXXBOH+LbUjGcx8fj8gwH0hDre+cPWsYf6XKEd6sZOG48t
         9vxmy8oji5DEP+xY+6d6f2geHnDkoAxlP3wOLQ5pyk20TzaAjZsWtU7KRjVmAPCnL9M7
         b+hA==
X-Gm-Message-State: AOAM533wDgAltTaT6p2mmDbW8EemWGK+lD99MswqdcXcCzyHqEixukRu
        So8BMtH9fYttjNVUCK3/Rc5vmg==
X-Google-Smtp-Source: ABdhPJyGu+ZvdtheJrELycd1JpLVfcWrMiWAHWhkVAjsu7J/59YpTq84mJkXKPzewCnepf4jpz2NHg==
X-Received: by 2002:a17:902:e983:b029:d5:f465:55d5 with SMTP id f3-20020a170902e983b02900d5f46555d5mr2814437plb.60.1603955984370;
        Thu, 29 Oct 2020 00:19:44 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id q5sm1728573pjj.26.2020.10.29.00.19.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:19:43 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 01/21] perf arm-spe: Include bitops.h for BIT() macro
Date:   Thu, 29 Oct 2020 15:19:07 +0800
Message-Id: <20201029071927.9308-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include header linux/bitops.h, directly use its BIT() macro and remove
the self defined macros.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c     | 5 +----
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 93e063f22be5..cc18a1e8c212 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -12,6 +12,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
 
@@ -21,10 +22,6 @@
 
 #include "arm-spe-decoder.h"
 
-#ifndef BIT
-#define BIT(n)		(1UL << (n))
-#endif
-
 static u64 arm_spe_calc_ip(int index, u64 payload)
 {
 	u8 *addr = (u8 *)&payload;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b94001b756c7..46ddb53a6457 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -8,11 +8,10 @@
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <linux/bitops.h>
 
 #include "arm-spe-pkt-decoder.h"
 
-#define BIT(n)		(1ULL << (n))
-
 #define NS_FLAG		BIT(63)
 #define EL_FLAG		(BIT(62) | BIT(61))
 
-- 
2.17.1

