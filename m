Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD49C2C529C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbgKZLJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgKZLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:09:31 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA98C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 03:09:31 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t8so1348743pfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 03:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNJxb2qJAH4O0yWWqf9uXtZEEqSnUuAovaCnsG4kfBg=;
        b=c1HDiRvsHjz51j3Ihijko3zLiIaPrp0JRsYI7TPV3pEsjZNF9XH2ZwnqOCacBRnKs1
         paRrIvXnHGODBuX+g6tY6jJHWVchKnV16DhyiEVJX+V82DAsxgaJjlJ+PZTl8J08fGnV
         z6zCFilDxEmOMZYV0fc0PVWR32wswKMGSp4PpYxiICG2TwWIY4fgrcEOu6v+iqv5yXGg
         JfMbqM48AFnObZcDY90pzT8BzQYAC5UhOXNXOO6A6IK/I9AkGfa4wpJ3XXgSRfhISnIT
         axW2bADkNdggUXPRdPbSnEbkXHC6CqT8H6vMXJFXvOe1MvoLDK6N0plmuC+6Vt//gi4H
         6/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DNJxb2qJAH4O0yWWqf9uXtZEEqSnUuAovaCnsG4kfBg=;
        b=dJbzQpJiZ6UGv5Rd7hckBqKJZfFr7pwgAZNjdejZ0PBYFNUwdI7tbMTRCQuhlVG26e
         DSic601IB/Ddes5qUAUQRWoXz7GdQiztvime8yvVKmCHKmhceS2i8mu1NTs7g72iYABY
         QX0Kd+230B4R2NkgxryPpy4/iwFr6ak47JatD9TANar1VHArvRMGN15dopP1CeKW/wMw
         LXRGX4kfkf5XuN/Cn03z9ilwvcwC/zwbMJXzzjYo8Bkovpc4Xm2TVJRk0nDQM1/COqwZ
         gzTZ1VmM1ROp2ec0sc7/WyCH9WAKARYRVyNtu/j6cD4lYQpb1jYlWmEyHpf9LLDSjJoj
         6vVg==
X-Gm-Message-State: AOAM53246VA0Ju7DPORHMNeHhK6EPi6nOna9EPJ54s4NxYgkWQ1wyZ0f
        usc/eA85bA8oAZ8Z0CgcFGJ6wAde4hk=
X-Google-Smtp-Source: ABdhPJzp3crA310JoexWMg+9Zqa1hv9s7+I3tk7jQbZr37/HIHHuE5LqELgwK7PUUY8qm/E7KpgQdQ==
X-Received: by 2002:a17:90a:7e0f:: with SMTP id i15mr3048896pjl.93.1606388970837;
        Thu, 26 Nov 2020 03:09:30 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id b80sm4463366pfb.40.2020.11.26.03.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:09:30 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephane Eranian <eranian@google.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf/x86/intel: Fix a warning on x86_pmu_stop() with large PEBS
Date:   Thu, 26 Nov 2020 20:09:21 +0900
Message-Id: <20201126110922.317681-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3966c3feca3f ("x86/perf/amd: Remove need to check "running"
bit in NMI handler") introduced this.  It seems x86_pmu_stop can be
called recursively (like when it losts some samples) like below:

  x86_pmu_stop
    intel_pmu_disable_event  (x86_pmu_disable)
      intel_pmu_pebs_disable
        intel_pmu_drain_pebs_nhm  (x86_pmu_drain_pebs_buffer)
          x86_pmu_stop

While commit 35d1ce6bec13 ("perf/x86/intel/ds: Fix x86_pmu_stop
warning for large PEBS") fixed it for the normal cases, there's
another path to call x86_pmu_stop() recursively when a PEBS error was
detected (like two or more counters overflowed at the same time).

Like in the Kan's previous fix, we can skip the interrupt accounting
for large PEBS, so check the iregs which is set for PMI only.

Fixes: 3966c3feca3f ("x86/perf/amd: Remove need to check "running" bit in NMI handler")
Reported-by: John Sperbeck <jsperbeck@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b47cc4226934..89dba588636e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1940,7 +1940,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if (error[bit]) {
 			perf_log_lost_samples(event, error[bit]);
 
-			if (perf_event_account_interrupt(event))
+			if (iregs && perf_event_account_interrupt(event))
 				x86_pmu_stop(event, 0);
 		}
 
-- 
2.29.2.454.gaff20da3a2-goog

