Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2F52F42FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAMETH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:19:07 -0500
Received: from foss.arm.com ([217.140.110.172]:57856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbhAMETG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:19:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4F81042;
        Tue, 12 Jan 2021 20:18:20 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6D673F719;
        Tue, 12 Jan 2021 20:18:17 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/11] arm64: coresight: Enable ETE and TRBE
Date:   Wed, 13 Jan 2021 09:48:07 +0530
Message-Id: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables future IP trace features Embedded Trace Extension (ETE)
and Trace Buffer Extension (TRBE). This series depends on the ETM system
register instruction support series [0] which is available here [1]. This
series which applies on [1] is avaialble here [2] for quick access.

ETE is the PE (CPU) trace unit for CPUs, implementing future architecture
extensions. ETE overlaps with the ETMv4 architecture, with additions to
support the newer architecture features and some restrictions on the
supported features w.r.t ETMv4. The ETE support is added by extending the
ETMv4 driver to recognise the ETE and handle the features as exposed by the
TRCIDRx registers. ETE only supports system instructions access from the
host CPU. The ETE could be integrated with a TRBE (see below), or with the
legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same firmware
description as the ETMs and requires a node per instance. 

Trace Buffer Extensions (TRBE) implements a per CPU trace buffer, which is
accessible via the system registers and can be combined with the ETE to
provide a 1x1 configuration of source & sink. TRBE is being represented
here as a CoreSight sink. Primary reason is that the ETE source could work
with other traditional CoreSight sink devices. As TRBE captures the trace
data which is produced by ETE, it cannot work alone.

TRBE representation here have some distinct deviations from a traditional
CoreSight sink device. Coresight path between ETE and TRBE are not built
during boot looking at respective DT or ACPI entries.

Unlike traditional sinks, TRBE can generate interrupts to signal including
many other things, buffer got filled. The interrupt is a PPI and should be
communicated from the platform. DT or ACPI entry representing TRBE should
have the PPI number for a given platform. During perf session, the TRBE IRQ
handler should capture trace for perf auxiliary buffer before restarting it
back. System registers being used here to configure ETE and TRBE could be
referred in the link below.

https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers.

Question:

- Should we implement sysfs based trace sessions for TRBE ?

[0] https://lore.kernel.org/linux-arm-kernel/20210110224850.1880240-1-suzuki.poulose@arm.com/
[1] https://gitlab.arm.com/linux-arm/linux-skp/-/tree/coresight/etm/sysreg-v7
[2] https://gitlab.arm.com/linux-arm/linux-anshuman/-/tree/coresight/ete_trbe_v2

Changes in V2:

- Converted both ETE and TRBE DT bindings into Yaml
- TRBE changes have been captured in the respective patches
 
Changes in V1:

https://lore.kernel.org/linux-arm-kernel/1608717823-18387-1-git-send-email-anshuman.khandual@arm.com/

- There are not much ETE changes from Suzuki apart from splitting of the ETE DTS patch
- TRBE changes have been captured in the respective patches

Changes in RFC:

https://lore.kernel.org/linux-arm-kernel/1605012309-24812-1-git-send-email-anshuman.khandual@arm.com/

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Linu Cherian <lcherian@marvell.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (4):
  arm64: Add TRBE definitions
  coresight: core: Add support for dedicated percpu sinks
  coresight: etm-perf: Truncate the perf record if handle has no space
  coresight: sink: Add TRBE driver

Suzuki K Poulose (7):
  coresight: etm-perf: Allow an event to use different sinks
  coresight: Do not scan for graph if none is present
  coresight: etm4x: Add support for PE OS lock
  coresight: ete: Add support for ETE sysreg access
  coresight: ete: Add support for ETE tracing
  dts: bindings: Document device tree bindings for ETE
  dts: bindings: Document device tree bindings for Arm TRBE

 Documentation/devicetree/bindings/arm/ete.yaml     |  71 ++
 Documentation/devicetree/bindings/arm/trbe.yaml    |  46 +
 Documentation/trace/coresight/coresight-trbe.rst   |  39 +
 arch/arm64/include/asm/sysreg.h                    |  51 ++
 drivers/hwtracing/coresight/Kconfig                |  21 +-
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-core.c       |  14 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  51 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 138 ++-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  19 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |  81 +-
 drivers/hwtracing/coresight/coresight-platform.c   |   6 +
 drivers/hwtracing/coresight/coresight-trbe.c       | 966 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.h       | 216 +++++
 include/linux/coresight.h                          |  12 +
 15 files changed, 1683 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
 create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h

-- 
2.7.4

