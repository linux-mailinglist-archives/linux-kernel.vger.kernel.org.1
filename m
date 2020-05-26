Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58C1DC421
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 02:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgEUAor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 20:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgEUAoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:44:46 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217AA2078C;
        Thu, 21 May 2020 00:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590021886;
        bh=we+EokfcDGrh26uNa5GypQrXE0g2ruaEwe2LL2XZnME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wVBxH+KlW/UEKbY0gWPUcUc2TTt5uheVwfZbdgWvdFRyUVtnnoywnQcZz/GuY4Bya
         Y+DKHxpySvXBe/xzhyAVlJXdnUFW6JqlyvpbI9Fy2w8ttdE6BJF8Nc58Xs0MV33STF
         CVn4DhRUXPSQOlYMTzg02SPYBhL20otgoXUxAuzQ=
Date:   Thu, 21 May 2020 02:44:44 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200521004443.GB15455@lenoir>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520184710.GO10078@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:47:10PM +0200, Juri Lelli wrote:
> On 20/05/20 19:02, Frederic Weisbecker wrote:
> > On Wed, May 20, 2020 at 06:49:25PM +0200, Juri Lelli wrote:
> > > On 20/05/20 18:24, Frederic Weisbecker wrote:
> > > 
> > > Hummm, so I enabled 'timer:*', anything else you think I should be
> > > looking at?
> > 
> > Are you sure you also enabled timer_expire_entry?
> > Because:
> 
> I run with
> 
> trace-cmd record -e sched_switch -e sched_wakeup -e sched_migrate_task \
> -e 'timer:*' -e 'irq_vectors:*' -e 'irq:softirq*' \
> -e 'irq:irq_handler*' taskset --cpu-list 4-35 ./sysjitter/sysjitter \
> --runtime 10 200
> 
> And
> 
> $ grep ' timer_expire_entry:' trace.txt | wc -l
> 1173
> 
> seems to confirm that the event was indeed enabled, e.g.
> 
> ksoftirqd/11-100   [011]   159.270023: timer_expire_entry:   timer=0xffff9807df8a5a60 function=delayed_work_timer_fn now=4294826418 baseclk=4294825984

That's interesting! I'll see if I can reproduce that with threaded irqs. If not we'll
have to investigate on your machine. We really don't want to trigger timer softirqs
when it's not necessary.
