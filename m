Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DCE26A8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgIOPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbgIOOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:52:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B313206DC;
        Tue, 15 Sep 2020 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600181537;
        bh=N9yGY1aXOgj8bD3rTeab7VM/6L6jqcYODfBu/4dZQGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jbgi3oTgKCpRS/gcC9HQAD47dKQc/oM65Tos9j05uzQrWfx4loznW5bLcAkc7yYSH
         oZ39xph87f6693yZghtnM8+YJL7WWunTt6QrvJhm8Z4MzKNY6TYqcWqEpy7/8nPz/I
         tYnVVlP2EOReRmi0uWS5VUyUGVnJfqJ/ydj0TPx0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kICJb-00C2UB-8i; Tue, 15 Sep 2020 15:52:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 15:52:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, kernel-team@android.com
Subject: Re: [PATCH 1/2] irqchip/gic: Handle non-standard SGI deactivation on
 Samsung's Franken-GIC
In-Reply-To: <d1301d9c-5529-0089-f163-2a728055712c@samsung.com>
References: <20200915133944.1285456-1-maz@kernel.org>
 <CGME20200915134023eucas1p2d2af4f3690329eb8de61f18700134122@eucas1p2.samsung.com>
 <20200915133944.1285456-2-maz@kernel.org>
 <d1301d9c-5529-0089-f163-2a728055712c@samsung.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <0a9212ef8a350bb78a145dab704a580e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-15 15:06, Marek Szyprowski wrote:
> On 15.09.2020 15:39, Marc Zyngier wrote:
>> The GIC available on some of Samsung's A9-based platform is
>> thankfully one of a kind. On top of not presenting a banked
>> programing model (each CPU has its own base addresses for both
>> distributor and CPU interface), it also encodes the source CPU
>> for SGIs in the INTID read from IAR, and requires this exact
>> value to be written back to EOI.
>> 
>> Without this, interrupts are never deactivated, and the kernel
>> grinds to a halt.
>> 
>> Work around it by stashing the INTID for in-flight SGIs, and
>> using that value on EOI. This only works because we don't nest
>> SGIs.
>> 
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Fixes: ac063232d4b0 ("irqchip/gic: Configure SGIs as standard 
>> interrupts")
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Works fine, thanks!
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for having reported the failure, and your patience with testing
all kind of random things! ;-)

         M.
-- 
Jazz is not dead. It just smells funny...
