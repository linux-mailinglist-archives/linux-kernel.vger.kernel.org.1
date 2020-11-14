Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910922B2CE9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 12:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKNLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 06:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgKNLh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 06:37:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267182080C;
        Sat, 14 Nov 2020 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605353879;
        bh=JcfYN9zF+kn20Wmgy4Zi2npMzAm1uj/P38XeSJP0dr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PwoZl7bKT4v+jV4/1DVc8gf4Gl14y6V971HfahBR1FLq6RCzGYlS2Ml5bW77FuQZt
         T+NeE56d0tAkDbhL0mlE8CIhfbY85aqYY0u06AgFpclVuli5EL8hvp/Hg8I73N23/y
         CdsEJPdQBWWNSiKrFyAzEsganhYVOJNRvxj0OAEU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kdtsT-00AZOs-4n; Sat, 14 Nov 2020 11:37:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 14 Nov 2020 11:37:57 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=C3=A1ne?= =?UTF-8?Q?k?= <msuchanek@suse.de>
Subject: Re: [PATCH kernel v3] genirq/irqdomain: Add reference counting to
 IRQs
In-Reply-To: <98d06682-da53-c851-74a7-952bf958b793@ozlabs.ru>
References: <20201109094646.71565-1-aik@ozlabs.ru>
 <fac73255eabb43242528821888acf2cc@kernel.org>
 <98d06682-da53-c851-74a7-952bf958b793@ozlabs.ru>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <258becba10679166555137c7f2727265@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: aik@ozlabs.ru, linux-kernel@vger.kernel.org, tglx@linutronix.de, clg@kaod.org, mpe@ellerman.id.au, cai@lca.pw, robh@kernel.org, fbarrat@linux.ibm.com, msuchanek@suse.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-14 03:37, Alexey Kardashevskiy wrote:

>>> What is the easiest way to get irq-hierarchical hardware?
>>> I have a bunch of powerpc boxes (no good) but also a raspberry pi,
>>> a bunch of 32/64bit orange pi's, an "armada" arm box,
>>> thinkpads - is any of this good for the task?
>> 
>> If your HW doesn't require an interrupt hierarchy, run VMs!
>> Booting an arm64 guest with virtual PCI devices will result in
>> hierarchies being created (PCI-MSI -> GIC MSI widget -> GIC).
> 
> Absolutely :) But the beauty of ARM is that one can buy an actual ARM
> device for 20$, I have "opi one+ allwinner h6 64bit cortex a53 1GB
> RAM", is it worth using KVM on this device, or is it too small for
> that?

I've run VMs on smaller machines. 256MB of guest RAM is enough to boot
a full blown Debian system with PCI devices, and your AW box should be
up to the task as long as you run a mainline kernel on it. Please don't
add to the pile of junk!

>> You can use KVM, or even bare QEMU on x86 if you are so inclined.
> 
> Have a QEMU command line handy for x86/tcg?

/me digs, as my x86 boxes are overspec'd X terminals these days:

Here you go, courtesy of Will:
http://cdn.kernel.org/pub/linux/kernel/people/will/docs/qemu/qemu-arm64-howto.html

         M.
-- 
Jazz is not dead. It just smells funny...
