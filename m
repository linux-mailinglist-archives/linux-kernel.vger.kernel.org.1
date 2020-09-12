Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47392677A0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 06:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgILEMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 00:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgILEMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 00:12:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E14C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 21:12:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n133so11901348qkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 21:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvVGrPVZzIS1i2wMlAaPm2He75bpFK9MoRWDiUbgtrI=;
        b=LOnXBIRfM1m+SDbt03QQez4K9AQTpwY4BzgDtgbOWh3vWGRXZfvZgx8CoI51L3dU1+
         rzwCQdhFEeLE9ijCRS/NOw7SXxwjPuOvawllEoIhsgmn0d2fF225WK79X0bAKicP1eJS
         Hi3DybCPE9MISX2o0ztPziiiFSR+IatAS1aPL/WlMg4ZTXiSAxuDfXy3rDktl5Yn3DB8
         IU9m3w1Z7Yjpnqqn01BzQD6PNk77gJ83Sr9/rbGVkS8egXXWjsYfkEvHlpFzcsN42sWy
         qr6SWCwJR67ukO+DibepLoyVeAN5NEgf7mBgl2vZt7bz6e3LDCsW0BlCBO9hOcEXvUUX
         RjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvVGrPVZzIS1i2wMlAaPm2He75bpFK9MoRWDiUbgtrI=;
        b=p3mASK9hhI6Uh8Y6lB49hT4wlLe/ZZKhcX5NP8O53O8aX/ijq7MsBGRYu9fwX3RG1f
         NNxtxdgevKVgkF2XCWOCLohekoFp0/zzU7hF3OQOUlJdgDsTU1ahJxpgnQ8NBIrdFEos
         x6ORSGmHDx0ggqKi9BbqMcPbEK5FMQ4BIUA3LtoLYz1mYGey4MOroP9yAIsaDMisU2T8
         u7AguLDUKJBC8Jgzo55rd97i2cFQUb5iEbB7s69G6zdxAThN8yFoKe1TPNiPkbCAh/N+
         0w8SEbCGevVRlCPuaZxkCYECbVsyykCbkK0gQ/ngXS+fWYU5XHweSG2ZWSdrAHAX0SsC
         86Qw==
X-Gm-Message-State: AOAM532kXHI4Bk/kRIoSgOgm/7pkJvloXoLuk/HO7HkJmey3tGIFPqWw
        qs1WXCY9qLVR67c7cXEaWV0=
X-Google-Smtp-Source: ABdhPJwFOb4CWBMbjqUUNM6KprIUtjbmLfvtN+whuLuU57rftiyP/7+dtjU8B/3jMFeRfR7OANGNlQ==
X-Received: by 2002:a37:5684:: with SMTP id k126mr4169396qkb.43.1599883940411;
        Fri, 11 Sep 2020 21:12:20 -0700 (PDT)
Received: from winbook.localdomain (ool-944c2509.dyn.optonline.net. [148.76.37.9])
        by smtp.gmail.com with ESMTPSA id z26sm5331265qkj.107.2020.09.11.21.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 21:12:20 -0700 (PDT)
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
Subject: [PATCH] perf vendor events amd: remove trailing comma
Date:   Sat, 12 Sep 2020 00:10:56 -0400
Message-Id: <20200912041101.2123-1-henrywolfeburns@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdzen2/core.json had a trailing comma on the x_ret_fus_brnch_inst
event. Since that goes against the JSON standard, lets remove it.

Signed-off-by: Henry Burns <henrywolfeburns@gmail.com>
---
 tools/perf/pmu-events/arch/x86/amdzen2/core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

