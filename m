Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB736281CC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgJBURg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:17:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:14518 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJBURf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:17:35 -0400
IronPort-SDR: 80cv6vmnJR6Ls6zKXOSroIg5ySqTWcvobTk5JeTdwj3e3inxzjfQ2Pbuvf2Tu+iRdBqx3c6Zrg
 aRgSoEr2cxmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="227197742"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="227197742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 13:17:32 -0700
IronPort-SDR: eYu69Avjbd1JDOaXyIeU2tEdoi9tcvYOwPvttfElLEx82zY7PFvB1L8x6eDYEvsvCxJbVqOu7+
 RvZ3bkIFL/MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="385960860"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Oct 2020 13:17:32 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/3] x86: Add initial support to discover Intel hybrid CPUs
Date:   Fri,  2 Oct 2020 13:19:28 -0700
Message-Id: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to discover and enumerate CPUs in Intel hybrid parts. A hybrid
part has CPUs with more than one type of micro-architecture. Thus, certain
features may only be present in a specific CPU type.

It is useful to know the type of CPUs present in a system. For instance,
perf may need to handle CPUs differently depending on the type of micro-
architecture. Decoding machine check error logs may need the additional
micro-architecture type information, so include that in the log.

A hybrid part can be identified by reading a new CPUID feature bit.
Likewise, CPUID contains information about the CPU type as well as a new
native model ID. Details can be found in the Intel manual (SDM, [1]).

This series adds support for Intel hybrid parts in two areas: a) adding
the hybrid feature bit as well as struct cpuinfo_x86; and b) decode machine
check errors on hybrid parts.

A later submission will use the proposed functionality to expose the CPU
topology to user space.

Thanks and BR,
Ricardo

[1].
https://software.intel.com/content/dam/develop/public/us/en/documents/325462-sdm-vol-1-2abcd-3abcd.pdf
Vol 2. Section 3.2.CPUID leaf 0x1a

Ricardo Neri (3):
  x86/cpufeatures: Enumerate hybrid CPU feature bit
  x86/cpu: Describe hybrid CPUs in cpuinfo_x86
  x86/mce: include type of core when reporting a machine check error

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/processor.h   | 13 +++++++++++++
 arch/x86/include/uapi/asm/mce.h    |  1 +
 arch/x86/kernel/cpu/common.c       |  5 +++++
 arch/x86/kernel/cpu/mce/core.c     |  7 +++++++
 5 files changed, 27 insertions(+)

-- 
2.17.1

