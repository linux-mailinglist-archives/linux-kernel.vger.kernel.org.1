Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5134328F621
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbgJOPuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389841AbgJOPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:50:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 669F322277;
        Thu, 15 Oct 2020 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602777003;
        bh=XRMI92JnUmhkO7lwEb3LE0rFuRzG8lAhuG70iJ3oFCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rufs8Yrs4NpHKxTZRew6A1B4Klf2QtJCjgNIcOOltDU8L5AjkRgK7IxybbenHwFWH
         8irlHZgbjbo5Q/QEpCmqnUYVenC1J7SGbaSQknuvjlfirRehb6Vsxf4oABpGjsW2GC
         06KR7kKrgYlo9WBpjvt5oAjwuueQm/q1sXScm8K4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kT5Vx-001QZ3-DG; Thu, 15 Oct 2020 16:50:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 15 Oct 2020 16:50:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.10-rc0: build error in ipi.c
In-Reply-To: <87imbba7qk.fsf@nanos.tec.linutronix.de>
References: <20201015101222.GA32747@amd>
 <87imbba7qk.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <3e6b7c98fd8221a7878aaaa6c1bf86f4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, pavel@ucw.cz, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-15 15:23, Thomas Gleixner wrote:
> On Thu, Oct 15 2020 at 12:12, Pavel Machek wrote:
> 
> Cc+ Marc

Thanks Thomas.

> 
>> I'm getting build problems in 5.10-rc0 in config for n900. ARM board.
>> 
>> CONFIG_SMP=y
>> CONFIG_SMP_ON_UP=y

On its own, this doesn't break anything with multi_v7_defconfig.

>> 
>> 
>>   CC      net/devres.o
>>   kernel/irq/ipi.c: In function ‘irq_reserve_ipi’:
>>   kernel/irq/ipi.c:84:9: error: implicit declaration of function
>>   ‘__irq_domain_alloc_irqs’; did you mean ‘irq_domain_alloc_irqs’?
>>   [-Werror=implicit-function-declaration]
>>     virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs,
>>   NUMA_NO_NODE,
>>            ^~~~~~~~~~~~~~~~~~~~~~~
>> 	            irq_domain_alloc_irqs
>> 		    cc1: some warnings being treated as errors
>> 		    make[2]: *** [scripts/Makefile.build:283:
>>   kernel/irq/ipi.o] Error 1
> 
> That probably comes from the ipi as irq rework for arm/arm64.

Most probably.

Pawel, can you please stash your config somewhere where I can get it?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
