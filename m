Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D992D0589
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 15:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLFOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 09:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLFOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 09:46:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA24C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 06:45:40 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2so3381058pfq.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 06:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SgrteoBjIXT5D4oog+tLO0lptvXOH+8Koop0iBKuuxo=;
        b=s0JvZIEO2/DWbBrS5Oo04bq7AWes0nVmt/2God9p9lt945/3IWynniwYrRoK9/LGst
         xUPgifa1zGcZQlXf8qfRnxRqFjfMyuLRYoFZaeGLhT9PYKbZ1wukM8Scb1wKv6Fk8GBw
         GVUX07dnFFcazqkpEv8kHHbvnkY7MkJcSVd2ZyenlUuDvnDgDTcNnNGjLAbJYRubMBte
         0z+GUTyvF+UeG3mS9wF0K6k6B3tEX6mjoGLCWfh6naBAd4IHHVJ84vo6yTpgA58CWKAZ
         YrMFPpLgnJgYM+CEidoBbRmS8dZSzOw4rMprUhjxhbD8gvm8fnBcVH21PL6ky5l7/S2F
         nacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SgrteoBjIXT5D4oog+tLO0lptvXOH+8Koop0iBKuuxo=;
        b=h1h6AaddeivQO43Aklg06UlXoXoETmvDiN7bbGmKRbvrkjuOst3DZCKrmxKj6BOHwV
         1s+1cXGjdTmmrQtBnXoXmfj0o7pTuNzsspAlOvYmYnMWu6om8xH7q0YdItcg36pDdV9k
         u5CIOsmz95XZPdKaHwjTLCElRNXe1mJHLBlyuemeiD36DpUtEvfW1qN6Ob7WJuM0qIpx
         d9PG8yucqQIF8C33ugLr/IusNpKm5tpkWIOHnaHsXEim+mLuHd06M64QCrG0rMPBQz6u
         WXJt1NFI8jbOJ2Y+32uGvULVc4ImyklEfC0B4Z9jyfiildY8X+z1/FcMorVeEQxQFoam
         FeQw==
X-Gm-Message-State: AOAM532NjQ9s6OXuzLWsK3ms5KA480qP5Qxv/5xR4X1bqsZowHVTbkdX
        9q4XFi3xmLYUaQ+01wx1X0o=
X-Google-Smtp-Source: ABdhPJyEhsgZDdwV4IGYekjuVR/D60yJpp9xj33aYDUtJXLzUcmGCODnYjl7Ii0KERWwd7iBMW1Alw==
X-Received: by 2002:a65:6a16:: with SMTP id m22mr15098298pgu.175.1607265940244;
        Sun, 06 Dec 2020 06:45:40 -0800 (PST)
Received: from localhost ([221.153.153.187])
        by smtp.gmail.com with ESMTPSA id o198sm10932531pfg.102.2020.12.06.06.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 06:45:39 -0800 (PST)
From:   Chanho Park <parkch98@gmail.com>
X-Google-Original-From: Chanho Park <chanho61.park@samsung.com>
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] perf arm pmu: fix build error on MUSL libc
Date:   Sun,  6 Dec 2020 23:45:27 +0900
Message-Id: <20201206144527.1670483-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__always_inline can cause build error on musl libc. The fix patch has
submitted but not merged yet[1]. To build perf tool with musl libc,
<linux/stddef.h> inclusion is necessary and it should be included before
perf_event.h.

from /usr/include/linux/byteorder/little_endian.h:13,
from /usr/include/asm/byteorder.h:23,
from tools/include/uapi/linux/perf_event.h:20,
from arch/arm64/util/../../arm/util/pmu.c:9:

/usr/include/linux/swab.h:171:8: error: unknown type name '__always_inline'
  171 | static __always_inline __u16 __swab16p(const __u16 *p)
      |        ^~~~~~~~~~~~~~~

[1]: https://lkml.org/lkml/2018/9/13/78
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 tools/perf/arch/arm/util/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index bbc297a7e2e3..4c0357e8c0ab 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -6,6 +6,9 @@
 
 #include <string.h>
 #include <linux/coresight-pmu.h>
+#if !defined(__GLIBC__)
+#include <linux/stddef.h>
+#endif
 #include <linux/perf_event.h>
 #include <linux/string.h>
 
-- 
2.23.0

