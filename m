Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992522E1C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgLWNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:05:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:55064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgLWNFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:05:23 -0500
IronPort-SDR: A9dee55kaz+UFUPY86j28AnosdMc/9XjVc/bGJRhaP9eKPWNiOZCd5mRS36YjV9x14JtlZW2Es
 ViJlArRM2nPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="163068598"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="163068598"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 05:03:38 -0800
IronPort-SDR: TT81Fz/w/BdX34UJHM64xVKmxLUIWIwabcmGWJwbkcpb9N4cHaBKn2IoDqN5z9UF8SFLm56S7r
 0IU0X5LZR6Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="393087800"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2020 05:03:35 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v2 5/6] perf stat: Enable iiostat mode for x86 platforms
Date:   Wed, 23 Dec 2020 16:03:19 +0300
Message-Id: <20201223130320.3930-6-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
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
 tools/perf/Documentation/perf-iiostat.txt |  89 ++++++
 tools/perf/Makefile.perf                  |   5 +-
 tools/perf/arch/x86/util/Build            |   1 +
 tools/perf/arch/x86/util/iiostat.c        | 337 ++++++++++++++++++++++
 tools/perf/command-list.txt               |   1 +
 tools/perf/perf-iiostat.sh                |  12 +
 6 files changed, 444 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/Documentation/perf-iiostat.txt
 create mode 100644 tools/perf/perf-iiostat.sh

diff --git a/tools/perf/Documentation/perf-iiostat.txt b/tools/perf/Documentation/perf-iiostat.txt
new file mode 100644
index 000000000000..38b5697b0d85
--- /dev/null
+++ b/tools/perf/Documentation/perf-iiostat.txt
@@ -0,0 +1,89 @@
+perf-iiostat(1)
+===============
+
+NAME
+----
+perf-iiostat - Show I/O performance metrics
+
+SYNOPSIS
+--------
+[verse]
+'perf iiostat' show
+'perf iiostat' <ports> -- <command> [<options>]
+
+DESCRIPTION
+-----------
+Mode is intended to provide four I/O performance metrics per each IIO
+stack (PCIe root port):
+
+- Inbound Read   - I/O devices below IIO stack read from the host memory, in MB
+
+- Inbound Write  - I/O devices below IIO stack write to the host memory, in MB
+
+- Outbound Read  - CPU reads from I/O devices below IIO stack, in MB
+
+- Outbound Write - CPU writes to I/O devices below IIO stack, in MB
+
+OPTIONS
+-------
+<command>...::
+	Any command you can specify in a shell.
+
+show::
+	List all IIO stacks.
+
+<ports>::
+	Select the root ports for monitoring. Comma-separated list is supported.
+
+EXAMPLES
+--------
+
+1. List all IIO stacks (example for 2-S platform):
+
+   $ perf iiostat show
+   S0-uncore_iio_0<0000:00>
+   S1-uncore_iio_0<0000:80>
+   S0-uncore_iio_1<0000:17>
+   S1-uncore_iio_1<0000:85>
+   S0-uncore_iio_2<0000:3a>
+   S1-uncore_iio_2<0000:ae>
+   S0-uncore_iio_3<0000:5d>
+   S1-uncore_iio_3<0000:d7>
+
+2. Collect metrics for all I/O stacks:
+
+   $ perf iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
+   357708+0 records in
+   357707+0 records out
+   375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s
+
+    Performance counter stats for 'system wide':
+
+      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
+   0000:00                    1                    0                    2                    3 
+   0000:80                    0                    0                    0                    0 
+   0000:17               352552                   43                    0                   21 
+   0000:85                    0                    0                    0                    0 
+   0000:3a                    3                    0                    0                    0 
+   0000:ae                    0                    0                    0                    0 
+   0000:5d                    0                    0                    0                    0 
+   0000:d7                    0                    0                    0                    0
+
+3. Collect metrics for comma-separated list of I/O stacks:
+
+   $ perf iiostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
+   357708+0 records in
+   357707+0 records out
+   375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s
+
+    Performance counter stats for 'system wide':
+
+      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
+   0000:17               358559                   44                    0                   22 
+   0000:3a                    3                    2                    0                    0 
+
+        197.081983474 seconds time elapsed
+
+SEE ALSO
+--------
+linkperf:perf-stat[1]
\ No newline at end of file
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ce3f2e8b9c7..c16c14a304a9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -280,6 +280,7 @@ SCRIPT_SH =
 
 SCRIPT_SH += perf-archive.sh
 SCRIPT_SH += perf-with-kcore.sh
+SCRIPT_SH += perf-iiostat.sh
 
 grep-libs = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
@@ -944,6 +945,8 @@ endif
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-with-kcore) \
 		$(INSTALL) $(OUTPUT)perf-with-kcore -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
+	$(call QUIET_INSTALL, perf-iiostat) \
+		$(INSTALL) $(OUTPUT)perf-iiostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 ifndef NO_LIBAUDIT
 	$(call QUIET_INSTALL, strace/groups) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'; \
@@ -1009,7 +1012,7 @@ python-clean:
 	$(python-clean)
 
 clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
-	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
+	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iiostat $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents $(OUTPUT)$(LIBJVMTI).so
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
index 98b9707b4827..de8690dbb8b0 100644
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
@@ -123,3 +161,302 @@ static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
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
+	if (count->run && count->ena) {
+		if (evsel->prev_raw_counts && !out->force_header) {
+			struct perf_counts_values *prev_count = perf_counts(evsel->prev_raw_counts, die, 0);
+
+			prev_count_val = prev_count->val;
+			prev_count->val = count->val;
+		}
+		iiostat_value = (count->val - prev_count_val) / ((double) count->run / count->ena);
+	}
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
+	/* Stop iiostat in show mode*/
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
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index bc6c585f74fc..77e4c9410b0e 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -14,6 +14,7 @@ perf-config			mainporcelain common
 perf-evlist			mainporcelain common
 perf-ftrace			mainporcelain common
 perf-inject			mainporcelain common
+perf-iiostat			mainporcelain common
 perf-kallsyms			mainporcelain common
 perf-kmem			mainporcelain common
 perf-kvm			mainporcelain common
diff --git a/tools/perf/perf-iiostat.sh b/tools/perf/perf-iiostat.sh
new file mode 100644
index 000000000000..2c5168d2550b
--- /dev/null
+++ b/tools/perf/perf-iiostat.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf iiostat
+# Alexander Antonov <alexander.antonov@linux.intel.com>
+
+if [[ "$1" == "show" ]] || [[ "$1" =~ ([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})(,)? ]]; then
+        DELIMITER="="
+else
+        DELIMITER=" "
+fi
+
+perf stat --iiostat$DELIMITER$*
\ No newline at end of file
-- 
2.19.1

