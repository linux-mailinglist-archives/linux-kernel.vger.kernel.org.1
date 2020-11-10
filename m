Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E744D2AD315
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbgKJKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbgKJKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:04:21 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3B0C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:21 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id 97so6303434plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KgS8vGvEuu+TfOWvR58Dhpdw0+LAwQavuZrBUFHUIzI=;
        b=mZ0Isq+0IwmLRdpUJu8k5Z1Ehi5aw3jH3eW3GTWFt+uBf6mkd6o68DwNyk5SsUMUWB
         mW1rIoqBl8BGRxfCL/LkvDHzQHpGqxGlH9AtlBDHy6HjLzkcz4a2MNaoOdXNbnZ0eM9A
         /xCoR2cHuH5IqLpoSoBgSTSaeG/c9YKqvwFPcD8qAn8NpUtVVuCmjw9veyJUXJEAnGAN
         A9mX1d7bmuC/OR1X+FDvSiJEWhvOZRvV3s7mJ4NIUEGTIWKiUDXbtz4QhENnaDbDSiXg
         YXxnAKtKg0ob7hSQ7FVXFGRbtZWSy9aMfSLWdL+WK8M43hGyCTXj3zEXfTsQ1c9h9MMs
         SW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KgS8vGvEuu+TfOWvR58Dhpdw0+LAwQavuZrBUFHUIzI=;
        b=jEjBwAUBtyEpkrH5NaRFsIwFCxt7eRZl/LrPXv3noLbXhQh2n6WE2CrrV3tV6vrUDy
         5K+ZLSwORtrejlg0XRAt56RWADssgZsHUZdWQGs6hfMiBecEYC2bdt1NTTkPhE78Z6Bi
         e6o3XZ4iegL8okKDDfsZ2jJKvF728Xt8pv7Jbqdr2cF4b6pdIQkgYsEDY+A50D7LvTjS
         fqbe8OL49d0awG/OUgjn7GUOgu2ZjEgFbxHPq5Nxy05uWc24ZEaR2vM1yrWTFjiDYVZA
         gIgQDRKkuRSF0sn8pGfu7pOXDbGWYo1pZ8uxa3PFEl6iTqHf18fHOh708ediqYT8DbaR
         Ritw==
X-Gm-Message-State: AOAM532jx3/wh0NohAA0DlmEdguQ9ICzYitVSM6xrvhx3VR+Y/hSKSsN
        vraXWRzR3GhfMwU3cPI3s8tmawFxGT2D
X-Google-Smtp-Source: ABdhPJzlHeFm/kTQ6oYMFS2Hcvl/8oMhwkvlyX0P2cyA9KAH4ZUzKasiMw+yI91h8S2dX+oiFtfYEACSTLte
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:aa7:8d05:0:b029:18b:6f5f:1ea with SMTP id
 j5-20020aa78d050000b029018b6f5f01eamr17813692pfe.38.1605002661167; Tue, 10
 Nov 2020 02:04:21 -0800 (PST)
Date:   Tue, 10 Nov 2020 02:03:46 -0800
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
Message-Id: <20201110100346.2527031-13-irogers@google.com>
Mime-Version: 1.0
References: <20201110100346.2527031-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [RFC PATCH 12/12] perf pmu-events: Topdown parser tool
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

From: Sandeep Dasgupta <sdasgup@google.com>

A tool for processing Intel's TMA_Metrics.csv and from it generating
metrics encoded as json.

As an example, the build here is configured to wget TMA_Metrics.csv
from download.01.org/perfmon and then build the metric json using
events encoded in the pmu-events directory. As the TMA_Metrics.csv is
newer there are missing event encodings that will be warned about, in
particular icelake PERF_METRICS.*.

On a Skylakex this shows with 'perf list metricgroups' the new groups
of:
  Topdown_Group_Backend
  Topdown_Group_BadSpec
  Topdown_Group_BrMispredicts
  Topdown_Group_Cache_Misses
  Topdown_Group_DSB
  Topdown_Group_FLOPS
  Topdown_Group_Fetch_BW
  Topdown_Group_Fetch_Lat
  Topdown_Group_Frontend
  Topdown_Group_HPC
  Topdown_Group_IcMiss
  Topdown_Group_Machine_Clears
  Topdown_Group_Memory_BW
  Topdown_Group_Memory_Bound
  Topdown_Group_Memory_Lat
  Topdown_Group_MicroSeq
  Topdown_Group_Offcore
  Topdown_Group_Ports_Utilization
  Topdown_Group_Retire
  Topdown_Group_TLB
  Topdown_Group_TopDownL1
  Topdown_Group_TopDownL2

And the new metrics of:
  Topdown_Metric_Backend_Bound
  Topdown_Metric_Bad_Speculation
  Topdown_Metric_Branch_Mispredicts
  Topdown_Metric_Branch_Resteers
  Topdown_Metric_Core_Bound
  Topdown_Metric_DRAM_Bound
  Topdown_Metric_DSB
  Topdown_Metric_DSB_Switches
  Topdown_Metric_DTLB_Load
  Topdown_Metric_Divider
  Topdown_Metric_FB_Full
  Topdown_Metric_FP_Arith
  Topdown_Metric_FP_Scalar
  Topdown_Metric_FP_Vector
  Topdown_Metric_Fetch_Bandwidth
  Topdown_Metric_Fetch_Latency
  Topdown_Metric_Frontend_Bound
  Topdown_Metric_Heavy_Operations
  Topdown_Metric_ICache_Misses
  Topdown_Metric_ITLB_Misses
  Topdown_Metric_L1_Bound
  Topdown_Metric_L2_Bound
  Topdown_Metric_L3_Bound
  Topdown_Metric_Light_Operations
  Topdown_Metric_MEM_Bandwidth
  Topdown_Metric_MEM_Latency
  Topdown_Metric_MITE
  Topdown_Metric_MS_Switches
  Topdown_Metric_Machine_Clears
  Topdown_Metric_Memory_Bound
  Topdown_Metric_Microcode_Sequencer
  Topdown_Metric_Other
  Topdown_Metric_Ports_Utilization
  Topdown_Metric_Retiring
  Topdown_Metric_Serializing_Operation
  Topdown_Metric_Store_Bound

Using one of the metric groups shows:
$ perf stat -M Topdown_Group_TopDownL1 -a

 Performance counter stats for 'system wide':

    18,224,977,565      cpu/idq_uops_not_delivered.core,edge,any,inv/ #     0.38 Topdown_Metric_Frontend_Bound
                                                  #     0.44 Topdown_Metric_Backend_Bound  (57.11%)
       450,438,658      cpu/int_misc.recovery_cycles,edge,any,inv/ #     0.07 Topdown_Metric_Bad_Speculation  (57.11%)
    11,981,273,993      cpu/cpu_clk_unhalted.thread,edge,any,inv/ #     0.11 Topdown_Metric_Retiring  (57.13%)
     5,288,258,009      cpu/uops_retired.retire_slots,edge,any,inv/                                     (57.17%)
     6,808,261,153      cpu/uops_issued.any,edge,any,inv/                                     (57.19%)
       456,255,269      cpu/int_misc.recovery_cycles_any,edge,any,inv/                                     (57.17%)
    12,383,804,530      cpu/cpu_clk_unhalted.thread_any,edge,any,inv/                                     (57.12%)

      10.159307832 seconds time elapsed

Co-authored-by: Stephane Eranian <eranian@google.com>
Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 tools/perf/Makefile.perf    | 13 +++++++++-
 tools/perf/pmu-events/Build | 50 ++++++++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ce3f2e8b9c7..b1f4145ca757 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -634,6 +634,11 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
 
+TOPDOWN_PARSER    := $(OUTPUT)pmu-events/topdown_parser
+TOPDOWN_PARSER_IN := $(OUTPUT)pmu-events/topdown_parser-in.o
+
+export TOPDOWN_PARSER
+
 JEVENTS       := $(OUTPUT)pmu-events/jevents
 JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
 
@@ -646,13 +651,19 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
+$(TOPDOWN_PARSER_IN): FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=topdown_parser
+
+$(TOPDOWN_PARSER): $(TOPDOWN_PARSER_IN)
+	$(QUIET_LINK)$(HOSTCC) $(TOPDOWN_PARSER_IN) -lstdc++ -o $@
+
 $(JEVENTS_IN): FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=jevents
 
 $(JEVENTS): $(JEVENTS_IN)
 	$(QUIET_LINK)$(HOSTCC) $(JEVENTS_IN) -o $@
 
-$(PMU_EVENTS_IN): $(JEVENTS) FORCE
+$(PMU_EVENTS_IN): $(JEVENTS) $(TOPDOWN_PARSER) FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
 $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 215ba30b8534..d54bf9e8c224 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,15 +1,57 @@
-hostprogs := jevents
+hostprogs := jevents topdown_parser
 
 jevents-y	+= json.o jsmn.o jevents.o
 HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
-pmu-events-y	+= pmu-events.o
+
+topdown_parser-y	+= topdown-parser/code_gen_target.o
+topdown_parser-y	+= topdown-parser/code_gen_target_perf_json.o
+topdown_parser-y	+= topdown-parser/configuration.o
+topdown_parser-y	+= topdown-parser/csvreader.o
+topdown_parser-y	+= topdown-parser/dependence_dag_utils.o
+topdown_parser-y	+= topdown-parser/event_info.o
+topdown_parser-y	+= topdown-parser/expr_parser-bison.o
+topdown_parser-y	+= topdown-parser/general_utils.o
+topdown_parser-y	+= topdown-parser/jsmn_extras.o
+topdown_parser-y	+= topdown-parser/topdown_parser_main.o
+topdown_parser-y	+= jsmn.o
+CXXFLAGS_topdown_parser += -I$(OUTPUT)pmu-events/topdown-parser
+
+$(OUTPUT)pmu-events/topdown-parser/expr_parser-bison.cpp $(OUTPUT)pmu-events/topdown-parser/expr_parser-bison.hpp: pmu-events/topdown-parser/expr_parser.y
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@
+
+$(OUTPUT)pmu-events/topdown-parser/code_gen_target_perf_json.o: pmu-events/topdown-parser/code_gen_target_perf_json.cpp $(OUTPUT)pmu-events/topdown-parser/expr_parser-bison.hpp
+	$(call rule_mkdir)
+	$(call if_changed_dep,cxx_o_c)
+
+$(OUTPUT)pmu-events/topdown-parser/event_info.o: pmu-events/topdown-parser/event_info.cpp $(OUTPUT)pmu-events/topdown-parser/expr_parser-bison.hpp
+	$(call rule_mkdir)
+	$(call if_changed_dep,cxx_o_c)
+
+TMA_METRICS = $(OUTPUT)pmu-events/TMA_Metrics.csv
+
+$(TMA_METRICS):
+	$(call rule_mkdir)
+	wget -O $@ https://download.01.org/perfmon/TMA_Metrics.csv
+
 JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell [ -d $(JDIR) ] &&				\
 			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
 
+$(OUTPUT)pmu-events/arch: pmu-events/topdown-parser/configuration.json $(TOPDOWN_PARSER) $(TMA_METRICS) $(JSON)
+	mkdir -p $(OUTPUT)pmu-events/arch
+	cp -R pmu-events/arch $(OUTPUT)pmu-events/
+	$(TOPDOWN_PARSER) \
+	    --csv-file $(TMA_METRICS) \
+	    --events-data-dir pmu-events/arch/x86 \
+            --config-file $< \
+            --output-path $(OUTPUT)pmu-events/arch/x86
+
+pmu-events-y	+= pmu-events.o
+
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
 #
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JEVENTS)
-	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
+$(OUTPUT)pmu-events/pmu-events.c: $(OUTPUT)pmu-events/arch $(JSON) $(JEVENTS)
+	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) $(OUTPUT)pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
-- 
2.29.2.222.g5d2a92d10f8-goog

