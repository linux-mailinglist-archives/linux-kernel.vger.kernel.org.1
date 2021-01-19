Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4DA2FAE67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392571AbhASBsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbhASBss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:48:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5EEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 17:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BLuACzj/hxlsdh8jmjBAmpxbJLlwSm10yHZoCOzYH4Y=; b=gEj1IYRa3NsonURFIRgd2StEg8
        8p4oaSLFOswN8bjnemVQhFRC3BwX0oBab/SCthJUm7lExQXT7kfQEiqasWpgCEQZ45GSezK8OV4+v
        E3kLsb17szO3nUrs7/YANNt2JfbbG2dVKpkxMfQPISJO/COfiQPhFLwKnS1SEKJAzqQayqH1Bx6XT
        1DCyD9/9QXkBOztjDNpMFMvb22M/dnMHPNaYdZZYyk6m6aDhkVO40c1eCLSbvuiwZI0jEOzj1i9eM
        lDwxOI/DGcqIEKAgsSUG+dR+FIecS/GGLIH0TzNjBEiCyeuS5/otzbYHIk2bWw4yR14hRd8UMbFRE
        0Vz23AnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1g7B-00DeJl-T8; Tue, 19 Jan 2021 01:47:45 +0000
Date:   Tue, 19 Jan 2021 01:47:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <20210119014725.GH2260413@casper.infradead.org>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:53:01AM +0900, Sergey Senozhatsky wrote:
> On (21/01/18 13:03), Timur Tabi wrote:
> > On 1/18/21 12:26 PM, Matthew Wilcox wrote:
> > > Don't make it easy.  And don't make it look like they're doing
> > > something innocent.  DUMP_PREFIX_SECURITY_HOLE would be OK
> > > by me.  DUMP_PREFIX_LEAK_INFORMATION would work fine too.
> > > DUMP_PREFIX_MAKE_ATTACKERS_LIFE_EASY might be a bit too far.
> > 
> > It's already extremely easy to replace %p with %px in your own printks, so I
> > don't really understand your argument.
> 
> I like the idea of a more radical name, e.g. DUMP_PREFIX_RAW_POINTERS or
> something similar.
> 
> > Seriously, this patch should not be so contentious.  If you want hashed
> > addresses, then nothing changes.  If you need unhashed addresses while
> > debugging, then use DUMP_PREFIX_UNHASHED.  Just like you can use %px in
> > printk.  I never use %p in my printks, but then I never submit code upstream
> > that prints addresses, hashed or unhashed.

I'm glad to hear you never make mistakes.  I make lots of mistakes, so
I prefer them to be big, loud and obvious so they're easy for people
to spot.

> So maybe DUMP_PREFIX_UNHASHED can do the unhashed dump only when
> CONFIG_DEBUG_KERNEL=y and fallback to DUMP_PREFIX_ADDRESS otherwise?

Distros enable CONFIG_DEBUG_KERNEL.  If you want to add
CONFIG_DEBUG_LEAK_ADDRESSES, then that's great, and you won't even have
to change users, you can just change how %p behaves.
