Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD8129DFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgJ2BDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:03:51 -0400
Received: from foss.arm.com ([217.140.110.172]:39058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbgJ1WKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0141B1767;
        Wed, 28 Oct 2020 15:10:06 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1314F3F68F;
        Wed, 28 Oct 2020 15:09:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 00/26] coresight: Support for ETM system instructions
Date:   Wed, 28 Oct 2020 22:09:19 +0000
Message-Id: <20201028220945.3826358-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
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
To keep the backward compatibility for any existing broken impelementation
which may not implement TRCDEVARCH, we fall back to TRCIDR1. Also
this covers us for the changes in the future architecture [0].

The series has been mildly tested on a model for system instructions.
I would really appreciate any testing on real hardware.

Applies on coresight/next.

[0] https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers/trcidr1

Known issues: 
  Checkpatch failure for "coresight: etm4x: Add sysreg access helpers" :

  ERROR: Macros with complex values should be enclosed in parentheses
  #121: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:153:
  +#define CASE_READ(res, x)                                      \
  +       case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }


I don't know how to fix that without breaking the build ! Suggestions
welcome.
  

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
  - Add support for Self Hosted tracing Arm v8.4 extensions. (Mike
    Leach)
    Originally written by Jonathan, refactored and cleaned up.
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


Suzuki K Poulose (26):
  coresight: etm4x: Fix accesses to TRCVMIDCTLR1
  coresight: etm4x: Fix accesses to TRCCIDCTLR1
  coresight: etm4x: Update TRCIDR3.NUMPROCS handling to match v4.2
  coresight: etm4x: Fix accesses to TRCPROCSELR
  coresight: etm4x: Handle TRCVIPCSSCTLR accesses
  coresight: etm4x: Handle access to TRCSSPCICRn
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
  coresight: etm4x: Detect access early on the target CPU
  coresight: etm4x: Handle ETM architecture version
  coresight: etm4x: Use TRCDEVARCH for component discovery
  coresight: etm4x: Add necessary synchronization for sysreg access
  coresight: etm4x: Detect system instructions support
  coresight: etm4x: Refactor probing routine
  coresight: etm4x: Add support for sysreg only devices
  dts: bindings: coresight: ETM system register access only units

 .../devicetree/bindings/arm/coresight.txt     |   5 +-
 drivers/hwtracing/coresight/coresight-catu.c  |  12 +-
 drivers/hwtracing/coresight/coresight-core.c  | 130 ++-
 .../hwtracing/coresight/coresight-cti-core.c  |  18 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  10 +-
 .../coresight/coresight-etm3x-core.c          |   9 +-
 .../coresight/coresight-etm4x-core.c          | 758 +++++++++++-------
 .../coresight/coresight-etm4x-sysfs.c         |  44 +-
 drivers/hwtracing/coresight/coresight-etm4x.h | 501 +++++++++++-
 .../hwtracing/coresight/coresight-funnel.c    |   7 +-
 .../coresight/coresight-replicator.c          |  17 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   4 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |  16 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  10 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |   4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  31 +-
 include/linux/coresight.h                     | 230 +++++-
 17 files changed, 1376 insertions(+), 430 deletions(-)

-- 
2.24.1

