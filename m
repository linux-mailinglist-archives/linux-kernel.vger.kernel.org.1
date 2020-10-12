Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3028C430
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgJLVgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:36:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47766 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgJLVgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:36:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602538594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsM3EW27obhgH7kZI5uOPXIz6nUXb2Os2T5f/89HyGo=;
        b=PfwiXzaZl9GOFEIOnjyk6/XGqj8r0dZ3qRuWB3666zzFTIWMHLYTpBkhc/c1ymwgzfRbYX
        QynbE+8EkaxO7BmRpDrdgneaedWbcwBQ0j1gD/CjNrWXi/R4RZm9Uu94yEf3BNZp0890lC
        xioW4wFjjYilqer4MLZbHja9DG+QT00OoqXz7NhaiLfgSLJ6byTM/KsSAXiimk0uVmx/V+
        hSJkzO9/RF6xpRCf+bCiJ61mDC6Tc8ty3AySD/4Tevhdm/NSbCdf2HQT51V20PLIYAGwlX
        XBmzF7g/trvVhYexslZXyzbTYl6Sq/WMU6qeE/5xXte7/KJaWYihUBY0kYRIAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602538594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsM3EW27obhgH7kZI5uOPXIz6nUXb2Os2T5f/89HyGo=;
        b=/lldecyW2yyuu72CQ/xv21+tVe1dH99NHiI1hr+xSD/yPNXhgZwestGjPLU7mqolDYcAiS
        V6gD8QIOm0v+SSDA==
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Michael =?utf-8?Q?We?= =?utf-8?Q?i=C3=9F?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
In-Reply-To: <20201012211308.GH26571@fieldses.org>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de> <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de> <20201009132815.5afulu5poh5ti57m@wittgenstein> <20201009135554.GE15719@fieldses.org> <878scfrwls.fsf@nanos.tec.linutronix.de> <20201012211308.GH26571@fieldses.org>
Date:   Mon, 12 Oct 2020 23:36:34 +0200
Message-ID: <87h7qzp1nh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12 2020 at 17:13, J. Bruce Fields wrote:
> On Fri, Oct 09, 2020 at 10:08:15PM +0200, Thomas Gleixner wrote:
>> You wish. That's clearly wrong because that code is not guaranteed to
>> always run in a context which belongs to the root time namespace.
>
> Argh, right, thanks.
>
>> AFAICT, this stuff can run in softirq context which is context stealing
>> and the interrupted task can belong to a different time name space.
>
> Some of it runs in the context of a process doing IO to proc, some from
> kthreads.  So, anyway, yes, it's not consistent in the way we'd need.

Yes, that'll do it. If the process is in a time namespace then it's
definitely incorrect vs. the kthread which is in the root namespace.

>> You'd obviously need to fixup CACHE_NEW_EXPIRY and the other place which
>> add's '1' to the expiry value and some janitoring of function names and
>> variable types, but no real big surgery AFAICT.
>
> I'll give it a shot.
>
> Thanks so much for taking a careful look at this.

Welcome. I was just looking at the use case. The code and especially
Arnds comment were odd enogh to make me look deeper. Such constructs are
usually showing shortcomings of the core interfaces. Seventh sense which
I gained over the past decades. :)

Thanks,

        tglx
