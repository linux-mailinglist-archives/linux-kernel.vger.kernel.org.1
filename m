Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB86F2D5617
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgLJJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:07:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:6083 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbgLJJG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:06:58 -0500
IronPort-SDR: v018thi3x7y2+19o9W+tkYjUtO3pxmfgoJ1soyBnlTGj2OZsD9t+0JoU2T0S18sz5lSKneJ1iX
 nGUgOvEuH7Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="170712763"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="170712763"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 01:04:04 -0800
IronPort-SDR: tctoK6Hrl+Bt2ZvDCT9mJGnpM1XFoCzZvngOXcXHEUsXblTeF4UDvf0N80d/hcKf8sqYPdyHAd
 eawEF3cSbROQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="408450153"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2020 01:04:00 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, mingo@redhat.com, peterz@infradead.org,
        ak@linux.intel.com, alexander.antonov@linux.intel.com
Subject: [PATCH 5/5] perf stat: Enable --iiostat mode for x86 platforms
Date:   Thu, 10 Dec 2020 12:03:40 +0300
Message-Id: <20201210090340.14358-6-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
References: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functionality is based on recently introduced sysfs attributes
for Intel® Xeon® Scalable processor family (code name Skylake-SP):
Commit bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to
IIO PMON mapping")

Mode is intended to provide four I/O performance metrics in MB per each
IIO stack:
 - Inbound Read: I/O devices below IIO stack read from the host memory
 - Inbound Write: I/O devices below IIO stack write to the host memory
 - Outbound Read: CPU reads from I/O devices below IIO stack
 - Outbound Write: CPU writes to I/O devices below IIO stack

Each metric requiries only one IIO event which increments at every 4B
transfer in corresponding direction. The formulas to compute metrics
are generic:
    #EventCount * 4B / (1024 * 1024)

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  31 +++
 tools/perf/arch/x86/util/Build         |   1 +
 tools/perf/arch/x86/util/iiostat.c     | 335 +++++++++++++++++++++++++
 3 files changed, 367 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 5d4a673d7621..2c066f7e0681 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -121,6 +121,37 @@ to activate system-wide monitoring. Default is to count on all CPUs.
 -A::
 --no-aggr::
 Do not aggregate counts across all monitored CPUs.
+--iiostat::
+Mode is intended to provide four I/O performance metrics per each IIO
+stack (PCIe root port):
+    --Inbound Read(MB)   - I/O devices below IIO stack read from the host memory, in MB
+    --Inbound Write(MB)  - I/O devices below IIO stack write to the host memory, in MB
+    --Outbound Read(MB)  - CPU reads from I/O devices below IIO stack, in MB
+    --Outbound Write(MB) - CPU writes to I/O devices below IIO stack, in MB
+
+Sample output:
+
+Show all IIO stacks on 2-S platform:
+  $ perf stat --iiostat=show
+    S0-uncore_iio_0<0000:00>
+    S1-uncore_iio_0<0000:80>
+    S0-uncore_iio_1<0000:17>
+    S1-uncore_iio_1<0000:85>
+    S0-uncore_iio_2<0000:3a>
+    S1-uncore_iio_2<0000:ae>
+    S0-uncore_iio_3<0000:5d>
+    S1-uncore_iio_3<0000:d7>
+
+Print metrics for requested IIO stacks, multiple comma-separated list supported.
+  $ perf stat --iiostat=0000:17 -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
+		357708+0 records in
+		357707+0 records out
+		375083606016 bytes (375 GB, 349 GiB) copied, 213.997 s, 1.8 GB/s
+
+   Performance counter stats for 'system wide':
+
+     port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
+  0000:17               358559                   44                    0                   22
 
 -n::
 --null::
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 347c39b960eb..6fa275d3d897 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ perf-y += perf_regs.o
 perf-y += topdown.o
 perf-y += machine.o
 perf-y += event.o
+perf-y += iiostat.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/iiostat.c b/tools/perf/arch/x86/util/iiostat.c
index 70f93a96723f..44342a111746 100644
--- a/tools/perf/arch/x86/util/iiostat.c
+++ b/tools/perf/arch/x86/util/iiostat.c
@@ -27,6 +27,44 @@
 #include "util/counts.h"
 #include "path.h"
 
+#ifndef MAX_PATH
+#define MAX_PATH 1024
+#endif
+
+#define UNCORE_IIO_PMU_PATH	"devices/uncore_iio_%d"
+#define SYSFS_UNCORE_PMU_PATH	"%s/"UNCORE_IIO_PMU_PATH
+#define PLATFORM_MAPPING_PATH	UNCORE_IIO_PMU_PATH"/die%d"
+
+enum iiostat_mode_t {
+	IIOSTAT_NONE		= -1,
+	IIOSTAT_RUN		= 0,
+	IIOSTAT_SHOW		= 1
+};
+
+static enum iiostat_mode_t iiostat_mode = IIOSTAT_NONE;
+
+/*
+ * Each metric requiries only one IIO event which increments at every 4B transfer
+ * in corresponding direction. The formulas to compute metrics are generic:
+ *     #EventCount * 4B / (1024 * 1024)
+ */
+static const char * const iiostat_metrics[] = {
+	"Inbound Read(MB)",
+	"Inbound Write(MB)",
+	"Outbound Read(MB)",
+	"Outbound Write(MB)",
+};
+
+static inline int iiostat_metrics_count(void)
+{
+	return sizeof(iiostat_metrics) / sizeof(char *);
+}
+
+static const char *iiostat_metric_by_idx(int idx)
+{
+	return *(iiostat_metrics + idx % iiostat_metrics_count());
+}
+
 struct iio_root_port {
 	u32 domain;
 	u8 bus;
@@ -123,3 +161,300 @@ static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
 	}
 	return 0;
 }
+
+static int uncore_pmu_iio_platform_mapping(u8 pmu_idx, struct iio_root_ports_list * const list)
+{
+	char *buf;
+	char path[MAX_PATH];
+	u32 domain;
+	u8 bus;
+	struct iio_root_port *rp;
+	size_t size;
+	int ret;
+
+	for (int die = 0; die < cpu__max_node(); die++) {
+		scnprintf(path, MAX_PATH, PLATFORM_MAPPING_PATH, pmu_idx, die);
+		if (sysfs__read_str(path, &buf, &size) < 0) {
+			if (pmu_idx)
+				goto out;
+			pr_err("Mode iiostat is not supported\n");
+			return -1;
+		}
+		ret = sscanf(buf, "%04x:%02hhx", &domain, &bus);
+		free(buf);
+		if (ret != 2) {
+			pr_err("Invalid mapping data: iio_%d; die%d\n", pmu_idx, die);
+			return -1;
+		}
+		rp = iio_root_port_new(domain, bus, die, pmu_idx);
+		if (!rp || iio_root_ports_list_insert(list, rp)) {
+			free(rp);
+			return -ENOMEM;
+		}
+	}
+out:
+	return 0;
+}
+
+static u8 iio_pmu_count(void)
+{
+	u8 pmu_idx = 0;
+	char path[MAX_PATH];
+	const char *sysfs = sysfs__mountpoint();
+
+	if (sysfs) {
+		for (;; pmu_idx++) {
+			snprintf(path, sizeof(path), SYSFS_UNCORE_PMU_PATH,
+				 sysfs, pmu_idx);
+			if (access(path, F_OK) != 0)
+				break;
+		}
+	}
+	return pmu_idx;
+}
+
+static int iio_root_ports_scan(struct iio_root_ports_list **list)
+{
+	int ret = -ENOMEM;
+	struct iio_root_ports_list *tmp_list;
+	u8 pmu_count = iio_pmu_count();
+
+	if (!pmu_count) {
+		pr_err("Unsupported uncore pmu configuration\n");
+		return -1;
+	}
+
+	tmp_list = iio_root_ports_list_new();
+	if (!tmp_list)
+		goto err;
+
+	for (u8 pmu_idx = 0; pmu_idx < pmu_count; pmu_idx++) {
+		ret = uncore_pmu_iio_platform_mapping(pmu_idx, tmp_list);
+		if (ret)
+			break;
+	}
+err:
+	if (!ret)
+		*list = tmp_list;
+	else
+		iio_root_ports_list_free(tmp_list);
+
+	return ret;
+}
+
+static int iio_root_port_parse_str(u32 *domain, u8 *bus, char *str)
+{
+	int ret;
+	regex_t regex;
+	/*
+	 * Expected format domain:bus:
+	 * Valid domain range [0:ffff]
+	 * Valid bus range [0:ff]
+	 * Example: 0000:af, 0:3d, 01:7
+	 */
+	regcomp(&regex, "^([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})$", REG_EXTENDED);
+	ret = regexec(&regex, str, 0, NULL, 0);
+	if (ret || sscanf(str, "%08x:%02hhx", domain, bus) != 2)
+		pr_warning("Unrecognized root port format: %s\n"
+			   "Please use the following format:\n"
+			   "\t [domain]:[bus]\n"
+			   "\t for example: 0000:3d\n", str);
+
+	regfree(&regex);
+	return ret;
+}
+
+static int iio_root_ports_list_filter(struct iio_root_ports_list **list,
+				      const char *filter)
+{
+	char *tok, *tmp, *filter_copy = NULL;
+	struct iio_root_port *rp;
+	u32 domain;
+	u8 bus;
+	int ret = -ENOMEM;
+	struct iio_root_ports_list *tmp_list = iio_root_ports_list_new();
+
+	if (!tmp_list)
+		goto err;
+
+	filter_copy = strdup(filter);
+	if (!filter_copy)
+		goto err;
+
+	for (tok = strtok_r(filter_copy, ",", &tmp); tok; tok = strtok_r(NULL, ",", &tmp)) {
+		if (!iio_root_port_parse_str(&domain, &bus, tok)) {
+			rp = iio_root_port_find_by_notation(*list, domain, bus);
+			if (rp) {
+				(*list)->rps[rp->idx] = NULL;
+				ret = iio_root_ports_list_insert(tmp_list, rp);
+				if (ret) {
+					free(rp);
+					goto err;
+				}
+			} else if (!iio_root_port_find_by_notation(tmp_list, domain, bus))
+				pr_warning("Root port %04x:%02x were not found\n", domain, bus);
+		}
+	}
+
+	if (tmp_list->nr_entries == 0) {
+		pr_err("Requested root ports were not found\n");
+		ret = -EINVAL;
+	}
+err:
+	iio_root_ports_list_free(*list);
+	if (ret)
+		iio_root_ports_list_free(tmp_list);
+	else
+		*list = tmp_list;
+
+	free(filter_copy);
+	return ret;
+}
+
+static int iiostat_event_group(struct evlist *evl, struct iio_root_ports_list *list)
+{
+	int ret;
+	struct iio_root_port **rp;
+	const char *iiostat_cmd_template =
+		"{uncore_iio_%x/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/,\
+		uncore_iio_%x/event=0x83,umask=0x01,ch_mask=0xF,fc_mask=0x07/,\
+		uncore_iio_%x/event=0xc0,umask=0x04,ch_mask=0xF,fc_mask=0x07/,\
+		uncore_iio_%x/event=0xc0,umask=0x01,ch_mask=0xF,fc_mask=0x07/}";
+	const int len_template = strlen(iiostat_cmd_template) + 1;
+	struct evsel *evsel = NULL;
+	int metrics_count = iiostat_metrics_count();
+	char *iiostat_cmd = calloc(len_template, 1);
+
+	if (!iiostat_cmd)
+		return -ENOMEM;
+
+	for (rp = list->rps; *rp; rp++) {
+		sprintf(iiostat_cmd, iiostat_cmd_template,
+			(*rp)->pmu_idx, (*rp)->pmu_idx, (*rp)->pmu_idx, (*rp)->pmu_idx);
+		ret = parse_events(evl, iiostat_cmd, NULL);
+		if (ret)
+			goto err;
+	}
+
+	evlist__for_each_entry(evl, evsel) {
+		evsel->perf_device = list->rps[evsel->idx / metrics_count];
+	}
+	list->nr_entries = 0;
+err:
+	iio_root_ports_list_free(list);
+	free(iiostat_cmd);
+	return ret;
+}
+
+int iiostat_parse(const struct option *opt, const char *str,
+		  int unset __maybe_unused)
+{
+	int ret;
+	struct iio_root_ports_list *list;
+	struct evlist *evl = *(struct evlist **)opt->value;
+	struct perf_stat_config *config = (struct perf_stat_config *)opt->data;
+
+	if (evl->core.nr_entries > 0) {
+		pr_err("Unsupported event configuration\n");
+		return -1;
+	}
+	config->metric_only = true;
+	config->aggr_mode = AGGR_IIO_STACK;
+	config->iiostat_run = true;
+	ret = iio_root_ports_scan(&list);
+	if (ret)
+		return ret;
+
+	if (!str) {
+		iiostat_mode = IIOSTAT_RUN;
+	} else if (!strcmp(str, "show")) {
+		iiostat_mode = IIOSTAT_SHOW;
+	} else {
+		iiostat_mode = IIOSTAT_RUN;
+		ret = iio_root_ports_list_filter(&list, str);
+		if (ret)
+			return ret;
+	}
+	return iiostat_event_group(evl, list);
+}
+
+void iiostat_prefix(struct perf_stat_config *config,
+		    struct evlist *evlist,
+		    char *prefix, struct timespec *ts)
+{
+	struct iio_root_port *rp = evlist->selected->perf_device;
+
+	if (rp) {
+		if (ts)
+			sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
+					ts->tv_sec, ts->tv_nsec,
+					config->csv_sep, rp->domain, rp->bus,
+					config->csv_sep);
+		else
+			sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bus,
+				config->csv_sep);
+	}
+}
+
+void iiostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
+			  struct perf_stat_output_ctx *out)
+{
+	double iiostat_value = 0;
+	u64 prev_count_val = 0;
+	const char *iiostat_metric = iiostat_metric_by_idx(evsel->idx);
+	u8 die = ((struct iio_root_port *)evsel->perf_device)->die;
+	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
+
+	if (evsel->prev_raw_counts && !out->force_header) {
+		struct perf_counts_values *prev_count = perf_counts(evsel->prev_raw_counts, die, 0);
+
+		prev_count_val = prev_count->val;
+		prev_count->val = count->val;
+	}
+	iiostat_value = (count->val - prev_count_val) / ((double) count->run / count->ena);
+	out->print_metric(config, out->ctx, NULL, "%8.0f", iiostat_metric,
+			  iiostat_value / (256 * 1024));
+}
+
+int iiostat_show_root_ports(struct evlist *evlist, struct perf_stat_config *config)
+{
+	struct evsel *evsel;
+	struct iio_root_port *rp = NULL;
+	bool is_show_mode = (iiostat_mode == IIOSTAT_SHOW);
+
+	if (config->aggr_mode != AGGR_IIO_STACK) {
+		pr_err("Unsupported event configuration\n");
+		return -1;
+	}
+
+	if (is_show_mode || verbose) {
+		evlist__for_each_entry(evlist, evsel) {
+			if (!evsel->perf_device) {
+				pr_err("Unsupported event configuration\n");
+				return -1;
+			}
+			if (rp != evsel->perf_device) {
+				rp = evsel->perf_device;
+				iio_root_port_show(config->output, rp);
+			}
+		}
+	}
+	/* Stop iiostat for show mode*/
+	config->iiostat_run = !is_show_mode;
+	if (is_show_mode)
+		iiostat_delete_root_ports(evlist);
+	return 0;
+}
+
+void iiostat_delete_root_ports(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	struct iio_root_port *rp = NULL;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (rp != evsel->perf_device) {
+			rp = evsel->perf_device;
+			free(evsel->perf_device);
+		}
+	}
+}
-- 
2.19.1

