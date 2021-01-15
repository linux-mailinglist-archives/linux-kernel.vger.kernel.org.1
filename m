Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FF12F7521
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbhAOJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:54380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbhAOJWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:22:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610702494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KT9EN3eX0+nSmx+nfrEJ3/uRnYd9p/NeYXSrly1MMiA=;
        b=L/MTVtx3P3zxEKxzlkObD4LCPc826bfCW7jmXkBMSA96jr4SHJWxzxOJ8WMJ1BjFJD9DnR
        N10BgNg+0eBsnH04HIwNrAO7hQ2yHEU9z1zub2fe76rkXqf0ndSjnXNLv2+bAT7qeIW64D
        +HjLyvsWm3nT0yiSoRWWTwIypzUDwoU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BA15AA6F;
        Fri, 15 Jan 2021 09:21:34 +0000 (UTC)
Date:   Fri, 15 Jan 2021 10:21:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Roman Fietze <roman.fietze@magna.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for unhashed
 addresses
Message-ID: <YAFenc9MHvPNrZ06@alley>
References: <20210106213547.1077789-1-timur@tabi.org>
 <X/wkMMiPPBAJb9+A@alley>
 <20210111173009.fe2383539e5ca2c23b135262@linux-foundation.org>
 <d067f15a-8816-8879-e575-b610707c5189@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d067f15a-8816-8879-e575-b610707c5189@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-01-14 20:56:36, Timur Tabi wrote:
> On 1/11/21 7:30 PM, Andrew Morton wrote:
> > I doubt if Kees (or I or anyone else) can review this change because
> > there are no callers which actually use the new DUMP_PREFIX_UNHASHED.
> > Is it intended that some other places in the kernel be changed to use
> > this?  If so, please describe where and why, so that others can better
> > understand both the requirement and the security implications.
> 
> In my opinion, hashed addresses make no sense in a hexdump, so I would say
> that ALL callers should change.  But none of the drivers I've written call
> print_hex_dump(), so I can't make those changes myself.

I know that you probably know it because you introduced new mode
instead of updating the existing one. But to be sure.

We need to be careful here. The hashed pointer has been introduced for
a reason. It prevents leaking pointers and helping bad guys.

The original plan was to introduce %pK. It was supposed to prevent
non-privileged users from seeing the real pointer value. It did not
really worked because it was only rarely used. The plain %p was
heavily used in historical and even in a new code.

By other words, every print_hex_dump() used need to be reviewed in
which context might be called.

> > If it is intended that this be used mainly for developer debug and not
> > to be shipped in the mainline kernel then let's get this info into the
> > changelog as well.
> 
> I definitely want this patch included in the mainline kernel.  Just because
> there aren't any users today doesn't mean that there won't be. In fact, I
> suspect that most current users haven't noticed that the addresses have
> changed or don't care any more, but if they were to write the code today,
> they would use unhashed addresses.

I am pretty sure that will look for this functionality sooner or
later. The hashed pointers make debugging really complicated.

> If you want, I can include a patch that changes a few callers of
> print_hex_dump() to use DUMP_PREFIX_UNHASHED, based on what I think would be
> useful.

It would be nice.

Best Regards,
Petr
