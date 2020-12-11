Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8350B2D723F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437158AbgLKIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405493AbgLKIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:50:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2KLxFX4cpBCUA9tI9eovULMW3sKQYah7BmVmmunzsj8=; b=oqCv07ywAHNKtPztwMeDm4KkRF
        J8djLvjSsGsrVGL5R88IWMtdl+gHV9P24ZmlbHR4Rq2MVpfLDYt3Ax/tIH+366lUjj2BonVF+OxSj
        Gqa2ovXkhGkdx/2loWFr9T/GAsoqgACrZRiiDGePkvnx9MdPzBu+gRZ7CO0cvtwma9IF0DbL9dC54
        nEiYuP+NA50ui+NR1nQ8zgt8o1Kbb4/iyhPk+xJriR19Q5OAuBBl8nBfy2psvHwQsppdXcMMfO2z7
        AO6f83DlwS1dv6aoofT3OgsglIEJJGqpj0dnv1rChveOaztH42ICbtsgDjqvO1fmxuXZ35P0hy7ur
        sfvoBCDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kne3N-0007Hi-1i; Fri, 11 Dec 2020 08:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA8B13003D8;
        Fri, 11 Dec 2020 09:45:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD28A203C67DA; Fri, 11 Dec 2020 09:45:19 +0100 (CET)
Date:   Fri, 11 Dec 2020 09:45:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool crashes with some clang produced .o files
Message-ID: <20201211084519.GT2414@hirez.programming.kicks-ass.net>
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
 <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 03:35:45PM -0800, Nick Desaulniers wrote:
> On Thu, Dec 3, 2020 at 5:56 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > I see occasional randconfig builds failing on x86 with clang-11
> > and clang-12 when objtool crashes with a segmentation fault.
> >
> > The simplest test case I managed to create is
> >
> > $ echo "__SCK__tp_func_cdev_update() { __SCT__tp_func_cdev_update(); }" > file.c

> So some instruction in .text that contained a relocation for, we could
> not determine a symbol for?  I'm curious why we're even in this loop
> though, since we didn't do anything related to static calls...


No you did, you called a __SCT*() function, which is a
static-call-trampoline. objtool does indeed assume it then has a symbol
for the matching key, which should be guaranteed by the __ADDRESSABLE()
in __static_call().

From linux/static_call.h:

/*
 * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
 * the symbol table so that objtool can reference it when it generates the
 * .static_call_sites section.
 */
#define __static_call(name)						\
({									\
	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
	&STATIC_CALL_TRAMP(name);					\
})


Let me go find a copy of clang-11..
