Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B882926D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgJSL42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgJSL42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:56:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD49221FC;
        Mon, 19 Oct 2020 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603108587;
        bh=QuduAn6k0rUFR+XlPjYg/pmTJf/ta7vn5SfuOao/njQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t3odKDxneKRZ/sEMPTz0TQL5M6chluNLskMhfyBO0ZuIYQ3YaEVqxox/KSXnBDm+e
         WJk11sjxsyrC2c1tXBgd4cpAtFX7sCdeRQD9nM2pCFNE82rXDqbOp8HBCfG2pbU6pd
         HS8X22ByDu8S+h4Q/EAEjXcDihwG5oaoUvKfcfyI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kUTm5-002POa-8O; Mon, 19 Oct 2020 12:56:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Oct 2020 12:56:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
In-Reply-To: <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b366c68fe0b365892aa4324be90235d6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 12:12, Sumit Garg wrote:
> Introduce framework to turn an IPI as NMI using pseudo NMIs. In case a
> particular platform doesn't support pseudo NMIs, then request IPI as a
> regular IRQ.
> 
> The main motivation for this feature is to have an IPI that can be
> leveraged to invoke NMI functions on other CPUs. And current 
> prospective
> users are NMI backtrace and KGDB CPUs round-up whose support is added
> via future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/nmi.h | 16 +++++++++
>  arch/arm64/kernel/Makefile   |  2 +-
>  arch/arm64/kernel/ipi_nmi.c  | 77 
> ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/nmi.h
>  create mode 100644 arch/arm64/kernel/ipi_nmi.c

[...]

> +	irq_set_status_flags(ipi, IRQ_HIDDEN);

Another thing is this. Why are you hiding this from /proc/interrupts?
The only reason the other IPIs are hidden is that displaying them as
"normal" interrupts would be a change in userspace ABI.

In your case, this is something new that can perfectly appear as
a standard interrupt (and I don't see how you'd display the
statistics otherwise).

         M.
-- 
Jazz is not dead. It just smells funny...
