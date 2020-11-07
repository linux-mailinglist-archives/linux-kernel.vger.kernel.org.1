Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4659F2AA1E2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 01:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgKGArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 19:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKGArM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:47:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B3FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 16:47:12 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604710030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kizlAGjxJjSwPr3I/kyrovWHgne+CD/s3FGEqnQm6J4=;
        b=OEHKaMRvI9qIU4kaUv0mjH5h0zh8RsLfvYvtVBdSL9zO0EE/q4/uHDLpnqnvgK7RKhZ7YM
        uunB4KvyOQ2vx7TxoitrsW6Jhbdf0ml9cRP63f7YpZgfuwC+5dZIH1hYpr+j9wLSIAXEwP
        XOwU/dUb1hfxyFuhx5wkarLMQ49lnrbzl8J2tvnVD/8a5VjCNtPs4aZR3ti7P1Isb9SeuH
        SPIk3XgC6MV21eHTHYWLNN31P6+nlrBeExaq22Rez9a3ZKjAvMpvb6RNNaxZaAGtI1viLK
        unOpBV5+CokeZkQ7twpgHS+S3jfKisE0NnrGBS+46XggWsb43srx8fEh+ISvkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604710030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kizlAGjxJjSwPr3I/kyrovWHgne+CD/s3FGEqnQm6J4=;
        b=mp704N5XM7+MQHISDg8H9hl57ZSJyNydmNXCv7nwXqC4QLPv12DWupvFeB+jR/8y2wX/zv
        v9b97YOTyW91knDA==
To:     Carlos O'Donell <carlos@redhat.com>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME support plans in Linux time namespaces
In-Reply-To: <7a4d7b14-1f0b-4c40-2bd1-2582d8b71868@redhat.com>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan> <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com> <87sg9vn40t.fsf@nanos.tec.linutronix.de> <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com> <87h7qbmqc3.fsf@nanos.tec.linutronix.de> <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com> <87k0v7kwdc.fsf@nanos.tec.linutronix.de> <7a4d7b14-1f0b-4c40-2bd1-2582d8b71868@redhat.com>
Date:   Sat, 07 Nov 2020 01:47:10 +0100
Message-ID: <87y2jej8mp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05 2020 at 12:25, Carlos O'Donell wrote:
> On 10/30/20 9:38 PM, Thomas Gleixner wrote:
> If kata grows up quickly perhaps this entire problem becomes solved, but until
> then I continue to have a testing need for a distinct CLOCK_REALTIME in a
> time namespace (and it need not be unconditional, if I have to engage magic
> then I'm happy to do that).

Conditional, that might be a way to go.

Would CONFIG_DEBUG_DISTORTED_CLOCK_REALTIME be a way to go? IOW,
something which is clearly in the debug section of the kernel which wont
get turned on by distros (*cough*) and comes with a description that any
bug reports against it vs. time correctness are going to be ignored.

> * Adding CLOCK_REALTIME to the kernel is a lot of work given the expected
>   guarantees for a local system.

Correct.

> * CLOCK_REALTIME is an expensive resource to maintain, even more expensive
>   than other resources where the kernel can balance their usage.

Correct.

> * On balance it would be better to use vm or vm+containers e.g. kata as a
>   solution to having CLOCK_REALTIME distinct in the container.

That'd be the optimal solution, but the above might be a middle ground.

Thanks,

        tglx
