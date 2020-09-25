Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44618279466
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgIYWzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:55:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58988 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIYWzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:55:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601074512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Obvuz1/Dj7IREACiXdEW9/bPBhlEoJrZlnsY+GA+QsE=;
        b=NHJmHf2F/2L+Lr06oq/aLPShHvQK+jsH5M+NtrE12xin+1ngh9rlfeupCo+0jj8oCTyWCP
        5NMK4H5Mf+WmZ3h5Qa/dBmI94v1M2w6r42T2M8x6A8wUIxT2flHjLBQRs3++5zVhvsuobD
        /1ZZgVuVuPEC5pIDGit+u34uO2FjPerJItpKi4jGUXHa2Xb+4LogMX6HXgap0kI/tAaFf/
        RX5b3Kb8Zb2/rE/75waUuraQ043sIOiTdYjXCy9yL5s+1l7Dm2HLLXozLcTSblCb39lbwY
        aKgbgr6VDEPR3K15HA2SVpAQEbtVx49RWQ5743MDh5OESq6d8V+YreRECvHbAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601074512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Obvuz1/Dj7IREACiXdEW9/bPBhlEoJrZlnsY+GA+QsE=;
        b=GqqH+xCtqvI1RVBMFcKVd4BciFBBInhDnD4zDgQ9tTa5NKS4jdtef+X2Hn+2KsL2XWdRFm
        VP8vIAmfY9qgW5CA==
To:     Adam Borowski <kilobyte@angband.pl>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>, rostedt@goodmis.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in hotplug path
In-Reply-To: <20200925141657.GA6325@angband.pl>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org> <1600906112-126722-2-git-send-email-psodagud@codeaurora.org> <20200924063352.GB592892@kroah.com> <87wo0j6nos.fsf@nanos.tec.linutronix.de> <20200925092754.GA2508526@kroah.com> <20200925141657.GA6325@angband.pl>
Date:   Sat, 26 Sep 2020 00:55:12 +0200
Message-ID: <871ripv54f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25 2020 at 16:16, Adam Borowski wrote:
> On Fri, Sep 25, 2020 at 11:27:54AM +0200, Greg KH wrote:
>> On Thu, Sep 24, 2020 at 08:21:07PM +0200, Thomas Gleixner wrote:
>> > On Thu, Sep 24 2020 at 08:33, Greg KH wrote:
>> > > On Wed, Sep 23, 2020 at 05:08:32PM -0700, Prasad Sodagudi wrote:
>> > >> +config CONSOLE_FLUSH_ON_HOTPLUG
>> > >> +	bool "Enable console flush configurable in hot plug code path"
>
>> > CPU hotplug is not meant to be a high speed operation and if people
>> > think they need it to be fast then its pretty much guaranteed that they
>> > want it for the completely wrong reasons.
>>=20
>> Odds are, it's the big/little systems that are trying to use cpu hotplug
>> for this type of thing :(
>
> Just a bit of info:
> My MT6797X (10 core: 4=C3=97A53 + 4=C3=97A53 + 2=C3=97A72), flickers its =
cores this way:
> the right-hand piece is CPUs, one character per core: bars show utilizati=
on,
> "o" stands for offline; every line is 0.1 second interval.
>
> topline -i 0.1
> mmcblk(=E2=A0=80) (oooo=E2=96=84=E2=96=86oo=E2=96=85o)
> mmcblk(=E2=A0=80) (oooo=E2=96=85=E2=96=84oooo)

...

> So it's on the order of a few ons/offs per second.
>
> The offline CPUs are "present" and "offline"; not sure if this means hotp=
lug
> or not (I'd expect dropping from "present" to "possible", but I don't know
> these parts).

Yes, they are (ab)using CPU hotplug instead of utilizing the fine
grained hotplug state control and fix up the few odds and ends which
keeps the CPU from staying in deep idle forever.

Tinkering is way simpler than proper engineering.

Thanks,

        tglx
