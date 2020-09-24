Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423802771A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgIXMxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:53:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgIXMxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:53:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600951982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/Gm604q90U/ArtkiAYziXtF7CMgqid9yHvU4IBGz9M=;
        b=sYsHXxS376YD5gKomf38rfaUJvC34cXay/hUPfWvSjftkPqAwsxPrChqTH/9vNs0xGlTkD
        o9qKcAleKH78nTGEjnGXSM+PQ6nCdls7iPmubOFPrNJ2Z3zgqFh4TTkNsov1kS9geZK5CM
        sVNaoVR2cDcef0PF0m5/XTRgwLfe84A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D4F8AD76;
        Thu, 24 Sep 2020 12:53:02 +0000 (UTC)
Date:   Thu, 24 Sep 2020 14:53:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] printk: Add more information about the printk caller
Message-ID: <20200924125259.GC29288@alley>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
 <20200924042414.GA6039@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924042414.GA6039@lx-t490>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 06:24:14, Ahmed S. Darwish wrote:
> On Wed, Sep 23, 2020 at 03:56:17PM +0200, Petr Mladek wrote:
> ...
> >
> > -static inline u32 printk_caller_id(void)
> > +static enum printk_caller_ctx get_printk_caller_ctx(void)
> > +{
> > +	if (in_nmi())
> > +		return printk_ctx_nmi;
> > +
> > +	if (in_irq())
> > +		return printk_ctx_hardirq;
> > +
> > +	if (in_softirq())
> > +		return printk_ctx_softirq;
> > +
> > +	return printk_ctx_task;
> > +}
> > +
> 
> in_softirq() here will be true for both softirq contexts *and*
> BH-disabled regions. Did you mean in_serving_softirq() instead?

Good question!

I am not sure if people would want to distinguish these two
situations.

Otherwise, I think that is_softirq() more close to the meaning of
in_irq(). They both describe a context where a new interrupt has
to wait until the handling gets enabled again.

Best Regards,
Petr
