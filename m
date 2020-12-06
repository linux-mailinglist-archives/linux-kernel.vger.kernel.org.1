Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE62D079B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 23:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgLFWJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 17:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgLFWJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:09:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A17C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 14:08:57 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607292536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+5wYSmV7lcFkyHHYfNCMDI0svv2RfxibRXE5myZbPQ=;
        b=hREXxPH6oM7hgGxINGBFegI0MIfKOmwrWyaq6qqWpAErqjSJ9r9Bhf4peecr5haY0610dH
        CW4izLItPaP1+qB89s5qY7ZOjW4im8mPVGdnANJmjE5qgnLq+tKPQn5oBZ+qhaB0MqBR2v
        ZnJtQT6Aq0VEJl0/1RsuzDTqJU3u6LXJJuOD+YUpCgjxSF73DvREPunVYZXMIstB9KSUY/
        CjRTdF8arjbm4C+UF3cMoer/IdxLz0dnxbLDs2OCG8b+3JDBx8t1gunjkTXA4it91bYoGk
        qMjp01lOlBXyY96beh1VCxHwZOrMBDD5VpuEXW0oJ+mynA02ymKnLywPsJV3aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607292536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+5wYSmV7lcFkyHHYfNCMDI0svv2RfxibRXE5myZbPQ=;
        b=7ulJcchhbjtSAHwGyhfXOGYvg2XpcwlcIRUCPZqs+ZO+HNNj7j62yp/X3DAzdGb5LsnpW2
        yhlW9XoHszjPMVAQ==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: recursion handling: Re: [PATCH next v2 3/3] printk: remove logbuf_lock, add syslog_lock
In-Reply-To: <X8sLr4snLX9DB3I8@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-4-john.ogness@linutronix.de> <X8pfX/qPBuY360k/@alley> <X8sLr4snLX9DB3I8@jagdpanzerIV.localdomain>
Date:   Sun, 06 Dec 2020 23:14:56 +0106
Message-ID: <87pn3mmvt3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-05, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> We should allow at least some level of recursion. Otherwise, we would
>> not see warnings printed from vsprintf code.
>
> One level of recursion seems reasonable on one hand, but on the other
> hand I also wonder if we can get useful info from recursion levels 2
> and higher. Would be great to maybe list possible scenarios. vsprintf()
> still call re-enter printk() -- WARN_ONCE()-s in the code -- external
> format specifiers handlers also can. Would we need to let two levels of
> recursion printk->vsprintf->printk->???->printk or one is just enough?
>
> It also would make sense to add the lost messages counter to per-CPU
> recursion counter struct, to count the number of times we bailout
> of printk due to recursion limit. So that we'll at least have
> "%d recursive printk messages lost" hints.

We do not need such a counter to be per-cpu. A global atomic_long_t
would suffice. Although I am not sure if that should be separate from
the @fail member of the ringbuffer.

> Overall...
> I wonder where does the "limit printk recursion" come from? printk_safe
> doesn't impose any strict limits (print_context is limited, but still)
> and we've been running it for years now; have we ever seen any reports
> of printk recursion overflows?

The printk code is undergoing some major changes and we have already had
bugs slip into the merge window. IMHO the additional code to track the
recursion does not add significant complexity or runtime overhead. I
would prefer to keep it until we are finished with this major rework.

John Ogness
