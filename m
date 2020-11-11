Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8522A2AE9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKKHWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgKKHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:25 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3199C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:23 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id f21so513072plr.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=sXdfpEYqCQ3hU1qWNUD8NBph7n4c/GTNllh7qtX4/lBy3+JqY1czZ2KwX88uzT0uEr
         Yw29v5OIAQuGvD4ARGkoX7FoQXRENUz8+X9aN8nHKHuzJRHCGie3xmtDY8i6/bKsC3rM
         9vCRNmXAKV/iHawOpi71BV9Tdodhn4sQOFWIHxZvNj0kDAcoSJZXdd2ZwxugCmouI7gF
         bniNbant1qT4OFl83fbNLSpmx0KJ+dPePbFanxXk6tDyP7q/P08LuDdiG3KMnPzCT3KI
         keoC45N8H0ab2AGLxZBLAkSxOSsUrzfY0/bZ++cvfoNXs7n/B5m7bIZydkkg0VB9nkfg
         c8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=saiXB+ZcL5wT99SUPAf6unSu4+HmCPNhC6SnoykfZUZ62h+alItkgcAjtdCksAYcLx
         RQBVTmyFo1QfstrJRHjwbV/D5GFB6vBtyqr3yqiPZSVqsBghQkAdIxA47k87ubQ6j/6q
         o4mLBAJD36cPX6FnkoQWK2LEmd1HSIHmK8bf8dpWndrzm1DZgOHRYEYLFclxqU7oALxv
         AIC3ItWZC6bSMZhCqH2YsEFFXQtpDKuyttF/vj888jGtmo3XCN0hEp0VwOZedp1uo62T
         ABNMarwFp+Tk+ybl0SDdtH2Kce67WQH87SH7fVZwdLJvNHjsqVEImHIgP5F0NqhoROY4
         pUjQ==
X-Gm-Message-State: AOAM531XTCyTv8v9XkxLK4XoEGZeZECVfeSkKfeE3CGjc+S+09+V2INx
        ExLfGrGx+9pSCWEPX8PTXQDsMg==
X-Google-Smtp-Source: ABdhPJzy+pbE5Kq1pMClO0vuUHcc1k0jsy2LzCIrXUeGFa8I9Oy0cMw7F7uIwVOPlG5ZCylJO2CQMw==
X-Received: by 2002:a17:90a:6487:: with SMTP id h7mr2530637pjj.28.1605078743546;
        Tue, 10 Nov 2020 23:12:23 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id d9sm1292141pfn.191.2020.11.10.23.12.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:23 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 01/22] perf arm-spe: Include bitops.h for BIT() macro
Date:   Wed, 11 Nov 2020 15:11:28 +0800
Message-Id: <20201111071149.815-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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

