Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCA27E7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgI3LxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:53:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbgI3LxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:53:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601466788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVH10QBD4QWRUGMBlREqgeRjVHRrmm+FuSJ/Eew8yco=;
        b=VowLJc1ITAfAlVhj2ZDwVam39q5V44kLMbF8ZxcIv9Wacz9Euky9v8jXiZbv5NFmBgT9Bj
        fm/k50gxoJ9oesUhf9oLSnAyks8N6X99uWIqL9d4Kv1zgQn2EmNj70yki0vLMs889zwj0n
        1+ga3KEVHYQN3ihKFl5qZnfFr6SUwaY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B29DAAD39;
        Wed, 30 Sep 2020 11:53:08 +0000 (UTC)
Date:   Wed, 30 Sep 2020 13:53:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
Message-ID: <20200930115307.GD29288@alley>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
 <20200930090134.8723-2-john.ogness@linutronix.de>
 <20200930094316.GB987@jagdpanzerIV.localdomain>
 <87imbv1s0d.fsf@jogness.linutronix.de>
 <20200930112836.GC29288@alley>
 <87ft6z1oe7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft6z1oe7.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-30 13:48:56, John Ogness wrote:
> On 2020-09-30, Petr Mladek <pmladek@suse.com> wrote:
> > Anyway, I see hardcoded limit more like a hack. It limits something
> > somewhere so that some other code somewhere else is safe to use.
> >
> > And printk.c is really bad from this point. It sometimes does not
> > check for overflow because it "knows" that the buffers are big
> > enough. But it is error prone code, especially when there are more
> > limits defined (pure text, prefix, extended prefix). And it
> > will be worse if we allow to add more optional information
> > into the prefix.
> 
> So should I post a v3 where the checks are added? Or should I add
> comments where checks would be, explaining why the checks are not
> needed?

If you have these locations still in head then it would be nice
to add the checks.

But it is not urgent. We should be on the safe side. Both ways
to store new messages are limited again now.

Anyway, please do so in a followup patch. I would like to push this
patchset into linux-next ASAP so that the robots could continue
finding new bugs.

Best Regards,
Petr
