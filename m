Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A06269C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIODSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgIODSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FBEC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so1091937pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zho2Ys2W8v2SdtZrsmDmxjiMwP8YGeIYUvymDhBdx8k=;
        b=ckM14f+Lc3YiXwBvgTQcOgNd5JNsLlJ9bXPBLoRB46awP68q2aA03p8qKVlYt/4QZm
         nFH42omY5AUMB1cYid/asIIMHv+0oHN/wxwFjdYPCTjtDGvGR2YSlyl5htr4h3H73u4u
         JYulPdHUbmUFV3u2vuP/UugZV8PSh3ZzOPWpPP6NAiZqyIJVb2hAP4ujxl9vS28ueRa1
         A2q9oOaMFc3/wS7JEPcLwOIWkQ+4imURDP+1eB81x1gY0IeIzt7jdRex/6RZKMyj20vn
         TjhsQWuag/dbpyMYiTxYzRI0f55DrQP+t96xsXP9i8qcXmfkJhRfpSS4cDpeA/ILX+8Q
         3Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zho2Ys2W8v2SdtZrsmDmxjiMwP8YGeIYUvymDhBdx8k=;
        b=kq3oIwA6/+FnIDebmnCiBw+8Gvfn5+E7/DoMqdoisYx0NCwVD2c2F/IzZY1v3gqOgO
         iZngUUFXUBVBrKh/NJ9XgFa8yofQv455gFIGQfJh19H0Uv1A02yD91sxdaFdpIzlUemJ
         QnSO5IXHkXpsKlZpg9nKk1wgVi1Ie6HqYTfmPfOwgwDTfD4/BU8dPfcvHyEDnIxmPeta
         w46cd9ccYlz7+Nq82kBZp81jqdlUa0LkVpPJT6/CK2gSy3lgsK7kJnPz5iFHs6ClgsXo
         6KGmoiWmOAg0diTm9STbXVI1MKFHT25MWETeHtDT14JwPY8HXED4TI2MSD2gsB6CTjmJ
         WPyw==
X-Gm-Message-State: AOAM530esxwqrdbk7ONfkLk2RaKxzcLHjx6m0BmKoMTeNGeeXWo+PrIB
        Wyn4Duuc6JC2yHh9QH01NAI=
X-Google-Smtp-Source: ABdhPJx1Qw1cK7i9SBvBMJr72jfY/g8NzcGTcpTL4j5uckqtOc4+tuLOXS5x/SeGq8nE8173eW/LCg==
X-Received: by 2002:a65:4c42:: with SMTP id l2mr13173591pgr.242.1600139915563;
        Mon, 14 Sep 2020 20:18:35 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:35 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 02/11] perf metric: Fix some memory leaks - part 2
Date:   Tue, 15 Sep 2020 12:18:10 +0900
Message-Id: <20200915031819.386559-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metric_event_delete() missed to free expr->metric_events and it
should free an expr when metric_refs allocation failed.

Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: 4ea2896715e67 ("perf metric: Collect referenced metrics in struct metric_expr")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 90d14c63babb..53747df601fa 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -84,6 +84,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
 
 	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
 		free(expr->metric_refs);
+		free(expr->metric_events);
 		free(expr);
 	}
 
@@ -315,6 +316,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 			if (!metric_refs) {
 				ret = -ENOMEM;
 				free(metric_events);
+				free(expr);
 				break;
 			}
 
-- 
2.28.0.618.gf4bc123cb7-goog

