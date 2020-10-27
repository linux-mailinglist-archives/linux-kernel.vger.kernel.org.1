Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD429AB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750643AbgJ0MGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750636AbgJ0MGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:06:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87B722264;
        Tue, 27 Oct 2020 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603800368;
        bh=h2JSf7zkOuIxpb10PQ5i/18/ehXzNDpVaiT54yUduwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wVU81IBgZfupXY+Ww7y1M1QdtUt6r1EVBjgUBfu7Cc7L1vm4zF90OF2wed95UwvR3
         alBV+89qS4Rfd+PDw4lQA8sH7SmXhQhBRz8o53Zo9D3Mo9f13rsCV07dR8LD3FYMp9
         lzd0NED30lx/8XtRJDVNMYzrMG8VBVErLYldZvgE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kXNjp-004g8O-Ky; Tue, 27 Oct 2020 12:06:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Oct 2020 12:06:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 03/16] arm64: Allow IPIs to be handled as normal
 interrupts
In-Reply-To: <CAKfTPtAfaTFXT5seyia=qwpX0BB7e6VpGo5iSYbF0JZwmC1nWg@mail.gmail.com>
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-4-maz@kernel.org>
 <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com>
 <353f13b0dcc6c7ea1b44012d9632a0cc@kernel.org>
 <CAKfTPtBjw5ay_BcPmEXpHOHbNxNZuYmdCoHQM53u3c+RXnKONg@mail.gmail.com>
 <CAKfTPtBURraZh8E8p3PmncoDRVV5N42yTyJcpPf0OROciM2+xg@mail.gmail.com>
 <7b754dfe579044902d3468b9f864bd37@kernel.org>
 <CAKfTPtBQd8LcXAq_TkUx6uY3NGu72RAAftawtHxEqB=18C3D8A@mail.gmail.com>
 <CAKfTPtAfaTFXT5seyia=qwpX0BB7e6VpGo5iSYbF0JZwmC1nWg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <11951c39bc676b83def46150e58e8df3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 11:21, Vincent Guittot wrote:
> On Tue, 27 Oct 2020 at 11:50, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>> 
>> On Tue, 27 Oct 2020 at 11:37, Marc Zyngier <maz@kernel.org> wrote:
>> >
>> > On 2020-10-27 10:12, Vincent Guittot wrote:
>> > > HI Marc,
>> > >
>> > > On Mon, 19 Oct 2020 at 17:43, Vincent Guittot
>> > > <vincent.guittot@linaro.org> wrote:
>> > >>
>> > >> On Mon, 19 Oct 2020 at 15:04, Marc Zyngier <maz@kernel.org> wrote:
>> > >> >
>> > >
>> > > ...
>> > >
>> > >> > >>
>> > >> > >> One of the major difference is that we end up, in some cases
>> > >> > >> (such as when performing IRQ time accounting on the scheduler
>> > >> > >> IPI), end up with nested irq_enter()/irq_exit() pairs.
>> > >> > >> Other than the (relatively small) overhead, there should be
>> > >> > >> no consequences to it (these pairs are designed to nest
>> > >> > >> correctly, and the accounting shouldn't be off).
>> > >> > >
>> > >> > > While rebasing on mainline, I have faced a performance regression for
>> > >> > > the benchmark:
>> > >> > > perf bench sched pipe
>> > >> > > on my arm64 dual quad core (hikey) and my 2 nodes x 112 CPUS (thx2)
>> > >> > >
>> > >> > > The regression comes from:
>> > >> > > commit: d3afc7f12987 ("arm64: Allow IPIs to be handled as normal
>> > >> > > interrupts")
>> > >> >
>> > >> > That's interesting, as this patch doesn't really change anything (most
>> > >> > of the potential overhead comes in later). The only potential overhead
>> > >> > I can see is that the scheduler_ipi() call is now wrapped around
>> > >> > irq_enter()/irq_exit().
>> > >> >
>> > >> > >
>> > >> > >           v5.9              + this patch
>> > >> > > hikey :   48818(+/- 0.31)   37503(+/- 0.15%)  -23.2%
>> > >> > > thx2  :  132410(+/- 1.72)  122646(+/- 1.92%)   -7.4%
>> > >> > >
>> > >> > > By + this patch,  I mean merging branch from this patch. Whereas
>> > >> > > merging the previous:
>> > >> > > commit: 83cfac95c018 ("genirq: Allow interrupts to be excluded from
>> > >> > > /proc/interrupts")
>> > >> > >  It doesn't show any regression
>> > >> >
>> > >> > Since you are running perf, can you spot where the overhead occurs?
>> > >
>> > > Any idea about the root cause of the regression ?
>> > > I have faced it on more arm64 platforms in the meantime
>> >
>> > two possible causes:
>> >
>> > (1) irq_enter/exit on the rescheduling IPI means we reschedule much more
>> > often
>> > (2) irq_domain lookups add some overhead.
>> >
>> > For (1), I have this series[1] which is ugly as sin and needs much more
>> > testing.
>> 
>> Ok, I'm going to test this series to see if it fixes the perf 
>> regression
> 
> You have spotted the root cause of the regression. We are back to ~1%
> performance diff on the hikey

Yeah. Only thing is that I can't look at this hack without vomiting...

         M.
-- 
Jazz is not dead. It just smells funny...
