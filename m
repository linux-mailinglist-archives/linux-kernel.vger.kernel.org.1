Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE922DF973
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgLUHXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:23:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:8563 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgLUHXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:23:33 -0500
IronPort-SDR: RWk0AZIsmELchpfMd2qrFeHscnirSWlesczcruyIeD2YCkZTExVkp5H3cYNFe92S5sugrdcKeY
 mNLZc+PzcdBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="194115523"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="194115523"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 23:20:26 -0800
IronPort-SDR: m5RGyML1N7IwhI3frjgO1lmm0bnakYODG+jvnV+WZyE3i8y+IyzPKq0U4wfI/S/Cnd8SrMZ32U
 Zz4cYkLGaTuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="372321453"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2020 23:20:25 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] tools/power/x86/intel-speed-select: Set higher of cpuinfo_max_freq or base_frequency
Date:   Sun, 20 Dec 2020 23:18:59 -0800
Message-Id: <20201221071859.2783957-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
References: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case when BIOS disabled turbo, cpufreq cpuinfo_max_freq can be
lower than base_frequency at higher config level. So, in that case set
scaling_min_freq to base_frequency.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 9b6f0e6f150d..09cb3a6672f3 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1461,6 +1461,16 @@ static void adjust_scaling_max_from_base_freq(int cpu)
 		set_cpufreq_scaling_min_max(cpu, 1, base_freq);
 }
 
+static void adjust_scaling_min_from_base_freq(int cpu)
+{
+	int base_freq, scaling_min_freq;
+
+	scaling_min_freq = parse_int_file(0, "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", cpu);
+	base_freq = get_cpufreq_base_freq(cpu);
+	if (scaling_min_freq < base_freq)
+		set_cpufreq_scaling_min_max(cpu, 0, base_freq);
+}
+
 static int set_clx_pbf_cpufreq_scaling_min_max(int cpu)
 {
 	struct isst_pkg_ctdp_level_info *ctdp_level;
@@ -1558,6 +1568,7 @@ static void set_scaling_min_to_cpuinfo_max(int cpu)
 			continue;
 
 		set_cpufreq_scaling_min_max_from_cpuinfo(i, 1, 0);
+		adjust_scaling_min_from_base_freq(i);
 	}
 }
 
-- 
2.29.2

