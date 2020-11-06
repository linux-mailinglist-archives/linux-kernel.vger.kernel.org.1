Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A492A8C2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbgKFBmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbgKFBmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:42:05 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E255CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:42:03 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so1680805plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=c79b9oN/WNGezaFCQs252hXWKLOCETdkPFR641WPu6PUCPRegRZ9rVd4rhAVakzaKx
         GFG/htKYcWs4B7UgXLlijBYtlGtvn2rKkrfYiiVn+0X9nhu59e6lI8NCXWUevXwnnQyj
         z4Lj17JkI0NTuPCMugfPzQNXigegqX6AkGxcT4B/57OqYIa1m+uZI4sSzvcHX6LkYtdV
         blszRRrSy48hpYZACa713dfOn/pv+qzT+ZYMuoHGCbl1E4UWHGJFOoXJDpb9AqzNndUs
         nMGp5+qyHRZAkCTzgGi34ciSywV6McMfGSOYBTsUXSR1MwfDcVvEbR9dnI38kAdPq59f
         3GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=CO/BxYnB8boWSzTFx95D+JYjdaPV2YIUsV3Qsn7uwMDV3F+yN35hCuh+WsrCZ3QStm
         2MOvV+7JCEx624lcoTjyRaaw9t+hZDiLT6AhCJJFMhmp+kxEggtCXKyL34N8SwH9RCf9
         WbCIP4ZTMewWe40Ud8FwbTFaoIv0dAsywXMiWbYw/RjnZrvjWQwo7HoN5P9pDt16YUs3
         oPQaPyhrue8way2Je85ZoaBAaL/cM+9bP9adRqAcGIoTAB8Fqyg0ormELraNaPj+g73e
         VW9b/DLkLCJmmzeGWnjEzY/Xkul6oRT2as+YISLJtgRID/Av6mmuCzNHCxIuAn14sjx6
         C9lA==
X-Gm-Message-State: AOAM531+6aV9oV54JmikmsUIMtP8r83Bhh32unXOmO6jswd54YK9vEm8
        /FrNEqo2p8sOdpywfVaHJIZmUA==
X-Google-Smtp-Source: ABdhPJzlIpHGRY4zgQAcPC7xI0ChupFmpt5idkI520AlOKgn+a9/4dQibttH1gThaxAC1byd87qvLw==
X-Received: by 2002:a17:902:8e8b:b029:d2:4276:1df0 with SMTP id bg11-20020a1709028e8bb02900d242761df0mr4715339plb.62.1604626923479;
        Thu, 05 Nov 2020 17:42:03 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id z11sm4190094pfk.52.2020.11.05.17.42.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:42:02 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 01/22] perf arm-spe: Include bitops.h for BIT() macro
Date:   Fri,  6 Nov 2020 09:41:15 +0800
Message-Id: <20201106014136.14103-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
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

