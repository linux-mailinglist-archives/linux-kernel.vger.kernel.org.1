Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F552A3F5A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgKCIx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:53:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgKCIx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:53:58 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67FD2071A;
        Tue,  3 Nov 2020 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604393637;
        bh=jo0K/cLDuVuUpl2aYeEje63m8fCechvSnD6PO543SY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=haESpG/hM7HKu0+swb8Zv08uNT8Uj6XX2KWm0Pv/SpuNXYU7xXy5XJXUoPevFdwOr
         I6+G+CW960mWSMQ2LzqGLKod9hS6DqYz0a/R5OKiTYBvZujGEYHFch6nO5x63g35Ks
         5m0UjLgY4c49YItIaxo0gVIkJ2qEN/E6dnThpp+o=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZs4h-007483-FH; Tue, 03 Nov 2020 08:53:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 03 Nov 2020 08:53:55 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Using fixed LPI number for some Device ID
In-Reply-To: <8ff6a30a-b51f-f9f0-4a18-307948f3519b@huawei.com>
References: <0baed5b0-6cbe-6492-b4af-fe758f461602@huawei.com>
 <04e31996-6eb8-3bb9-e333-bc46eebe3d7a@huawei.com>
 <87eeleen3m.wl-maz@kernel.org>
 <8ff6a30a-b51f-f9f0-4a18-307948f3519b@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0882fef907e3b7bf9f23f941474c109f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gengdongjiu@huawei.com, jason@lakedaemon.net, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-03 05:22, Dongjiu Geng wrote:
> On 2020/10/31 17:55, Marc Zyngier wrote:
>> Dongjiu,
>> 
>> On Sat, 31 Oct 2020 02:19:19 +0000,
>> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>> 
>>> Hi Marc,
>>> Sorry to disturb you, Currently the LPI number is not fixed for the
>>> device. The LPI number is dynamically allocated start from 8092.
>>> For two OS which shares the ITS, One OS needs to configure the
>>> device interrupt required by another OS, and the other OS uses a
>>> fixed interrupt ID to respond the interrupt. Therefore, the LPI IRQ
>>> number of the device needed be fixed. I want to upstream this
>>> feature that allocate fixed LPI number for the device that is
>>> specified through the DTS. What is your meaning?  Thanks
>> 
>> I think you are starting from the wrong premises.
>> 
>> You can't "share" an ITS directly between two operating systems. The
>> ITS can only be controlled by a single operating system, because its
>> function goes way beyond allocating an LPI. How would you deal with
>> simple things such as masking an interrupt, which requires:
>> 
>> - Access to memory (configuration table)
>> - Access to the command queue (to insert an invalidation command)
>> - Access to MMIO registers (to kick the command queue into action)
>> 
>> all of which needs to be exclusive of concurrent modifications. How do
>> you propose this is implemented in a safe manner by two operating
>> systems which, by nature, distrust each other? Allocating LPIs is the
>> least of your problems, really.
> Yes， I agree with you it . But in my HW platform, using
> virtualization, the performance
> deteriorates greatly.  So I distributed the I/O devices to different
> operation systems. During the startup of one OS,
> interrupts are bound to different OS in one OS, which can be exclusive
> of concurrent modifications.
> 
> In fact it has some limitations as you said, such mask/enable/route
> Interrupts, If want to
> mask interrupts, need to mask interrupts on the source device.
> 
> If you think it is not a common feature, I will used it as a local
> customization function and not upstream.

I don't think this makes sense for Linux, at least not in a way
that limits the way the kernel deals with simple things such as
LPI allocation.

We have systems in the tree where Linux route interrupts on behalf
of other agents in the system (see what the TI PRUSS subsystem does,
for example), and even direct interrupt injection is, to an extent,
doing that. This requires a standardised way for describing the routing,
the allocation, and potentially the life cycle of the interrupt.

But hardcoding the allocation based on some non-standard scheme
is not something I'm considering.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
