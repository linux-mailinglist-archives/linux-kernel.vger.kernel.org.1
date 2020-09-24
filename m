Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E8276C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgIXIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:54:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbgIXIyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:54:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600937685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gnupa/FLLl5BSc73ruXnxSmNk2cnUZqVStpXpBHlSG8=;
        b=NPezC9QdftkpIrnAMch7/Gy7kMVeJhInMg8bpApfN7KFE0oNMe+k0ReKvOTPO/sW8KPEO8
        9pGc7ShExvqmDy6iNhP84GbFjbYzMrnXkBZs7Zjnv7CCTp/X2ly20sNPAtXuAcEZ/KgGB7
        w+sBMUijR6BI4MqCAydIP5CK1Ng6nzY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA9B0ABF4;
        Thu, 24 Sep 2020 08:55:23 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:54:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200924085445.GK6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200924061746.GF577@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924061746.GF577@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 15:17:46, Sergey Senozhatsky wrote:
> On (20/09/22 17:44), John Ogness wrote:
> > +/*
> > + * The sprint buffers are used with interrupts disabled, so each CPU
> > + * only requires 2 buffers: for non-NMI and NMI contexts. Recursive
> > + * printk() calls are handled by the safe buffers.
> > + */
> > +#define SPRINT_CTX_DEPTH 2
> > +
> > +/* Static sprint buffers for early boot (only 1 CPU). */
> > +static DECLARE_BITMAP(sprint_static_textbuf_map, SPRINT_CTX_DEPTH);
> > +static char sprint_static_textbuf[SPRINT_CTX_DEPTH * LOG_LINE_MAX];
> > +
> > +/* Dynamically allocated sprint buffers. */
> > +static unsigned int sprint_dynamic_textbuf_count;
> > +static unsigned long *sprint_dynamic_textbuf_map;
> > +static char *sprint_dynamic_textbuf;
> 
> Just a question:
> 
> Can dynamic_textbuf be a PER_CPU array of five textbuf[1024] buffers
> (for normal printk, nmi, hard irq, soft irq and one extra buffer for
> recursive printk calls)?

That would be my preferred fallback when the approach with
vsprintf(NULL, ) is not acceptable for some reasons.

But I still think that calling vsprintf(NULL, ) is the most trivial
and good enough solution.

IMHO, the solution with per-CPU buffers is not that trivial, for
example:

  What if recursive printk() is interrupted by NMI and it causes
  yet another recursion?

  Is one level of recursion enough?

Best Regards,
Petr
