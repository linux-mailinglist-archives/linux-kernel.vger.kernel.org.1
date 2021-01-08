Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438CB2EEA15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbhAHACV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:02:21 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:40925 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbhAHACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:02:21 -0500
Received: by mail-il1-f176.google.com with SMTP id e7so8538968ile.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 16:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OUdgYT2bV2z9JMQ5Dnm5gfN8+JaqX2+57UkKZK6TJcg=;
        b=GXNToxlossapLsH5x+/2Da9dF9cJHXn83ykpcG1zWFQm0Y4zYCcZ6Zo9mhpUVv03GU
         ICr6BMwysjGhfZJM6+132Yfw27NUC2O9HE+GeUJ0221MIZ7nrOzcdw6377F9Hh4n7qPW
         IXj6xDxY5o+cJt/FR6pkqIV16sIdIQ+ouDnFG5+PM1qk8Mi+9uojKmxC4+iBXGajlJ3t
         ULpvYH+zTVtqkw8fAnLaFF8c7ZvwblzRvTbE1nib6N5HCqb40d28XUm+nRf/3+uNeAYW
         Rc4WWHED0YA7z+GEtC/AD9ae8D7L6LXC9yD6lPY9TaLDQNPXZmaCoHlq6fGhpAlIhjf+
         EiyA==
X-Gm-Message-State: AOAM533wJxU7SuefvxV7YXDHDIgDeJZJe4EOeSWKPptW0ppyKrhuH8TM
        jeheVRL2VBgXJom65KNgdg==
X-Google-Smtp-Source: ABdhPJzntJusReXegW/sOc5IBt2tMDZ27KMS4THSZ/OAA40iCURuV8r5pMDzeoz0JkAkQX+iGARIdw==
X-Received: by 2002:a92:d210:: with SMTP id y16mr1331520ily.97.1610064100261;
        Thu, 07 Jan 2021 16:01:40 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id i6sm5127742ilm.70.2021.01.07.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 16:01:39 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC] perf/x86: Only expose userspace rdpmc for events on current CPU
Date:   Thu,  7 Jan 2021 17:01:36 -0700
Message-Id: <20210108000136.1556129-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace access using rdpmc only makes sense if the event is valid for
the current CPU. However, cap_user_rdpmc is currently set no matter which
CPU the event is associated with. The result is userspace reading another
CPU's event thinks it can use rdpmc to read the counter. In doing so, the
wrong counter will be read.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
I'm working on adding userspace counter access for arm64 along with a
common access routine in libperf. I found this issue when testing per CPU
events. More details are here[1]. 

I'm going to need the same thing for arm64. This could possibly go into
perf_event_update_userpage() instead, but perhaps there could be an arch
where userspace can read other cpu's counters.

What's the ABI between libperf and kernel versions? This change will 
only help the libperf implementation if libperf doesn't need to support 
old kernels.

[1] https://lore.kernel.org/r/CAL_JsqJzeCebq4VP+xBtfh=fbomvaJoVMp35AQQDGTYD-fRWgw@mail.gmail.com
---
 arch/x86/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a88c94d65693..6e6d4c1d03ca 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2490,7 +2490,8 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_rdpmc =
-		!!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
+		!!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED) &&
+		(event->oncpu == smp_processor_id());
 	userpg->pmc_width = x86_pmu.cntval_bits;
 
 	if (!using_native_sched_clock() || !sched_clock_stable())
-- 
2.27.0

