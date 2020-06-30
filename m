Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0120F5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbgF3NkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 09:40:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:31774 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbgF3NkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:40:14 -0400
IronPort-SDR: k3t3bH4XVwYHtrM4+25tiM8ZqPwgL+r8CrWbMIHDDU8R76wIVHCcHc3TBCuyegPNZ9XHtdI+UQ
 IMl7zUva1qAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145302173"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="145302173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 06:40:13 -0700
IronPort-SDR: STWRW55HtaBObb/Cxk3VvcsjQSJA2zFwfKXo9Fsy0Ayq912iaOUPHhwSINFzhfdTwg2LnTQii4
 pMPBOTXdiLOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="425207181"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 06:40:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH 0/3] perf intel-pt: Fix PEBS-via-PT with registers
Date:   Tue, 30 Jun 2020 16:39:32 +0300
Message-Id: <20200630133935.11150-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some more Intel PT fixes for v5.8.


Adrian Hunter (3):
      perf intel-pt: Fix recording PEBS-via-PT with registers
      perf intel-pt: Fix displaying PEBS-via-PT with registers
      perf intel-pt: Fix PEBS sample for XMM registers

 tools/perf/arch/x86/util/intel-pt.c | 1 +
 tools/perf/builtin-script.c         | 2 +-
 tools/perf/util/evsel.c             | 4 ++--
 tools/perf/util/intel-pt.c          | 5 +++--
 4 files changed, 7 insertions(+), 5 deletions(-)


Regards
Adrian
