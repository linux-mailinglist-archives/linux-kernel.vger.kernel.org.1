Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1C2DF975
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgLUHX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:23:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:8647 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgLUHX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:23:59 -0500
IronPort-SDR: nZDR06QSSuq2TNEjFDul3ieV/IoELisOuKGVus1/cAlF6wCq7aobLw6FhNW6HmROoo5oiwB/7+
 YRZnP2aZxdBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="194115524"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="194115524"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 23:20:26 -0800
IronPort-SDR: iWcWMnI0GzMNBUdIs8dUK1/dPjvasJgpa6YWhdan82FYvoK6CpKT7Juya7WhmRMlfZNxg17GTV
 +5Jzr3+4C38g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="372321452"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2020 23:20:25 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] tools/power/x86/intel-speed-select: Set scaling_max_freq to base_frequency
Date:   Sun, 20 Dec 2020 23:18:58 -0800
Message-Id: <20201221071859.2783957-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
References: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When BIOS disables turbo, The scaling_max_freq in cpufreq sysfs will be
limited to config level 0 base frequency. But when user selects a higher
config levels, this will result in higher base frequency. But since
scaling_max_freq is still old base frequency, the performance will still
be limited. So when the turbo is disabled and cpufreq base_frequency is
higher than scaling_max_freq, update the scaling_max_freq to the
base_frequency.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 5390158cdb40..9b6f0e6f150d 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1249,6 +1249,8 @@ static void dump_isst_config(int arg)
 	isst_ctdp_display_information_end(outf);
 }
 
+static void adjust_scaling_max_from_base_freq(int cpu);
+
 static void set_tdp_level_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 				  void *arg4)
 {
@@ -1267,6 +1269,9 @@ static void set_tdp_level_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 			int pkg_id = get_physical_package_id(cpu);
 			int die_id = get_physical_die_id(cpu);
 
+			/* Wait for updated base frequencies */
+			usleep(2000);
+
 			fprintf(stderr, "Option is set to online/offline\n");
 			ctdp_level.core_cpumask_size =
 				alloc_cpu_set(&ctdp_level.core_cpumask);
@@ -1283,6 +1288,7 @@ static void set_tdp_level_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 					if (CPU_ISSET_S(i, ctdp_level.core_cpumask_size, ctdp_level.core_cpumask)) {
 						fprintf(stderr, "online cpu %d\n", i);
 						set_cpu_online_offline(i, 1);
+						adjust_scaling_max_from_base_freq(i);
 					} else {
 						fprintf(stderr, "offline cpu %d\n", i);
 						set_cpu_online_offline(i, 0);
@@ -1440,6 +1446,21 @@ static int set_cpufreq_scaling_min_max(int cpu, int max, int freq)
 	return 0;
 }
 
+static int no_turbo(void)
+{
+	return parse_int_file(0, "/sys/devices/system/cpu/intel_pstate/no_turbo");
+}
+
+static void adjust_scaling_max_from_base_freq(int cpu)
+{
+	int base_freq, scaling_max_freq;
+
+	scaling_max_freq = parse_int_file(0, "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_max_freq", cpu);
+	base_freq = get_cpufreq_base_freq(cpu);
+	if (scaling_max_freq < base_freq || no_turbo())
+		set_cpufreq_scaling_min_max(cpu, 1, base_freq);
+}
+
 static int set_clx_pbf_cpufreq_scaling_min_max(int cpu)
 {
 	struct isst_pkg_ctdp_level_info *ctdp_level;
-- 
2.29.2

