Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EE02BFFAF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 06:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKWFhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 00:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKWFhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 00:37:52 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E8BC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 21:37:52 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x15so8299458pll.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 21:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0N6BcOmsAdHPYlc42ac3xchKt3p6Jr2SHMXL0xL4wf8=;
        b=G51R4G/2/FL9HhQRNtfoxven9s01YPVAXDmR6sn48S1SIybtaS+Fq3jbxPgymEijFb
         qp5LZmv7myYsy1ljf4iGnGiwT5aq+lfZTwx0kstZWys5kW/nMbtqp2sQpRWqJDjta2NC
         PwI8eiLbwqoYABEPSBAL01GQQTv69KKofvQW16wGDpXAUsqf4CvPTn5S0hxVXawgRWv6
         Rg7bMy6ZoPR7ukDIAScfjmDrHI3ltPm6ydys8zJ3hIRlkPkSUTGWbr2umRHoY2G0IAJN
         Oy7VGlLPV6TIjHNo2gfzKcdYchYVTPFFQ17g5kuSz9VJGrv8ipiXeZ/mnnJR7tWyYeBo
         2iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0N6BcOmsAdHPYlc42ac3xchKt3p6Jr2SHMXL0xL4wf8=;
        b=IlwioJNtzg7TaUKA56VF4E8G6y7ZZ41H80wKB1icQLurxx7zDjCI7cgE2vFQ3/D9Ff
         TeJaAhWlLDWT3wpMsflvpc6y+69bXjhjU8K52YBOlqmi83DZUOhdWb3WzXc2tq4SyKqf
         b8JOit7/9oyATqI+UMKjq/M96omuDfnMTR35d2uc4vEwxX+TVn+4tee9ySqqCDmDnUob
         Sx9wkXCTL9Onf+JKmoOqrKjE0lptunb+kVmCwL27nb8HIW2h3kTdZT5ezEREnXuqM9mW
         M8cvryXcKj0G2ktyna0GHN41P8tao+vajh4bH1HlBpt/fyQhiJSlgHVtAfr4zWifqnxc
         7djg==
X-Gm-Message-State: AOAM530KKQOIAszAQ8zBD/MK1vqrKmlVaD072g1tRhQzGhazvyvR/6ab
        Q1jNq3hGXJ/lIXDSmYBGRDMJL19bwA==
X-Google-Smtp-Source: ABdhPJz4b4y0u40iMztdyFzUDGeD8CoBVtxnhaS/tA1S966XsputbHpiq1PdICJoVuyfnsmLM2qUSQ==
X-Received: by 2002:a17:902:70cc:b029:d7:e8ad:26d4 with SMTP id l12-20020a17090270ccb02900d7e8ad26d4mr22812783plt.33.1606109871475;
        Sun, 22 Nov 2020 21:37:51 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h18sm5827825pfk.17.2020.11.22.21.37.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Nov 2020 21:37:50 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Omar Sandoval <osandov@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org
Subject: [PATCH 1/2] events/core: introduce perf_pmu_disable_all() to turn off all PMU
Date:   Mon, 23 Nov 2020 13:37:25 +0800
Message-Id: <1606109846-13688-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In crash context, NMI should be suppressed before jump to a new kernel.
Naturally as the source of NMI on some arches, PMU should be turned off at
that time.

Introduce perf_pmu_disable_all() to achieve the goal.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org
To: linux-kernel@vger.kernel.org
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 96450f6..f4baa87 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -965,6 +965,7 @@ extern const struct perf_event_attr *perf_event_attrs(struct perf_event *event);
 extern void perf_event_print_debug(void);
 extern void perf_pmu_disable(struct pmu *pmu);
 extern void perf_pmu_enable(struct pmu *pmu);
+extern void perf_pmu_disable_all(void);
 extern void perf_sched_cb_dec(struct pmu *pmu);
 extern void perf_sched_cb_inc(struct pmu *pmu);
 extern int perf_event_task_disable(void);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dc568ca..c8e04a5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1205,6 +1205,16 @@ void perf_pmu_enable(struct pmu *pmu)
 		pmu->pmu_enable(pmu);
 }
 
+/* When crashed, other cpus hang in idle loop, so here do an emergency job under no lock */
+void perf_pmu_disable_all(void)
+{
+	struct pmu *pmu;
+
+	list_for_each_entry(pmu, &pmus, entry)
+		if (pmu->pmu_disable)
+			pmu->pmu_disable(pmu);
+}
+
 static DEFINE_PER_CPU(struct list_head, active_ctx_list);
 
 /*
-- 
2.7.5

