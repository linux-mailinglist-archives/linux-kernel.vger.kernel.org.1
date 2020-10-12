Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148FE28C3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbgJLVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731517AbgJLVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:13:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589BC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:13:09 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7332F1E50; Mon, 12 Oct 2020 17:13:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7332F1E50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602537188;
        bh=UCj+DsuZKA1izzZfECvTrVOAVQYPk81HV/UKNNnkGzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbIHRbIxY4Yl2UGnbEDfMA5PdT41pYUJLgXtwLu+5kUl9SIYOA7QTuGkLtp8DQkEk
         lolk3GPiWGjAkWhIHMKaYbAKZj0gYM0E6N8nUAF3ANJ3hF24gla6n+mOhZmuQeveYr
         6ov0blcD5jDppFXTMoLKZGjsiM+qJGih/Vf8GdgY=
Date:   Mon, 12 Oct 2020 17:13:08 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
Message-ID: <20201012211308.GH26571@fieldses.org>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
 <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de>
 <20201009132815.5afulu5poh5ti57m@wittgenstein>
 <20201009135554.GE15719@fieldses.org>
 <878scfrwls.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878scfrwls.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 10:08:15PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 09 2020 at 09:55, J. Bruce Fields wrote:
> > Looking at how it's used in net/sunrpc/cache.c....  All it's doing is
> > comparing times which have all been calculated relative to the time
> > returned by getboottime64().  So it doesn't really matter what
> > getboottime64() is, as long as it's always the same.
> >
> > So, I don't think this should change behavior of the sunrpc code at all.
> 
> You wish. That's clearly wrong because that code is not guaranteed to
> always run in a context which belongs to the root time namespace.

Argh, right, thanks.

> AFAICT, this stuff can run in softirq context which is context stealing
> and the interrupted task can belong to a different time name space.

Some of it runs in the context of a process doing IO to proc, some from
kthreads.  So, anyway, yes, it's not consistent in the way we'd need.

> In fact the whole thing can be simplified. You can just use time in
> nanoseconds retrieved via ktime_get_coarse_boottime() which does not
> read the clocksource and advances once per tick and does not contain a
> divison and is definitely faster than seconds_since_boot()
> 
> The expiry time is initialized via get_expiry() which does:
> 
>    getboottime64(&boot);
>    return rv - boot.tv_sec; 
> 
> The expiry value 'rv' which is read out of the buffer is wall time in
> seconds. So all you need is are function which convert real to boottime
> and vice versa. That's trivial to implement and again faster than
> getboottime64(). Something like this:
> 
> ktime_t ktime_real_to_boot(ktime_t real)
> {
>         struct timekeeper *tk = &tk_core.timekeeper;
>         ktime_t mono = ktime_sub(real, tk->offs_real);
>               
>         return ktime_add(mono, tk->offs_boot);
> }
> 
> so the above becomes:
> 
>    return ktime_real_to_boot(rv * NSEC_PER_SEC);
> 
> which is still faster than a division.
> 
> The nanoseconds value after converting back to wall clock will need a
> division to get seconds since the epoch, but that's not an issue because
> that backward conversion already has one today.
> 
> You'd obviously need to fixup CACHE_NEW_EXPIRY and the other place which
> add's '1' to the expiry value and some janitoring of function names and
> variable types, but no real big surgery AFAICT.

I'll give it a shot.

Thanks so much for taking a careful look at this.

--b.
