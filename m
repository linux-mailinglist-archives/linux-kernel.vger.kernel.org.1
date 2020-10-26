Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD2D2998B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbgJZV1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:27:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33524 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732807AbgJZV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:27:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id x7so5132512ota.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7iBjVOiLEiQoedNWLzG0TU122Ys5J9UkVQlTCn6OG0=;
        b=Pqd4GnvUr+B2JvTVqwqbFlWxMLV2LObPZ4c+MTIC+SwRJ/9jzzMrC6VJQ/bDupFQQ6
         r9dygtM+n/axiWu3QjlRPIovSioa/dAxTF6owNTM5H8/hgaHUj+Jc7rVZCaG2LyrJr85
         3WHM6VKZNrIEXAfAkDFutw4STcy+HGSIWr5DtX+B5c14HjHtQMsmJYBZOsMDp6mgZnNx
         sci8SyUdyJVP9gw7jp8JBhqFa0v7YMtxMqX8GoQ7rvfyDuo5FmF3UBJTH40xYCLNgR9+
         7X05mSDI7LPiMMdhftnK42AARU4EpUqHN1xA52KS9Wv0LZESebQAZco1QJbmjhq6w1zn
         9rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7iBjVOiLEiQoedNWLzG0TU122Ys5J9UkVQlTCn6OG0=;
        b=evSJOTlUVegCeKMKQRr2pZv/JvpeaRxoo4D2xHgMaGCNLIhqwCo5i0meeYdljXJxOU
         Bqc/DPugorPuf2mF87LKcK1mS/iEiNLD4iLIqqQ8D3fU7JOigdSj37B4E43T3+cGVlFh
         2youlVKF9yDrCCZv7puzrw0RrgTCXUVQIM8hG3M6lzp4vP3hBJd0J+4eOOsE6vslYHVs
         cclwIJqu5Q5kkUSdRlMwkF7qyqLjyfhVJeGdOP1zuR4A+SPIGd8+ZwcJgixG6d2GovJf
         k2FUZutZPhzshZoj1BTam0ZLVBQhp7wVDcataJqb6J+/rwpokUSsspqMyg6rI7TjGhT2
         KToA==
X-Gm-Message-State: AOAM531CVwa1uHkgVEmjU/8W/8ZmtfgkoqUcOnrxcwkkIDbD4tUPdw1F
        xg0DOMbPKBQXIWWbo2C8VbA=
X-Google-Smtp-Source: ABdhPJz1vN6K9yTkkjKQPr0ZAPtg/mJJjnFmssNQCA+3zVoPVwLMAmGnsLsqjBFQWgQ6U3A3+AULrg==
X-Received: by 2002:a9d:71dc:: with SMTP id z28mr12227830otj.249.1603747659773;
        Mon, 26 Oct 2020 14:27:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r8sm4298695otq.43.2020.10.26.14.27.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 14:27:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Oct 2020 14:27:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
Message-ID: <20201026212737.GA113829@roeck-us.net>
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
 <20201026194127.GA106214@roeck-us.net>
 <CAHk-=whjhHuwANGerJLJyn7jXCfMQMiaBAW+o2r_T+n=Ki+New@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjhHuwANGerJLJyn7jXCfMQMiaBAW+o2r_T+n=Ki+New@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:33:48PM -0700, Linus Torvalds wrote:
> On Mon, Oct 26, 2020 at 12:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > make ARCH=um SUBARCH=x86_64 defconfig:
> >
> > Building um:defconfig ... failed
> > --------------
> > Error log:
> > arch/um/kernel/skas/clone.c:24:16: error: expected declaration specifiers or '...' before string constant
> > arch/x86/um/stub_segv.c:11:16: error: expected declaration specifiers or '...' before string constant
> 
> Weird. Is __section() not defined somehow for those files?
> 
> It does look like they have very minimal headers, so undoing that
> patch just for those two files is likely the right thing to do.
> 
> > As with s390, reverting this patch fixes the problem.
> 
> s390 should be fixed already.
> 
> Is the attached minimal patch sufficient for um to get back to working
> order, or is there something else hiding there too?
> 
That works for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
