Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FD42C4BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgKZARJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgKZARI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:17:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE203C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:17:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606349826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRee7ll7KL6Y4DD/n1bdCOEAovuU1E0tGnx+A6EI3Pw=;
        b=vfBqNW2u/IvtxuxVsmye5AjJgZNJC2jSI0uKf88S7ofHdGGmHfGYx8GAuJwYKMs3B3qFj5
        8UkOXWa4b/2EqTTLkNeC9XGOFCUpYik75TA0zmzmns3hwcRrVvq8YTNfI8tvuPUIoBtxRz
        a8x4QHtxK+uqR4xSijQMtQIOEUdDME0uPSWAOzg+3rM691f5GfyyGCsNigHARFUX55x8eS
        lzZlVkGyK25qa6ti1BUiI/SI8HP+YIuDraKMopiymNh0KKlAQ1bTa8nAWynwO30NywYKVy
        ummwkOK3zpw5OP+x2ZKPx1ileD8x4raKgADMnm69fs2c80jBiIFAdCEIyBfMVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606349826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRee7ll7KL6Y4DD/n1bdCOEAovuU1E0tGnx+A6EI3Pw=;
        b=8Kke/KJDWqu2BJlQDwHqGm1Pl/Nt1DQhMt0G5K/s+qTeP0febMOlO/8NYixPGLRjkgfiol
        mvVdOm7k24nvA1BA==
To:     Carlos O'Donell <carlos@redhat.com>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr =?utf-8?B?xaBwYcSNZWs=?= <petr.spacek@nic.cz>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME support plans in Linux time namespaces
In-Reply-To: <5c382ef4-c505-5629-a85c-abae67c05c7c@redhat.com>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan> <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com> <87sg9vn40t.fsf@nanos.tec.linutronix.de> <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com> <87h7qbmqc3.fsf@nanos.tec.linutronix.de> <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com> <87k0v7kwdc.fsf@nanos.tec.linutronix.de> <7a4d7b14-1f0b-4c40-2bd1-2582d8b71868@redhat.com> <87y2jej8mp.fsf@nanos.tec.linutronix.de> <d88ede3f-5f50-24a2-5009-6418f3cfaf4c@redhat.com> <87wnygopen.fsf@nanos.tec.linutronix.de> <5c382ef4-c505-5629-a85c-abae67c05c7c@redhat.com>
Date:   Thu, 26 Nov 2020 01:17:06 +0100
Message-ID: <87pn41j7jx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos, Petr,

On Wed, Nov 25 2020 at 15:37, Carlos O'Donell wrote:
> On 11/19/20 7:14 PM, Thomas Gleixner wrote:
>> So from my point of view asking for distorted time still _is_ a request
>> for ponies.
>
> I'm happy if you say it's more work than the value it provides.

Thinking more about it. Would a facility which provides:

         CLOCK_FAKE_MONOTONIC|BOOTTIME|REALTIME

where you can go wild on setting time to whatever you want solve
your problem?

Thanks,

        tglx
