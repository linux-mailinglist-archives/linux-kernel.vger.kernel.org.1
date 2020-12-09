Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80F02D4924
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbgLIShd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgLIShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:37:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B09C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YaidPVlCxOibO+8c1Y8zsApUURZrb2kkqSHr+hyl+7A=; b=Udgs5SOt8G6nHTapDFKcxpRuha
        AA1iApPdtIiQ0fQU4USFuLG8i3fmxoldKlOapZEXkVt3d5bYssVBG7EjG30o7U6UHusm++edgHPFB
        JV0cg22HL1c/XmdABD6Q9mFfFZN4/L+opKB0xpv5aGX6X2vMqvuoyISLRG1yIJIGbXW+OxntWwcVR
        GUAfyzjS1TDJVWiCHym4ug1b9trTGu8ogSWH+R9scRsOIKruzkVW6dAmlNsxTsb3qRzvz/9AJyOBR
        3tvjiZf/N9cWXVId+i91QyZ5GmUbjvOiOeW92KlYvY2px4co+2zIcmTG6S6ddhL/4MQX3vmbD8SAZ
        XnI0J/hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn4KJ-000100-4Y; Wed, 09 Dec 2020 18:36:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD1DC980EF2; Wed,  9 Dec 2020 19:36:33 +0100 (CET)
Date:   Wed, 9 Dec 2020 19:36:33 +0100
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
Message-ID: <20201209183633.GA6190@worktop.programming.kicks-ass.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <87360hy5hp.fsf@x220.int.ebiederm.org>
 <20201208145257.GE2414@hirez.programming.kicks-ass.net>
 <87tuswup9g.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuswup9g.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 12:27:39PM -0600, Eric W. Biederman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Mon, Dec 07, 2020 at 09:56:34AM -0600, Eric W. Biederman wrote:
> >
> >> Do you want to pull these two into a topic branch in the tip tree
> >> based on v10-rc1?
> >
> > I'll go do that. I'll let the robots chew on it before pushing it out
> > though, I'll reply once it's in tip.git.
> 
> Thanks,

git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rwsem

