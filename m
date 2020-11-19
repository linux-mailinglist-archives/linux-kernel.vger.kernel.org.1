Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED732B9865
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgKSQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:46:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgKSQqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:46:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CC9A1478;
        Thu, 19 Nov 2020 08:46:01 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 617023F719;
        Thu, 19 Nov 2020 08:46:00 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 00/26] coresight: etm4x: Support for system instructions
Date:   Thu, 19 Nov 2020 16:45:22 +0000
Message-Id: <20201119164547.2982871-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight ETMv4.4 obsoletes memory mapped access to ETM and
mandates the system instructions for registers.
This also implies that they may not be on the amba bus.
Right now all the CoreSight components are accessed via memory
map. Also, we have some common routines in coresight generic
code driver (e.g, CS_LOCK, claim/disclaim), which assume the
mmio. In order to preserve the generic algorithms at a single
place and to allow dynamic switch for ETMs, this series introduces
an abstraction layer for accessing a coresight device. It is
designed such that the mmio access are fast tracked (i.e, without
an indirect function call).

This will also help us to get rid of the driver+attribute specific
sysfs show/store routines and replace them with a single routine
to access a given register offset (which can be embedded in the
dev_ext_attribute). This is not currently implemented in the series,
but can be achieved.

Further we switch the generic routines to work with the abstraction.
With this in place, we refactor the etm4x code a bit to allow for
supporting the system instructions with very little new code. The
changes also switch to using the system instructions by default
even when we may have an MMIO.

We use TRCDEVARCH for the detection of the ETM component, which
is a standard register as per CoreSight architecture, rather than
the etm specific id register TRCIDR1. This is for making sure
that we are able to detect the ETM via system instructions accurately,
when the the trace unit could be anything (etm or a custom trace unit).
To keep the backward compatibility for any existing broken
impelementation which may not implement TRCDEVARCH, we fall back to TRCIDR1.
Also this covers us for the changes in the future architecture [0].

Also, v8.4 self-hosted tracing extensions (coupled with ETMv4.4) adds
new filtering registers for trace by exception level. So on a v8.4
system, with Trace Filtering support, without the appropriate
programming of the Trace filter registers (TRFCR_ELx), tracing
will not be enabled. This series also includes the TraceFiltering
support to cover the ETM-v4.4 support.

The series has been mildly tested on a model for system instructions.
I would really appreciate any testing on real hardware.

Applies on coresight/next.

[0] https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers/trcidr1

Known issues: 
  Checkpatch failure for "coresight: etm4x: Add sysreg access helpers" :

  ERROR: Macros with complex values should be enclosed in parentheses
  #121: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:153:
  +#define CASE_READ(res, x)                                      \
  +    case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }

 I don't know a way to fix the warning without loosing the code
 readability, which I believe is crucial for such a construct.

Changes since v3:
  - Device tree compatible changed to etm4x
  - Use etm4x_** instead of generalizing etm_ in etm4x driver.
  - Added v8.4 self hosted trace support patches, reworked
    from Jonathan's series.
  - Dropped queued patches.
  - Expose TRCDEVARCH via trcidr, as this will be needed for
    the userspace tools to determine the trace major/minor
    arch versions.
  - Remove csa argument to read()/write() (Mathieu)
  - Fix secure exception mask calculation (Mathieu)
  - Fix various coding style comments (Mathieu)
   (See individual patches for change log)
  
Changes since V2:
  - Several fixes to the ETM register accesses. Access a register
    when it is present.
  - Add support for TRCIDR3.NUMPROCS for v4.2+
  - Drop OS lock detection. Use software lock only in case of mmio.
  - Fix issues with the Exception level masks (Mike Leach)
  - Fall back to using TRCIDR1 when TRCDEVARCH is not "present"
  - Use a generic notion of ETM architecture (rather than using
    the encoding as in registers)
  - Fixed some checkpatch issues.
  - Changed the dts compatible string to "arm,coresight-etm-sysreg"
    (Mike Leach)

Changes since V1:
  - Flip the switch for iomem from no_iomem to io_mem in csdev_access.
  - Split patches for claim/disclaim and CS_LOCK/UNLOCK conversions.
  - Move device access initialisation for etm4x to the target CPU
  - Cleanup secure exception level mask handling.
  - Switch to use TRCDEVARCH for ETM component discovery. This
    is for making 
  - Check the availability of OS/Software Locks before using them.


Jonathan Zhou (2):
  arm64: Add TRFCR_ELx definitions
  coresight: Add support for v8.4 SelfHosted tracing

Suzuki K Poulose (23):
  coresight: etm4x: Handle access to TRCSSPCICRn
  coresight: etm4x: Skip accessing TRCPDCR in save/restore
  coresight: Introduce device access abstraction
  coresight: tpiu: Prepare for using coresight device access abstraction
  coresight: Convert coresight_timeout to use access abstraction
  coresight: Convert claim/disclaim operations to use access wrappers
  coresight: etm4x: Always read the registers on the host CPU
  coresight: etm4x: Convert all register accesses
  coresight: etm4x: Add commentary on the registers
  coresight: etm4x: Add sysreg access helpers
  coresight: etm4x: Define DEVARCH register fields
  coresight: etm4x: Check for Software Lock
  coresight: etm4x: Cleanup secure exception level masks
  coresight: etm4x: Clean up exception level masks
  coresight: etm4x: Handle ETM architecture version
  coresight: etm4x: Detect access early on the target CPU
  coresight: etm4x: Use TRCDEVARCH for component discovery
  coresight: etm4x: Expose trcdevarch via trcidr
  coresight: etm4x: Add necessary synchronization for sysreg access
  coresight: etm4x: Detect system instructions support
  coresight: etm4x: Refactor probing routine
  coresight: etm4x: Add support for sysreg only devices
  dts: bindings: coresight: ETM system register access only units

 .../devicetree/bindings/arm/coresight.txt     |   5 +-
 arch/arm64/include/asm/sysreg.h               |  11 +
 drivers/hwtracing/coresight/coresight-catu.c  |  12 +-
 drivers/hwtracing/coresight/coresight-core.c  | 122 ++-
 .../hwtracing/coresight/coresight-cti-core.c  |  18 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  10 +-
 .../coresight/coresight-etm3x-core.c          |   9 +-
 .../coresight/coresight-etm4x-core.c          | 771 +++++++++++-------
 .../coresight/coresight-etm4x-sysfs.c         |  46 +-
 drivers/hwtracing/coresight/coresight-etm4x.h | 498 ++++++++++-
 .../hwtracing/coresight/coresight-funnel.c    |   7 +-
 .../coresight/coresight-replicator.c          |  13 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   4 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |  16 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  10 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |   4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  31 +-
 include/linux/coresight.h                     | 227 +++++-
 18 files changed, 1386 insertions(+), 428 deletions(-)

-- 
2.24.1

