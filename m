Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5192D2D97
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgLHOxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgLHOxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:53:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF312C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=69aiA/KbXT2suDAl7pYGEHkjGFFwGcIsW5cPybJySu0=; b=kh+G8V2hbdzgsQgk0meP5s+IEp
        hJlvi77pY3JvhLfVYRYFxvvYc+juZeXMWoe3hLdSQUR78uDXqOg8C4kk0u/GJPeJL9EiQ5TRjwqhs
        advWUg37n5dvlsPOYvjIqQpoTpuiMy7LDRiQm6ux2UHHJZtGfCzCaNRhpY/wr/0kLEojMuZJDI1h2
        G9KH69hdMYBysqBiBYYlrzaGffvIymcbkG0CfhOn28l8PSyFfPlt9183KPHDVFC2w4ED4XWyEK2MF
        gOTutCiOPnyj6I32vniHORhl4dxDjAKWwnwn8KTW9An0oHsQh0y4MYDbnpw5fE2M92mtvIIAk0PMi
        hPRhmy3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmeMM-0003PV-Ve; Tue, 08 Dec 2020 14:52:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0020304B92;
        Tue,  8 Dec 2020 15:52:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4FB62846DEB5; Tue,  8 Dec 2020 15:52:57 +0100 (CET)
Date:   Tue, 8 Dec 2020 15:52:57 +0100
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
Message-ID: <20201208145257.GE2414@hirez.programming.kicks-ass.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <87360hy5hp.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87360hy5hp.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:56:34AM -0600, Eric W. Biederman wrote:

> Do you want to pull these two into a topic branch in the tip tree
> based on v10-rc1?

I'll go do that. I'll let the robots chew on it before pushing it out
though, I'll reply once it's in tip.git.
