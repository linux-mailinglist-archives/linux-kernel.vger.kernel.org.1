Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A1E234574
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbgGaMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 08:11:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733082AbgGaMLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:11:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F02601FB;
        Fri, 31 Jul 2020 05:11:14 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131753F71F;
        Fri, 31 Jul 2020 05:11:13 -0700 (PDT)
References: <20200730170321.31228-1-valentin.schneider@arm.com> <20200730170321.31228-3-valentin.schneider@arm.com> <ba26464de5e82eace97924121d7bcd1d@kernel.org> <jhjmu3gim0g.mognet@arm.com> <10da73b8a8937b08b0993513d6c20e98@kernel.org> <8dfeb7782d7ffaa1f107a8e4aca10840@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH v2 2/2] irqchip/gic-v2, v3: Prevent SW resends entirely
In-reply-to: <8dfeb7782d7ffaa1f107a8e4aca10840@kernel.org>
Date:   Fri, 31 Jul 2020 13:11:08 +0100
Message-ID: <jhjk0yjj34z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/07/20 12:27, Marc Zyngier wrote:
>> Look for anything that performs an interrupt allocation by calling
>> into the parent with a 3 cell (DT case) fwspec. There is a bunch
>> of them.
>
> For what it is worth, I have just pushed out a branch[1] containing some
> of this rework as well as your patches.
>

Brilliant, thanks for taking a shot at this! I'll try to look for stragglers.

> The only tricky part is the GICv4.1 doorbell retriggering, which just
> can't be re-injected. It shouldn't matter though. Same for vSGIs, they
> never fire on the host.
>
> Thanks,
>
>          M.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gic-retrigger
