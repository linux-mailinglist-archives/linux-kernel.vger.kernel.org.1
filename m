Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6F253B48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 03:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgH0BGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 21:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgH0BGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:06:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC60C061797
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:06:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so3421076qtn.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4D8w+r1u4ZF8ObB9md7UqC9A1yIMi0yqZmxDxxB0NME=;
        b=M7l7N/H7iHcqw9SsIm9p8GfNXlNB5NmE3wGzBjKkccbuavNn1+mRvosSbKp4jxs9vN
         /Y1oyCMRjXdwGIen3RTTagpX3OAJvpdwh0mPwiaJTI526bDhZWN5kYUV5wGThWRL5u9+
         aNuEa7uUgSahKdBcL9wPxtXepw/xepTTDVVDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4D8w+r1u4ZF8ObB9md7UqC9A1yIMi0yqZmxDxxB0NME=;
        b=BhCxwBpLTORkZpnjhTfkUe9W1X4mfGneiYHl2rb37SNqtjALv7ZnzjmpCQnF4CqjUV
         v2NtiWWe3mh5gba/scBrgKz9kuaxGqIm7MIV28QmcfBqhmrAfJjAVEvXtwUeLsJbpz+B
         xdRr8t2wJqlGlhzRV/um20Gwqxksmj36DTjzrtPjQjGfAxBOyGYAnVl4NM6TRExqlOyL
         FXA8BFzFy69LsozMt6hdvUjVFJgleSznnCkmBWHK28mvOahfFAwi080Ea0MFx6ZO03ez
         NqeEJJ4KmDpnoOGRxV/hq/V2E3TzLovVk4O630CGUzF1qfL3tsOlg9Jk/vZ+S6ZQW4zd
         deFw==
X-Gm-Message-State: AOAM533rQsAYDPc0VenGgIMvLjbP4uKJJngn2grh4davVY/rmcDgRgvF
        KofrRP2BTo/LiTN5sPRZ7Juq0Q==
X-Google-Smtp-Source: ABdhPJyHYRQlELCTR089ytkzrTTiCYPig6rfi9psRMRInyOTvOx+3xidkpFcraMQaSk3FFuPIq9l0w==
X-Received: by 2002:ac8:71d6:: with SMTP id i22mr16261248qtp.371.1598490397396;
        Wed, 26 Aug 2020 18:06:37 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id w17sm645399qki.65.2020.08.26.18.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 18:06:36 -0700 (PDT)
Date:   Wed, 26 Aug 2020 21:06:36 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, svens@linux.ibm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 02/11] cpuidle: Fixup IRQ state
Message-ID: <20200827010636.GB1939707@google.com>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.251340558@infradead.org>
 <2397536.RUgnjfFTVL@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2397536.RUgnjfFTVL@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 07:36:43PM +0200, Rafael J. Wysocki wrote:
> On Friday, August 21, 2020 10:47:40 AM CEST Peter Zijlstra wrote:
> > Match the pattern elsewhere in this file.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Tested-by: Marco Elver <elver@google.com>
> 
> For all patches in the series:
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> > ---
> >  drivers/cpuidle/cpuidle.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -153,7 +153,8 @@ static void enter_s2idle_proper(struct c
> >  	 */
> >  	stop_critical_timings();
> >  	drv->states[index].enter_s2idle(dev, drv, index);
> > -	WARN_ON(!irqs_disabled());
> > +	if (WARN_ON_ONCE(!irqs_disabled()))
> > +		local_irq_disable();
> >  	/*
> >  	 * timekeeping_resume() that will be called by tick_unfreeze() for the
> >  	 * first CPU executing it calls functions containing RCU read-side
> > 
> > 
> > 
> 
> 
> 
> 
