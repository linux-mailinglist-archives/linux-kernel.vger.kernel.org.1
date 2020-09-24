Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F403F276EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIXKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:37:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:43480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgIXKh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:37:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600943847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OvK7t9Loa7SNSd60wI7vWX6CBAYZcCl23YU7tpkB1ho=;
        b=iMyHKi8RgrsVu9diQmSB2XaPM5ssIH2ncGBdfVB5wZdjpXpk6orNWQDHqrT1Kc1urbGPNN
        1TVnhgYnBtiDuCvjiUEVoHF475+C84DhtT6q8FUPoulteNRdzr2ZlrfytRQhyDy7FZLIMm
        ZmoaH2aPJNEVB6mFcoB2jKr94UkKgy0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87D57AC7D;
        Thu, 24 Sep 2020 10:38:05 +0000 (UTC)
Date:   Thu, 24 Sep 2020 12:37:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Store all three timestamps
Message-ID: <20200924103726.GM6442@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-2-pmladek@suse.com>
 <878sd0m4c3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sd0m4c3.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 02:06:12, John Ogness wrote:
> On 2020-09-23, Petr Mladek <pmladek@suse.com> wrote:
> > diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> > index 0adaa685d1ca..09082c8472d3 100644
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -14,7 +15,7 @@
> >   */
> >  struct printk_info {
> >  	u64	seq;		/* sequence number */
> > -	u64	ts_nsec;	/* timestamp in nanoseconds */
> > +	struct ktime_timestamps ts; /* timestamps */
> 
> Until now struct printk_info has contained generic types. If we add
> struct ktime_timestamps, we may start storing more than we need. For
> example, if more (possibly internal) fields are added to struct
> ktime_timestamps that printk doesn't care about. We may prefer to
> generically and explicitly store the information we care about:
> 
>     u64 ts_mono;
>     u64 ts_boot;
>     u64 ts_real;
> 
> Or create our own struct printk_ts to copy the fields of interest to.

I would like to have a structure if we have more timestamps.

Honestly, printk-specific structure sounds like an overhead to me.
How big is the chance that struct ktime_timestamps ts would get
modified? It has been created for printk after all.

That said, I could live with printk-specific structure.
We might even need it if we need to store also local_clock().

Best Regards,
Petr
