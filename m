Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD21B838C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 06:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgDYEFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 00:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDYEFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 00:05:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7882EC09B04A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 21:05:04 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i27so16255783ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ky0eyr9lLThTQVUeFvCBClSKtV93JYH6d8kHWt9AbY=;
        b=xsmyrmaPpckFzclp7L+uXkwIuEQPI0AkgTZpagovbHJzVpyzvl7xsdYmVYyYlEd4cE
         AjiV8KyC6Ha79JNisdzpuGRwzhZDpJXvfgeFJuewUZPJkxFcXxCnpGtwPjwdxZGk/71c
         MhbiUOkwdbLhYOuWso0i8s+l+VBZ14EpWPC0/99g+6smIEjGvGvR8os79N2J+lzBtGbR
         s3WnThEwyPG/GrvoUiJvodTdyImCxcINnatR+Ccr/k0wy7rU+6t5f/3q5oiOM8dhPEt4
         OvMoxj3DtqdxI5smzsaTPVQ34HTBrcqo0Qud1AjDjgTzOBI3qqofJIk5n977BDQ7JWP7
         Ve9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ky0eyr9lLThTQVUeFvCBClSKtV93JYH6d8kHWt9AbY=;
        b=HIzjij+0pP4mDmeTE9KAaD7rxWseYg5Ek1J5lyRv23pe/yy7g2BCFg/pPvaAJ1tWl0
         mHOAaQMpq74WhiRijAg2kiX6fXl1iaKQ/ncb8Hfv96Jqb9CT8VkZ/pBKQZ3OGrYFwflw
         Oq7K+g8Zd+QglBHSog1A3/su1l9//bpItwbwHG9HtPGe/2cbonEyGNlz5KOZNRqi1iCJ
         VZx2+ZXcBZCjrTEGdUlSAApz7omSU41Uid0ltFKNQtDoUKnWkhFZ23IZ9V4B12PiDz4z
         35VRkfvx2iLOkf5VP7Kdj2bn9bqLd5leGfotAjh1sRz+3kM6k3vNTzXJbsXNdmy+h2CE
         yxnA==
X-Gm-Message-State: AGi0PuZjFq/zmqyNCMxQHIUVioJ5eQcjhRDnnkfUVS4gAqstpemCt3Ew
        M3ibjwKSMnT0SqibYrAL+/lHTQChWs75c17pUlqiGA==
X-Google-Smtp-Source: APiQypJRrNuc6s4TK5Hy1LsXQFO4dVFdba3u8LGcLKEkJWGWHwnmvoiMEq4flU4dqofCtu9E0FvesLWDRf2qIs8Ff5g=
X-Received: by 2002:aca:c311:: with SMTP id t17mr9055910oif.169.1587787503419;
 Fri, 24 Apr 2020 21:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200423220056.29450-1-john.stultz@linaro.org> <jhj1rodyeu1.mognet@arm.com>
In-Reply-To: <jhj1rodyeu1.mognet@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 24 Apr 2020 21:04:50 -0700
Message-ID: <CALAqxLW+CBMxj_5gCF5yLcX8dhM7Fg6oOL-zot0ZZT6PW6R04g@mail.gmail.com>
Subject: Re: [RFC][PATCH] serial: amba-pl011: Make sure we initialize the
 port.lock spinlock
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 4:14 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
> On 23/04/20 23:00, John Stultz wrote:
> > Which seems to be due to the fact that after allocating the uap
> > structure, the pl011 code doesn't initialize the spinlock.
> >
> > This patch fixes it by initializing the spinlock and the warning
> > has gone away.
> >
>
> Thanks for having a look. It does seem like the reasonable thing to do, and
> I no longer get the warning on h960.
>
> That said, I got more curious as this doesn't show up on my Juno (same
> Image). Digging into it I see that uart_add_one_port() has a call to
> uart_port_spin_lock_init() a few lines before uart_configure_port() (in
> which the above warning gets triggered). That thing says:
>
>  * Ensure that the serial console lock is initialised early.
>  * If this port is a console, then the spinlock is already initialised.
>
> Which requires me to ask: are we doing the right thing here?

So I got a little bit of time to look at this before I got pulled off
to other things (and now its Friday night, so I figured I'd reply
before I forget it on Monday).

I did check and lockdep is tripping when we add ttyAMA6 which is the
serial console on the board. I wasn't able to trace back to why we
hadn't already called spin_lock_init() in the console code, but it
seems we haven't.

Also I checked on HiKey as well, and there I'm seeing the same lockdep
splat and this fix seems to resolve it. So more digging is needed. If
anyone has a better idea of what might be awry or if the lock does
need to be initialized in the driver (it's a bit inconsistent, I see
some drivers do but others don't), let me know.

thanks
-john
