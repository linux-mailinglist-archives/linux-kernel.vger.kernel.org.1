Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B1F2AE0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKJUde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:33:34 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF52FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 12:33:33 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id t191so11671123qka.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 12:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGyjU1VFt03gTjbteYJEMdl1u0ziLYUtvD1NXemfJhs=;
        b=iD6NGpE1mnBrvgAsnOHd2EJKsUjVra3puLElxMvH9dayS1Y4J7BdSu8POnN/3tqDx3
         TgHnN0b9/e1BZjEEPF6k89aK9eODBtg9FhzicC8MxgUwuuYE6jpsRMLLdzG7uOltOsdL
         1PhqdXX9Hkj8XMvsBrOwwoxUBOqdW8hTx7df4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGyjU1VFt03gTjbteYJEMdl1u0ziLYUtvD1NXemfJhs=;
        b=ithJr4oyYsYe0f58sBkqZZCvSdhlmRMMNwzQ8/LeX0qT3NF+oyaBfCItaL5SjvS1AL
         1A77/x/0iqcNs8Z+V3sVrOQfj7gTzMchPoVjFg69isadiB+dowYjRLSbC5PYDXlRaXv+
         i1th/3IsBCD1NWmvA3mZCGP/1HUec2SupVS17aIF9Pi8xJaTmt8Va0CEabvd3aK+Zaff
         zoRXl2SmXw66NCEARejbMS7EWSGlSfc4QV91MNWV0Ns9cu8y8Nu3RBIL/dBBpmz/NyfW
         Iwc1nRrg6UpaD8XGo9cizdLTXPxNtIsGRhp3+5ihMrL9aGzYCW8tnvZDQY/T222+B1pw
         l13A==
X-Gm-Message-State: AOAM532y4DEXkrIa9n9mMrVSXdsFgiCgnCXdXncMpA3ZJHPheY+MezcM
        v6w5ITngsrQ3gmVC2h81VWDdbUzDyKB5Bg==
X-Google-Smtp-Source: ABdhPJxa69TxULwtqWM4g1jhzML48igFEJTuMp1hchP6B5ueOhZOEsls5SPVIjL0X2Uw3UmSQ1ZAfw==
X-Received: by 2002:a37:86c4:: with SMTP id i187mr21508004qkd.371.1605040409776;
        Tue, 10 Nov 2020 12:33:29 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b4sm5591796qti.64.2020.11.10.12.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:33:29 -0800 (PST)
Date:   Tue, 10 Nov 2020 15:33:28 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 2/4] docs: Update RCU's hotplug requirements
 with a bit about design
Message-ID: <20201110203328.GA694269@google.com>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-2-paulmck@kernel.org>
 <20201109122317.GM2594@hirez.programming.kicks-ass.net>
 <20201109162452.GK3249@paulmck-ThinkPad-P72>
 <20201109171433.GL2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109171433.GL2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 06:14:33PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2020 at 08:24:52AM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 09, 2020 at 01:23:17PM +0100, Peter Zijlstra wrote:
> > > On Thu, Nov 05, 2020 at 03:05:08PM -0800, paulmck@kernel.org wrote:
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > 
> > > > The rcu_barrier() section of the "Hotplug CPU" section discusses
> > > > deadlocks, however the description of deadlocks other than those involving
> > > > rcu_barrier() is rather incomplete.
> > > > 
> > > > This commit therefore continues the section by describing how RCU's
> > > > design handles CPU hotplug in a deadlock-free way.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  .../RCU/Design/Requirements/Requirements.rst       | 49 +++++++++++++++++-----
> > > >  1 file changed, 39 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > index 1ae79a1..98557fe 100644
> > > > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > @@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
> > > >  to allow the various kernel subsystems (including RCU) to respond
> > > >  appropriately to a given CPU-hotplug operation. Most RCU operations may
> > > >  be invoked from CPU-hotplug notifiers, including even synchronous
> > > > -grace-period operations such as ``synchronize_rcu()`` and
> > > > -``synchronize_rcu_expedited()``.
> > > 
> > > I was under the impression that this rst crap now recognises func() and
> > > you no longer need to make the text unreadable with "``".
> > 
> > It was there to start with, but good point.  How about the commit
> > below?
> 
> Much appreciated, thanks!

Thanks for making the change, I built it and it looks good in my web browser
;-).

BTW, these APIs are obsolete due to consolidation. Paul could you remove them
from the document?:
 synchronize_rcu_bh(), synchronize_rcu_bh_expedited(), call_rcu_bh(),
 rcu_barrier_bh().

thanks!

-Joel

