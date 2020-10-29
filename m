Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116ED29E553
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgJ2H4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgJ2HyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:54:09 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F171DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:54:08 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a12so1395352ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFXHHhFAI7F0boyMMl9VuURltwpwedI93M6v4kx2qIw=;
        b=zRJqdA3rovxvN6CyF/Mhd9hNsAlylTjNBzzA2Kg6THqRr+rPWNXjw00Mw9fqvzHJz+
         t3ID7YJDs8BE7c3MMjjpt51Y8WPpnzDqUcTjNpYdshlHoGxpS+SA7H9JVOPkY2R1EnzS
         ZFiwPnqXXrHxBBe6C4hNReSpNMXV0dODV1EtjRmlrnYzJSx/xub34kjdmY6OEAHbcQX7
         eLWIuO9WBkRgD9DZ1Bgj4fYPyNolp/odX3wtXw8eW8VfyB1wyBni+lxpK9WZJ+TvAK3W
         CfPT6U4PLZz13dz7D9z7fkKDHV18edYktimZaZs+UGk7B3vIkruW1guLjGa5ykCnYxc6
         aH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFXHHhFAI7F0boyMMl9VuURltwpwedI93M6v4kx2qIw=;
        b=GmyXzcuk0jIfT5souWlApoppK9DpFim5rqxZc2y2Kjq+/z58aCtf/R4B1adbuP6gyl
         yg4sPFCbpCOsq4rs6GFq/bM2p0g51IHHAb2KYQHEtQN5eikCC775A5qbNAfO1r6dmyy4
         NGr6bfzKPSB9ApODhbLiHlwcgenVjXI1jhDpWBz+c7PBx3iR/zcQi8Eh6y4DAawjeInz
         hsOqutSHXxuy6NuMY++2BE+UIVq/87OJy0MfiC31nRHU2pfEK5rBEA2D/bxg6RfuBmS9
         sNYMtXC4lSrQd0G5QpBWAlz1KjOnbVIskeS3h7koz1Gz6A/m5jk7KUQku4bVym8lu+H+
         X9mw==
X-Gm-Message-State: AOAM532eFleyvfi386nQ1cPnsCpUoqSppKdh3nZILStRDSM+JU4kbbb5
        WwLYnLgP9Tw/5bq1q0aK6ng2OW3z/1Z5uKXdDjBzuA==
X-Google-Smtp-Source: ABdhPJwcIKpvFt/o64DVjKP74EsOKgo/fki63/eC47bd3J3h7T+4YmJbDxOFgCsyl8N6+77Foh9g3yN0LIFgNFNipuY=
X-Received: by 2002:a25:d616:: with SMTP id n22mr4693171ybg.106.1603958048125;
 Thu, 29 Oct 2020 00:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 29 Oct 2020 07:53:57 +0000
Message-ID: <CAJ9a7Vh5ODr=atPLffG0ud2XZjwav5ysiR9J2rQQxWfmL6ypQA@mail.gmail.com>
Subject: Re: [PATCH v3 00/26] coresight: Support for ETM system instructions
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, 28 Oct 2020 at 22:10, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
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
> To keep the backward compatibility for any existing broken impelementation
> which may not implement TRCDEVARCH, we fall back to TRCIDR1. Also
> this covers us for the changes in the future architecture [0].
>
> The series has been mildly tested on a model for system instructions.
> I would really appreciate any testing on real hardware.
>
> Applies on coresight/next.
>
> [0] https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers/trcidr1
>
> Known issues:
>   Checkpatch failure for "coresight: etm4x: Add sysreg access helpers" :
>
>   ERROR: Macros with complex values should be enclosed in parentheses
>   #121: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:153:
>   +#define CASE_READ(res, x)                                      \
>   +       case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }
>
>
> I don't know how to fix that without breaking the build ! Suggestions
> welcome.
>

I hit exactly the same issue with my recent v2 set. The checker really
hates case statements in macros. In my case I shut it up for v3 by
changing:-

    #define MAPREG(cval, elem) \
        case cval: \
            reg->drv_store = &drvcfg->elem; \
            break;


    if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
        ((offset >= TRCSEQRSTEVR) && (offset <= TRCEXTINSELR)) ||
        ((offset >= TRCCIDCCTLR0) && (offset <= TRCVMIDCCTLR1))) {
        switch (offset) {
            /* 32 bit single control and filter registers */
            MAPREG(TRCEVENTCTL0R, eventctrl0);
            MAPREG(TRCEVENTCTL1R, eventctrl1);
            MAPREG(TRCSTALLCTLR, stall_ctrl);
            MAPREG(TRCTSCTLR, ts_ctrl);
            MAPREG(TRCSYNCPR, syncfreq);
            MAPREG(TRCCCCTLR, ccctlr);
            MAPREG(TRCBBCTLR, bb_ctrl);
            MAPREG(TRCVICTLR, vinst_ctrl);
            MAPREG(TRCVIIECTLR, viiectlr);
            MAPREG(TRCVISSCTLR, vissctlr);
            MAPREG(TRCVIPCSSCTLR, vipcssctlr);
            MAPREG(TRCSEQRSTEVR, seq_rst);
            MAPREG(TRCSEQSTR, seq_state);
            MAPREG(TRCEXTINSELR, ext_inp);
            MAPREG(TRCCIDCCTLR0, ctxid_mask0);
            MAPREG(TRCCIDCCTLR1, ctxid_mask1);
            MAPREG(TRCVMIDCCTLR0, vmid_mask0);
            MAPREG(TRCVMIDCCTLR1, vmid_mask1);
        default:
            err = -EINVAL;
            break;
        }


to

err = -EINVAL;

#define CHECKREG(cval, elem) \
    { \
        if (offset == cval) { \
            reg->drv_store = &drvcfg->elem; \
            err = 0; \
            break; \
        } \
    }

    if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
        ((offset >= TRCSEQRSTEVR) && (offset <= TRCEXTINSELR)) ||
        ((offset >= TRCCIDCCTLR0) && (offset <= TRCVMIDCCTLR1))) {
        do {
            CHECKREG(TRCEVENTCTL0R, eventctrl0);
            CHECKREG(TRCEVENTCTL1R, eventctrl1);
            CHECKREG(TRCSTALLCTLR, stall_ctrl);
            CHECKREG(TRCTSCTLR, ts_ctrl);
            CHECKREG(TRCSYNCPR, syncfreq);
            CHECKREG(TRCCCCTLR, ccctlr);
            CHECKREG(TRCBBCTLR, bb_ctrl);
            CHECKREG(TRCVICTLR, vinst_ctrl);
            CHECKREG(TRCVIIECTLR, viiectlr);
            CHECKREG(TRCVISSCTLR, vissctlr);
            CHECKREG(TRCVIPCSSCTLR, vipcssctlr);
            CHECKREG(TRCSEQRSTEVR, seq_rst);
            CHECKREG(TRCSEQSTR, seq_state);
            CHECKREG(TRCEXTINSELR, ext_inp);
            CHECKREG(TRCCIDCCTLR0, ctxid_mask0);
            CHECKREG(TRCCIDCCTLR1, ctxid_mask1);
            CHECKREG(TRCVMIDCCTLR0, vmid_mask0);
            CHECKREG(TRCVMIDCCTLR1, vmid_mask1);
        } while (0);


A bit contrived but functionally the same - and doesn't annoy the
checker, No idea if the code is more or less efficient after
compilation than a standard switch / case combo, but not on a critical
path for me so wasn't bothered.
As I look again I could have actually put the err = -EINVAL; line just
before the while(0) statement - making it more like a case default -
but my current set is too close to release to change that now.

Cheers

Mike


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
>   - Add support for Self Hosted tracing Arm v8.4 extensions. (Mike
>     Leach)
>     Originally written by Jonathan, refactored and cleaned up.
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
>
> Suzuki K Poulose (26):
>   coresight: etm4x: Fix accesses to TRCVMIDCTLR1
>   coresight: etm4x: Fix accesses to TRCCIDCTLR1
>   coresight: etm4x: Update TRCIDR3.NUMPROCS handling to match v4.2
>   coresight: etm4x: Fix accesses to TRCPROCSELR
>   coresight: etm4x: Handle TRCVIPCSSCTLR accesses
>   coresight: etm4x: Handle access to TRCSSPCICRn
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
>   coresight: etm4x: Detect access early on the target CPU
>   coresight: etm4x: Handle ETM architecture version
>   coresight: etm4x: Use TRCDEVARCH for component discovery
>   coresight: etm4x: Add necessary synchronization for sysreg access
>   coresight: etm4x: Detect system instructions support
>   coresight: etm4x: Refactor probing routine
>   coresight: etm4x: Add support for sysreg only devices
>   dts: bindings: coresight: ETM system register access only units
>
>  .../devicetree/bindings/arm/coresight.txt     |   5 +-
>  drivers/hwtracing/coresight/coresight-catu.c  |  12 +-
>  drivers/hwtracing/coresight/coresight-core.c  | 130 ++-
>  .../hwtracing/coresight/coresight-cti-core.c  |  18 +-
>  drivers/hwtracing/coresight/coresight-etb10.c |  10 +-
>  .../coresight/coresight-etm3x-core.c          |   9 +-
>  .../coresight/coresight-etm4x-core.c          | 758 +++++++++++-------
>  .../coresight/coresight-etm4x-sysfs.c         |  44 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h | 501 +++++++++++-
>  .../hwtracing/coresight/coresight-funnel.c    |   7 +-
>  .../coresight/coresight-replicator.c          |  17 +-
>  drivers/hwtracing/coresight/coresight-stm.c   |   4 +-
>  .../hwtracing/coresight/coresight-tmc-core.c  |  16 +-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |  10 +-
>  .../hwtracing/coresight/coresight-tmc-etr.c   |   4 +-
>  drivers/hwtracing/coresight/coresight-tpiu.c  |  31 +-
>  include/linux/coresight.h                     | 230 +++++-
>  17 files changed, 1376 insertions(+), 430 deletions(-)
>
> --
> 2.24.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
