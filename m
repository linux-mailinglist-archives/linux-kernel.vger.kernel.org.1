Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15D2D33BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgLHUYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgLHUY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:24:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6442823B1A;
        Tue,  8 Dec 2020 20:00:09 +0000 (UTC)
Date:   Tue, 8 Dec 2020 15:00:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "J. Avila" <elavila@google.com>
Cc:     William Mcvicker <willmcvicker@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Mentz <danielmentz@google.com>
Subject: Re: Potential Issue in Tracing Ring Buffer
Message-ID: <20201208150007.2a0176af@gandalf.local.home>
In-Reply-To: <CAGFReeOOBoWqq-Ksdg6c7phS6KgpnK5em_PNKgnUX844fYsoEg@mail.gmail.com>
References: <20201124223917.795844-1-elavila@google.com>
        <X79CrSX1rnpnbqPd@kroah.com>
        <20201126132613.7f737afe@oasis.local.home>
        <20201130094846.6b8bc60b@gandalf.local.home>
        <20201130181350.GA1116146@google.com>
        <CAGFReeOOBoWqq-Ksdg6c7phS6KgpnK5em_PNKgnUX844fYsoEg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 11:37:13 -0800
"J. Avila" <elavila@google.com> wrote:

> Hello Steven,
> 
> Thank you once again for all of your support. We saw that you also recently
> merged a change[1] which adds some validation for the timestamps in
> ring_buffer.c. Would you have any recommendations on how to add a more
> lightweight check for time going "backwards" in the timestamps? The idea
> is that we could use this quick test to detect the problem, then run a build
> with your config to dig deeper.

I'm looking at adding a user space kernel selftest to make sure the buffer
never goes backwards[1] (note the code has changed since that posting). You
can see the stand alone code here[2]. But requires downloading and
installing libtraceevent[3] and libtracefs[4].

-- Steve


[1] https://lore.kernel.org/r/20201201160656.7cc6a5e8@gandalf.local.home
[2] http://rostedt.org/code/test-ring-buffer/
[3] https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
[4] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
