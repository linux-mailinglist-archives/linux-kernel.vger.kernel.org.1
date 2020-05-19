Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373E81DA155
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgESTvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgESTvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:51:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C4C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:51:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so561366lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urLKtiiyrLVz8Ua4Fxzp8gGt/IvKEX1hFAF1IYUDico=;
        b=U9h2cOUfOcfJrmhfbliK4JirnazbKNYMzDRB/ZRGlHR7Yh6nIhGQI69ANWowb2U+g2
         Mpk40uzi9qLJoeLmuKCQ+5dv42asrotkhs4Ul6pmhIbM75+uMOL2vEBtyP3FY/c7uCib
         /JkLYrJpflPBP/kfV+D+LiQybPenDK9OGwd4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urLKtiiyrLVz8Ua4Fxzp8gGt/IvKEX1hFAF1IYUDico=;
        b=fwX9Ais7PE1toHViK0hlbN/mH/9xaztsiLLnNmchd4LoJdAP+xmVab9wo+DujHiXhc
         HYsf3E7RDArvgdJiRoDS5av18LbdCpn0WeZH10EluoXDFd0tbARiPZ25F2VyzBNfbSJl
         hyMeKBPWIXcbKrYcJX6hhnd8HfE4MtKs5bqwOkcAXWQ2n0AAcHdAJz2zZU/AFHwqduyJ
         ZQtlsNuQhZqNzWOte2wRgXuy+RPHg5Jw0K1VGRfe8W8v3PtlOJ7xBo951qpy5OLnlJnP
         JY+i8cJa+UczXAGlOch79skKF9KHAd7l2Ek+/pW7c+PS4Xf84a5s14dXDRxbKboVBHC1
         iYTw==
X-Gm-Message-State: AOAM532U8sHULYzk2hRdPYj/Y2/MeqYFe0BdPAodgKWrnyA8E99qHN74
        n0ftEMQvvvD81/7+3oRaZvU44ZuWAhg=
X-Google-Smtp-Source: ABdhPJxz/ho1FGNS6++oWaBc7i9ih9e/SGAA8eH13R99fxb/9NKfhA6W0SJjAq5cwgWUscfSrGD/Ug==
X-Received: by 2002:ac2:4c95:: with SMTP id d21mr345991lfl.22.1589917911388;
        Tue, 19 May 2020 12:51:51 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id d3sm206502lfq.2.2020.05.19.12.51.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 12:51:50 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id r125so532910lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:51:50 -0700 (PDT)
X-Received: by 2002:ac2:504e:: with SMTP id a14mr352992lfm.30.1589917909684;
 Tue, 19 May 2020 12:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190718131834.GA22211@redhat.com> <20200127122817.GA10957@redhat.com>
 <20200519172506.GA317395@hirez.programming.kicks-ass.net> <CAHk-=wjjxDY6XzKKPEE1S+AUXycmo8XNpX2C-jO4fS+qU8ObpA@mail.gmail.com>
 <20200519191156.GA325280@hirez.programming.kicks-ass.net>
In-Reply-To: <20200519191156.GA325280@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 12:51:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4VYrwMKobaxe=HGhPzupLVOjv9ubi=gWjsdvH5e1qLg@mail.gmail.com>
Message-ID: <CAHk-=wg4VYrwMKobaxe=HGhPzupLVOjv9ubi=gWjsdvH5e1qLg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:12 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> My compiler doesn't like overriding a __weak with a static inline. It
> complains about redefinitions.
>
> It works with extern inline though; but that is fairly rare in the
> kernel. Still it compiles and generates the right code.

That's a tiny bit worrisome, because the compiler might just decide
not to inline at all and then you end up with the (relatively bad)
version that doesn't take advantage of the hardware capabilities. But
things will work, and not be absolutely horrid, I guess.

And you do use "always_inline" so I guess it's all fine.

For added protection, you might also mark the asm itself as
"asm_inline", which makes sure gcc thinks it's a small asm too.

Regardless, ack from me, with just a note on that small worry.

                 Linus
