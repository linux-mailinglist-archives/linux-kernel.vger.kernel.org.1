Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6A1A9BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 13:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896824AbgDOLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 07:14:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896797AbgDOLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:12:45 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOfy8-0007Ia-4g; Wed, 15 Apr 2020 13:12:36 +0200
Date:   Wed, 15 Apr 2020 13:12:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.2-rt1
Message-ID: <20200415111235.6gomftgifn62dylp@linutronix.de>
References: <20200403170443.pzm24672qo4hufcm@linutronix.de>
 <20200408070013.GB14300@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408070013.GB14300@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-08 09:00:13 [+0200], Juri Lelli wrote:
> Hi,
Hi,

> On 03/04/20 19:04, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> > 
> > I'm pleased to announce the v5.6.2-rt1 patch set. 
> > 
> > Changes since v5.4.28-rt19:
> > 
> >   - Rebase to v5.6.2
> 
> I was reviewing the new set and I couldn't find v5.4.28-rt19
> 6dbbc833c99f ("mm: perform lru_add_drain_all() remotely"). Don't think
> it has been squashed either.
> 
> Am I wrong? If not, why was that left out?

I was going to drop it from v5.4 but kept it last minute. I announced in
	https://lkml.kernel.org/r/20200309171350.kjb3pdjazhxm2li2@linutronix.de

that the problem it fixes is not limited to RT so we need a solution for
both config switches. The current plan for local-locks is not to work
cross CPU because it breaks the local_irq_save() / preempt_disable()
replacement which is something this patch relies on.
The worker triggered via vmstat_update() is also blocked if the user
task runs at an elevated priority for longer time.

> Thanks!
> 
> Juri

Sebastian
