Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6392B2C420F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgKYOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgKYOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:18:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B5C0613D4;
        Wed, 25 Nov 2020 06:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wU0zOrnocdlJXkwamHXZAUVyZC76vH5lJ5qYsICzTKo=; b=ZuzsjBMR9U0lOnIq/91BDGYPEA
        xn+47d8MvnUyg0jb+LlGQaXhOVNZZ0HxdFkuGcVOIPoxSJme47cjFNsRC0seL2naATdv5B4NKA2JS
        VySBiCx2iK4Qxvk7FeoJeptUxcaJwpWZBeryC506uwx6HbbOxVl08piQ7f4EVkumqG22zzaoxbOV9
        DXq+CfJ/nHL3hVFaQDowit5vE3Sl5ttR9mpY5iFcJ3epNHQjktWxbaPPSzAkZDGQDZrhjwhOYd9se
        OfC4HUbDqj/yJToiL2Qhu9n6pCJ5nXaV2e92gxqPrVSFydbh9TstGdABE92ozX3z+457pVs+qha/t
        W5xl5aJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khvcc-0001r2-CL; Wed, 25 Nov 2020 14:18:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0254306E0C;
        Wed, 25 Nov 2020 15:18:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A08ED22B9CF4B; Wed, 25 Nov 2020 15:18:13 +0100 (CET)
Date:   Wed, 25 Nov 2020 15:18:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS
 supported
Message-ID: <20201125141813.GC2414@hirez.programming.kicks-ass.net>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org>
 <20201124143931.GI2414@hirez.programming.kicks-ass.net>
 <CAJF2gTTBbjOhvvLTd6d5zgb0kskoSJhPW7nmg==4w2wV+OaUgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTBbjOhvvLTd6d5zgb0kskoSJhPW7nmg==4w2wV+OaUgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 08:52:23AM +0800, Guo Ren wrote:

> > I'm pretty sure there's a handfull of implementations like this out
> > there... if only we could share.
> Michael has sent qspinlock before, ref to Link below. He reused mips' code.
> 
> Link: https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/
> 
> Which short xchg implementation do you prefer (Mine or his)?

Well, it would be very nice to have mips/riscv/csky all use the same
header to implement these I suppose.

But then we're back to a cmpxchg-loop, in which case Arnd's suggestion
isn't worse.
