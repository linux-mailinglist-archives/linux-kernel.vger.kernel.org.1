Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAC294D17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442699AbgJUMzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441063AbgJUMzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:55:47 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E182222E9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603284946;
        bh=2ota0tuSECP/POEB9s7yw5RlmTdDGLvF9Qw/hydbkIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fomtG/vA94iAz6gal8vl+5Y6sJD3c/0eOtMKQ03pimhpKbL4YaNRRUqSVX37Bb2e8
         La2pS4HHrWuu2mr0fPA7d7u30i/9RS3NU3NtAhG58uMS5bjE/DhbImZTJZPXDTvMWQ
         tjaq1VJP4fN3AxvcWa/5gGBP5ZRIl+VDxN3NXbOs=
Received: by mail-qt1-f173.google.com with SMTP id m9so1915326qth.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:55:46 -0700 (PDT)
X-Gm-Message-State: AOAM531/12q3dEWg0ZI8Xm5i6KRlTbkAYFak0pgQ1smeIXIjVdapA5Fw
        TR/L8Vo99oSJJnaLTp5uJXRkn4jB7dZUMlqB0Pk=
X-Google-Smtp-Source: ABdhPJzCfz0Fe73QJEi4Maut0n+4vGAmpoVRE8bEWwXuF87kXP1H6zN2f/VKK2rHH/cn7OdDIo2Q8wcq3XcdqCX6PKg=
X-Received: by 2002:ac8:1ba6:: with SMTP id z35mr2880105qtj.204.1603284945616;
 Wed, 21 Oct 2020 05:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
 <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
 <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com> <20201021124542.GL1551@shell.armlinux.org.uk>
In-Reply-To: <20201021124542.GL1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Oct 2020 14:55:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a12DXAP6NhHxf9Fr9pxJ-yjE5L7KsAMNEtSJ01xR6asXw@mail.gmail.com>
Message-ID: <CAK8P3a12DXAP6NhHxf9Fr9pxJ-yjE5L7KsAMNEtSJ01xR6asXw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Maninder Singh <maninder1.s@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>, v.narang@samsung.com,
        a.sahrawat@samsung.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 2:45 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Wed, Oct 21, 2020 at 02:42:48PM +0200, Arnd Bergmann wrote:
> > >
> > > - define 'current' as 'this_cpu_read_stable(current_task);'
> > > - convert to CONFIG_THREAD_INFO_IN_TASK
>
> That means we need to also code that up in assembly - remember, we
> need to access thread_info from assembly code.

Are there any obvious places that need patching aside from
.macro get_thread_info? I did expect the above conversion to
be somewhat more complicated than Maninder's original patch,
but that part seems easy enough.

       Arnd
