Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3C2EF51C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbhAHPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbhAHPtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:49:07 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267452368A;
        Fri,  8 Jan 2021 15:48:27 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kxu01-0066wY-2F; Fri, 08 Jan 2021 15:48:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Jan 2021 15:48:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] Driver core: platform: Add extra error check in
 devm_platform_get_irqs_affinity()
In-Reply-To: <e10af177-583b-636a-be14-6f781baaa61a@huawei.com>
References: <1608561055-231244-1-git-send-email-john.garry@huawei.com>
 <X/h9vy/1h0E1hyN0@kroah.com>
 <e10af177-583b-636a-be14-6f781baaa61a@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <68e22d9cd4cc631201f06300205bafb6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, gregkh@linuxfoundation.org, rafael@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-08 15:43, John Garry wrote:
> On 08/01/2021 15:43, Greg KH wrote:
>> On Mon, Dec 21, 2020 at 10:30:55PM +0800, John Garry wrote:
>>> The current check of nvec < minvec for nvec returned from
>>> platform_irq_count() will not detect a negative error code in nvec.
>>> 
>>> This is because minvec is unsigned, and, as such, nvec is promoted to
>>> unsigned in that check, which will make it a huge number (if it 
>>> contained
>>> -EPROBE_DEFER).
>>> 
>>> In practice, an error should not occur in nvec for the only in-tree
>>> user, but add a check anyway.
>>> 
>>> Fixes: e15f2fa959f2 ("driver core: platform: Add 
>>> devm_platform_get_irqs_affinity()")
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>> I hope that this can go through either irqchip or driver/core trees, 
>>> thanks!
>> 
>> I'll take it, thanks.
>> 
> 
> Hi Greg,
> 
> I think that Marc already has taken it:
> 
> https://lore.kernel.org/lkml/X%2Fh9vy%2F1h0E1hyN0@kroah.com/T/#m95ef1736dbbd801cd85a4144c8f13c2afe33bc2c
> 
> I hope it doesn't cause hassle.

I was about to send tglx a pull request.

Greg, let me know if you want me to drop it.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
