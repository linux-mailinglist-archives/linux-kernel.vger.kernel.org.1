Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8062C8EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgK3UVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:60098 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbgK3UV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:29 -0500
IronPort-SDR: rc1PHIdD8rFgN8NfT2A+c99ZTDFxANgEAOmGoEqdr2mlfgIIaCSReiW4Djr0vTh4eg6SECM7tL
 2ZBHAzLL0Ndg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140729"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140729"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:31 -0800
IronPort-SDR: YVAd3fQxIwCPSREB2VNMnpzb17MWZaOQUMFDCsCS7c4vIAx9eULnaK0vyLm4FcglrtFqs6VQMs
 14l8nFeaDgtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793756"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:30 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 00/17] Miscellaneous fixes for resctrl selftests
Date:   Mon, 30 Nov 2020 20:19:53 +0000
Message-Id: <20201130202010.178373-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set has several miscellaneous fixes to resctrl selftest tool
that are easily visible to user. V1 had fixes to CAT test and CMT test
but they were dropped in V2 because having them here made the patchset
humongous. So, changes to CAT test and CMT test will be posted in another
patchset.

Change Log:
v4:
- Address various comments from Shuah Khan:
  1. Combine a few patches e.g. a couple of fixing typos patches into one
     and a couple of unmounting patches into one etc.
  2. Add config file.
  3. Remove "Fixes" tags.
  4. Change strcmp() to strncmp().
  5. Move the global variable fixing patch to the patch 1 so that the
     compilation issue is fixed first.

Please note:
- I didn't move the patch of renaming CQM to CMT to the end of the series
  because code and commit messages in a few other patches depend on the
  new term of "CMT". If move the renaming patch to the end, the previous
  patches use the old "CQM" term and code which will be changed soon at
  the end of series and will cause more code and explanations.
[v3: https://lkml.org/lkml/2020/10/28/137]

v3:
Address various comments (commit messages, return value on test failure,
print failure info on test failure etc) from Reinette and Tony.
[v2: https://lore.kernel.org/linux-kselftest/cover.1589835155.git.sai.praneeth.prakhya@intel.com/]

v2:
1. Dropped changes to CAT test and CMT test as they will be posted in a later
   series.
2. Added several other fixes
[v1: https://lore.kernel.org/linux-kselftest/cover.1583657204.git.sai.praneeth.prakhya@intel.com/]

Fenghua Yu (15):
  selftests/resctrl: Fix compilation issues for global variables
  selftests/resctrl: Clean up resctrl features check
  selftests/resctrl: Rename CQM test as CMT test
  selftests/resctrl: Add a few dependencies
  selftests/resctrl: Check for resctrl mount point only if resctrl FS is
    supported
  selftests/resctrl: Use resctrl/info for feature detection
  selftests/resctrl: Fix missing options "-n" and "-p"
  selftests/resctrl: Fix MBA/MBM results reporting format
  selftests/resctrl: Enable gcc checks to detect buffer overflows
  selftests/resctrl: Don't hard code value of "no_of_bits" variable
  selftests/resctrl: Modularize resctrl test suite main() function
  selftests/resctrl: Skip the test if requested resctrl feature is not
    supported
  selftests/resctrl: Fix unmount resctrl FS
  selftests/resctrl: Fix incorrect parsing of iMC counters
  selftests/resctrl: Fix checking for < 0 for unsigned values

Reinette Chatre (2):
  selftests/resctrl: Fix printed messages
  selftests/resctrl: Ensure sibling CPU is not same as original CPU

 tools/testing/selftests/resctrl/Makefile      |   2 +-
 tools/testing/selftests/resctrl/README        |   4 +-
 tools/testing/selftests/resctrl/cache.c       |  10 +-
 tools/testing/selftests/resctrl/cat_test.c    |  22 +--
 .../resctrl/{cqm_test.c => cmt_test.c}        |  33 ++--
 tools/testing/selftests/resctrl/config        |   2 +
 tools/testing/selftests/resctrl/fill_buf.c    |   4 +-
 tools/testing/selftests/resctrl/mba_test.c    |  25 ++-
 tools/testing/selftests/resctrl/mbm_test.c    |  18 +-
 tools/testing/selftests/resctrl/resctrl.h     |  45 ++++-
 .../testing/selftests/resctrl/resctrl_tests.c | 162 ++++++++++++------
 tools/testing/selftests/resctrl/resctrl_val.c |  88 ++++++----
 tools/testing/selftests/resctrl/resctrlfs.c   |  85 ++++++---
 13 files changed, 318 insertions(+), 182 deletions(-)
 rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (85%)
 create mode 100644 tools/testing/selftests/resctrl/config

-- 
2.29.2

