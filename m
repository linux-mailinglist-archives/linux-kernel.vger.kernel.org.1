Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A267129A2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438855AbgJ0DKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38286 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438768AbgJ0DKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so19756plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=ebZZ3o3Q48p50qM4b0JF1G1LBk+HuoAHpftbSR2yJibkklmM0WyGO/QUv//XtWtvkS
         yGkS52TFo6D7FCF3yhWVof7C/pUvU71ewth7aSlwreIeKzTNjom2yEiwixFdfUulInL8
         H4guGDWf83t+ys+Y1yaLyageJVBMmYGtIk5FiQKRncULUXf6wmuAen5dim6GSnTGP3/H
         On+39Ml+BAbpIgP0QnBwh4F8IP0aAhp5r+WpJS1Jy4teBO05cvgieek/kMfGNl8/t3eF
         wOPuIvNH8e7VcIRmA/F1voWxtHgpR7m/bzGEcQzXw3Cm5p24gt2vnzWrFiI70Vm9DqkT
         zE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apqneqUKXXFA0ko61Am5+wWNWyct8BORdlCdgpMaKE0=;
        b=d3FxnjCuH+fDy/RhCXX0ZyXYpLa6gQ9UuBrr+Gc3vTgUVq+jXmXzYbRoRw5Arg6Xio
         FZcMz/iC3uQlOOzmsoTViz+jBS/AuMdmBaHK0RpK2o+5t87LTYW/ite3SeuIFeFtDG4c
         9suk1IFEbjf7ohbHslUtBiOksFE2m764LyHBonHikH3Ir4fE/N4BIQjqG59ST+GiAl+C
         8JUzng/dRHiB6g4b3VPA4d5pVDsXW67f7A40InbuK2MbsVqmaYq3zN8aj5EIAhb0FPhJ
         a/sJPNxWzdE5nZolBkavBCtmt2OvKAGbpsFJoMGLhzEXTreqWDmZ55m5Z3TCYn83QcA0
         X9pQ==
X-Gm-Message-State: AOAM533P8I580LpcmJaBc1rMs/Syf/3QldDBxhCNivGqSJJaKgqJuN6x
        /adWLkDVUSbn+270fL3VOg+eOA==
X-Google-Smtp-Source: ABdhPJz07lwpv3/q2oUhheV1gx81Rg5cblnGSZCmqgqYJTfoqv3J79JAVfYXlfOBU2hlRaGWGnxI/g==
X-Received: by 2002:a17:902:8eca:b029:d2:4276:1b2d with SMTP id x10-20020a1709028ecab02900d242761b2dmr84585plo.17.1603768209432;
        Mon, 26 Oct 2020 20:10:09 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z10sm161743pjn.27.2020.10.26.20.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 01/21] perf arm-spe: Include bitops.h for BIT() macro
Date:   Tue, 27 Oct 2020 11:08:57 +0800
Message-Id: <20201027030917.15404-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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

