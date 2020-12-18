Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6E2DEA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgLRUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgLRUyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:54:36 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6260D23B6C;
        Fri, 18 Dec 2020 20:53:55 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kqMl7-002Ncg-Bq; Fri, 18 Dec 2020 20:53:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Dec 2020 20:53:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        tglx@linutronix.de
Subject: Re: [irqchip: irq/irqchip-next] irqchip/bcm2836: Fix IPI
 acknowledgement after conversion to handle_percpu_devid_irq
In-Reply-To: <jhjo8iqsvgk.mognet@arm.com>
References: <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net>
 <160831684292.22759.15563002516530918910.tip-bot2@tip-bot2>
 <jhjo8iqsvgk.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <aad56a6f5af539b1dc39d3e75ef83bc3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-kernel@vger.kernel.org, linux@roeck-us.net, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-18 20:36, Valentin Schneider wrote:
> On 18/12/20 18:40, irqchip-bot for Marc Zyngier wrote:
>> The following commit has been merged into the irq/irqchip-next branch 
>> of irqchip:
>> 
>> Commit-ID:     d7f39c40ebb6986e7371510d1c20a4efee4a7f0d
>> Gitweb:        
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d7f39c40ebb6986e7371510d1c20a4efee4a7f0d
>> Author:        Marc Zyngier <maz@kernel.org>
>> AuthorDate:    Fri, 18 Dec 2020 18:03:46
>> Committer:     Marc Zyngier <maz@kernel.org>
>> CommitterDate: Fri, 18 Dec 2020 18:34:17
>> 
>> irqchip/bcm2836: Fix IPI acknowledgement after conversion to 
>> handle_percpu_devid_irq
>> 
>> It appears that despite its name, the bcm2836_arm_irqchip_ipi_eoi()
>> callback is an acknowledgement, and not an EOI. This means that
>> we lose IPIs that are made pending between the handling of the
>> IPI and the write to LOCAL_MAILBOX0_CLR0. With the right timing,
>> things fail nicely.
>> 
>> This used to work with handle_percpu_devid_fasteoi_ipi(), which
>> started by eoi-ing the interrupt. With the standard fasteoi flow,
>> this doesn't work anymore.
>> 
>> So let's use this callback for what it is, an ack. Your favourite
>> RPi-2/3 is back up and running.
>> 
> 
> Thanks for cleaning up my mess!

Shared responsibilities... ;-)

         M.
-- 
Jazz is not dead. It just smells funny...
