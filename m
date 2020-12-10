Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F92D5EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391859AbgLJOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391691AbgLJOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:51 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D4C061282
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:49:07 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so2867304plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wx4A+kVfANyKKouXibaMmrxB2TGDnv3OnnXJGb8AhZI=;
        b=AptavSWWJyt+xTeURjvBQxUdMO9yixJ4ttAjiAgYLergI0jXQWHUsRsm/i4BBwkxIR
         iGXoX4Zns9v3aY2hfLHdb2+vEzQRX2/V9iJIQmdEppUw7wYLy7QUkF4YI39sI1WwZYIM
         l5y5q/wS/6mHmy8W4/G9Ue7TcA3KsPTDtOOrY22oYwM7bxSOF847A4tDbC64+8UJTpMH
         r2nxckyudDOTYASgQDSWmRuqgT6GTz8vivn/fI3sHIlYhkBeuk6yBEtvpmFRIaOyls1i
         z2gREFCo+PKX9/MpYQdBYRuqGEb20UDg5WmJKN5VZtc0BXC9Wz03M/0onkOCzSj+braM
         Xptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wx4A+kVfANyKKouXibaMmrxB2TGDnv3OnnXJGb8AhZI=;
        b=hVRT/vuGyB7DXHlkOSXrKHFzZog6/xvoF/PbSW8Wk2w/thVd5eSNTcGLCwDnwQSKmw
         6laV+S+VR8emeEVxj+KGBb2PDck20Y3SLv/Dvr2RMq1AsZZCyZVXMS5ztTVeEw1I25j3
         OToQIjeivH0jO2U2MfQIbunpN8R/LGrWrFQmEv7YDPHletYLiWrz9Zwfv+m4xBYr+QBX
         6H308jGw1bf7uI/wVj6oXiFB7dVLNP3i4DfTB4gWCUoAPnGaJMcZxJxD3nmdZERQHBMP
         2N3Ns/j8wsbVWuqqwCeiN+BidwN7v0khlDqa9o/lksjaTfaI1xOA9Bz+UF2sS1voHCTg
         4bFg==
X-Gm-Message-State: AOAM530qAjd7d+6MoSs5zgbWabISTCUOkNkBP4r/ITgmt7Ahmt7xi9ET
        LtTH+EOeZld/pNUZLUODOwmZ8uf4Gv6A0SrS
X-Google-Smtp-Source: ABdhPJwU59QT4QY7Oq5wZOQkMp/ZjswgxTvApOzjAdGsrtnuypcLArnrETVbpPviSCJANZLpH+QSKA==
X-Received: by 2002:a17:902:694c:b029:da:afba:beab with SMTP id k12-20020a170902694cb02900daafbabeabmr6857935plt.32.1607611746619;
        Thu, 10 Dec 2020 06:49:06 -0800 (PST)
Received: from localhost ([221.153.153.187])
        by smtp.gmail.com with ESMTPSA id k21sm6320264pfu.7.2020.12.10.06.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 06:49:06 -0800 (PST)
From:   Chanho Park <parkch98@gmail.com>
X-Google-Original-From: Chanho Park <chanho61.park@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chanho Park <chanho61.park@samsung.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Subject: [PATCH 1/2] perf: fix build error on MUSL libc
Date:   Thu, 10 Dec 2020 23:48:43 +0900
Message-Id: <20201210144844.72580-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201210144844.72580-1-chanho61.park@samsung.com>
References: <20201210144844.72580-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__always_inline can cause build error on musl libc. The fix patch has
submitted but not merged yet[1]. To build perf tool with musl libc,
<linux/stddef.h> inclusion is necessary and it should be included before
asm/byteorder.h.

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
 include/uapi/linux/perf_event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271397a6..af5e80dc7d54 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -17,6 +17,9 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#if !defined(__GLIBC__)
+#include <linux/stddef.h>
+#endif
 #include <asm/byteorder.h>
 
 /*
-- 
2.23.0

