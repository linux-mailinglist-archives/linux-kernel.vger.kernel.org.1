Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A062F2DEA4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgLRUh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:37:29 -0500
Received: from foss.arm.com ([217.140.110.172]:41576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgLRUh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:37:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C88FC1FB;
        Fri, 18 Dec 2020 12:36:43 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10A2C3F718;
        Fri, 18 Dec 2020 12:36:42 -0800 (PST)
References: <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net> <160831684292.22759.15563002516530918910.tip-bot2@tip-bot2>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
Subject: Re: [irqchip: irq/irqchip-next] irqchip/bcm2836: Fix IPI acknowledgement after conversion to handle_percpu_devid_irq
Message-ID: <jhjo8iqsvgk.mognet@arm.com>
In-reply-to: <160831684292.22759.15563002516530918910.tip-bot2@tip-bot2>
Date:   Fri, 18 Dec 2020 20:36:37 +0000
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/12/20 18:40, irqchip-bot for Marc Zyngier wrote:
> The following commit has been merged into the irq/irqchip-next branch of irqchip:
>
> Commit-ID:     d7f39c40ebb6986e7371510d1c20a4efee4a7f0d
> Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d7f39c40ebb6986e7371510d1c20a4efee4a7f0d
> Author:        Marc Zyngier <maz@kernel.org>
> AuthorDate:    Fri, 18 Dec 2020 18:03:46
> Committer:     Marc Zyngier <maz@kernel.org>
> CommitterDate: Fri, 18 Dec 2020 18:34:17
>
> irqchip/bcm2836: Fix IPI acknowledgement after conversion to handle_percpu_devid_irq
>
> It appears that despite its name, the bcm2836_arm_irqchip_ipi_eoi()
> callback is an acknowledgement, and not an EOI. This means that
> we lose IPIs that are made pending between the handling of the
> IPI and the write to LOCAL_MAILBOX0_CLR0. With the right timing,
> things fail nicely.
>
> This used to work with handle_percpu_devid_fasteoi_ipi(), which
> started by eoi-ing the interrupt. With the standard fasteoi flow,
> this doesn't work anymore.
>
> So let's use this callback for what it is, an ack. Your favourite
> RPi-2/3 is back up and running.
>

Thanks for cleaning up my mess!

> Fixes: ffdad793d579 ("irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()")
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net
