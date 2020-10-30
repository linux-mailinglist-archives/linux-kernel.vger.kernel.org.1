Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8736329FBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgJ3C5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3C5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:57:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D512C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:57:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g12so3971852pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=XjD9L5KD6dG48jTmnj8OjpWyzZwf9c5RK3523rtktpbqXCA8hCrXYFeEAFe99B1+4f
         oynH65QRUOEvgcnGfXn7JtoDB92UXKzNTl6Fj39Zxbj1XjKUt2D9inKKGVf6NfmpIfWu
         sLglMtfEH/G7ORSgb/bi6bkzW1ZQ1aQk6JSFvLxMise2R4Yhx32h9OaiMOxATt8NVXtg
         yLqz+zO3UIO2bfm8Vk+BrH7smzOpZ8P5MkGSlKOdrRsqNAl0jce3FwLHwVEeQkAywjT+
         086zCjoXUA7PUtJWn/v4mOnSGmp1WbojAnrPw4RE9HJSmawI3g8PTOr19z/RBtEMTSnC
         IchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=sb5CIeaiDlqVdz6xvd+aZmwN0FN8X5j67s03+8qNDzSTCPXwd97Vwa6F+RQoMavRaO
         FXBDnsbI2iuGUnhv6Y4IeO0M7DBFAta7HNmP+uXAKzVOEjExNolthtOQwltUVDv8u5+1
         81mkQhwVIHnReen82iIJL+s1yVGieyCaSOVDb4ezmkkOe71qyRHRnZcCgCnNhihFhNpC
         8sWqec21N8mMjWO3Jp7GSGGtpCVNYcd7dVaWlZns/CbEX86ORp3MwHx9B24XXLHMerJ+
         k8F1QMyRyCIdDB8bPJd2E3ErrBUAGxstkRfZLsdnJWNagMA5mPrXcJfYNqGcpxHqNGsy
         WuBA==
X-Gm-Message-State: AOAM532ddi3jukeVbe1BPmlGrlXSDZ6DkSA1qGTOfg9TgFDrqHjikK9t
        oAsHzAZtL37mHSvxrwQtQnAmTg==
X-Google-Smtp-Source: ABdhPJwLuOxuF5b04Aqtddoe9YpyHxJBPpyzeWeJLsK/Z8PUasTzR14rm4UDBm+nyYaaexI3zi4vsA==
X-Received: by 2002:a17:90b:4189:: with SMTP id hh9mr191337pjb.199.1604026668174;
        Thu, 29 Oct 2020 19:57:48 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l129sm3932665pgl.3.2020.10.29.19.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:57:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 01/21] perf arm-spe: Include bitops.h for BIT() macro
Date:   Fri, 30 Oct 2020 10:57:04 +0800
Message-Id: <20201030025724.19157-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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

