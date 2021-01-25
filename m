Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE7F30392C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391268AbhAZJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 04:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbhAYSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:50:33 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:49:53 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id r4so8205286pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qc9prigLr3Iter3zKRVLUD7b0eU7k2VCSX5sIttLDgg=;
        b=m8DkWFQPsrh2wBcnsmhE/9gnfrksXwrsTg/zDNyNqa4YHanUT+kR2iQHKAbdphvZIg
         ikJbZQyXyRRuns5PpJHhwhRUcsDaVt8ft2nA88AoiugAbZpgqzkMeEVpkzsBGpjzvLdZ
         VX1CxpV/1m2DeNg1Xu/awMn8GPh6F1SVeGh16Jdd1z276RGPIaolA0GZ0aiDKIx5/jT3
         zd/vPAFft+XOXAZn+fZOzt01OQZYOH1fq88sub6IqLzzNSK03hijgeaKRJt7eZ3Z6duL
         EDHNY+SgDZT/2mH+JXoCDp2GBgiR4PZqXmQsKIPfMAtM92sE7H2BgyZ+41sTGMfYt0/2
         8rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qc9prigLr3Iter3zKRVLUD7b0eU7k2VCSX5sIttLDgg=;
        b=Khr/EoJon6IJvz6b+60GcwbIVoCPVB6hQGvX3OnW/Ve6Xzvq+v1km6aoKJOgwe4N7Q
         j6rhC/2asq9OS6FL+2b79RJ+NN9BaBogrHrN7pvK4gRcA8gNfOojbukodSGf3P5h3+lW
         si+HzmqLkmzHAGm0lV58Q8YOCvSwTA7oe5J6Ozkp52RgorvO/kx5HtTJiZ76CxyNMACP
         ISz0GEFrLnrbNpf/90fSu4Fvzpsn5G+RPBaWxUGkeJ4tYVyMNhhb2oaDZqCUDtCLrFXE
         0O+jBUBlcs+pw6ImHsIRHB2it1Xm552UAibhyxfbMJ3buzGMzvfAlgoW8Tpsh1n6ZPsT
         aKHA==
X-Gm-Message-State: AOAM532Z6rlCR+QEnkcx3Cai5jXgi35g4azafKJlAvF7xJWwHXbObUsr
        E8uEQhnEsW7J9gY+C6AJw704xQ==
X-Google-Smtp-Source: ABdhPJwH9EKRENY2gEjojawmMdhasu1aby6Zvv4W3t4MT6btS2PjPlQfFq/MlNfLCeZB1TexXWSdTA==
X-Received: by 2002:a17:90b:34b:: with SMTP id fh11mr1552423pjb.225.1611600593222;
        Mon, 25 Jan 2021 10:49:53 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p64sm17065143pfb.201.2021.01.25.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:49:52 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:49:50 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com
Subject: Re: [PATCH v7 00/28] coresight: etm4x: Support for system
 instructions
Message-ID: <20210125184950.GC894394@xps15>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 10:48:22PM +0000, Suzuki K Poulose wrote:
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
> supporting the system instructions with very little new code.
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

I have applied this set.

Thanks,
Mathieu

> 
> [0] https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers/trcidr1
> [1] https://gitlab.arm.com/linux-arm/linux-skp coresight/etm/sysreg-v7
> 
> Changes since v6:
>   - New patch: Patch9 : Prepare the sysfs attributes for
>     filtering by offset of the register
>   - New patch: Patch12: Hide ETM registers unaccessible
>     on the ETM (for system instructions based ETMs)
>   - Split the list of ETM registers to memory mapped only
>     and common registers (Patch 11)
>   - Fixed the alignment issues pointed by Mathieu
>     (Patch 3, 14, 24)
> 
> Changes since v5:
>   - Rebased on to coresight/next.
>   - Moved trcdevarch to mgmt/ in sysfs and updated the sysfs ABI
>     document (Mike Leach)
>   - New patch : Moved the etm4_check_arch_features to run on the CPU, since
>     the PID of the ETM has to be read on the CPU and is unavailable
>     otherwise.
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
> 
> Jonathan Zhou (2):
>   arm64: Add TRFCR_ELx definitions
>   coresight: Add support for v8.4 SelfHosted tracing
> 
> Suzuki K Poulose (26):
>   coresight: etm4x: Handle access to TRCSSPCICRn
>   coresight: etm4x: Skip accessing TRCPDCR in save/restore
>   coresight: Introduce device access abstraction
>   coresight: tpiu: Prepare for using coresight device access abstraction
>   coresight: Convert coresight_timeout to use access abstraction
>   coresight: Convert claim/disclaim operations to use access wrappers
>   coresight: etm4x: Always read the registers on the host CPU
>   coresight: etm4x: Convert all register accesses
>   coresight: etm4x: Make offset available for sysfs attributes
>   coresight: etm4x: Add commentary on the registers
>   coresight: etm4x: Add sysreg access helpers
>   coresight: etm4x: Hide sysfs attributes for unavailable registers
>   coresight: etm4x: Define DEVARCH register fields
>   coresight: etm4x: Check for Software Lock
>   coresight: etm4x: Cleanup secure exception level masks
>   coresight: etm4x: Clean up exception level masks
>   coresight: etm4x: Handle ETM architecture version
>   coresight: etm4x: Detect access early on the target CPU
>   coresight: etm4x: Use TRCDEVARCH for component discovery
>   coresight: etm4x: Expose trcdevarch via sysfs
>   coresight: etm4x: Add necessary synchronization for sysreg access
>   coresight: etm4x: Detect system instructions support
>   coresight: etm4x: Refactor probing routine
>   coresight: etm4x: Run arch feature detection on the CPU
>   coresight: etm4x: Add support for sysreg only devices
>   dts: bindings: coresight: ETM system register access only units
> 
>  .../testing/sysfs-bus-coresight-devices-etm4x |   8 +
>  .../devicetree/bindings/arm/coresight.txt     |   5 +-
>  arch/arm64/include/asm/sysreg.h               |  11 +
>  drivers/hwtracing/coresight/coresight-catu.c  |  12 +-
>  drivers/hwtracing/coresight/coresight-core.c  | 122 ++-
>  .../hwtracing/coresight/coresight-cti-core.c  |  18 +-
>  drivers/hwtracing/coresight/coresight-etb10.c |  10 +-
>  .../coresight/coresight-etm3x-core.c          |   9 +-
>  .../coresight/coresight-etm4x-core.c          | 805 ++++++++++++------
>  .../coresight/coresight-etm4x-sysfs.c         | 187 ++--
>  drivers/hwtracing/coresight/coresight-etm4x.h | 505 ++++++++++-
>  .../hwtracing/coresight/coresight-funnel.c    |   7 +-
>  .../coresight/coresight-replicator.c          |  13 +-
>  drivers/hwtracing/coresight/coresight-stm.c   |   4 +-
>  .../hwtracing/coresight/coresight-tmc-core.c  |  16 +-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |  10 +-
>  .../hwtracing/coresight/coresight-tmc-etr.c   |   4 +-
>  drivers/hwtracing/coresight/coresight-tpiu.c  |  31 +-
>  include/linux/coresight.h                     | 220 ++++-
>  19 files changed, 1520 insertions(+), 477 deletions(-)
> 
> -- 
> 2.24.1
> 
