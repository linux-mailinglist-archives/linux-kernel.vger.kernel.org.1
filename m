Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48572269A80
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgIOAlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgIOAln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:41:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A28C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:41:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f142so2503710qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4BoWd0+ZOKKFBQZkXbh53GfiObavQzcshUX5iDlWfA=;
        b=J0qxPbO8yCYyNYEzTO98Zh4f+sem0rKKGSTmit7KFlz1h/LyGbtHoXWwvC/40rFzu+
         yBVtFd4Ja513mm2YmUTRe3HCU4iYeajBFSgcfp4CMSTr229GA6NPGEjYqJ3MVvT8lpb6
         uhmQmJbsimzcHI+hgdd66XnOI0ploLF/0oSpLi/ouRp6+BNhdwhmQMRyQn8AMP6zE/Ms
         xnFDxOxVVod7dS2G7ZuI97VWPbRYQgB7aO94us7vrewp5P0Ezj7eukWnr/9mqF2SOtIb
         hyfMFZufze9dwsDk+VsrRLC6zWJZy5paLV5178M5YuWDGSt8ZAYC35L7DJorr9OjAfUD
         FFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4BoWd0+ZOKKFBQZkXbh53GfiObavQzcshUX5iDlWfA=;
        b=PolUn0j/Qfo83wMH6NaoGdilttqPrFQrdz4/AHpoEiTyvNPiZyxrga1eBROuO0cS3b
         wP4MZJbRdzm/EIxTptOiCx+etvg+V7zo83D7An5w7s82/qMskWJB8ZD9X8Frf85jWGAf
         W63R/tmj6K6INjsY+B2N914DfRbhj5oBH2nw7Y357J9/dxHPHxyGSvIrvF0SYHf0vrVh
         5h0adPVFc3oypIOWGfpc+JB6i/RwpBH45a3oQOUKVtI6kvsCYnY5mjGiMLzqH+8F5wKX
         YVHvDvjfyt8yK862GDtqDsmps18Jc83lQMBJ8yTOjstiFN2mhUBcPTL+2lROkwvTVJcU
         mAOg==
X-Gm-Message-State: AOAM533r5Ve1gbk07u1Vpum9/iVCEjJc9XKW+w0bjK6P+mtMjxn+cWx7
        AnXGGuJ8YqQvJ5Aed4D9sYM=
X-Google-Smtp-Source: ABdhPJwgnUMcC42Ys0HAoBA+S2OcboSSiegNKl/Y4XlLZYtkO5zT55/FB0/OlCkwS1c1GukU5RCqEw==
X-Received: by 2002:a37:e82:: with SMTP id 124mr14804531qko.77.1600130501047;
        Mon, 14 Sep 2020 17:41:41 -0700 (PDT)
Received: from winbook.localdomain (ool-944c2509.dyn.optonline.net. [148.76.37.9])
        by smtp.gmail.com with ESMTPSA id p3sm15295575qkj.113.2020.09.14.17.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:41:40 -0700 (PDT)
From:   Henry Burns <henrywolfeburns@gmail.com>
To:     henrywolfeburns@gmail.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf vendor events amd: remove trailing commas
Date:   Mon, 14 Sep 2020 20:40:49 -0400
Message-Id: <20200915004125.971-1-henrywolfeburns@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912041101.2123-1-henrywolfeburns@gmail.com>
References: <20200912041101.2123-1-henrywolfeburns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdzen2/core.json and amdzen/core.json have the occasional trailing
comma. Since that goes against the JSON standard, lets remove it.

Signed-off-by: Henry Burns <henrywolfeburns@gmail.com>
---
 tools/perf/pmu-events/arch/x86/amdzen1/core.json | 2 +-
 tools/perf/pmu-events/arch/x86/amdzen2/core.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
index 7e1aa8273935..653b11b23399 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
@@ -61,7 +61,7 @@
   {
     "EventName": "ex_ret_brn_ind_misp",
     "EventCode": "0xca",
-    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
+    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted."
   },
   {
     "EventName": "ex_ret_mmx_fp_instr.sse_instr",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
index de89e5a44ff1..4b75183da94a 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
@@ -125,6 +125,6 @@
   {
     "EventName": "ex_ret_fus_brnch_inst",
     "EventCode": "0x1d0",
-    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8.",
+    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8."
   }
 ]
-- 
2.25.1

