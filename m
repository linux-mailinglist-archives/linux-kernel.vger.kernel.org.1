Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DDE27A307
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgI0T4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:56:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgI0Tz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601236557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Szpo4w21IZpnZ2qNo/StcyttmD30FJG0p2SEFkzckEw=;
        b=ot6mRpNTuKZr0zO+Fr51LDVAjUZE1TOaqhjdgFmUvG/wWxN/+fUkcgCvlo8p1ypgaW3Qul
        7ybd7gKRKEm2keY7upE6Awwy+mAlTjCprz0xR32MGXPG64BjHyabd7l6B3apU97+tYwiXz
        mSqIyBbslYurq5cLfJjsPHmaZN8HMrRo04fqU/AjZ5BajlguUJ2KeRdArWZsE0aHR0mAkP
        Pi6nzLE31lLiefiBMvTsxXWXUCP9LRmrOQKUr3cI7GYqIymR7nxHk3qNuH0/m/EBZMQLVL
        BKIZnkatADF2jrrLQc/SR7e3zaq6TrTLnKIHhj7oR4X75CgOMr8nYkPTxTQfig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601236557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Szpo4w21IZpnZ2qNo/StcyttmD30FJG0p2SEFkzckEw=;
        b=hQipufzVgYN5zHNuw/3AMXPcPwQ+oAh6LO3fEWIxVqz/OV1pQs8Yke5E+yjMKMPjTBiu2G
        6/axQwvbfsGZZ9Ag==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] timers/urgent for 5.9-rc7
In-Reply-To: <CAHk-=wgdcYgqGvS76ohR4SsgooahOWVc0Z9LRPP61wcGoHx4Pw@mail.gmail.com>
References: <160121922194.23623.5568205948074131939.tglx@nanos> <CAHk-=wgdcYgqGvS76ohR4SsgooahOWVc0Z9LRPP61wcGoHx4Pw@mail.gmail.com>
Date:   Sun, 27 Sep 2020 21:55:57 +0200
Message-ID: <87mu1bkn8y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27 2020 at 12:17, Linus Torvalds wrote:
> On Sun, Sep 27, 2020 at 8:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> please pull the latest timers/urgent branch from:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-09-27
>
> Hmm. I got this (and the x86) pull request twice.
>
> Is it just because the subject line was messed up the first time, or
> did you perhaps mean to send something else?

Nah, it was just the subject line because I was too stupid to get it
right the first time.

Thanks,

        tglx
