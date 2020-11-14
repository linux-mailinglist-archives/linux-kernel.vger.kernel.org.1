Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7002B2B68
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 06:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgKNFRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 00:17:30 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:34199 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgKNFRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 00:17:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605331048; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=N5xCek6D3akltjkhWRjrBydlXr+Qp7Z7ZrEgFzlOYgM=; b=YdK6IcrEgUXv/9IKSt9RAZycz6A1MYJ2NFIaDMP68YOaRfRmCLErNMrK2Nd6AXIH7vGJdu8Z
 QHG4he66dYdpvR1jnSzjvksvdZ2Ll6H1VottrpKmJUqLcBvbGkKadaKrfbVE5Q5oF0c9T5kC
 3nG7mOLeXwdZmI6SkR4KTqSc+6M=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5faf686525da3a0fa97dddf4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 14 Nov 2020 05:17:25
 GMT
Sender: tingweiz=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29E38C433CB; Sat, 14 Nov 2020 05:17:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A6DAC433C8;
        Sat, 14 Nov 2020 05:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A6DAC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Sat, 14 Nov 2020 13:17:15 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/11] arm64: coresight: Enable ETE and TRBE
Message-ID: <20201114051715.GA23685@codeaurora.org>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Tue, Nov 10, 2020 at 08:44:58PM +0800, Anshuman Khandual wrote:
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

Only perf mode is supported in TRBE in current path. Will you consider
support sysfs mode as well in following patch sets?

Thanks,
Tingwei

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
> [0] 
> https://lore.kernel.org/linux-arm-kernel/20201028220945.3826358-1-suzuki.poulose@arm.com/
> [1] 
> https://lore.kernel.org/linux-arm-kernel/1600396210-54196-1-git-send-email-jonathan.zhouwen@huawei.com/
> [2] 
> https://gitlab.arm.com/linux-arm/linux-skp/-/tree/coresight/etm/v8.4-self-hosted
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
>  drivers/hwtracing/coresight/coresight-trbe.c       | 768 
> +++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-trbe.h       | 525 ++++++++++++++
>  include/linux/coresight.h                          |   2 +
>  14 files changed, 1680 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/trbe.txt
>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
