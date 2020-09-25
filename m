Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B799E279471
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgIYW7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:59:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59064 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgIYW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:59:54 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601074792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vssvkRTPmBq0TEWs5UmZrYu34ljdxxWXgeuqetaowvw=;
        b=dv0bGpe72nBqrLZBVZUXyuWUFzl3iVXi7i/kdZv4pQg1uhbRkVzmCv54Ih1Z9gY6paxKdN
        UqxmYSL9F9Yi7I8eR1ejXah+aB2vLKI6fx3JqYT5G6kEdXTTJJY/ObtoVfGuAR94+o58eG
        NkhXIhV5W6YfR9B7qH4zezqn/E+Q4xzD2KkKqbAmuJDnA4V2iLCHc27V6eWx436RelbnAE
        IqzBz5T6MrrXqsiqdflwo8Dj3otVvs+xtEW/U67WND9m1b44Ltjn0Ns1o7k6e+OpPwxZaY
        rekN3Lvu/Sys2HgF5vSL5HjZqbbrKr0v6iwiPDryMSYbXl7FF1bJaVidDUalzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601074792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vssvkRTPmBq0TEWs5UmZrYu34ljdxxWXgeuqetaowvw=;
        b=JEWQHJ0TvJlZgOIuoOQKq4um3UCNFED4AyrbLZxFU7TBLRapPLfOx+9jbHSJrXHr5zMCrR
        biui1xAyKh0aNUBg==
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 6/6] printk: reimplement log_cont using record extension
In-Reply-To: <f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com>
References: <20200914123354.832-1-john.ogness@linutronix.de> <20200914123354.832-7-john.ogness@linutronix.de> <CGME20200925190829eucas1p2f35866317389cd5e842e99b465632902@eucas1p2.samsung.com> <f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com>
Date:   Sat, 26 Sep 2020 01:05:51 +0206
Message-ID: <87v9g1bgyg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-25, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> This patch landed recently in linux-next as commit f5f022e53b87=20
> ("printk: reimplement log_cont using record extension"). I've noticed=20
> that it causes a regression on my test system (ARM 32bit Samsung Exynos=20
> 4412-based Trats2 board). The messages are printed correctly on the=20
> serial console during boot, but then when I run 'dmesg' command, the log=
=20
> is truncated.
>
> Here is are the last lines of the dmesg log after this patch:
>
> [=C2=A0=C2=A0=C2=A0 6.649018] Waiting 2 sec before mounting root device...
> [=C2=A0=C2=A0=C2=A0 6.766423] dwc2 12480000.hsotg: new device is high-spe=
ed
> [=C2=A0=C2=A0=C2=A0 6.845290] dwc2 12480000.hsotg: new device is high-spe=
ed
> [=C2=A0=C2=A0=C2=A0 6.914217] dwc2 12480000.hsotg: new address 51
> [=C2=A0=C2=A0=C2=A0 8.710351] RAMDISK: squashfs filesystem found at block=
 0
>
> The corresponding dmesg lines before applying this patch:
>
> [=C2=A0=C2=A0=C2=A0 8.864320] RAMDISK: squashfs filesystem found at block=
 0
> [=C2=A0=C2=A0=C2=A0 8.868410] RAMDISK: Loading 37692KiB [1 disk] into ram=
 disk... /
> [=C2=A0=C2=A0=C2=A0 9.071670] /
> [=C2=A0=C2=A0=C2=A0 9.262498] /
> [=C2=A0=C2=A0=C2=A0 9.540711] /
> [=C2=A0=C2=A0=C2=A0 9.818031] done.

Ah. One of the more creative printk users...
init/do_mounts_rd.c:rd_load_image(). This is a set of LOG_CONT messages
that try to display a rotating line, complete with '\b' control
characters. The code is totally broken, but that is no excuse for printk
to break. It should be easy to reproduce on any architecture. I will
investigate it further. Thanks for reporting.

John Ogness
