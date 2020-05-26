Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBD91BF1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD3HwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 03:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgD3HwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:52:09 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B93C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:09 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d15so5616617qkl.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=F4O7lQTtie4LkwM6qvAlzhGo2gFCLr81rEIUXEPhJKk=;
        b=h7nrTyb8MZfmh4JUCWjoidqdtwwatLB6aQXFhhedEbWN4MmtUUkUsJUbUeMuxR3tQL
         7Bwjohh6MT4fNLyK+P+c+fFLqNveV0dnhrmP2GPtoZiIGGIntxFP8gPYf7XPtrtnbJ2U
         hTxPTDbyor2KwaXxcxTAloe72EzKj7Q6/JUGgC9Br84C8ZK6UlQw0gtjs0jpf+NhuuRR
         IxV+2NtIkIYjJi4ZOc/YoPPn8DW/5odoJxuCN/zW0ch6vVZSN++lcLt31iK+ux7Mq1bs
         d0jHgcHCbiexF1RSOgGlsT20MGrgqS6s/ruId5Ofjh0Es7D98qk0CtNlXNRD8DYT9giy
         COeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=F4O7lQTtie4LkwM6qvAlzhGo2gFCLr81rEIUXEPhJKk=;
        b=Dgn3rN7/t4bStRuPj/fZ2A1S/kRGD/kLVYiSj3jhF5+bop+BEIzZUK1ei9YHXwXs0Z
         7ZuxYpt7ioxc+Q/zeMDUZxN14fpFbZWB6oDUL/ljZ9UfsKZREhFdfR+z1oWJ7stExGtd
         EcRLKLy3N/wMJMze50S0E6f/O/d/ZX7xWwbMuQdAS5vb7Gqoxu3A9ErOfd4EEjjHFwPd
         qwKy06h33USe5wzVdNhKflDItWamAcoXTQbJmDvw/qQexn3RzBXPm78f8jPbWfYc8mrb
         gn0RFTpTaxlv0/NjH/BjNRklktTqrL1N36H4Z7d3F8KMm/oRTiOWntx+7ZfOdn5BCW8i
         7sPg==
X-Gm-Message-State: AGi0PuZsIbp9ksmsEucKyKZ0hJg8cNY7dQrI6vyTCjW4k+d7HQ5RbpGt
        9O6aYTXS0y3I/q0RaLQ5pZlXx9iPsK4E
X-Google-Smtp-Source: APiQypLcc6oCYtUNaOKhSup2CchYgVcUllO+k7j/8K0NZ0YN9BYpWNXxTjJ03CJB2Segl4/RMk056PoUHxuJ
X-Received: by 2002:a0c:b751:: with SMTP id q17mr1643227qve.97.1588233128167;
 Thu, 30 Apr 2020 00:52:08 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:43 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-12-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 11/12] perf parse-events: expand add PMU error/verbose messages
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a CPU like skylakex an uncore_iio_0 PMU may alias with
uncore_iio_free_running_0. The latter PMU doesn't support fc_mask
as a parameter and so pmu_config_term fails. Typically
parse_events_add_pmu is called in a loop where if one alias succeeds
errors are ignored, however, if multiple errors occur
parse_events__handle_error will currently give a WARN_ONCE.

This change removes the WARN_ONCE in parse_events__handle_error and
makes it a pr_debug. It adds verbose messages to parse_events_add_pmu
warning that non-fatal errors may occur, while giving details on the pmu
and config terms for useful context. pmu_config_term is altered so the
failing term and pmu are present in the case of the 'unknown term'
error which makes spotting the free_running case more straightforward.

Before:
$ perf --debug verbose=3D3 stat -M llc_misses.pcie_read sleep 1
Using CPUID GenuineIntel-6-55-4
metric expr unc_iio_data_req_of_cpu.mem_read.part0 + unc_iio_data_req_of_cp=
u.mem_read.part1 + unc_iio_data_req_of_cpu.mem_read.part2 + unc_iio_data_re=
q_of_cpu.mem_read.part3 for LLC_MISSES.PCIE_READ
found event unc_iio_data_req_of_cpu.mem_read.part0
found event unc_iio_data_req_of_cpu.mem_read.part1
found event unc_iio_data_req_of_cpu.mem_read.part2
found event unc_iio_data_req_of_cpu.mem_read.part3
metric expr unc_iio_data_req_of_cpu.mem_read.part0 + unc_iio_data_req_of_cp=
u.mem_read.part1 + unc_iio_data_req_of_cpu.mem_read.part2 + unc_iio_data_re=
q_of_cpu.mem_read.part3 for LLC_MISSES.PCIE_READ
found event unc_iio_data_req_of_cpu.mem_read.part0
found event unc_iio_data_req_of_cpu.mem_read.part1
found event unc_iio_data_req_of_cpu.mem_read.part2
found event unc_iio_data_req_of_cpu.mem_read.part3
adding {unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_of_cpu.mem_=
read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_req_of_cpu.m=
em_read.part3}:W,{unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_o=
f_cpu.mem_read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_re=
q_of_cpu.mem_read.part3}:W
intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
WARNING: multiple event parsing errors
...
Invalid event/parameter 'fc_mask'
...

After:
$ perf --debug verbose=3D3 stat -M llc_misses.pcie_read sleep 1
Using CPUID GenuineIntel-6-55-4
metric expr unc_iio_data_req_of_cpu.mem_read.part0 + unc_iio_data_req_of_cp=
u.mem_read.part1 + unc_iio_data_req_of_cpu.mem_read.part2 + unc_iio_data_re=
q_of_cpu.mem_read.part3 for LLC_MISSES.PCIE_READ
found event unc_iio_data_req_of_cpu.mem_read.part0
found event unc_iio_data_req_of_cpu.mem_read.part1
found event unc_iio_data_req_of_cpu.mem_read.part2
found event unc_iio_data_req_of_cpu.mem_read.part3
metric expr unc_iio_data_req_of_cpu.mem_read.part0 + unc_iio_data_req_of_cp=
u.mem_read.part1 + unc_iio_data_req_of_cpu.mem_read.part2 + unc_iio_data_re=
q_of_cpu.mem_read.part3 for LLC_MISSES.PCIE_READ
found event unc_iio_data_req_of_cpu.mem_read.part0
found event unc_iio_data_req_of_cpu.mem_read.part1
found event unc_iio_data_req_of_cpu.mem_read.part2
found event unc_iio_data_req_of_cpu.mem_read.part3
adding {unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_of_cpu.mem_=
read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_req_of_cpu.m=
em_read.part3}:W,{unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_o=
f_cpu.mem_read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_re=
q_of_cpu.mem_read.part3}:W
intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
Attempting to add event pmu 'uncore_iio_free_running_5' with 'unc_iio_data_=
req_of_cpu.mem_read.part0,' that may result in non-fatal errors
After aliases, add event pmu 'uncore_iio_free_running_5' with 'fc_mask,ch_m=
ask,umask,event,' that may result in non-fatal errors
Attempting to add event pmu 'uncore_iio_free_running_3' with 'unc_iio_data_=
req_of_cpu.mem_read.part0,' that may result in non-fatal errors
After aliases, add event pmu 'uncore_iio_free_running_3' with 'fc_mask,ch_m=
ask,umask,event,' that may result in non-fatal errors
Attempting to add event pmu 'uncore_iio_free_running_1' with 'unc_iio_data_=
req_of_cpu.mem_read.part0,' that may result in non-fatal errors
After aliases, add event pmu 'uncore_iio_free_running_1' with 'fc_mask,ch_m=
ask,umask,event,' that may result in non-fatal errors
Multiple errors dropping message: unknown term 'fc_mask' for pmu 'uncore_ii=
o_free_running_3' (valid terms: event,umask,config,config1,config2,name,per=
iod,percore)
...

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 32 ++++++++++++++++++-----------
 tools/perf/tests/pmu.c              |  4 ++--
 tools/perf/util/parse-events.c      | 29 +++++++++++++++++++++++++-
 tools/perf/util/pmu.c               | 32 ++++++++++++++++++-----------
 tools/perf/util/pmu.h               |  2 +-
 5 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util=
/intel-pt.c
index 1643aed8c4c8..1306cd9d8d58 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -58,7 +58,8 @@ struct intel_pt_recording {
 	size_t				priv_size;
 };
=20
-static int intel_pt_parse_terms_with_default(struct list_head *formats,
+static int intel_pt_parse_terms_with_default(const char *pmu_name,
+					     struct list_head *formats,
 					     const char *str,
 					     u64 *config)
 {
@@ -77,7 +78,8 @@ static int intel_pt_parse_terms_with_default(struct list_=
head *formats,
 		goto out_free;
=20
 	attr.config =3D *config;
-	err =3D perf_pmu__config_terms(formats, &attr, terms, true, NULL);
+	err =3D perf_pmu__config_terms(pmu_name, formats, &attr, terms, true,
+				     NULL);
 	if (err)
 		goto out_free;
=20
@@ -87,11 +89,12 @@ static int intel_pt_parse_terms_with_default(struct lis=
t_head *formats,
 	return err;
 }
=20
-static int intel_pt_parse_terms(struct list_head *formats, const char *str=
,
-				u64 *config)
+static int intel_pt_parse_terms(const char *pmu_name, struct list_head *fo=
rmats,
+				const char *str, u64 *config)
 {
 	*config =3D 0;
-	return intel_pt_parse_terms_with_default(formats, str, config);
+	return intel_pt_parse_terms_with_default(pmu_name, formats, str,
+						 config);
 }
=20
 static u64 intel_pt_masked_bits(u64 mask, u64 bits)
@@ -228,7 +231,8 @@ static u64 intel_pt_default_config(struct perf_pmu *int=
el_pt_pmu)
=20
 	pr_debug2("%s default config: %s\n", intel_pt_pmu->name, buf);
=20
-	intel_pt_parse_terms(&intel_pt_pmu->format, buf, &config);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format, buf,
+			     &config);
=20
 	return config;
 }
@@ -336,13 +340,16 @@ static int intel_pt_info_fill(struct auxtrace_record =
*itr,
 	if (priv_size !=3D ptr->priv_size)
 		return -EINVAL;
=20
-	intel_pt_parse_terms(&intel_pt_pmu->format, "tsc", &tsc_bit);
-	intel_pt_parse_terms(&intel_pt_pmu->format, "noretcomp",
-			     &noretcomp_bit);
-	intel_pt_parse_terms(&intel_pt_pmu->format, "mtc", &mtc_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "tsc", &tsc_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "noretcomp", &noretcomp_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "mtc", &mtc_bit);
 	mtc_freq_bits =3D perf_pmu__format_bits(&intel_pt_pmu->format,
 					      "mtc_period");
-	intel_pt_parse_terms(&intel_pt_pmu->format, "cyc", &cyc_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "cyc", &cyc_bit);
=20
 	intel_pt_tsc_ctc_ratio(&tsc_ctc_ratio_n, &tsc_ctc_ratio_d);
=20
@@ -768,7 +775,8 @@ static int intel_pt_recording_options(struct auxtrace_r=
ecord *itr,
 		}
 	}
=20
-	intel_pt_parse_terms(&intel_pt_pmu->format, "tsc", &tsc_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "tsc", &tsc_bit);
=20
 	if (opts->full_auxtrace && (intel_pt_evsel->core.attr.config & tsc_bit))
 		have_timing_info =3D true;
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 74379ff1f7fa..5c11fe2b3040 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -156,8 +156,8 @@ int test__pmu(struct test *test __maybe_unused, int sub=
test __maybe_unused)
 		if (ret)
 			break;
=20
-		ret =3D perf_pmu__config_terms(&formats, &attr, terms,
-					     false, NULL);
+		ret =3D perf_pmu__config_terms("perf-pmu-test", &formats, &attr,
+					     terms, false, NULL);
 		if (ret)
 			break;
=20
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index 10107747b361..b057819d35cd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -204,7 +204,8 @@ void parse_events__handle_error(struct parse_events_err=
or *err, int idx,
 		err->help =3D help;
 		break;
 	default:
-		WARN_ONCE(1, "WARNING: multiple event parsing errors\n");
+		pr_debug("Multiple errors dropping message: %s (%s)\n",
+			err->str, err->help);
 		free(err->str);
 		err->str =3D str;
 		free(err->help);
@@ -1424,6 +1425,19 @@ int parse_events_add_pmu(struct parse_events_state *=
parse_state,
 	bool use_uncore_alias;
 	LIST_HEAD(config_terms);
=20
+	if (verbose > 1) {
+		fprintf(stderr, "Attempting to add event pmu '%s' with '",
+			name);
+		if (head_config) {
+			struct parse_events_term *term;
+
+			list_for_each_entry(term, head_config, list) {
+				fprintf(stderr, "%s,", term->config);
+			}
+		}
+		fprintf(stderr, "' that may result in non-fatal errors\n");
+	}
+
 	pmu =3D perf_pmu__find(name);
 	if (!pmu) {
 		char *err_str;
@@ -1460,6 +1474,19 @@ int parse_events_add_pmu(struct parse_events_state *=
parse_state,
 	if (perf_pmu__check_alias(pmu, head_config, &info))
 		return -EINVAL;
=20
+	if (verbose > 1) {
+		fprintf(stderr, "After aliases, add event pmu '%s' with '",
+			name);
+		if (head_config) {
+			struct parse_events_term *term;
+
+			list_for_each_entry(term, head_config, list) {
+				fprintf(stderr, "%s,", term->config);
+			}
+		}
+		fprintf(stderr, "' that may result in non-fatal errors\n");
+	}
+
 	/*
 	 * Configure hardcoded terms first, no need to check
 	 * return value when called with fail =3D=3D 0 ;)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d9f89ed18dea..2bc820a542da 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1045,7 +1045,8 @@ static char *pmu_formats_string(struct list_head *for=
mats)
  * Setup one of config[12] attr members based on the
  * user input data - term parameter.
  */
-static int pmu_config_term(struct list_head *formats,
+static int pmu_config_term(const char *pmu_name,
+			   struct list_head *formats,
 			   struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct list_head *head_terms,
@@ -1071,16 +1072,23 @@ static int pmu_config_term(struct list_head *format=
s,
=20
 	format =3D pmu_find_format(formats, term->config);
 	if (!format) {
-		if (verbose > 0)
-			printf("Invalid event/parameter '%s'\n", term->config);
+		char *pmu_term =3D pmu_formats_string(formats);
+		char *unknown_term;
+		char *help_msg;
+
+		asprintf(&unknown_term,
+			"unknown term '%s' for pmu '%s'",
+			term->config, pmu_name);
+		help_msg =3D parse_events_formats_error_string(pmu_term);
 		if (err) {
-			char *pmu_term =3D pmu_formats_string(formats);
-
 			parse_events__handle_error(err, term->err_term,
-				strdup("unknown term"),
-				parse_events_formats_error_string(pmu_term));
-			free(pmu_term);
+						   unknown_term,
+						   help_msg);
+		} else {
+			pr_debug("%s (%s)\n", unknown_term, help_msg);
+			free(unknown_term);
 		}
+		free(pmu_term);
 		return -EINVAL;
 	}
=20
@@ -1157,7 +1165,7 @@ static int pmu_config_term(struct list_head *formats,
 	return 0;
 }
=20
-int perf_pmu__config_terms(struct list_head *formats,
+int perf_pmu__config_terms(const char *pmu_name, struct list_head *formats=
,
 			   struct perf_event_attr *attr,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *err)
@@ -1165,7 +1173,7 @@ int perf_pmu__config_terms(struct list_head *formats,
 	struct parse_events_term *term;
=20
 	list_for_each_entry(term, head_terms, list) {
-		if (pmu_config_term(formats, attr, term, head_terms,
+		if (pmu_config_term(pmu_name, formats, attr, term, head_terms,
 				    zero, err))
 			return -EINVAL;
 	}
@@ -1185,8 +1193,8 @@ int perf_pmu__config(struct perf_pmu *pmu, struct per=
f_event_attr *attr,
 	bool zero =3D !!pmu->default_config;
=20
 	attr->type =3D pmu->type;
-	return perf_pmu__config_terms(&pmu->format, attr, head_terms,
-				      zero, err);
+	return perf_pmu__config_terms(pmu->name, &pmu->format, attr,
+				      head_terms, zero, err);
 }
=20
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 1edd214b75a5..ae2466ce01b5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -75,7 +75,7 @@ struct perf_pmu *perf_pmu__find(const char *name);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-int perf_pmu__config_terms(struct list_head *formats,
+int perf_pmu__config_terms(const char *pmu_name, struct list_head *formats=
,
 			   struct perf_event_attr *attr,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *error);
--=20
2.26.2.303.gf8c07b1a785-goog

