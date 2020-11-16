Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78972B480A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgKPPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbgKPPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:00:42 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:00:42 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id s8so15877726yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aeioXhff1f3vF7j0RCbDiD5PCPYyMBjNjvduftBiGI=;
        b=afq4b0WgGf2RhElW4gFlg3yLRUK6iULczidRZN0VAZzzw1YDLvKgl2eiOcpYy0HnCl
         EJa5NJHtDVJaGXC3Dy4Pt0Mwosfcj6DJiboOBIVjVpukVbEWbHs/OGGKThBBekdMhhGe
         uIjyTKNu61RnWTpsvq4/FArMVW5CN1ihmAZWsn0lP9qpofDeeNOBoh2enNpO818rQxAU
         h6vig9C1BlgEn5J8DHoADX0XNp0svupdywig27VZBme6IxsA0Q3vuAoD6unwCnjFm0qw
         AVtqatqMB5SN9LYyo6VJqRqYvWPCqWhIsHZuCeAt8HRloMjOvg0nC8sMG5iJuDgTS9CJ
         spbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aeioXhff1f3vF7j0RCbDiD5PCPYyMBjNjvduftBiGI=;
        b=psRfVewAMM0lB/G3ady8tKLrO8Sc66FGX76+WfymvspCf53fgDekMJU5d5P6HOJzBL
         yB1nB3a3HdXQGx8QKnOtvefj3phjih6mL17H+WfHSse/qHmzIeifZyvEdqQ0ZnSJrJEw
         QmYTnpYNnf+/UlNk/Eo3rw1v7WbNe2HvUKxKqWkhZyBHH78KvgGygejL9x+8me5lIetP
         xYfVH9OXdmYxFTYat0x+Zuc8qZx+yMgtGJpHfx09OYlKtH4wY2nzSqF55fauFsnay+LS
         tn+ONy8uEJJkRio2kT2VN3gweL9aBrn9s4QWkhVLVT+H0RIY8u21QYhPlz8ZmOgXIz4u
         xO7Q==
X-Gm-Message-State: AOAM5326OxQnar616h9UEkLsd30ua+38CQVxng0jK2BblXxWbTKYlu72
        NxBraWiuXJPjqJCePEevrth9yJTwQtzBF70v2ob5u1xqVEijTw==
X-Google-Smtp-Source: ABdhPJwaAM6788DDnVap8DMY7NVUOgsAjZUERus6gXtB1GYZFdu29PElH01Zlgplk8Htzrm5uaNYFbZ1a3krqL1ikE4=
X-Received: by 2002:a25:8087:: with SMTP id n7mr22806968ybk.416.1605538841170;
 Mon, 16 Nov 2020 07:00:41 -0800 (PST)
MIME-Version: 1.0
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com> <20201114051715.GA23685@codeaurora.org>
In-Reply-To: <20201114051715.GA23685@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 16 Nov 2020 15:00:30 +0000
Message-ID: <CAJ9a7ViiZHi92Wr1uurb0B_nE4SmeHmbMChutaS++=FxcC8DTw@mail.gmail.com>
Subject: Re: [RFC 00/11] arm64: coresight: Enable ETE and TRBE
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

I've not looked in detail at this set yet, but having skimmed through
it  I do have an initial question about the handling of wrapped data
buffers.

With the ETR/ETB we found an issue with the way perf concatenated data
captured from the hardware buffer into a single contiguous data
block. The issue occurs when a wrapped buffer appears after another
buffer in the data file. In a typical session perf would stop trace
and copy the hardware buffer multiple times into the auxtrace buffer.

e.g.

For ETR/ETB we have a fixed length hardware data buffer - and no way
of detecting buffer wraps using interrupts as the tracing is in
progress.

If the buffer is not full at the point that perf transfers it then the
data will look like this:-
1) <async><synced trace data>
easy to decode, we can see the async at the start of the data - which
would be the async issued at the start of trace.

If the buffer wraps we see this:-

2) <unsynced trace data><async><synced trace data>

Again no real issue, the decoder will skip to the async and trace from
there - we lose the unsynced data.

Now the problem occurs when multiple transfers of data occur. We can
see the following appearing as contiguous trace in the auxtrace
buffer:-

3) < async><synced trace data><unsynced trace data><async><synced trace data>

Now the decoder cannot spot the point that the synced data from the
first capture ends, and the unsynced data from the second capture
begins.
This means it will continue to decode into the unsynced data - which
will result in incorrect trace / outright errors. To get round this
for ETR/ETB the driver will insert barrier packets into the datafile
if a wrap event is detected.

4) <async><synced trace data><barrier><unsynced trace
data><async><synced trace data>

This <barrier> has the effect of resetting the decoder into the
unsynced state so that the invalid trace is not decoded. This is a
workaround we have to do to handle the limitations of the ETR / ETB
trace hardware.

For TRBE we do have interrupts, so it should be possible to prevent
the buffer wrapping in most cases - but I did see in the code that
there are handlers for the TRBE buffer wrap management event. Are
there other factors in play that will prevent data pattern 3) from
appearing in the auxtrace buffer?

Regards

Mike





On Sat, 14 Nov 2020 at 05:17, Tingwei Zhang <tingweiz@codeaurora.org> wrote:
>
> Hi Anshuman,
>
> On Tue, Nov 10, 2020 at 08:44:58PM +0800, Anshuman Khandual wrote:
> > This series enables future IP trace features Embedded Trace Extension (ETE)
> > and Trace Buffer Extension (TRBE). This series depends on the ETM system
> > register instruction support series [0] and the v8.4 Self hosted tracing
> > support series (Jonathan Zhou) [1]. The tree is available here [2] for
> > quick access.
> >
> > ETE is the PE (CPU) trace unit for CPUs, implementing future architecture
> > extensions. ETE overlaps with the ETMv4 architecture, with additions to
> > support the newer architecture features and some restrictions on the
> > supported features w.r.t ETMv4. The ETE support is added by extending the
> > ETMv4 driver to recognise the ETE and handle the features as exposed by the
> > TRCIDRx registers. ETE only supports system instructions access from the
> > host CPU. The ETE could be integrated with a TRBE (see below), or with the
> > legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same firmware
> > description as the ETMs and requires a node per instance.
> >
> > Trace Buffer Extensions (TRBE) implements a per CPU trace buffer, which is
> > accessible via the system registers and can be combined with the ETE to
> > provide a 1x1 configuration of source & sink. TRBE is being represented
> > here as a CoreSight sink. Primary reason is that the ETE source could work
> > with other traditional CoreSight sink devices. As TRBE captures the trace
> > data which is produced by ETE, it cannot work alone.
> >
> > TRBE representation here have some distinct deviations from a traditional
> > CoreSight sink device. Coresight path between ETE and TRBE are not built
> > during boot looking at respective DT or ACPI entries. Instead TRBE gets
> > checked on each available CPU, when found gets connected with respective
> > ETE source device on the same CPU, after altering its outward connections.
> > ETE TRBE path connection lasts only till the CPU is online. But ETE-TRBE
> > coupling/decoupling method implemented here is not optimal and would be
> > reworked later on.
>
> Only perf mode is supported in TRBE in current path. Will you consider
> support sysfs mode as well in following patch sets?
>
> Thanks,
> Tingwei
>
> >
> > Unlike traditional sinks, TRBE can generate interrupts to signal including
> > many other things, buffer got filled. The interrupt is a PPI and should be
> > communicated from the platform. DT or ACPI entry representing TRBE should
> > have the PPI number for a given platform. During perf session, the TRBE IRQ
> > handler should capture trace for perf auxiliary buffer before restarting it
> > back. System registers being used here to configure ETE and TRBE could be
> > referred in the link below.
> >
> > https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers.
> >
> > This adds another change where CoreSight sink device needs to be disabled
> > before capturing the trace data for perf in order to avoid race condition
> > with another simultaneous TRBE IRQ handling. This might cause problem with
> > traditional sink devices which can be operated in both sysfs and perf mode.
> > This needs to be addressed correctly. One option would be to move the
> > update_buffer callback into the respective sink devices. e.g, disable().
> >
> > This series is primarily looking from some early feed back both on proposed
> > design and its implementation. It acknowledges, that it might be incomplete
> > and will have scopes for improvement.
> >
> > Things todo:
> > - Improve ETE-TRBE coupling and decoupling method
> > - Improve TRBE IRQ handling for all possible corner cases
> > - Implement sysfs based trace sessions
> >
> > [0]
> > https://lore.kernel.org/linux-arm-kernel/20201028220945.3826358-1-suzuki.poulose@arm.com/
> > [1]
> > https://lore.kernel.org/linux-arm-kernel/1600396210-54196-1-git-send-email-jonathan.zhouwen@huawei.com/
> > [2]
> > https://gitlab.arm.com/linux-arm/linux-skp/-/tree/coresight/etm/v8.4-self-hosted
> >
> > Anshuman Khandual (6):
> >   arm64: Add TRBE definitions
> >   coresight: sink: Add TRBE driver
> >   coresight: etm-perf: Truncate the perf record if handle has no space
> >   coresight: etm-perf: Disable the path before capturing the trace data
> >   coresgith: etm-perf: Connect TRBE sink with ETE source
> >   dts: bindings: Document device tree binding for Arm TRBE
> >
> > Suzuki K Poulose (5):
> >   coresight: etm-perf: Allow an event to use different sinks
> >   coresight: Do not scan for graph if none is present
> >   coresight: etm4x: Add support for PE OS lock
> >   coresight: ete: Add support for sysreg support
> >   coresight: ete: Detect ETE as one of the supported ETMs
> >
> >  .../devicetree/bindings/arm/coresight.txt          |   3 +
> >  Documentation/devicetree/bindings/arm/trbe.txt     |  20 +
> >  Documentation/trace/coresight/coresight-trbe.rst   |  36 +
> >  arch/arm64/include/asm/sysreg.h                    |  51 ++
> >  drivers/hwtracing/coresight/Kconfig                |  11 +
> >  drivers/hwtracing/coresight/Makefile               |   1 +
> >  drivers/hwtracing/coresight/coresight-etm-perf.c   |  85 ++-
> >  drivers/hwtracing/coresight/coresight-etm-perf.h   |   4 +
> >  drivers/hwtracing/coresight/coresight-etm4x-core.c | 144 +++-
> >  drivers/hwtracing/coresight/coresight-etm4x.h      |  64 +-
> >  drivers/hwtracing/coresight/coresight-platform.c   |   9 +-
> >  drivers/hwtracing/coresight/coresight-trbe.c       | 768
> > +++++++++++++++++++++
> >  drivers/hwtracing/coresight/coresight-trbe.h       | 525 ++++++++++++++
> >  include/linux/coresight.h                          |   2 +
> >  14 files changed, 1680 insertions(+), 43 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/trbe.txt
> >  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
> >  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
> >  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > CoreSight mailing list
> > CoreSight@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/coresight
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
