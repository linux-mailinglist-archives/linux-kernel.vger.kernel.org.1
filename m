Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62CD2FB862
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392875AbhASMaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:30:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387414AbhASMXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:23:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611058923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kzOjM95fJedKhanGDes7Gs/np2Mc8EB1YqmNdBhWlW0=;
        b=HsvHysxL/+Ozf2nxPNfuID3A/uqizmc/x30cu3vnqls0uKtM6x+I8/x3hZieIRIKldul2Q
        N1O7TvUCy9dTjwvDtmNhuIUUQaLk9X9rBsNy6mM/rC9iqtxeKOkCqLkKVUBq73T9eD5rON
        t2Bz/wJS8NkcEML5hcK6/BAf08o/Tno=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0DFEAC6E;
        Tue, 19 Jan 2021 12:22:03 +0000 (UTC)
Date:   Tue, 19 Jan 2021 13:22:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
Message-ID: <YAbO6tQelFISgovf@alley>
References: <20210114170412.4819-1-john.ogness@linutronix.de>
 <YAGE1O/nG57hyRs4@alley>
 <YAGFebfPNLwjyhcl@alley>
 <YAYriDiAl7lajty9@jagdpanzerIV.localdomain>
 <87r1mh5mso.fsf@jogness.linutronix.de>
 <YAa0j9CG/6yrGcs+@jagdpanzerIV.localdomain>
 <87bldl5exc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bldl5exc.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-19 12:50:47, John Ogness wrote:
> On 2021-01-19, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> >>> John, how did you spot these problems?
> >> 
> >> I am preparing my series to remove the logbuf_lock, which also
> >> refactors and consolidates code from syslog_print_all() and
> >> kmsg_dump_get_buffer(). While testing/verifying my series, I noticed
> >> the these oddities in the semantics and decided I should research
> >> where they came from and if they were actually necessary.
> >
> > Any chance you can put those tests somewhere public so that we can
> > run them regularly?

Great idea.

> I have a collection of hacked-together tools that I use to test most of
> the various interfaces of printk. I would need to clean them up if they
> should be used for any kind of automated regression testing.

Sounds good. We could even help with the clean up. This kind of code
always need it when it was not written for public use from scratch.

> And where should I make such things available? I could put them in a
> repo in the Linutronix github account (like I did for the ringbuffer
> stress testing tool). (??)

Sounds good as well.

Best Regards,
Petr
