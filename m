Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B828F517
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgJOOqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389091AbgJOOqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E73C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e2so3985027wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZCd2bm+jjmLJLco12LHFroKrNFntcc2aoeaMWKeI8s=;
        b=XA/Mky+L+9tMXT/+pp9fHvkjk0i+CC5F1MjQ4KKHxgvhTA3+3QNV4+sygrYxrZTOrz
         Qyiot2n3Q/ca/uzLKZy4SreAeJkXBJ945e0xRJVO6SAyytIbW7FFUwPRw1cF16RJYXuO
         xiea98EeFmH5WSWbuBpMEIzJZQKFz5AqDZucLgv3yQhKf0mt9QspSb94fMVw5onf7cPh
         7armjkQfmNO3MKiM15GiM9KC84MpqEiD/w4N7bRi9c4GRfgx1b1aSUz3Gc9vmZI2wAcS
         lzQG9QdEzRFks4gx2+9DYphKukAmvQYdtuE5rpGbF/KPsCELPrun8A9l/BVlkL0EEypF
         UQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZCd2bm+jjmLJLco12LHFroKrNFntcc2aoeaMWKeI8s=;
        b=siYpDvd/KaAuq/vDYID3EeYcPBrEkOxfFRrCCdsY6ALfzidK2/HUzrqdUikWP4hbuS
         5QJAX98ocariXtlvckmtmwc48+6SjUiq6eZkfpSVbDlUKad4rGOy5TGJSnYCQ0a6C3sK
         SKBWvxc1gpOFJcLIL4Sj8HrEXTcfH8rraCX0gVrpl/ls3zQD7AZ2kwXOpYUXh2gXUWK6
         QzUC7VXY5Y92MJS7AxwS6zx3UFgMCP3O57AgDb67TIRiQhiFpKcwyzypgl6ipe1yyr0D
         AVJJYn0qDkgBfD0FMnzdx0TqNMkQgiohjhxrhb7xypge1OoKTuIBGLM+hRbJeCZx/+9K
         EX8g==
X-Gm-Message-State: AOAM531Cx9xeLSKiyHHlmr1v6uSqq/8ADUgGJQiA2Es8U2JofJlJCvMe
        giGbXRKK7ZHGmRobSDOjwZVmbA==
X-Google-Smtp-Source: ABdhPJzplrE/dyv/eJhWl5xFIYtxbM2ebpA3UL9vVvHb7EAwADMWls3u3z34QqEXSTk2gA2b2dW9vQ==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr4641401wmf.10.1602773174712;
        Thu, 15 Oct 2020 07:46:14 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/9] perf c2c: Change header from "LLC Load Hitm" to "Load Hitm"
Date:   Thu, 15 Oct 2020 15:45:43 +0100
Message-Id: <20201015144548.18482-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144548.18482-1-leo.yan@linaro.org>
References: <20201015144548.18482-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metrics "LLC Load Hitm" contains two items: one is "local Hitm" and
another is "remote Hitm".

"local Hitm" means: L3 HIT and was serviced by another processor core
with a cross core snoop where modified copies were found; it's no doubt
that "local Hitm" belongs to LLC access.

But for "remote Hitm", based on the code in util/mem-events, it's the
event for remote cache HIT and was serviced by another processor core
with modified copies.  Thus the remote Hitm is a remote cache's hit and
actually it's LLC load miss.

Now the display format gives users the impression that "local Hitm" and
"remote Hitm" both belong to the LLC load, but this is not the fact as
described.

This patch changes the header from "LLC Load Hitm" to "Load Hitm", this
can avoid the give the wrong impression that all Hitm belong to LLC.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Joe Mario <jmario@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 404d4739b8c1..fa7a1c55b989 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1328,7 +1328,7 @@ static struct c2c_dimension dim_iaddr = {
 };
 
 static struct c2c_dimension dim_tot_hitm = {
-	.header		= HEADER_SPAN("----- LLC Load Hitm -----", "Total", 2),
+	.header		= HEADER_SPAN("------- Load Hitm -------", "Total", 2),
 	.name		= "tot_hitm",
 	.cmp		= tot_hitm_cmp,
 	.entry		= tot_hitm_entry,
-- 
2.17.1

