Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FAE2D5EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391866AbgLJOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391692AbgLJOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:56 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:49:16 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so2878945plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNA1cVZvxMl2/nbzGeOooP/JVSNaInb9gfQacGnknYo=;
        b=eB5Zp+V4Sb3Krx+eTrvxQnXQPzvrYn1ClGFPNT8WEwn5t0/9BB7ZrV/PXY0x/Da1Sp
         plyJKhXfFSQ4hAiHgaIkCCLC1pFktL8dFjUHdpKXodHXKuM3H77kvJfHj56l5f9TDXCh
         rkjTSjje4qmYKX9N19memLMXDhXvJ5RvBOkNUDJtnvsa521SVdAKbVgrLcLrZ6cQNPyc
         HErofPJCou7lMWKPOyzxoHo2V0StSYOqZktxuKDqsrsguD26RV03BPEnMOB29WwIXOaJ
         ZWPmQSgsG9QqFCtEqR5aArm9BGErzhnRt++ioN7xljj9/08HNwKgUokZBCCqlbm2uxpT
         g4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNA1cVZvxMl2/nbzGeOooP/JVSNaInb9gfQacGnknYo=;
        b=oPddi75fTl+t0bPOlVrJ3YbcNMmMw38h9ejYunZ9Rf5vtc4AjKtI+8TPva+twvgwMe
         ULR2EZENE8ged5q9DBHJx9ZHiS03vDmNODBHO+H2FWnv2N46Aiz2H4cUuKHpDt/pEayO
         8GH7MX+zcZ18dmX5YVqkmztKeQkzFbRyA3F2KvpPmKDmqn+baXTsBsP2/oWvMtgnHXw9
         e5SxqNIIAsfNWO+2GPqZdHlwLZ08szw5bZJFSSI8Nu+/Tn3WMnhV5TeSUPKmCM+vyYRi
         r1oI8omCTZhvAVm6QAWahSmMfS6aqBIXFCIf+e+9G0uYrhT36m4SyA+ZRk+WXCriFvLF
         FGnQ==
X-Gm-Message-State: AOAM5323h2sVRQ1scSFWeIGaZa4NzvHh+hOUcME7YYbqIU85RLc8eNeZ
        I3H7l0Z9Yne+5La7mmSxC+YOaW/1SB7lhCo3
X-Google-Smtp-Source: ABdhPJyVVJx0azWqS51tWSgNWxL/KIXZ9RuXDjBAzlyOJKma9dLQAxfV86L09peHKKXhxo6asa91IA==
X-Received: by 2002:a17:902:b282:b029:da:fd05:7766 with SMTP id u2-20020a170902b282b02900dafd057766mr6651674plr.52.1607611755604;
        Thu, 10 Dec 2020 06:49:15 -0800 (PST)
Received: from localhost ([221.153.153.187])
        by smtp.gmail.com with ESMTPSA id u12sm277566pfh.98.2020.12.10.06.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 06:49:14 -0800 (PST)
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
Subject: [PATCH 2/2] perf: tool: fix build error on MUSL libc
Date:   Thu, 10 Dec 2020 23:48:44 +0900
Message-Id: <20201210144844.72580-3-chanho61.park@samsung.com>
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
 tools/include/uapi/linux/perf_event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bb7b271397a6..af5e80dc7d54 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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

