Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1F29DABB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390477AbgJ1X3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgJ1X26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:28:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B433C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:28:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t22so388888plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w3jvPkaI6Fvufscz5TOGN3cMyWxi/xK+/XekPoieKuM=;
        b=nbHmMt5Ofz7dpI4oVG8er172WLWhYn3iy87HwpWDGZroHblR40SYYb12GE6tOGhAYL
         VUsDndG8Qeikh/AigBMf6S9lz43v38jUqnkrO4GROlXKjIVbQ/J5FzQedEKVUq27kRjB
         uMY1Ne8mSFyap/KOnSR8/cYkvXw4YIZznl/wRfierXV+0B7r97oT9Jws8fK32ljjJZup
         a9l+E0uarqBeTPRnqC6H9/ncEibZqRZyYaA2j1JBVzdSeV/D+xTdxMd1AnyTJCZ+w1c5
         orxLgmLdaoKE6ONBlyyjsiCHFV4ZKpRl/zFxb6i4MA5pnulZNJafWq81G/qKne6tXBhn
         ZkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w3jvPkaI6Fvufscz5TOGN3cMyWxi/xK+/XekPoieKuM=;
        b=e7jEkxqvp/at1axsGXSwjQMLaQXhkVwN/iS0hEPTyL1dvSc8Cs8iQ0O3KtUUqS2jFS
         W3NYFkg7yH0OL/snrt9/xSwNzEYrk9Cer3mTdwZkVpMcfq/O2oBaIElyE1B7B4I3N2e/
         T+FUgF52ROhgRSeVqM4ealeymmLDwGr1AIcoEl+07GyNJW7pCw8Wla8BMeGXycLBrNMl
         f6iXjjyPptfgjBuj6wXCNDcoo/aTzzNjkC+JTTy/NjDbKWhZnm6sNX8H89L/HvEIlMpX
         ErxP/PI/h0NMAQs+n+qwgYtHxnH8YEFCaQHL5fKZ4UDqqwJsjL/WqdXo97sMecuPOcLc
         REcA==
X-Gm-Message-State: AOAM531GHxYyQl93aTDaRT0bBuxMqKvKTzH9hYy98ufNUDihpUqELY/+
        QJSLu6iEfvJ/kQnRr+MREEraSHYhdd+LH3nA
X-Google-Smtp-Source: ABdhPJweHXefCoW8ZQA9mpLM4Yu8KeZfkGcFKKE2c8zmiq39SmIfmF+GSWMPp9wmAlimk0jqQYHJnQ==
X-Received: by 2002:a17:902:16b:b029:d6:7a92:451a with SMTP id 98-20020a170902016bb02900d67a92451amr32383plb.85.1603867149280;
        Tue, 27 Oct 2020 23:39:09 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id i123sm4324281pfc.13.2020.10.27.23.39.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:39:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?UTF-8?q?Andr=C3=A9=20Przywara?= <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 9/9] perf mem: Document event type 'ldst'
Date:   Wed, 28 Oct 2020 14:38:13 +0800
Message-Id: <20201028063813.8562-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event type 'ldst' is added for recording both load and store memory
operations, this patch documents for the new event type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-mem.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 199ea0f0a6c0..c50ef37dba72 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -38,7 +38,11 @@ OPTIONS
 
 -t::
 --type=<type>::
-	Select the memory operation type: load or store (default: load,store)
+	Select the memory operation type: load, store, ldst (default: load,store).
+	The type 'ldst' means the single event can record both for load and store
+	operations; Intel and PowerPC support the types 'load' and 'store' but
+	'ldst' cannot be used; on Arm64, it uses Arm SPE as memory events and
+	user needs to specify one of these three types.
 
 -D::
 --dump-raw-samples::
-- 
2.17.1

