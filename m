Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30952938E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405608AbgJTKIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbgJTKIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:08:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7244F22253;
        Tue, 20 Oct 2020 10:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603188513;
        bh=Pvc6PAgxMsRidFxK+BBUIS16vHaM9gVploXYIngka3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D6ppd8bndAPKng3zkj9Ww196fvyQt4yzrHa3LIw7jYYRYGHudL6tm421CVeh7+Zmt
         Wxutd6ebNuX1lDfMzkevtg/IUB4e10tQjDHC/VxrkdZrfchw86qeIcO8symkAAeFsU
         Jj6PHQpMNS7Ok9aK6OUAfqwktAvUT6lsXtadtAkw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kUoZC-002gji-Vr; Tue, 20 Oct 2020 11:08:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Oct 2020 11:08:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
In-Reply-To: <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
 <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
 <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <f3596e3ed70737d36f72056827d7d441@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-20 07:43, Sumit Garg wrote:
> On Mon, 19 Oct 2020 at 17:07, Marc Zyngier <maz@kernel.org> wrote:

[...]

>> > +{
>> > +     if (!ipi_desc)
>> > +             return;
>> > +
>> > +     if (is_nmi) {
>> > +             if (!prepare_percpu_nmi(ipi_id))
>> > +                     enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
>> > +     } else {
>> > +             enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
>> 
>> I'm not keen on this. Normal IRQs can't reliably work, so why do you
>> even bother with this?
> 
> Yeah I agree but we need to support existing functionality for kgdb
> roundup and sysrq backtrace using normal IRQs as well.

When has this become a requirement? I don't really see the point in
implementing something that is known not to work.

         M.
-- 
Jazz is not dead. It just smells funny...
