Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCC262295
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 00:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgIHWW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 18:22:56 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59368 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgIHWWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:22:55 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 61D401C0B7F; Wed,  9 Sep 2020 00:22:53 +0200 (CEST)
Date:   Wed, 9 Sep 2020 00:22:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200908222252.GC1005@bug>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807095051.385985-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is RFC v2 of Peter's SCHED_DEADLINE server infrastructure
> implementation [1].
> 
> SCHED_DEADLINE servers can help fixing starvation issues of low priority tasks (e.g., 
> SCHED_OTHER) when higher priority tasks monopolize CPU cycles. Today we have RT 
> Throttling; DEADLINE servers should be able to replace and improve that.

It would be worth noting what "server" is in this context.

It is not white box with CPU inside, it is not even an userland process, afaict.

Subject is quite confusing.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
