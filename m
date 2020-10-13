Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2390328C73A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgJMCrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:47:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:47364 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgJMCrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:47:11 -0400
IronPort-SDR: QTnGytfAimFJ/fInIh9pZVaxFXplMI1IrwMOrjx3IFwDA5HfdTrF0VY+reRXfu30mIpLr6+9UY
 P12NdABuvYng==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162369330"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="162369330"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 19:47:10 -0700
IronPort-SDR: VrElMgCHa10hJ0BqiwV0Zn2AeyH+FZsRVjS+WBMaP8OuVvVoqp0hRXd0cgz2pb3RcbDYeOuJ0Z
 ABsx9ComjLew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="520882246"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga005.fm.intel.com with ESMTP; 12 Oct 2020 19:47:10 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Stephane Eranian" <eranian@google.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/2] x86/resctrl: Workaround MBM errata
Date:   Tue, 13 Oct 2020 02:46:54 +0000
Message-Id: <20201013024656.700492-1-fenghua.yu@intel.com>
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
v2:
- Document the errata and the correction table in resctrl.rst (Boris).
- Address various comments on patch 2 (Boris).
- Change the documentation URLs to stable archive.org (Tony).

Fenghua Yu (2):
  Documentation: x86: Rename resctrl_ui.rst and add two errata to the
    file
  x86/resctrl: Correct MBM total and local values

 Documentation/conf.py                         |  2 +-
 Documentation/x86/index.rst                   |  2 +-
 .../x86/{resctrl_ui.rst => resctrl.rst}       | 82 ++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/core.c            |  4 +
 arch/x86/kernel/cpu/resctrl/internal.h        |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c         | 83 ++++++++++++++++++-
 6 files changed, 170 insertions(+), 4 deletions(-)
 rename Documentation/x86/{resctrl_ui.rst => resctrl.rst} (92%)

-- 
2.28.0

