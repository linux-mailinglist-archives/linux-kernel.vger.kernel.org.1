Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02D2FCE36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbhATKTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbhATKFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:05:10 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F792332A;
        Wed, 20 Jan 2021 10:04:29 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2ALi-008uyI-S0; Wed, 20 Jan 2021 10:04:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jan 2021 10:04:25 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of: property: Add device link support for interrupts
In-Reply-To: <CAMuHMdUpZELgL4qUCs1VH0UUeckpTwqYLrMy2ETPzrpuUwkLnQ@mail.gmail.com>
References: <20201218210750.3455872-1-saravanak@google.com>
 <CAMuHMdUpZELgL4qUCs1VH0UUeckpTwqYLrMy2ETPzrpuUwkLnQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <4360c54bccf9c5a34052d1ad2b7eb049@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: geert@linux-m68k.org, saravanak@google.com, gregkh@linuxfoundation.org, robh+dt@kernel.org, frowand.list@gmail.com, khilman@baylibre.com, kernel-team@android.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 09:53, Geert Uytterhoeven wrote:
> Hi Saravana,
> 
> On Fri, Dec 18, 2020 at 10:11 PM Saravana Kannan <saravanak@google.com> 
> wrote:
>> Add support for creating device links out of interrupts property.
>> 
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> 
> Thanks for your patch!
> 
> This does not seem to add all links.  I see links being created to the
> secondary interrupt controller (e61c0000 "renesas,irqc"), but not to
> the primary interrupt controller (GIC)
> 
> Which is good, as the GIC driver is not a platform_driver, and thus
> creating links would break everything ;-)
> 
> BTW, I'd _love_ the GIC driver to be a platform_driver, as the GIC is
> part of a power/and or clock domain on Renesas SoCs...

The trouble is that we need the GIC much earlier than the device model
is available, because the timer needs to be available super early.
This isn't specific to the GIC, by the way, but also to all root
interrupt controllers that end-up controlling the per-CPU interrupts.

If you try to relax this constraint, you'll end up observing some of the
very weird dependencies between sysfs, sched, and the device model (I 
went
there a few years back, wasted a week on it, did a reset --hard on the 
branch,
and swore never to look at this again! ;-)

But for a start, I'd like the ITS code to be turned into a platform 
driver,
as this would potentially allow for the various domains to be 
instantiated
dynamically. One day.

         M.
-- 
Jazz is not dead. It just smells funny...
