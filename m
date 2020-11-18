Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E702B758B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 06:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgKRFDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgKRFDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:03:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E54C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:03:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a6so736748ybi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uFz0KCM73TpvJCsC+Abj2fPwPBVrxW/KqD+HHaF74Ug=;
        b=oSx5Exb7+cNxEE0tsBJewNc1XQ0zwGl6fMGhQV1zNGdi3GpS1bOKS+G8ee+E3OYNYf
         mIGbYeDaGQrRUswlRGxWhyNrZJYbDfk+nsjc8fd9smnH9TKZQmcLBjolSr3AeC1HXPuT
         5UnJFd/kbwIERQw6UDQ6uonoqXABpBDxDHGxmUWDePAix+jEfD+d6/Hl5vLjVzgnx2dV
         uM0l7sitTPHjDeeaoHDIIWwm9HNk4EJeke4J0aMeE1RVQIycKGjBEMQMsDalELkRR+DZ
         0JcGsrWhFAdfVO1OLF18q7VHzZtCrtz2UoSsJ5RvHuow6UOWvPTb06qIJUaJG39qLNUi
         24pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uFz0KCM73TpvJCsC+Abj2fPwPBVrxW/KqD+HHaF74Ug=;
        b=a041Dru+qBmd+YJlkZWfRv2VL4txzAgSImqAzetZ1ZRzIbgDbvtlVlHZX32HyWXy/U
         gp7TyJqzLCTDaZ3lTaNIXM1DrsH7enfd/M7lAC3IeX5VTBlbiDsa89R1Z1yR/j5a2Vs4
         IzoRW8TfzFBDJ8g6sn/7GAxiY6zvhChf4KWkyzwo/74SLc8rhOKy3zYuWQhF79RGu4pM
         h/FCYTEmwbSRAQx2Um3A4CIr22SV7oqSZjn2rnbukv/dQjlkVGVlyD+qC6BH/0XeH+T/
         ZwyM7X1MRDx+fTjd4l4Ei/PT9UniU0qET41U5p7zOxGkbCagiTeLnVYQn4blbpqb4W16
         XT0g==
X-Gm-Message-State: AOAM5301pHp+Ly4FNow/G3xI+6BAnjR/yVZ14Bymkk6yG2XLUB4U08FK
        lh1gA5jDCBUi+vZ4D2TzjDwFj1k7Tr31
X-Google-Smtp-Source: ABdhPJxRzirO/Q7puaOoiAnbUo7FcbeTkhNPn6XpYgRnM1LY0V5WAHOAUwt8soC5QsRoLNj23OyKGe9Iv8mL
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:ae14:: with SMTP id
 a20mr5529367ybj.43.1605675823256; Tue, 17 Nov 2020 21:03:43 -0800 (PST)
Date:   Tue, 17 Nov 2020 21:03:32 -0800
In-Reply-To: <20201118050335.2347358-1-irogers@google.com>
Message-Id: <20201118050335.2347358-3-irogers@google.com>
Mime-Version: 1.0
References: <20201118050335.2347358-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 2/5] perf metric: Use NAN for missing event IDs.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If during computing a metric an event (id) is missing the parsing
aborts. A later patch will make it so that events that aren't used in
the output are deliberately omitted, in which case we don't want the
abort. Modify the missing ID case to report NAN for these cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index b2ada8f8309a..c22e3500a40f 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,7 @@
 /* Simple expression parser */
 %{
 #define YYDEBUG 1
+#include <math.h>
 #include <stdio.h>
 #include "util.h"
 #include "util/debug.h"
@@ -89,8 +90,7 @@ expr:	  NUMBER
 					struct expr_id_data *data;
 
 					if (expr__resolve_id(ctx, $1, &data)) {
-						free($1);
-						YYABORT;
+						$$ = NAN;
 					}
 
 					$$ = expr_id_data__value(data);
-- 
2.29.2.299.gdc1121823c-goog

