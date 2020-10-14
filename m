Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BF28D7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgJNAtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:49:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:7196 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgJNAtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:49:36 -0400
IronPort-SDR: DvT2q7gTpKOVBHQ8U+4Wd11hGIxC7DC5XAhLqwRZOZaOPeHMyfzxlJlLB4BSnnVz7dqL9hNnYO
 B5HtIsriWfIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="183507729"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="183507729"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 17:49:35 -0700
IronPort-SDR: Y+u0/xb/VyyeFry49Y75RaH3rkfD8sf3ZZPOAyZUvaRMh4PYr5QOKF4BBvoWt0Erk8871CTE7p
 vLDS88oPy+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="390492550"
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
Subject: [PATCH v3 0/2] x86/resctrl: Work around MBM errata
Date:   Wed, 14 Oct 2020 00:49:25 +0000
Message-Id: <20201014004927.1839452-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Memory Bandwidth Monitoring (MBM) counters may report system
memory bandwidth incorrectly on some Intel processors. The errata are
reported in erratum SKX99 [1], erratum BDF102 [2] and RDT reference
manual [3].

The errata are worked around using a correction factor table. Since
the correction factor table is not publicly documented anywhere, it's
documented in Documentation/x86/resctrl.rst along with the errata.

1. Erratum SKX99 in Intel Xeon Processor Scalable Family Specification
   Update:
http://web.archive.org/web/20200716124958/https://www.intel.com/content/www/us/en/processors/xeon/scalable/xeon-scalable-spec-update.html
2. Erratum BDF102 in Intel Xeon E5-2600 v4 Processor Product Family
   Specification Update:
http://web.archive.org/web/20191125200531/https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e5-v4-spec-update.pdf
3. The errata in Intel Resource Director Technology (Intel RDT) on 2nd
   Generation Intel Xeon Scalable Processors Reference Manual:
https://software.intel.com/content/www/us/en/develop/articles/intel-resource-director-technology-rdt-reference-manual.html

Change Log:
v3:
- Remove unnecessary conf.py change in patch 1 (Randy).

v2:
- Document the errata and the correction table in resctrl.rst (Boris).
- Address various comments on patch 2 (Boris).
- Change the documentation URLs to stable archive.org (Tony).

Fenghua Yu (2):
  Documentation: x86: Rename resctrl_ui.rst and add two errata to the
    file
  x86/resctrl: Correct MBM total and local values

 Documentation/x86/index.rst                   |  2 +-
 .../x86/{resctrl_ui.rst => resctrl.rst}       | 82 +++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/core.c            |  4 +
 arch/x86/kernel/cpu/resctrl/internal.h        |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c         | 82 ++++++++++++++++++-
 5 files changed, 168 insertions(+), 3 deletions(-)
 rename Documentation/x86/{resctrl_ui.rst => resctrl.rst} (92%)

-- 
2.28.0

