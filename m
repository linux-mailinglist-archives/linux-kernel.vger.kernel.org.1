Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642A128B3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbgJLLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:31:14 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:23655 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387743AbgJLLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:31:14 -0400
X-IronPort-AV: E=Sophos;i="5.77,366,1596492000"; 
   d="scan'208";a="472127745"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:31:12 +0200
Date:   Mon, 12 Oct 2020 13:31:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: SD_LOAD_BALANCE
In-Reply-To: <20201012112124.GT2628@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2010121330390.2901@hadrien>
References: <alpine.DEB.2.22.394.2009031605190.2496@hadrien> <jhj7dtaokxe.mognet@arm.com> <alpine.DEB.2.22.394.2010101740290.2691@hadrien> <20201012112124.GT2628@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Oct 2020, Peter Zijlstra wrote:

> On Sat, Oct 10, 2020 at 06:14:23PM +0200, Julia Lawall wrote:
> > Prior to v5.8 on my machine this was a rare event, because there were not
> > many of these background processes.  But in v5.8, the default governor for
> > Intel machines without the HWP feature was changed from intel_pstate to
> > intel_cpufreq.  The use of intel_cpufreq triggers very frequent kworkers on
> > all cores, which makes it much more likely that cores that are currently
> > idle, and are overall not at all overloaded, will have a higher load
> > average even with the waking thread deducted, than the core managing the
> > wakeup of the threads.
>
> Rafael, any idea what those kworkers are for, and can we get rid of
> them?

They execute the function intel_cpufreq_target defined in
drivers/cpufreq/intel_pstate.c

julia
