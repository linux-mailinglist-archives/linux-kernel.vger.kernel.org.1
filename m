Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FD2E10AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 00:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgLVXxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 18:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLVXxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 18:53:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBCFC0613D3;
        Tue, 22 Dec 2020 15:52:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608681148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBg6u3ycvJLYb+a8Gwh+4UKSChn8eINhzdFNu5z9WyE=;
        b=K1OSJMhctJgGqMijS/Dc/dfEJdTW+iWwbbbjAvUc//I3mzeptfqjfQOXVdZEw/VxmlXZbM
        2USlNBwyrFUILUuc+ZHzWwZ9ut/UeuR8s5TMCQs8iFyVsQxaE0LAmdOOnCz5FKssZ19+nQ
        WFhrEQU9pdlgA8k0fa5kn6y5Xcw/c7aOJeo9w8zkbE743F1tviXktld2kIXl5T7dphJFTG
        2szLcKVExLAWUH6aJqWmDZg6G86NSUJKqTLa6Yyz959ZSBW32HRuTl0NUQNLp6UwkTlUXl
        PkTEzM0pF0P/56BHou13K8VMDy44Q0BWceQ40CP4oopHqni2U13zAoU3hSdGUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608681148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBg6u3ycvJLYb+a8Gwh+4UKSChn8eINhzdFNu5z9WyE=;
        b=tQt53sLP8hlrZ3beATYIm1t4bWQWfbwTznxZokdW4DuOeaSX2ea6B3Hw3vneVfdSi4Yc+/
        KNKio+NiAah6rABw==
To:     Andreas Larsson <andreas@gaisler.com>,
        sparclinux <sparclinux@vger.kernel.org>, linux-mm@kvack.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: sparc32: Init process fails to load with generic kmap atomic
In-Reply-To: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
References: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
Date:   Wed, 23 Dec 2020 00:52:28 +0100
Message-ID: <87v9ctcsar.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22 2020 at 18:58, Andreas Larsson wrote:
>  From as far as I have gotten into hunting down the problem, I get a
> failure from load_elf_binary here:
>
> 	/* First of all, some simple consistency checks */
> 	if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
> 		goto out;
>
> at least seemingly due to the kaddr from copy_page_to_iter in
> lib/iov_iter.c
>
> 	if (i->type & (ITER_BVEC|ITER_KVEC)) {
> 		void *kaddr = kmap_atomic(page);
> 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
>
> where kaddr points to memory with all zeroes (from an earlier bzero) in 
> this context:

The kaddr might be misleading you here. If the code flow is:

    kaddr1 = kmap_atomic(page1);
    ...
    kunmap_atomic(kaddr1);

    kaddr2 = kmap_atomic(page2);

Then kaddr1 == kaddr2, but first it maps page1 and then page2, but that
was the same in the original code.

> I will have to continue to dig deeper into this in January. If anyone
> has any ideas how this could stem from this kmap patch, I am all ears.

I can't spot it either. I'll send you a debug patch after the holidays.

Thanks,

        tglx
