Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860BC257413
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgHaHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 03:12:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:12:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598857967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0T5AK1WewHGFQuB5YXJMQjTPSmjOUGySbyGnm8WX0I=;
        b=YrMbHrasYKyLkWFIEIRoalEVyprNvplnrpACKO43TQIEXZatQRhNClTXO3+a7Us0XlkWJJ
        8e7+SfDSmSjSKiwn/24Vx2Ulrdqt/EBYzOGu8btpNNcx04oiOy53GrQwTn0h/kH5ewKQ1w
        T5PtPFUHcL39S/cTO6u+9ab8ttSB7Ss1PqRf5q/gd6+OEL9qZ8oKE+YorAL7awTzqtPawu
        9M9KL2HMxWCDnmDYMvXNgu4vRftwJClzz7BhDBO19jFr2LQV9d3ujuSfu423RViAnzTeY/
        bvzzGDQHJ+oJoa8j1Z1afU7V7gmmpWcadTMNgttzGVPXtRl2mat56QFYqmIMGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598857967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0T5AK1WewHGFQuB5YXJMQjTPSmjOUGySbyGnm8WX0I=;
        b=tU4ZIc3ojfzFE/Rxxslj1z2GcI/2vMo0RVOETFwJ9F5S0fny4QplnfFqACwf34N6RduVLD
        uM1KFOl4JntRVABQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
In-Reply-To: <CAHk-=wj16dFx2Mx1oO2oxhJjAmsaPOqLcGvEGb86-z+v5iu5tw@mail.gmail.com>
References: <159881061564.27993.11909051048930389391.tglx@nanos> <159881061925.27993.10669865438175129325.tglx@nanos> <CAHk-=wj16dFx2Mx1oO2oxhJjAmsaPOqLcGvEGb86-z+v5iu5tw@mail.gmail.com>
Date:   Mon, 31 Aug 2020 09:12:47 +0200
Message-ID: <87mu2bi900.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30 2020 at 12:13, Linus Torvalds wrote:
> On Sun, Aug 30, 2020 at 11:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>    The historical inconsistent for_each_cpu() behaviour of
>>    ignoring the cpumask and unconditionally claiming that CPU0 is in the
>>    mask struck again. Sigh.
>
> I guess we could remove the UP optimizations these days. It's not like
> they matter like they used to.

Indeed.

> Or leave the optimizations in the sense that they wouldn't do the
> crazy bit searching, but they could look at bit 0 of the mask they're
> passed..

Yes, that's trivial enough and the compiler should turn the whole thing
into a simple conditional checking bit 0 and remove the rest of the loop
gunk.

Thanks,

        tglx
