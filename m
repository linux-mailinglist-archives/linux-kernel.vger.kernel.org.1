Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341372D7188
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405487AbgLKISS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgLKIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:17:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BCC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dxP77bAMnCYsIKNcNQqeSagE6C5RUaAg5sGNMdv3j/s=; b=HI4O5kyfjLPrOHmJ8zazWBkViY
        +EiIi/y3Hai/ycRkhgsN5MI+6lkCMKbWDKXCKUWR/0CsIECey0Qe2fl7o/TJJ1eCMX5nb1yb0bp/L
        hqnpbD5rytw79Nn2DnbhUoWBpyECb5tNkI0JYaLvzIWT32MhDUjSRi9DYuaYpQ8DKV7tDISVFdhjM
        FYkMNKFmu8tiVMaO7uuVRxGJD2WGQi6tKzJOebb6w8M2iOiCaa25Je3jQPrt2brbD1noVhgrNii6c
        XaGg4EfBVQUjqTtIL9crlxpK9oSkFnJy2uM5p8GN123o2+1DyHfNYDnTZMe0Qe88nrNk4BUTmIi/e
        Y3INzgbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kndbY-00009b-Oi; Fri, 11 Dec 2020 08:16:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A0033011E6;
        Fri, 11 Dec 2020 09:16:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D58021BE8D90; Fri, 11 Dec 2020 09:16:38 +0100 (CET)
Date:   Fri, 11 Dec 2020 09:16:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3] rwsem: Implement down_read_interruptible
Message-ID: <20201211081638.GS2414@hirez.programming.kicks-ass.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <87360hy5hp.fsf@x220.int.ebiederm.org>
 <20201208145257.GE2414@hirez.programming.kicks-ass.net>
 <87tuswup9g.fsf@x220.int.ebiederm.org>
 <20201209183633.GA6190@worktop.programming.kicks-ass.net>
 <877dppo3qy.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dppo3qy.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:33:25PM -0600, Eric W. Biederman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Tue, Dec 08, 2020 at 12:27:39PM -0600, Eric W. Biederman wrote:
> >> Peter Zijlstra <peterz@infradead.org> writes:
> >> 
> >> > On Mon, Dec 07, 2020 at 09:56:34AM -0600, Eric W. Biederman wrote:
> >> >
> >> >> Do you want to pull these two into a topic branch in the tip tree
> >> >> based on v10-rc1?
> >> >
> >> > I'll go do that. I'll let the robots chew on it before pushing it out
> >> > though, I'll reply once it's in tip.git.
> >> 
> >> Thanks,
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rwsem
> 
> Is that branch supposed to be against 34816d20f173
> ("Merge tag 'gfs2-v5.10-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2")

That's what it looks like indeed. IIRC my script was supposed to pick
the most recent -rc when creating new branches, but then I've no idea
how I ended up on this. I'll go dig..

> If so I can live with that, but it is a little awkward to work with a
> base that recent.  As all of my other branches have an older base.

I missed you explicitly requested -rc1, sorry about that :/


