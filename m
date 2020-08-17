Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860B5246873
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgHQOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgHQOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:32:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FCFC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:32:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so15238551wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4xCxql3rFXOrYwsJnruwiMml2YFmKU3isYfeanIkWcA=;
        b=e2VC/nDUrcTrPiLe8Rsn9RLZlW4rcYA2Jl5mIjWssD4VC0ZsKSwazLp8W5LLAaUaQj
         phEwXCaxN15zdXIHVkVdQueXA7BSoUMC0zP4wxhkF81Dtcv5KDknoOUQjRfneCH/dG8i
         A0xmmSzTjChp0DTHg0RH9HZcD65eQFAjQE1SPdMLbebUyYnIzJbKT2cH4SwFYFHq9W9C
         QPdKnQp7eFbhQ0pEWFwCu033czTsTfQikLNWQ+0wf9674ynxvj/JUV+8zh1UaU4OLTO3
         w2ZoiM/l+X1VgEo0AWO+IdM8fY/IvnQpjF22RYs8pd/4Y5fUgXJaPyurEa7kKxZpGK5+
         R9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4xCxql3rFXOrYwsJnruwiMml2YFmKU3isYfeanIkWcA=;
        b=gPzL+kRdpPYH1JttqhN/1x0sViThmMF1BivrNd8d8cVTV37ph3kpQTPhf7MZBhybQx
         2v4q4t4PpgP7v0MD+WNtM75ad2vFJ301JiyGbAe7SFl99M0SG4VU9/mceK/d1bKzulMQ
         txBEIkg2b5f2h0Z1nNInB26MCfi+voZ083TBGfV4hEc1+wx5l5+Es+6GalD22W0lSK7n
         aIkaIjjSgu8pRu5cc9EMwt+WnlSUpAolCiGjDaLPKuIzGteB4fw4C6UvIJTKmqMbRJt4
         j83PQ9mx4KBKeN+rOG7ReP8zdvu4f/egIeGhCsidBQqVYsQlZMr7sGXkbAx6o2YsVtVC
         rf2g==
X-Gm-Message-State: AOAM53058JxVVrqx4QmQH7fsuMwG3nkAr9FqYW27E9s7iBAUjDkHOfoo
        h8VnJ+Aj/na4/P7Sp1ZBOzq3ZQ==
X-Google-Smtp-Source: ABdhPJwcWtkOmSHjWMaBZRj99E/tmhBdkQKcx9/iCQNmdDknYb0vfHpbcTwe6vVmWZ3/tTu3rSxwpQ==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr15343611wro.43.1597674745210;
        Mon, 17 Aug 2020 07:32:25 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d23sm30698956wmd.27.2020.08.17.07.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:32:24 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:32:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial
 drivers
Message-ID: <20200817143222.x524v6xqw5hvzvjs@holly.lan>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org>
 <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
 <20200814141322.lffebtamfjt2qrym@holly.lan>
 <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
 <CAD=FV=WiZi18zBwx9J0sKLdCqMCvxuQ=U0m21yNqhtaBfZEqzA@mail.gmail.com>
 <CAFA6WYOww8T7fmP-LtzS-EXG0iBbKEUOS5KrUU_7i+yqd_rFfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOww8T7fmP-LtzS-EXG0iBbKEUOS5KrUU_7i+yqd_rFfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 07:53:55PM +0530, Sumit Garg wrote:
> On Mon, 17 Aug 2020 at 19:27, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Aug 17, 2020 at 5:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Thanks for your suggestion, irq_work_schedule() looked even better
> > > without any overhead, see below:
> > >
> > > diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> > > index 3082378..1eade89 100644
> > > --- a/include/linux/irq_work.h
> > > +++ b/include/linux/irq_work.h
> > > @@ -3,6 +3,7 @@
> > >  #define _LINUX_IRQ_WORK_H
> > >
> > >  #include <linux/smp_types.h>
> > > +#include <linux/workqueue.h>
> > >
> > >  /*
> > >   * An entry can be in one of four states:
> > > @@ -24,6 +25,11 @@ struct irq_work {
> > >         void (*func)(struct irq_work *);
> > >  };
> > >
> > > +struct irq_work_schedule {
> > > +       struct irq_work work;
> > > +       struct work_struct *sched_work;
> > > +};
> > > +
> > >  static inline
> > >  void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
> > >  {
> > >  {
> > > @@ -39,6 +45,7 @@ void init_irq_work(struct irq_work *work, void
> > > (*func)(struct irq_work *))
> > >
> > >  bool irq_work_queue(struct irq_work *work);
> > >  bool irq_work_queue_on(struct irq_work *work, int cpu);
> > > +bool irq_work_schedule(struct work_struct *sched_work);
> > >
> > >  void irq_work_tick(void);
> > >  void irq_work_sync(struct irq_work *work);
> > > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > > index eca8396..3880316 100644
> > > --- a/kernel/irq_work.c
> > > +++ b/kernel/irq_work.c
> > > @@ -24,6 +24,8 @@
> > >  static DEFINE_PER_CPU(struct llist_head, raised_list);
> > >  static DEFINE_PER_CPU(struct llist_head, lazy_list);
> > >
> > > +static struct irq_work_schedule irq_work_sched;
> > > +
> > >  /*
> > >   * Claim the entry so that no one else will poke at it.
> > >   */
> > > @@ -79,6 +81,25 @@ bool irq_work_queue(struct irq_work *work)
> > >  }
> > >  EXPORT_SYMBOL_GPL(irq_work_queue);
> > >
> > > +static void irq_work_schedule_fn(struct irq_work *work)
> > > +{
> > > +       struct irq_work_schedule *irq_work_sched =
> > > +               container_of(work, struct irq_work_schedule, work);
> > > +
> > > +       if (irq_work_sched->sched_work)
> > > +               schedule_work(irq_work_sched->sched_work);
> > > +}
> > > +
> > > +/* Schedule work via irq work queue */
> > > +bool irq_work_schedule(struct work_struct *sched_work)
> > > +{
> > > +       init_irq_work(&irq_work_sched.work, irq_work_schedule_fn);
> > > +       irq_work_sched.sched_work = sched_work;
> > > +
> > > +       return irq_work_queue(&irq_work_sched.work);
> > > +}
> > > +EXPORT_SYMBOL_GPL(irq_work_schedule);
> >
> > Wait, howzat work?  There's a single global variable that you stash
> > the "sched_work" into with no locking?  What if two people schedule
> > work at the same time?
> 
> This API is intended to be invoked from NMI context only, so I think
> there will be a single user at a time.

How can you possibly know that?

This is library code, not a helper in a driver.


Daniel.


> And we can make that explicit
> as well:
> 
> +/* Schedule work via irq work queue */
> +bool irq_work_schedule(struct work_struct *sched_work)
> +{
> +       if (in_nmi()) {
> +               init_irq_work(&irq_work_sched.work, irq_work_schedule_fn);
> +               irq_work_sched.sched_work = sched_work;
> +
> +               return irq_work_queue(&irq_work_sched.work);
> +       }
> +
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(irq_work_schedule);
> 
> -Sumit
> 
> >
> > -Doug
