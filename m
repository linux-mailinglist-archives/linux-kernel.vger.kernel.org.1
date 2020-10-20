Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E299288713
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbgJIKhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:37:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:34910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgJIKhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:37:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602239851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PSnE8Z6vmo+QjfFMOr8IzsEeysZ+b2m8XiyzgtxyjuU=;
        b=TBEkdamhFsMR6aQi1th0/8dXZLXYyqk5xISPS7talJ6YDCQgCm/iVWjysiiw7bONwuX4IT
        gpaSi8QFNmbXeDNV5vq+E+NauqSVoU//Kjf9/qOHetw3vQr0tF0HyDgv9hNj8Fs9TDYrt9
        B5EJ74pYx1zFCHSIQVIQnRK9ZCJToVc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C276AC2F;
        Fri,  9 Oct 2020 10:37:31 +0000 (UTC)
Date:   Fri, 9 Oct 2020 12:37:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009103730.GJ4967@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009091218.GF4967@dhcp22.suse.cz>
 <20201009094245.GG2628@hirez.programming.kicks-ass.net>
 <20201009101044.GH4967@dhcp22.suse.cz>
 <20201009101431.GJ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009101431.GJ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-10-20 12:14:31, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:10:44PM +0200, Michal Hocko wrote:
> > On Fri 09-10-20 11:42:45, Peter Zijlstra wrote:
> > > On Fri, Oct 09, 2020 at 11:12:18AM +0200, Michal Hocko wrote:
> > > > Is there any additional feedback? Should I split up the patch and repost
> > > > for inclusion?
> > > 
> > > Maybe remove PREEMPT_NONE after that?  Since that's then equivalent to
> > > building with VOLUNTARY and booting with preempt=none.
> > 
> > So do you mean that I should post an additional patch which does this on
> > top? With a justification that there is one option less to chose from?
> 
> Exactly!

It seems we have to get rid of CONFIG_NO_PREEMPT first
$ git grep ARCH_NO_PREEMPT
arch/Kconfig:config ARCH_NO_PREEMPT
arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
arch/um/Kconfig:        select ARCH_NO_PREEMPT
kernel/Kconfig.preempt: depends on !ARCH_NO_PREEMPT
kernel/Kconfig.preempt: depends on !ARCH_NO_PREEMPT
lib/Kconfig.debug:      select PREEMPT_COUNT if !ARCH_NO_PREEMPT
lib/Kconfig.debug:      depends on !ARCH_NO_PREEMPT

Is there anybody working on that. Is this even possible? I can see it
has been added by 87a4c375995e ("kconfig: include kernel/Kconfig.preempt
from init/Kconfig") but this looks more like a mechanical change and it
has defined ARCH_NO_PREEMPT all arches which haven't included
Kconfig.preempt. But is there any reason why those cannot support
preemption for some reason? Cc respective maintainer (the email thread
starts http://lkml.kernel.org/r/20201007120401.11200-1-mhocko@kernel.org
-- 
Michal Hocko
SUSE Labs
