Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E62A07A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJ3OSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:18:10 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:52470 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgJ3OSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:18:09 -0400
X-Greylist: delayed 924 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2020 10:18:09 EDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4CN3sx748pzDTD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:02:45 -0400 (EDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4CN3sx0g0gz1f9f
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:02:45 -0400 (EDT)
Received: by mail-ej1-f46.google.com with SMTP id 7so8817516ejm.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:02:45 -0700 (PDT)
X-Gm-Message-State: AOAM531TOLUaX9vwHWw53k7zZnNiUXnu/ZtcarnWgLJZ4jLJnA4PcWgw
        md/KDQoP9P5pQgx8H23NmdqOpaWGh0m7NxNAqYU=
X-Google-Smtp-Source: ABdhPJw8J+4cOp1WFt2Gq3nyQkJW+64glQjsML0SG/NZY2/Qa+/sII201MUJIn8DpG9MrwQhAiHM0Dkna9wLvnU2q8M=
X-Received: by 2002:a17:906:2895:: with SMTP id o21mr2759315ejd.332.1604066564183;
 Fri, 30 Oct 2020 07:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan>
In-Reply-To: <20201030135816.GA1790@yuki.lan>
From:   Zack Weinberg <zackw@panix.com>
Date:   Fri, 30 Oct 2020 10:02:29 -0400
X-Gmail-Original-Message-ID: <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
Message-ID: <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 9:57 AM Cyril Hrubis <chrubis@suse.cz> wrote:
> > According to patch description [1] and time_namespaces documentation
> > [2] the CLOCK_REALTIME is not supported (for now?) to avoid complexity
> > and overhead in the kernel.
...
> > To be more specific - [if this were supported] it would be possible to modify time after time_t
> > 32 bit overflow (i.e. Y2038 bug) on the process running Y2038
> > regression tests on the host system (64 bit one). By using Linux time
> > namespaces the system time will not be affected in any way.
>
> And what's exactly wrong with moving the system time forward for a
> duration of the test?

Interference with other processes on the same computer?  Some of us
*do* like to run the glibc test suite on computers not entirely
devoted to glibc CI.

zw
