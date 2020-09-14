Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA1B268E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgINOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:46:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:14942 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgINOn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:43:28 -0400
IronPort-SDR: kSfmNtIz8Q0198wa+bYRID5DFlj0muo0z83wz87h7sEjwzDWlqwbHbhLx+al5KAYw3vQ0388d4
 Q3oQ83LyEhHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223270421"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="223270421"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 07:43:25 -0700
IronPort-SDR: Edw9gQPu/o9qDtkI2o+usrq71pKVDHEfgzE7qYblP+ld3WEOp8kC/AZec3oMhpolm+Rjabrvo5
 1LghevWMgRQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="335304743"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 07:43:24 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH V2 0/6] Support PCIe3 uncore PMU on Snow Ridge
Date:   Mon, 14 Sep 2020 07:34:14 -0700
Message-Id: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Drop the platform device solution
- A new uncore PCI sub driver solution is introduced which searches
  the PCIe Root Port device via pci_get_device() and id table.
  Register a PCI bus notifier for the remove notification. Once the
  device is removed, the uncore driver can be notified to unregister
  the corresponding PMU.
- Modify the parameters of uncore_pci_pmu_unregister() function.

The Snow Ridge integrated PCIe3 uncore performance monitoring unit (PMU)
can be used to collect the performance data, e.g., the utilization
between the PCIe devices and the components (in M2IOSF) which are
responsible for translating and managing the requests to/from the
device. The performance data is very useful for analyzing the
performance of the PCIe devices.

The PCIe3 uncore PMU was once supported in the Linux kernel, but it was
removed by the commit 2167f1625c2f ("perf/x86/intel/uncore: Remove
PCIe3 unit for SNR") due to the conflict between the PCIe Root Port
driver and the perf uncore driver. The counters of the PCIe3 uncore PMU
are located in the configuration space of the PCIe Root Port device,
which already has a bonded driver portdrv_pci. One device can only have
one bonded driver. The uncore driver is always failed to be loaded.

To re-enable the PCIe3 uncore PMU support in the uncore driver, a new
solution should be introduced, which has to meet the requirements as
below:
- must have a reliable way to find the PCIe Root Port device from the
  uncore driver;
- must be able to access the uncore counters of the PCIe Root Port
  device from the uncore driver;
- must support hotplug. When the PCIe Root Port device is removed, the
  uncore driver has to be notified and unregisters the PCIe3 uncore
  PMU.

In the v1 patch set, a new platform device solution is implemented to
address the issue, but it's rejected.
https://lkml.kernel.org/r/20200708183034.GA466341@bjorn-Precision-5520

A new uncore PCI sub driver solution is introduced from the V2 patch
set, which:
- searches the PCIe Root Port device via pci_get_device() and id table.
  The matched pci_dev can be used to register a PMU for accessing the
  counters in the PCIe Root Port device.
- register a PCI bus notifier. Once the device is removed, the uncore
  driver can be notified to unregister the corresponding PMU.

Kan Liang (6):
  perf/x86/intel/uncore: Factor out uncore_pci_get_dev_die_info()
  perf/x86/intel/uncore: Factor out uncore_pci_find_dev_pmu()
  perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
  perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()
  perf/x86/intel/uncore: Generic support for the PCI sub driver
  perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge

 arch/x86/events/intel/uncore.c       | 273 +++++++++++++++++++++++++++--------
 arch/x86/events/intel/uncore.h       |   1 +
 arch/x86/events/intel/uncore_snbep.c |  53 +++++++
 3 files changed, 265 insertions(+), 62 deletions(-)

-- 
2.7.4

