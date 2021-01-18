Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA852FA92F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407783AbhARSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393673AbhARS1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:27:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA20C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=psMEzxEPv5+ylWqc3o687nSgEjIGZMC3XbmoOskqoPc=; b=qoHMpXLGbkzJhTV1+VZMk8+RXs
        7Ke5qITA1Hy5HqACCa1n4z1+W8k+SajBGXe9VzF+Lyk2/qjTs7/LZVX3JHE3QeeP74Ac2Xmqzjbr0
        jbYx1f/pFPpk6trnbNqbMEExl9dJAi78lo3wC9SvY45v+cSVGzkcp/yX3EGvYeT2gaiDgdM9b6wB4
        5PgCIsDFlQ/C4aCFaPFs/AYoJAertBLl1rmO2zYpdyKnu8P3pVjUkWvPLpsB+VUE3fAusUnEDAsjK
        dxAwKYFR8u5E0HJjIxdxZnOQB9ILdcZH5Z95MSRB7U9PA3FxCqoxZQEaRb8mkAuyEdKaomGU/5Hse
        KRy2tOcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1ZEZ-00DDQv-GC; Mon, 18 Jan 2021 18:26:37 +0000
Date:   Mon, 18 Jan 2021 18:26:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <20210118182635.GD2260413@casper.infradead.org>
References: <20210116220950.47078-1-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116220950.47078-1-timur@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 04:09:48PM -0600, Timur Tabi wrote:
> First patch updates print_hex_dump() and related functions to
> allow callers to print hex dumps with unhashed addresses.  It
> adds a new prefix type, so existing code is unchanged.
> 
> Second patch changes a page poising function to use the new
> address type.  This is just an example of a change.  If it's
> wrong, it doesn't need to be applied.
> 
> IMHO, hashed addresses make very little sense for hex dumps,
> which print addresses in 16- or 32-byte increments.  Typical
> use-case is to correlate an addresses in between one of these
> increments with some other address, but that can't be done
> if the addresses are hashed.  I expect most developers to
> want to replace their usage of DUMP_PREFIX_ADDRESS with
> DUMP_PREFIX_UNHASHED, now that they have the opportunity.

Yes, I'm sure most kernel developers actually do want to leak kernel
addresses into kernel messages.  The important thing though is that it
should be hard for them to do that, and it should stick out like a sore
thumb if they do it.

Don't make it easy.  And don't make it look like they're doing
something innocent.  DUMP_PREFIX_SECURITY_HOLE would be OK
by me.  DUMP_PREFIX_LEAK_INFORMATION would work fine too.
DUMP_PREFIX_MAKE_ATTACKERS_LIFE_EASY might be a bit too far.
