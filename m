Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F235329DADC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390561AbgJ1Xgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390551AbgJ1Xfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:35:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2325AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:35:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r186so835513pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8NFetcbnPvpRRyVvaPr4tQ5pZ0QFIkTHNVbsIdXXM68=;
        b=v3S+xmyHFalHLvIc4JebFYwylpnozJJAQhYlcsklusQ8+5gn4Zun+W4ewtlvrNp+tt
         B4sWgwVbqHZXXp8QnI5P1go2jezZoLYJJNNNkA1gASVoLojkMqDxq8VltO6soTULTgHg
         RZWdbOAzqre8o1qsUXiP60USNOuSIFRlEd7LsSwYFId6coG2Sxvw0rIVDX65EwDwweTN
         Bq2O4POg7HMBjJaMs2U2fIqFQwS2IOOiisXpElZCCOfSPxOSBBfH1fg17bL5PDry0Boy
         j9R+zSfzRHWo4N/SR85Udxhjs1Hk0gzAsDrVjRa80hGxyF6JhRRDn/XFgxcrIPe644dk
         r7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8NFetcbnPvpRRyVvaPr4tQ5pZ0QFIkTHNVbsIdXXM68=;
        b=RPiT8CcjULs3J/L3glE1bSsJRIoWwIyNQM208vli+PX3jCeEhB52np3q3j7pi54s0G
         u+iuAUaiQcjl4U1ZloS8stih+Gi0oGnEvvBrYRSsneRP78myzaB/IxkYbVMzISoMOzCp
         E0IOwp3yd+IC8/agxufWSqvV7lxgfWVNF41CgqD5UF6nWb1KE0vAyoUDt5aWzUv6chw1
         mjpgKMS7TzsNSCuItTr7iU6cpu6v9njzRdyq6g9fZuK70D5oeROIEqsDOf8AceA0aoiY
         5nfp7oPCieZM93sidigCm0WLoxhhR458ttfEi0UnUTz+7eWtK+NUHzxPkd7/HUd7s7c6
         ic3w==
X-Gm-Message-State: AOAM530Ur27BgZyim2Jfbq1TA3YstUIzQ3xuYoA+1/9hLNtWk6qv4Zcj
        yLc/fqc49kzNRxkHyqj7fL0AjjyBoSkyLnp3
X-Google-Smtp-Source: ABdhPJx+q8fuTwvlzmIAtpvjelU7lqkYbb0WVNeDXjn7nqnlJtkRULq1wn+BLgjlmB5hrhf89AV6zQ==
X-Received: by 2002:a63:774e:: with SMTP id s75mr5116141pgc.336.1603867144360;
        Tue, 27 Oct 2020 23:39:04 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id b16sm4545286pfp.195.2020.10.27.23.39.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:39:03 -0700 (PDT)
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
Subject: [PATCH v3 8/9] perf mem: Return NULL for event 'ldst' on PowerPC
Date:   Wed, 28 Oct 2020 14:38:12 +0800
Message-Id: <20201028063813.8562-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user specifies event type "ldst", PowerPC's perf_mem_events__name()
will wrongly return the store event name "cpu/mem-stores/".

This patch changes to return NULL for the event "ldst" on PowerPC.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/powerpc/util/mem-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
index 07fb5e049488..90c5a0760685 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -7,6 +7,8 @@ char *perf_mem_events__name(int i)
 {
 	if (i == PERF_MEM_EVENTS__LOAD)
 		return (char *) "cpu/mem-loads/";
-
-	return (char *) "cpu/mem-stores/";
+	else if (i == PERF_MEM_EVENTS__STORE)
+		return (char *) "cpu/mem-stores/";
+	else
+		return NULL;
 }
-- 
2.17.1

