Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9E296146
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368348AbgJVO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368318AbgJVO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77564C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t9so2809844wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=jIycW9CcdbMdCd49Idf2yIKsDVxNGKK9um3DoBJbvmsNOW5fiYB/jtfaRVOblyM5Ek
         Z/PlxKuUYhvDPGsAHi922SLTkDjDKk8+2wG/T3R+7JdOMkYwOrle7CHPnmvwXV7afntz
         7RSZWHETpbp3lYeM3r9qIUSun0HNIC4pG2SZvEWK4I5kQL2ymFlIWWuCNfcRVKlHLCBx
         tQN9+WuVxGJMjuGJnep+n9eoldhbBsDwn5nl4HZ0yd3HV+cucUj4381T2I+EK9TeN0eK
         5Ev0+GcsiN0901zjIM4VHIIHYJehYyprxFsOzlHIr+flfvDsCf/sJUxwOx0qWuVeYA6y
         fXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=eXr9zM2usliiTPyBFKTEmVDT+mEcgts05jCZlnTbwc7JydgMfrg/TUG4KiyGKgiZqD
         ZRalDGPTxpWxExsycCBLZHsRRWBSeNKt3h6/Qxvxgs+nMiXeTFvi4cR1nsWjLyiUhs4O
         zbu/Ze+Xor1aDXSUEZBhOcutADFjTLc+UuTvh+ugIXnJGA6VMjg2HhQqFxEerzv1jS5b
         zGSMwZpRVrMPMrfGSH8XAg1bf8pm3/Y5dgEwomVoZLNjRDbki5x1mVHvXxJrNvjB1SPo
         fJnUa1fQ9xD9fgQmlIDAjsARbXPem+HIKXfwauHlIMe5RzoCzpotABnq6nuKTZk43fAx
         9G3Q==
X-Gm-Message-State: AOAM533+mEZW0lHnc2/mHc4OaAzijn8Rp5rocfxKNhKtdQcy76Vczezn
        zhW6FC7VCpzw1W/CgnTM5MJfhA==
X-Google-Smtp-Source: ABdhPJxDrX4xcpG72zo2N732FaOMfYvGrQXnyZdQimrwh6DLiz7MD68KWs8QrLOpxzROoJcM0UbgJg==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr3113813wrv.414.1603378711147;
        Thu, 22 Oct 2020 07:58:31 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:30 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 01/20] perf arm-spe: Include bitops.h for BIT() macro
Date:   Thu, 22 Oct 2020 15:57:57 +0100
Message-Id: <20201022145816.14069-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
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

