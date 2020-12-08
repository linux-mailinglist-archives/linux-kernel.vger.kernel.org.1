Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E832D2B12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgLHMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgLHMdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:33:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B03FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 04:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=35pjWeZIwV5ZzKGhstE73Xq/THlWfXAEgRM5OI3Jsww=; b=O4fUd7W5HQS6PKP7LUsYK6PoUp
        OnmtIgnJzgBSdBtTt8Y1Icy5pU5FO25vPhooeKGBsBrp//bXg/1I7ye1tZAei08xB6darKbHFHLWy
        kO9T7ZLwEldsUoUb5i2vaN2td/uDZok0yRg2kVO7TNmByp6zMTQcHHZR9jic8uai5cIzZiO/cwfm3
        ONsaStYaV3wuUaZ8J1rgVZVz4UynbQcQlzWEYtyAD8gevfY/QPOI++6TWBmi0qNkhtiSS810l6iqc
        047T5j5lAD7eIhv9geTdMamBVap5a2rJjlPhU6ITuqoWLeDgixsUuTR5OSCONLjmsBQOe0HRgV2ez
        oal1uqKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmcA5-0003ZT-LE; Tue, 08 Dec 2020 12:32:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB8DF304B92;
        Tue,  8 Dec 2020 13:32:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D65F0200AABB6; Tue,  8 Dec 2020 13:32:04 +0100 (CET)
Date:   Tue, 8 Dec 2020 13:32:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Waiman Long' <longman@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20201208123204.GW2414@hirez.programming.kicks-ass.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <7be81903-14e3-7485-83e7-02e65e80e8c3@redhat.com>
 <c781c59872e742c2b64f1aa70c30d7e2@AcuMS.aculab.com>
 <aef54faf-cead-403c-6088-ff52ce1a5dde@redhat.com>
 <71db845efc7d44b5a7d23b0e55b3a496@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71db845efc7d44b5a7d23b0e55b3a496@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 09:12:36AM +0000, David Laight wrote:
> From: Waiman Long
> > Sent: 07 December 2020 19:02
> ...
> > > How much more difficult would it be to also add a timeout option?
> > > I looked at adding one to the mutex code - and fell into a big pile
> > > of replicated code.
> > >
> > > ISTM that one the initial locked exchange (and spin) fails a few
> > > extra instructions when heading for the sleep don't really matter
> > >
> > Actually, I had tried that before. See
> > 
> > https://lore.kernel.org/lkml/20190911150537.19527-1-longman@redhat.com/
> > 
> > That is for rwsem, but the same can be done for mutex. However, Peter
> > didn't seem to like the idea of a timeout parameter. Anyway, it is
> > certainly doable if there is a good use case for it.
> 
> 'Unfortunately' my use-case if for an out-of-tree driver.
> 
> The problem I was solving is a status call blocking because
> some other code is 'stuck' (probably an oops) with a mutex held.

Working around oopses is not a sane use-case. If you oops, you get to
keep all the pieces.
