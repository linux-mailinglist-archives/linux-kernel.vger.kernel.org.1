Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC12CC551
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgLBSha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:37:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgLBSha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:37:30 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606934208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1foj5CsrViA5SnitgSB9afdnS+nk8RYKri/uQf762Sw=;
        b=gwasJt4poOMW5wOYjISAkGD39Hg11wWf7RWMwG0ZUzlWUPsB/RtTTOt4qsQx306KjFJi5j
        6O17bg2fqul9rX9Hh7jbSJhSyV/gkUEEMRYOpYLGZuuF/zTq4yT6k/n4mF+cg+n78rqByy
        4rxxM2Z94IRy1d++35EpyUzWn+adeXAmTdkWZmIKfBZ+8bZFalHYWVkrwtBvxG28/6/kM2
        pfNcjf//jQQdKnQcwHodOh9nLEvjQCggxmMEa+Alsu33nNM2p+7pR1JaVPg5sOBFY39XnO
        tLEK1u+xUzrJYtTj06JUMRMjZFxfjnVZQ69Pi5V8pvGG7m8KoUnAcHn5cTD8mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606934208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1foj5CsrViA5SnitgSB9afdnS+nk8RYKri/uQf762Sw=;
        b=RSWTZTk0SHOmL86mzhZi8XFkcjohexnCZi2/sqDGub0NrcrnQm00BCnZQ101U/cSU26Rsy
        gH8cU2scPQ1K4TAA==
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
In-Reply-To: <20201202153656.GC2231584@localhost>
References: <20201201143835.2054508-1-mlichvar@redhat.com> <20201201161224.GF5487@ziepe.ca> <20201201171420.GN1900232@localhost> <20201201173540.GH5487@ziepe.ca> <87mtywe2zu.fsf@nanos.tec.linutronix.de> <20201202150725.GA2231584@localhost> <20201202153656.GC2231584@localhost>
Date:   Wed, 02 Dec 2020 19:36:47 +0100
Message-ID: <87eek8dphc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02 2020 at 16:36, Miroslav Lichvar wrote:
> On Wed, Dec 02, 2020 at 04:07:28PM +0100, Miroslav Lichvar wrote:
>> On Wed, Dec 02, 2020 at 02:44:53PM +0100, Thomas Gleixner wrote:
>> > Something like the completely untested below should make this reliable
>> > and only needs to retry when the work is running late (busy machine),
>> > but the wakeup will be on time or at max 1 jiffie off when high
>> > resolution timers are not available or disabled.
>> 
>> It seems to work nicely. In my test most of the updates succeeded on
>> the first attempt hitting the right tick, the rest succeeding on the
>> second attempt. Only when the clock was set to run 10% faster, it
>> needed few more attempts to converge to the target time.
>
> I noticed an observable change wrt adjtimex() calls though. It seems
> it now reschedules the RTC update, i.e. there can be more than one
> update per 11 minutes. Was this intended?

No. Let me fix that.

Thanks,

        tglx
