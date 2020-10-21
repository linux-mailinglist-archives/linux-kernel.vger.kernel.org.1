Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4445E295404
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505997AbgJUVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394607AbgJUVSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:18:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C88FC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:17:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c196so3703243ybf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VTsL/mnGXOHM15tEpa+zlSLbM4q0ZXZQuhhqE0xKDOg=;
        b=FbMO0xrPffKneNQ7fv+LboOBF7jI4duNDmsbMHObD9N4t/IdFoGS2JdEgFxgCnVW4x
         Lbzv3XpK5rbpOvakjra4+qovqJaUzY1Tae1yxn0gHyxZSAoxA0xbyi1iIskcZ47EEoua
         NV3FHfkb8qzPqg953JPXuKUTalwJWLYq6VBGHTAAeSm0c4mIB0GXO/0ofQoLcm4ewPC8
         YyIFtaUCnQp/CDD5Nfx/ClYld/KMoueB6LaKcoj79vbvmQbX38aD6pprLfyxcPe5vbn+
         1uSgOJQautwojvh+aOUUydobbUGAeF8u06so5t9DR4ez7mMI+iWP966ZCFyRhZgmUufs
         a25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VTsL/mnGXOHM15tEpa+zlSLbM4q0ZXZQuhhqE0xKDOg=;
        b=OjGBboBZMqzybkmUReMT3kRjjRvhV+o/mmci093Q145hxIGISdXxCj0cErSGH0maEM
         C6diYNiOijeRj2JOdl4q7ZiClFFw4rECW6cK7kYIQtTJT+QkO8Ull8v+8e/IL/I27ytS
         nCNYtfOH5oq4Ty0JkYrmRVeXy+D/r61h1lGmnJrgxkEeQtSFzgIOgad6i8WnUIAviDu+
         0U9hJkpd+AR0dbWaaURjL6kTOzUbTuUJVzMPXJqL917x8/2wXgsHjXH9dZJwGJ46nFdM
         jp+CvE9a2uKBU3ZYWjXmT1rqAvLfmeBJhrd5EHDwCasLJLHzheAsEF8YWLSMoB0c5Qx7
         IQZQ==
X-Gm-Message-State: AOAM531P9ochViRWZp50s57TNALWLcURmewHdh7+q6gfxImY4HbLXigj
        7jwd3nLAJ0ym0OSKEWkc9qY5hEbyWr23lh1r3atgEzfcv3Bgx4vxLj6S+PTRhA+rrc5jokrWP6w
        kOZlYyyVmyuwTD4wMX80DN6Kgy+QsVpnGtzWYmZi1gy5FdHzq+WMj4rD2gtzmJfVUJN55ZztC
X-Google-Smtp-Source: ABdhPJz09wCJhmN9z7CBaH9UqXRZofHqCdOkKZzvQQ5/yHeh/3cb1+vv+8QS2g+MAJUAqa0xvU1RBFlbNKRJ
Sender: "eranian via sendgmr" <eranian@uluru3.svl.corp.google.com>
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe0f:9db2])
 (user=eranian job=sendgmr) by 2002:a25:388d:: with SMTP id
 f135mr8063582yba.54.1603315077676; Wed, 21 Oct 2020 14:17:57 -0700 (PDT)
Date:   Wed, 21 Oct 2020 14:16:12 -0700
Message-Id: <20201021211612.2026234-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH] perf/x86/intel: make anythread filter support conditional
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

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/core.c      | 20 ++++++++++++++++++++
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h |  4 +++-
 arch/x86/kvm/cpuid.c              |  4 +++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f1926e9f2143..65bf649048a6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4220,6 +4220,16 @@ static struct attribute *intel_arch3_formats_attr[] = {
 	NULL,
 };
 
+static struct attribute *intel_arch5_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_pc.attr,
+	&format_attr_inv.attr,
+	&format_attr_cmask.attr,
+	NULL,
+};
+
 static struct attribute *hsw_format_attr[] = {
 	&format_attr_in_tx.attr,
 	&format_attr_in_tx_cp.attr,
@@ -4987,6 +4997,12 @@ __init int intel_pmu_init(void)
 
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
@@ -5512,6 +5528,10 @@ __init int intel_pmu_init(void)
 	x86_pmu.intel_ctrl |=
 		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
 
+	/* AnyThread may be deprecated on arch perfmon v5 or later */
+	if (x86_pmu.intel_cap.anythread_deprecated)
+		x86_pmu.format_attrs = intel_arch5_formats_attr;
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
2.29.0.rc2.309.g374f81d7ae-goog

