Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B152281FF4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 03:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgJCBPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 21:15:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:53472 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgJCBPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 21:15:47 -0400
IronPort-SDR: 61scJdn2isADiSgl02v5gxf/5iXiHFuGilD0WOfJPZp5OzO/0udQnMKz7gMweJMNm77BQV5oI/
 RulRamgv8vNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160436325"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="160436325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:15:47 -0700
IronPort-SDR: OY57zqeOnaXEg5lNznw+9oRx+mdMvMSyi8V6b1DDT6sNuOOhLvEdYiQhBpFUFL1hCr2uB1wo0X
 sBnnBiYwoEyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="325996774"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 02 Oct 2020 18:15:46 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/4] drivers core: Introduce CPU type sysfs interface
Date:   Fri,  2 Oct 2020 18:17:41 -0700
Message-Id: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hybrid CPU topologies combine processors with more than one type of
micro-architecture. Hence, it is possible that individual CPUs support
slightly different features (e.g., performance counters) and different
performance properties. Thus, there may be user space entities interested
in knowing the topology of the system based on the types of available
CPUs.

Currently, there exists an interface for the CPU capacity (/sys/devices/
system/cpu/cpuX/cpu_capacity). However, CPU capacity does not always map
to CPU types (by the way, I will submit a separate series to bring such
interface to x86).

This series proposes the new interface /sys/devices/system/cpu/types
which, in hybrid parts, creates a subdirectory for each type of CPU.
Each subdirectory contains a CPU list and a CPU map that user space can
query.

Patch 1 of the series proposes the generic interface, with hooks
that architectures can override to suit their needs. The three patches
patches implement such interface for x86 (as per request from Boris,
I pulled patch 2 from a separate submission [1]).

Thanks and BR,
Ricardo

[1]. https://lkml.org/lkml/2020/10/2/1013

Ricardo Neri (4):
  drivers core: Introduce CPU type sysfs interface
  x86/cpu: Describe hybrid CPUs in cpuinfo_x86
  x86/cpu/intel: Add function to get name of hybrid CPU types
  x86/cpu/topology: Implement the CPU type sysfs interface

 .../ABI/testing/sysfs-devices-system-cpu      |  13 ++
 arch/x86/include/asm/intel-family.h           |   4 +
 arch/x86/include/asm/processor.h              |  13 ++
 arch/x86/include/asm/topology.h               |   2 +
 arch/x86/kernel/cpu/common.c                  |   3 +
 arch/x86/kernel/cpu/cpu.h                     |   3 +
 arch/x86/kernel/cpu/intel.c                   |  23 ++
 arch/x86/kernel/cpu/topology.c                |  23 ++
 drivers/base/cpu.c                            | 214 ++++++++++++++++++
 include/linux/cpu.h                           |  12 +
 include/linux/cpuhotplug.h                    |   1 +
 11 files changed, 311 insertions(+)

-- 
2.17.1

