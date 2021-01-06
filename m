Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3212EBFD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAFOtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbhAFOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:49:51 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8AC061359
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:49:10 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x2so2975852ybt.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 06:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uigYjRtNP30s+lOXLNKCDAsIjmssdIHxK9AANGgD80=;
        b=PTXP/X5NXszukdRynUVkyhxUDqmrKTjw4eAvAjErPDAx57wYFIUBG8IPiLL//t+rh0
         P4wXEzFa7lcM6lZxzip+alv+e0C4cEAWLSOAeoS2RjNIGBOOlGk1Id0G9umkFlYNxfm+
         1FLE2/5aDI8IcxcVJg70NroxBY8sNxbwMY1I97kB+fFdWYCYYuWkDn/EA2T4wpfSwoTU
         Ds3YqTnmnzrM2lEZN9J0ABIqYmv6RuaLa/SDWBveya7eYETAZoiCmm1EMnuBu7knx3tg
         rQPQH1JuvqeZSYsPZmv7BwAj40/2X/jwMQm8Jvkk85JuPw+8iN+IyEHM3nJhr7PmcyER
         K9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uigYjRtNP30s+lOXLNKCDAsIjmssdIHxK9AANGgD80=;
        b=LJuJ1fKYP5Bi3Ce5R3/5sqF/FjHag0tp8CH6GX2NIFHgYwehqt5TOHnhhRhkQbwXR4
         78NSgMoIrIzr23LH6doKfl7EptWRpXV1V2o5jTJaG1vthTtzRDwxMx0e2UeBFeMg8JK4
         Ub6JRpMQ9FWY8eqLo9ix3t7AlnYp6A693svKWew+vaYapK8bJZQZPxjr/s2iiflO7IZe
         +vU/6Qap+TFi5m2O6S/ZFqWIMaWm+KTAyY3Vt6uB08SRWcSEeyPwqDwu6Es1IpWDgP+M
         p+dh6l02w2Hhn9TWSYyBOvWy+i1aNpsXI2IRsHLOpisLmzaQs2PsFpL3AcfFvOwTaOwo
         /4jQ==
X-Gm-Message-State: AOAM5318jG7RuNeIsVazj+M290VFhuVTi8LtOnKQninFKpiA1OGU3bqg
        vrmwbRbE3oBNM3m6vw/JMKaz4JnuVtFXcB1F5yc3OQ==
X-Google-Smtp-Source: ABdhPJx3p6oIAadfTWz8x8PUe0DlVJqUAqXhYeIOCSW2SHltEwwufaSJ4WkriNzGsjbHLVakKGehOu2aZnPQxlhHMP4=
X-Received: by 2002:a25:7682:: with SMTP id r124mr6509649ybc.416.1609944549826;
 Wed, 06 Jan 2021 06:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
In-Reply-To: <20201214173731.302520-1-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 6 Jan 2021 14:48:59 +0000
Message-ID: <CAJ9a7Vgx10RD-8UCaDR1UgGqsOAEjiu2RoxOTcToWkcr6HvT5A@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] coresight: etm4x: Support for system instructions
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

In addition to altering patch 18, to put the newly accessible
TRCDEVARCH register into the more appropriate 'mgmt' subdir for
CoreSight management registers, an update is needed to
./Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x to add a
reference for this new sysfs file to reflect the location and purpose
of the register.

Thanks

Mike


On Mon, 14 Dec 2020 at 17:37, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> CoreSight ETMv4.4 obsoletes memory mapped access to ETM and
> mandates the system instructions for registers.
> This also implies that they may not be on the amba bus.
> Right now all the CoreSight components are accessed via memory
> map. Also, we have some common routines in coresight generic
> code driver (e.g, CS_LOCK, claim/disclaim), which assume the
> mmio. In order to preserve the generic algorithms at a single
> place and to allow dynamic switch for ETMs, this series introduces
> an abstraction layer for accessing a coresight device. It is
> designed such that the mmio access are fast tracked (i.e, without
> an indirect function call).
>
> This will also help us to get rid of the driver+attribute specific
> sysfs show/store routines and replace them with a single routine
> to access a given register offset (which can be embedded in the
> dev_ext_attribute). This is not currently implemented in the series,
> but can be achieved.
>
> Further we switch the generic routines to work with the abstraction.
> With this in place, we refactor the etm4x code a bit to allow for
> supporting the system instructions with very little new code. The
> changes also switch to using the system instructions by default
> even when we may have an MMIO.
>
> We use TRCDEVARCH for the detection of the ETM component, which
> is a standard register as per CoreSight architecture, rather than
> the etm specific id register TRCIDR1. This is for making sure
> that we are able to detect the ETM via system instructions accurately,
> when the the trace unit could be anything (etm or a custom trace unit).
> To keep the backward compatibility for any existing broken
> impelementation which may not implement TRCDEVARCH, we fall back to TRCIDR1.
> Also this covers us for the changes in the future architecture [0].
>
> Also, v8.4 self-hosted tracing extensions (coupled with ETMv4.4) adds
> new filtering registers for trace by exception level. So on a v8.4
> system, with Trace Filtering support, without the appropriate
> programming of the Trace filter registers (TRFCR_ELx), tracing
> will not be enabled. This series also includes the TraceFiltering
> support to cover the ETM-v4.4 support.
>
> The series has been mildly tested on a model for system instructions.
> I would really appreciate any testing on real hardware.
>
> Applies on coresight/next. A tree is available here [1].
>
>
> [0] https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers/trcidr1
> [1] https://gitlab.arm.com/linux-arm/linux-skp coresight/etm/sysreg-v5
>
> Changes since v4:
>   - Fix typo in commit description for the patches 02 & 15
>   - Refactor the AMBA device "remove" call back for use with
>     paltform_driver. (patch 21). Thus remove Review tag by Mathieu,
>     even though the changes are minimal.
>   - Added "remove" callback for platform_driver in patch 22, removed
>     Review tag by Mathieu
>   - Add 'U' suffix for constants in Patch 24 (Catalin)
>   - Fixed field extraction in Patch 25
>
> Changes since v3:
>   - Device tree compatible changed to etm4x
>   - Use etm4x_** instead of generalizing etm_ in etm4x driver.
>   - Added v8.4 self hosted trace support patches, reworked
>     from Jonathan's series.
>   - Dropped queued patches.
>   - Expose TRCDEVARCH via trcidr, as this will be needed for
>     the userspace tools to determine the trace major/minor
>     arch versions.
>   - Remove csa argument to read()/write() (Mathieu)
>   - Fix secure exception mask calculation (Mathieu)
>   - Fix various coding style comments (Mathieu)
>    (See individual patches for change log)
>
> Changes since V2:
>   - Several fixes to the ETM register accesses. Access a register
>     when it is present.
>   - Add support for TRCIDR3.NUMPROCS for v4.2+
>   - Drop OS lock detection. Use software lock only in case of mmio.
>   - Fix issues with the Exception level masks (Mike Leach)
>   - Fall back to using TRCIDR1 when TRCDEVARCH is not "present"
>   - Use a generic notion of ETM architecture (rather than using
>     the encoding as in registers)
>   - Fixed some checkpatch issues.
>   - Changed the dts compatible string to "arm,coresight-etm-sysreg"
>     (Mike Leach)
>
> Changes since V1:
>   - Flip the switch for iomem from no_iomem to io_mem in csdev_access.
>   - Split patches for claim/disclaim and CS_LOCK/UNLOCK conversions.
>   - Move device access initialisation for etm4x to the target CPU
>   - Cleanup secure exception level mask handling.
>   - Switch to use TRCDEVARCH for ETM component discovery. This
>     is for making
>   - Check the availability of OS/Software Locks before using them.
>
> Known issues:
>   Checkpatch failure for "coresight: etm4x: Add sysreg access helpers" :
>
>   ERROR: Macros with complex values should be enclosed in parentheses
>   #121: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:153:
>   +#define CASE_READ(res, x)                                      \
>   +    case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }
>
>  I don't know a way to fix the warning without loosing the code
>  readability, which I believe is crucial for such a construct.
>
>
> Jonathan Zhou (2):
>   arm64: Add TRFCR_ELx definitions
>   coresight: Add support for v8.4 SelfHosted tracing
>
> Suzuki K Poulose (23):
>   coresight: etm4x: Handle access to TRCSSPCICRn
>   coresight: etm4x: Skip accessing TRCPDCR in save/restore
>   coresight: Introduce device access abstraction
>   coresight: tpiu: Prepare for using coresight device access abstraction
>   coresight: Convert coresight_timeout to use access abstraction
>   coresight: Convert claim/disclaim operations to use access wrappers
>   coresight: etm4x: Always read the registers on the host CPU
>   coresight: etm4x: Convert all register accesses
>   coresight: etm4x: Add commentary on the registers
>   coresight: etm4x: Add sysreg access helpers
>   coresight: etm4x: Define DEVARCH register fields
>   coresight: etm4x: Check for Software Lock
>   coresight: etm4x: Cleanup secure exception level masks
>   coresight: etm4x: Clean up exception level masks
>   coresight: etm4x: Handle ETM architecture version
>   coresight: etm4x: Detect access early on the target CPU
>   coresight: etm4x: Use TRCDEVARCH for component discovery
>   coresight: etm4x: Expose trcdevarch via trcidr
>   coresight: etm4x: Add necessary synchronization for sysreg access
>   coresight: etm4x: Detect system instructions support
>   coresight: etm4x: Refactor probing routine
>   coresight: etm4x: Add support for sysreg only devices
>   dts: bindings: coresight: ETM system register access only units
>
>  .../devicetree/bindings/arm/coresight.txt     |   5 +-
>  arch/arm64/include/asm/sysreg.h               |  11 +
>  drivers/hwtracing/coresight/coresight-catu.c  |  12 +-
>  drivers/hwtracing/coresight/coresight-core.c  | 122 ++-
>  .../hwtracing/coresight/coresight-cti-core.c  |  18 +-
>  drivers/hwtracing/coresight/coresight-etb10.c |  10 +-
>  .../coresight/coresight-etm3x-core.c          |   9 +-
>  .../coresight/coresight-etm4x-core.c          | 796 ++++++++++++------
>  .../coresight/coresight-etm4x-sysfs.c         |  46 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h | 498 ++++++++++-
>  .../hwtracing/coresight/coresight-funnel.c    |   7 +-
>  .../coresight/coresight-replicator.c          |  13 +-
>  drivers/hwtracing/coresight/coresight-stm.c   |   4 +-
>  .../hwtracing/coresight/coresight-tmc-core.c  |  16 +-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |  10 +-
>  .../hwtracing/coresight/coresight-tmc-etr.c   |   4 +-
>  drivers/hwtracing/coresight/coresight-tpiu.c  |  31 +-
>  include/linux/coresight.h                     | 225 ++++-
>  18 files changed, 1406 insertions(+), 431 deletions(-)
>
> --
> 2.24.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
