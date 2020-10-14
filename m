Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6B28D7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgJNAti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:49:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:7196 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbgJNAtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:49:36 -0400
IronPort-SDR: 5TBkM8TDSSRiEFYngR9c9faDecCTd2NNVsP3Y4RKXu3AgQLofku8Ynp80NKv+BH/ILPeAyw3HH
 T1aW7mi9Dqhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="183507731"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="183507731"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 17:49:35 -0700
IronPort-SDR: IRQHjT9yvBq60Afk/IIBa/Dl4q8jHR89ZiQa2sjHBzO07KBheFdnLw+haU8vHBsfkAd7Yrmqwz
 laTwxium4Y5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="390492552"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga001.jf.intel.com with ESMTP; 13 Oct 2020 17:49:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Stephane Eranian" <eranian@google.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 1/2] Documentation: x86: Rename resctrl_ui.rst and add two errata to the file
Date:   Wed, 14 Oct 2020 00:49:26 +0000
Message-Id: <20201014004927.1839452-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014004927.1839452-1-fenghua.yu@intel.com>
References: <20201014004927.1839452-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Memory Bandwidth Monitoring (MBM) counters may report system
memory bandwidth incorrectly on some Intel processors. The errata are
reported in erratum SKX99 [1], erratum BDF102 [2] and RDT reference
manual [3].

To work around the errata, MBM total and local readings are corrected
using a correction factor table.

Since the correction factor table is not publicly documented anywhere,
the table and the errata are documented in Documentation/x86/resctrl.rst
for future reference. The resctrl.rst file is renamed from
Documentation/x86/resctrl_ui.rst because the file won't contain user
interface only anymore.

1. Erratum SKX99 in Intel Xeon Processor Scalable Family Specification
   Update:
http://web.archive.org/web/20200716124958/https://www.intel.com/content/www/us/en/processors/xeon/scalable/xeon-scalable-spec-update.html
2. Erratum BDF102 in Intel Xeon E5-2600 v4 Processor Product Family
   Specification Update:
http://web.archive.org/web/20191125200531/https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e5-v4-spec-update.pdf
3. The errata in Intel Resource Director Technology (Intel RDT) on 2nd
   Generation Intel Xeon Scalable Processors Reference Manual:
https://software.intel.com/content/www/us/en/develop/articles/intel-resource-director-technology-rdt-reference-manual.html

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Change Log:
v3:
- Remove unnecessary conf.py change in patch 1 (Randy).

v2:
- Document the correction factor table and errata in resctrl.rst (Boris).
- Change the documentation URLs to stable archive.org (Tony).

 Documentation/x86/index.rst                   |  2 +-
 .../x86/{resctrl_ui.rst => resctrl.rst}       | 82 +++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 rename Documentation/x86/{resctrl_ui.rst => resctrl.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 265d9e9a093b..49d2fd9f0e5b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -25,7 +25,7 @@ x86-specific Documentation
    pti
    mds
    microcode
-   resctrl_ui
+   resctrl
    tsx_async_abort
    usb-legacy-support
    i386/index
diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl.rst
similarity index 92%
rename from Documentation/x86/resctrl_ui.rst
rename to Documentation/x86/resctrl.rst
index e59b7b93a9b4..8b8ca6de5e1f 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl.rst
@@ -1209,3 +1209,85 @@ View the llc occupancy snapshot::
 
   # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
   11234000
+
+Intel RDT Errata
+================
+
+Intel MBM Counters May Report System Memory Bandwidth Incorrectly
+-----------------------------------------------------------------
+
+Errata SKX99 for Skylake server and BDF102 for Broadwell server.
+
+Problem: Intel Memory Bandwidth Monitoring (MBM) counters track metrics
+according to the assigned Resource Monitor ID (RMID) for that logical core.
+The IA32_QM_CTR register(MSR 0xC8E), used to report these metrics, may
+report incorrect system bandwidth for certain RMID values.
+
+Implication: Due to the errata, system memory bandwidth may not match
+what is reported.
+
+Workaround: The kernel works around the errata.
+
+MBM total and local readings are corrected by the following correction
+factor table for the errata:
+
++---------------+---------------+---------------+-----------------+
+|core count	|rmid count	|rmid threshold	|correction factor|
++---------------+---------------+---------------+-----------------+
+|1		|8		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|2		|16		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|3		|24		|15		|0.969650	  |
++---------------+---------------+---------------+-----------------+
+|4		|32		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|6		|48		|31		|0.969650	  |
++---------------+---------------+---------------+-----------------+
+|7		|56		|47		|1.142857	  |
++---------------+---------------+---------------+-----------------+
+|8		|64		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|9		|72		|63		|1.185115	  |
++---------------+---------------+---------------+-----------------+
+|10		|80		|63		|1.066553	  |
++---------------+---------------+---------------+-----------------+
+|11		|88		|79		|1.454545	  |
++---------------+---------------+---------------+-----------------+
+|12		|96		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|13		|104		|95		|1.230769	  |
++---------------+---------------+---------------+-----------------+
+|14		|112		|95		|1.142857	  |
++---------------+---------------+---------------+-----------------+
+|15		|120		|95		|1.066667	  |
++---------------+---------------+---------------+-----------------+
+|16		|128		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|17		|136		|127		|1.254863	  |
++---------------+---------------+---------------+-----------------+
+|18		|144		|127		|1.185255	  |
++---------------+---------------+---------------+-----------------+
+|19		|152		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|20		|160		|127		|1.066667	  |
++---------------+---------------+---------------+-----------------+
+|21		|168		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|22		|176		|159		|1.454334	  |
++---------------+---------------+---------------+-----------------+
+|23		|184		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|24		|192		|127		|0.969744	  |
++---------------+---------------+---------------+-----------------+
+|25		|200		|191		|1.280246	  |
++---------------+---------------+---------------+-----------------+
+|26		|208		|191		|1.230921	  |
++---------------+---------------+---------------+-----------------+
+|27		|216		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|28		|224		|191		|1.143118	  |
++---------------+---------------+---------------+-----------------+
+
+If rmid > rmid threshold, MBM total and local values should be multiplied
+by the correction factor.
-- 
2.28.0

