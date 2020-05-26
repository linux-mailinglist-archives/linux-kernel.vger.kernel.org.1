Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497D11C4B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 03:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgEEBcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 21:32:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:41897 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgEEBck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 21:32:40 -0400
IronPort-SDR: 0pnyot5BcEI8eVEnPzuov+LVBqp/7/T/hfT/wGx66VHu5oLj/IDfsGA+qrXTPamuWYgkj+pZ+P
 HT7/UiBL163w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:32:40 -0700
IronPort-SDR: 3KEitOO9aaD9RIM/1pOIlMqVW3k86nuDmiocDj29kl/+Ho1iUx52j0U2z7rReLhaoEn8WYxVVf
 VK1ADIUyKeRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="406664749"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2020 18:32:40 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id 44B5858048A;
        Mon,  4 May 2020 18:32:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Intel Platform Monitoring Technology
Date:   Mon,  4 May 2020 18:32:03 -0700
Message-Id: <20200505013206.11223-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Platform Monitoring Technology (PMT) is an architecture for
enumerating and accessing hardware monitoring capabilities on a device.
With customers increasingly asking for hardware telemetry, engineers not
only have to figure out how to measure and collect data, but also how to
deliver it and make it discoverable. The latter may be through some device
specific method requiring device specific tools to collect the data. This
in turn requires customers to manage a suite of different tools in order to
collect the differing assortment of monitoring data on their systems.  Even
when such information can be provided in kernel drivers, they may require
constant maintanence to update register mappings as they change with
firmware updates and new versions of hardware. PMT provides a solution for
discovering and reading telemetry from a device through a hardware agnostic
framework that allows for updates to systems without requiring patches to
the kernel or software tools.

PMT defines several capabilities to support collecting monitoring data from
hardware. All are discoverable as separate instances of the PCIE Designated
Vendor extended capability (DVSEC) with the Intel vendor code. The DVSEC ID
field uniquely identifies the capability. Each DVSEC also provides a BAR
offset to a header that defines capability-specific attributes, including
GUID, feature type, offset and length, as well as configuration settings
where applicable. The GUID uniquely identifies the register space of any
monitor data exposed by the capability. The GUID is associated with an XML
file from the vendor that describes the mapping of the register space along
with properties of the monitor data. This allows vendors to perform
firmware updates that can change the mapping (e.g. add new metrics) without
requiring any changes to drivers or software tools. The new mapping is
confirmed by an updated GUID, read from the hardware, which software uses
with a new XML.

The current capabilities defined by PMT are Telemetry, Watcher, and
Crashlog.  The Telemetry capability provides access to a continuous block
of read only data. The Watcher capability provides access to hardware
sampling and tracing features. Crashlog provides access to device crash
dumps.  While there is some relationship between capabilities (Watcher can
be configured to sample from the Telemetry data set) each exists as stand
alone features with no dependency on any other. The design therefore splits
them into individual, capability specific drivers. MFD is used to create
platform devices for each capability so that they may be managed by their
own driver. The PMT architecture is (for the most part) agnostic to the
type of device it can collect from. Devices nodes are consequently generic
in naming, e.g. /dev/telem<n> and /dev/smplr<n>. Each capability driver
creates a class to manage the list of devices supporting it.  Software can
see which devices support a PMT feature by perusing each device file
underneath the class in sysfs. It can additionally see if a particluar
device supports a PMT feature by seeing if that device contains a pointer
to a PMT class in its device folder.

This patch set provides support for the PMT framework, along with support
for Telemetry on Tiger Lake.

Patch 1 - adds the Designated Vendor PCI Extended Capability. The PMT
	  feature is discoverable as an Intel DVSEC capabilitity.

Patch 2 - an MFD driver that creates cells for each PMT capability found on
	  a PCI device. This supports SoC platforms that expose PMT
	  capabilities under a PMT dedicated PCI device id.

Patch 3 - adds support for the PMT Telemetry feature.

To: bhelgaas@google.com,
    andy@infradead.org,
    alexander.h.duyck@intel.com
Cc: linux-kernel@vger.kernel.org,
    linux-pci@vger.kernel.org

*** BLURB HERE ***

David E. Box (3):
  pci: Add Designated Vendor Specific Capability
  mfd: Intel Platform Monitoring Technology support
  platform/x86: Intel PMT Telemetry capability driver

 .../ABI/testing/sysfs-class-intel_pmt_telem   |  46 +++
 MAINTAINERS                                   |   6 +
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel_pmt.c                       | 174 +++++++++
 drivers/platform/x86/Kconfig                  |  10 +
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/intel_pmt_telem.c        | 356 ++++++++++++++++++
 drivers/platform/x86/intel_pmt_telem.h        |  20 +
 include/linux/intel-dvsec.h                   |  44 +++
 include/uapi/linux/pci_regs.h                 |   5 +
 11 files changed, 673 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-intel_pmt_telem
 create mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel_pmt_telem.c
 create mode 100644 drivers/platform/x86/intel_pmt_telem.h
 create mode 100644 include/linux/intel-dvsec.h

-- 
2.20.1

