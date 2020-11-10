Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4E2ADE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgKJSZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJSZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:25:55 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EF5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:25:55 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id u19so15317363ion.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmC2bek4giP8oKrp5Sfgdf/srGJxxJSDSe/5JfcySzk=;
        b=Ex8cDI+3Utlv9xkDTlQjNyWPvZrFrWnV4UuPIVeNSIV/jhvfe9fygcYQrlKmMoG3bv
         yfFNLUDn43TJIKdTT83Pffr9Vq185jTieqT7st7I1Qu6g1iPsgB36aGHjSedudOhl6gF
         I8bChzsIvtcLgvsUvh0d4dtvOhqeigaeaI0hgbbSoGytdAcL+kH0ZK1dPUDgfaMqyQ6O
         bwJJCBVmCXJ1RGRFdEocuLhbLkP27knbdtukDWaR7cakU5x+ZF4IRWN1rAC7odqa7bi9
         KqoVW1VIGCtz7ngMZkFWUU9gzUKS74CgQUyGUj4AWjZn3uLHLkiqqmets9sQaRoc8/4R
         zYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmC2bek4giP8oKrp5Sfgdf/srGJxxJSDSe/5JfcySzk=;
        b=abWMHXj7borUYtkqWf0TBmGQBwEZ9bSUIkuu19JkBPKzPDEe/SdAcBEYG/Cyc9S/F0
         cE0RotKzbOyD74jfQ/KN6m+GRAArVAtpYMsOEkQLyEa3J4HZmUvZQLZleOEEU/lQiUML
         F0jXA80mbxV0yS34tQDRUa9ZuPyiHCZynJfMxn1A9KWVmo2ROYsqlBDbSPnp+TDuGupK
         7tGDHh9PTZQuMFUFBpL3W1PuD4vnTW6occn5jnASJ+FgpbEReDiqcdfanq6z6uZCiMjo
         0NtmmfVGPnwhmXfVugANGlT0gdsWxPsguAthbDOLq6WC0HwT/uzzNPBIxFnfnluMVS/c
         78ng==
X-Gm-Message-State: AOAM533PEBcduJKTGywF0OrhmMgzxIKvG9AtnrXBIQUaWBId+R390AYX
        cIAtqTdOCJ1/CyQeXvw6hV3jRiDUVkR/A+z2bjl+kxoes+A=
X-Google-Smtp-Source: ABdhPJzvzFKjJog6OR5kvD0VC5AzMLwo2C1vQ2shcBUc0XlnCRR+7b/TCI3tYhXUqHIcqReUHMasgC/jDp9WzF7g14k=
X-Received: by 2002:a05:6638:124d:: with SMTP id o13mr16215369jas.98.1605032754654;
 Tue, 10 Nov 2020 10:25:54 -0800 (PST)
MIME-Version: 1.0
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 10 Nov 2020 11:25:43 -0700
Message-ID: <CANLsYkwv0Jk87UhAceEqPXxAOpuj8Qzj5+5DG=D4jCK1RjqvTg@mail.gmail.com>
Subject: Re: [RFC 00/11] arm64: coresight: Enable ETE and TRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Tue, 10 Nov 2020 at 05:45, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This series enables future IP trace features Embedded Trace Extension (ETE)
> and Trace Buffer Extension (TRBE). This series depends on the ETM system
> register instruction support series [0] and the v8.4 Self hosted tracing
> support series (Jonathan Zhou) [1]. The tree is available here [2] for
> quick access.
>
> ETE is the PE (CPU) trace unit for CPUs, implementing future architecture
> extensions. ETE overlaps with the ETMv4 architecture, with additions to
> support the newer architecture features and some restrictions on the
> supported features w.r.t ETMv4. The ETE support is added by extending the
> ETMv4 driver to recognise the ETE and handle the features as exposed by the
> TRCIDRx registers. ETE only supports system instructions access from the
> host CPU. The ETE could be integrated with a TRBE (see below), or with the
> legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same firmware
> description as the ETMs and requires a node per instance.
>
> Trace Buffer Extensions (TRBE) implements a per CPU trace buffer, which is
> accessible via the system registers and can be combined with the ETE to
> provide a 1x1 configuration of source & sink. TRBE is being represented
> here as a CoreSight sink. Primary reason is that the ETE source could work
> with other traditional CoreSight sink devices. As TRBE captures the trace
> data which is produced by ETE, it cannot work alone.
>
> TRBE representation here have some distinct deviations from a traditional
> CoreSight sink device. Coresight path between ETE and TRBE are not built
> during boot looking at respective DT or ACPI entries. Instead TRBE gets
> checked on each available CPU, when found gets connected with respective
> ETE source device on the same CPU, after altering its outward connections.
> ETE TRBE path connection lasts only till the CPU is online. But ETE-TRBE
> coupling/decoupling method implemented here is not optimal and would be
> reworked later on.
>
> Unlike traditional sinks, TRBE can generate interrupts to signal including
> many other things, buffer got filled. The interrupt is a PPI and should be
> communicated from the platform. DT or ACPI entry representing TRBE should
> have the PPI number for a given platform. During perf session, the TRBE IRQ
> handler should capture trace for perf auxiliary buffer before restarting it
> back. System registers being used here to configure ETE and TRBE could be
> referred in the link below.
>
> https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers.
>
> This adds another change where CoreSight sink device needs to be disabled
> before capturing the trace data for perf in order to avoid race condition
> with another simultaneous TRBE IRQ handling. This might cause problem with
> traditional sink devices which can be operated in both sysfs and perf mode.
> This needs to be addressed correctly. One option would be to move the
> update_buffer callback into the respective sink devices. e.g, disable().
>
> This series is primarily looking from some early feed back both on proposed
> design and its implementation. It acknowledges, that it might be incomplete
> and will have scopes for improvement.
>
> Things todo:
> - Improve ETE-TRBE coupling and decoupling method
> - Improve TRBE IRQ handling for all possible corner cases
> - Implement sysfs based trace sessions
>
> [0] https://lore.kernel.org/linux-arm-kernel/20201028220945.3826358-1-suzuki.poulose@arm.com/
> [1] https://lore.kernel.org/linux-arm-kernel/1600396210-54196-1-git-send-email-jonathan.zhouwen@huawei.com/
> [2] https://gitlab.arm.com/linux-arm/linux-skp/-/tree/coresight/etm/v8.4-self-hosted
>
> Anshuman Khandual (6):
>   arm64: Add TRBE definitions
>   coresight: sink: Add TRBE driver
>   coresight: etm-perf: Truncate the perf record if handle has no space
>   coresight: etm-perf: Disable the path before capturing the trace data
>   coresgith: etm-perf: Connect TRBE sink with ETE source
>   dts: bindings: Document device tree binding for Arm TRBE
>
> Suzuki K Poulose (5):
>   coresight: etm-perf: Allow an event to use different sinks
>   coresight: Do not scan for graph if none is present
>   coresight: etm4x: Add support for PE OS lock
>   coresight: ete: Add support for sysreg support
>   coresight: ete: Detect ETE as one of the supported ETMs
>
>  .../devicetree/bindings/arm/coresight.txt          |   3 +
>  Documentation/devicetree/bindings/arm/trbe.txt     |  20 +
>  Documentation/trace/coresight/coresight-trbe.rst   |  36 +
>  arch/arm64/include/asm/sysreg.h                    |  51 ++
>  drivers/hwtracing/coresight/Kconfig                |  11 +
>  drivers/hwtracing/coresight/Makefile               |   1 +
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  85 ++-
>  drivers/hwtracing/coresight/coresight-etm-perf.h   |   4 +
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 144 +++-
>  drivers/hwtracing/coresight/coresight-etm4x.h      |  64 +-
>  drivers/hwtracing/coresight/coresight-platform.c   |   9 +-
>  drivers/hwtracing/coresight/coresight-trbe.c       | 768 +++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-trbe.h       | 525 ++++++++++++++
>  include/linux/coresight.h                          |   2 +
>  14 files changed, 1680 insertions(+), 43 deletions(-)

This is to confirm that I have received your work and it is now on my
list of patchset to review.  However doing so likely won't happen
before a couple of weeks because of patchsets already in the queue.  I
will touch base with you again if there are further delays.

Thanks,
Mathieu

>  create mode 100644 Documentation/devicetree/bindings/arm/trbe.txt
>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>
> --
> 2.7.4
>
