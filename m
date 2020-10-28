Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DF29E20F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgJ2CFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgJ1ViR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:17 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2BAC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:38:16 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j20so568310qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=dLAZp75cCByBX0dApe3sqiLCgJj4EGqL5QEg0Gtk9z8=;
        b=t4mgoMeOcXh+1SZ2IRANoepguh4zdI1XFMagy1iLEe3x+FdsOA670APWjrCXmQEbgB
         Ak8vFOwz+ucWE/D3/CGYFu/9t4vdHUmLtXJh+bq493sIyfCsec68EkOkP7cvbb0U8w0O
         tcEFHJ/OnBMY6zz9QS+sBrWdymySQGa81wE7bv+cB8GcJzaVSbhhso+IZnPamib4/cU6
         K2JQcLfqeVzK1oNalf/rAj6mCNfsXIVFxUx/QibS+/l3G757uCx9OKueNVs/7hQj/VZ7
         YhQp1vJSAS1pcMopGkOOTemDAr/K3xYuvqNJ6PAmpVCNStGkOZprtCW/0wg+0XeCfUkt
         OTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=dLAZp75cCByBX0dApe3sqiLCgJj4EGqL5QEg0Gtk9z8=;
        b=AZIpnfp+dikjQupGhjloW9Rs5EmrpQ55j8XxhOWZI4AcC3bakCN8xzqBUxLW4fFG3N
         vu7TgH2VPysEabMzo3M6n56NnztYLMj/Ce4EUkcH5bswxszE04hL2fJxOYulP3D6qRxy
         elg+CvMI7bF+BZmnQF8BWV8piSreF2JJAxhXwoyZKNwb0ohok2fXrAo3wibcnrdF2CVj
         DqgiuNNe02ffSDiTvztlaNr8Dj20ziUjSmGEUcxbE8ZO5NB28kV4PLTO6whMx2Sp9x/N
         9SI4ZalSlEDCeMwcQbf01PzxLAOWAS3ALjDpnEaCugZ1xjDCZiApK4YKb9KNzr2vtsTY
         uJMg==
X-Gm-Message-State: AOAM5339vUY56z277rNlQcGO2K2Cn6Gndf7+HRlNh0/RHIDXFrzcaave
        3ptTs3Xc5qsmXxAs4MfMemPlA3nF8DjR3PV24/vcN2fQV9f6yCCtvTH5FE0wXNMjKTsWemYof7w
        7s34AQvMViyE2Kn1gUBA/6YPum1H9Q4NmK8L1j80Qy/ErgeW0amxqM6z4gHcz69Dye5/Vj/mm
X-Google-Smtp-Source: ABdhPJzoFO4dkR1sxzYXCkvC3Mg0yWUoFmXTmqEVpE1gSjjZ/0ZiBaiziYrFH3KQMh4Vp6hP4dV/0Y+WhO2h
Sender: "eranian via sendgmr" <eranian@uluru3.svl.corp.google.com>
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe0f:9db2])
 (user=eranian job=sendgmr) by 2002:a0c:9e20:: with SMTP id
 p32mr1007145qve.44.1603914174652; Wed, 28 Oct 2020 12:42:54 -0700 (PDT)
Date:   Wed, 28 Oct 2020 12:42:47 -0700
Message-Id: <20201028194247.3160610-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2] perf/x86/intel: make anythread filter support conditional
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, kan.liang@intel.com, jolsa@redhat.com,
        peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with Arch Perfmon v5, the anythread filter on generic counters may be
deprecated. The current kernel was exporting the any filter without checking.
On Icelake, it means you could do cpu/event=0x3c,any/ even though the filter
does not exist. This patch corrects the problem by relying on the CPUID 0xa leaf
function to determine if anythread is supported or not as described in the
Intel SDM Vol3b 18.2.5.1 AnyThread Deprecation section.

In V2, we remove intel_arch_v4_format_attrs because it is a duplicate
of intel_arch_format_attrs.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/core.c      | 10 ++++++++++
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h |  4 +++-
 arch/x86/kvm/cpuid.c              |  4 +++-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f1926e9f2143..7daab613052b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4987,6 +4987,12 @@ __init int intel_pmu_init(void)
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
+	if (version >= 5) {
+		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
+		if (x86_pmu.intel_cap.anythread_deprecated)
+			pr_cont(" AnyThread deprecated, ");
+	}
+
 	/*
 	 * Install the hw-cache-events table:
 	 */
@@ -5512,6 +5518,10 @@ __init int intel_pmu_init(void)
 	x86_pmu.intel_ctrl |=
 		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
 
+	/* AnyThread may be deprecated on arch perfmon v5 or later */
+	if (x86_pmu.intel_cap.anythread_deprecated)
+		x86_pmu.format_attrs = intel_arch_formats_attr;
+
 	if (x86_pmu.event_constraints) {
 		/*
 		 * event on fixed counter2 (REF_CYCLES) only works on this
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ee2b9b9fc2a5..906b494083a8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -585,6 +585,7 @@ union perf_capabilities {
 		u64     pebs_baseline:1;
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
+		u64	anythread_deprecated:1;
 	};
 	u64	capabilities;
 };
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 6960cd6d1f23..b9a7fd0a27e2 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -137,7 +137,9 @@ union cpuid10_edx {
 	struct {
 		unsigned int num_counters_fixed:5;
 		unsigned int bit_width_fixed:8;
-		unsigned int reserved:19;
+		unsigned int reserved1:2;
+		unsigned int anythread_deprecated:1;
+		unsigned int reserved2:16;
 	} split;
 	unsigned int full;
 };
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7456f9ad424b..09097d430961 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -636,7 +636,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		edx.split.num_counters_fixed = min(cap.num_counters_fixed, MAX_FIXED_COUNTERS);
 		edx.split.bit_width_fixed = cap.bit_width_fixed;
-		edx.split.reserved = 0;
+		edx.split.anythread_deprecated = 1;
+		edx.split.reserved1 = 0;
+		edx.split.reserved2 = 0;
 
 		entry->eax = eax.full;
 		entry->ebx = cap.events_mask;
-- 
2.29.1.341.ge80a0c044ae-goog

