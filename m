Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9512DF970
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgLUHWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:22:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:8563 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgLUHWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:22:13 -0500
IronPort-SDR: b5Ew+Ttdi4fa9zHxJdBkY8JaV12fSlenrEP8KNFpBSroBwafidbke+GQIkMSGznShwIIvw/YIf
 ZL37enZTAePg==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="194115520"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="194115520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 23:20:25 -0800
IronPort-SDR: PSS5g5LvPub4FC9vPhFnDXYmSTbZMTcZRiMIUP09/T/1lMCnF6/cKEnFzDG/ZoxrFUjchW+x53
 aAPMDwGgQj+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="372321451"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2020 23:20:25 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: tools/power/x86/intel-speed-select: Fixes for regression
Date:   Sun, 20 Dec 2020 23:18:57 -0800
Message-Id: <20201221071859.2783957-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One side-effect of fixing the scaling frequency limits using the
commit eacc9c5a927e ("cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max()
for turbo disabled") causes stale HWP_CAP.GUARANTEED to be used as max.
Without processing HWP interrupts, user space needs to be able to update
a new max while Intel SST is in use. This is not a problem as the
change of guaranteed is caused by user space action, so user space knows
that guarantee will change.

This series causes user space to trigger scaling_max_freq update with
the new base_frequency.


Srinivas Pandruvada (2):
  tools/power/x86/intel-speed-select: Set scaling_max_freq to
    base_frequency
  tools/power/x86/intel-speed-select: Set higher of cpuinfo_max_freq or
    base_frequency

 .../x86/intel-speed-select/isst-config.c      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.29.2

