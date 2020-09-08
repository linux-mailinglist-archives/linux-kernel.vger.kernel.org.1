Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C3261CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbgIHTZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbgIHQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369DDC061386
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b0t5z+qQG1ZBS7H6b7JrMNbuOF10sV7lq6zuv68QoOk=; b=WE7GI1FmhLy4VJa7HinxaNTyg5
        W2oX8Pvudh0bQzETvhChmPYJAaJ6CSFSPOYS0EUPPayPY76pi2t4mAOohC+I0Mw5D4fsO6TiVz3c+
        P24ohSbPjOeVDXAfQi4gRX5KBkFDF9210T+DXrMxQ8IaVBP5FFXOUdagoySMcG7MPpZ6I0rK/Dylm
        qCqDis0r68MLYTMkfIG1je1XRoXC7/FjW6XPOI1m3Y4R2z9puhNJuxXya0+oZ9AgRN0nzCKd6cU5G
        dCdd1VE7III74de9bgKLHHeBP63kc15CZteugiBgHOWznNHY9/e6zKFMeRYHSw/iTZcFBcH6BcJe5
        ZtDIQxOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFg14-0006h8-Ku; Tue, 08 Sep 2020 15:58:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E3CA3010D2;
        Tue,  8 Sep 2020 17:58:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 283302C099E17; Tue,  8 Sep 2020 17:58:40 +0200 (CEST)
Date:   Tue, 8 Sep 2020 17:58:40 +0200
From:   peterz@infradead.org
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, mark.rutland@arm.com, luto@amacapital.net
Subject: Re: [PATCH V2 3/3] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
Message-ID: <20200908155840.GC35926@hirez.programming.kicks-ass.net>
References: <20200821195754.20159-1-kan.liang@linux.intel.com>
 <20200821195754.20159-3-kan.liang@linux.intel.com>
 <20200907160115.GS2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907160115.GS2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:01:15PM +0200, peterz@infradead.org wrote:
> On Fri, Aug 21, 2020 at 12:57:54PM -0700, kan.liang@linux.intel.com wrote:
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 0f3d01562ded..fa08d810dcd2 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1440,7 +1440,10 @@ static void x86_pmu_start(struct perf_event *event, int flags)
> >  
> >  	cpuc->events[idx] = event;
> >  	__set_bit(idx, cpuc->active_mask);
> > -	__set_bit(idx, cpuc->running);
> > +	/* The cpuc->running is only used by the P4 PMU */
> > +	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON) &&
> > +	    (boot_cpu_data.x86 == 0xf))
> > +		__set_bit(idx, cpuc->running);
> >  	x86_pmu.enable(event);
> >  	perf_event_update_userpage(event);
> >  }
> 
> Yuck! Use a static_branch() or something. This is a gnarly nest of code
> that runs 99.9% of the time to conclude a negative. IOW a complete waste
> of cycles for everybody not running a P4 space heater.

Better still, move it into p4_pmu_enable_event().
