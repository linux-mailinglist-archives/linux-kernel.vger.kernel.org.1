Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC01CA2BB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEHFgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 01:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEHFgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:36:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E48C05BD0B
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 22:36:39 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w9so665795qvs.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 22:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xEil2WDfEhybqR01BVqKRFgy+bYbolDc7L63+QdH+a4=;
        b=Z0ljUuBjZuel8FVMhdEIP6iuikaiOPXb5XJ5IyPczjvVE8tdgXDiKyuf1Q21ntROY5
         S8NQAckAn1KF0xxF7+++QeZNQc5rZKdDDsKPqbvbBugZ2Njtk7rlMoCuqtRdSSo2JjY4
         Y7+aZeVQKk/L/K4HgU3cUFXLa7AVK9V+hpqRUC+H0acPueVczP5OlwNVXSdhQGOxqIU4
         mRhwy8ndzG13L0yYeEI6AWMgiYtIQnVi+VzENXsHEAOrWwBF+DC2XxO640aE9gP2Kgte
         drgbVCEOEHct5PpavYF0gG7IdYTYEBdDA9LLLfojSVl/JrwfPlrRg42hlWVPCd16o5Fm
         dD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xEil2WDfEhybqR01BVqKRFgy+bYbolDc7L63+QdH+a4=;
        b=kOkmX8Rnqtqjk+kfV7o6ws2MSPPkNA+Ss9BsG7ZAI+AVmpIH1vcQOpojz6Uo1ykTS6
         cFVUi2PiiQbftfr57vdZ2Qe/XjNXrOO4Rm+LWNzYmfITvXQyQSgzFzS6XEEpFaxOSBgF
         JI3/qSZMILj10QUeUCVYQMin5PB+nHfAnGr7qWkCdp3uQ0GBSeBIuLprVESaqRpXYNT4
         zV9rWcz3DGK6vEY39uHY3PI4VLXVqR8SiQWecU1s3a/N4Rh3UQ3gH+aOWCRzkdnp4bK+
         jHOXAij7lYCX1XFdi+ERkNK+EDxKlYdiPO/wAmszZn1R6LX5LbJF1aI4TcJKptM7L21V
         dhzQ==
X-Gm-Message-State: AGi0PuYUHuRjqMpCVYY0jinKUoR33EHEXRcxgRhhz2A8BpvVzu2CwvJr
        xOUFHkDYUomoRz4q5JSLYto+2i5L275s
X-Google-Smtp-Source: APiQypJ+QjJqNWmjhvGyF1u145zqbioAO45KWMImUP8a8FiES9H3xjrtw8MfnKoTY3VIIzXqU/8VMeRC5A1q
X-Received: by 2002:a05:6214:16c8:: with SMTP id d8mr1042832qvz.93.1588916198597;
 Thu, 07 May 2020 22:36:38 -0700 (PDT)
Date:   Thu,  7 May 2020 22:36:18 -0700
In-Reply-To: <20200508053629.210324-1-irogers@google.com>
Message-Id: <20200508053629.210324-4-irogers@google.com>
Mime-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [RFC PATCH v3 03/14] lib/bpf hashmap: increase portability
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't include libbpf_internal.h as it is unused and has conflicting
definitions, for example, with tools/perf/util/debug.h.
Fix a non-glibc include path.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index bae8879cdf58..d5ef212a55ba 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -13,9 +13,8 @@
 #ifdef __GLIBC__
 #include <bits/wordsize.h>
 #else
-#include <bits/reg.h>
+#include <linux/bitops.h>
 #endif
-#include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
 {
-- 
2.26.2.645.ge9eca65c58-goog

