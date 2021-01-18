Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789572FAA98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437776AbhARTvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437685AbhARTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:50:52 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:50:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m25so25700927lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qDR+mNGZHllf39DntlHuJJnHsB5tX1uvHhXHEZIhQA=;
        b=Rdr46bIUXsoawCt25vB8KAGaHjTWAFKJc0wXof9osCdXYkfMa0TmiIwWIenn62Fgue
         tXkr+lbAvxMPSDLszQinnilCAd1RhChd6ThjxZP9aI4Dl+2crq7L0RjkwOJwNbjcLfVF
         oi1Q5ffw3QZSPdkupM5eGyDA6iGtnDJHR6Xac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qDR+mNGZHllf39DntlHuJJnHsB5tX1uvHhXHEZIhQA=;
        b=hYvdekWPEnr/FAXcTEVhROCP3I066/vO9UQxMMF+usmkkk4E1kouVZyqq/TaRgnq/s
         oiWz0XMgMz1Z158+zk2YSUN+NBZp5Nkkq8VBCOHQBdWEqsqCiik1RFYez2sFc8yw4VD5
         mkJmUGMy0M6QZKjGYHo9noGXuPD8LUEacFRvN4C//ROSAHBMTtZ7D7m/An7DBecRqR4K
         5qRC9VMWsrKPM6xEf+sFy7YgqPdf3OEvtfQ1aP2/oovIGtrtPMzzHf/qXxHDna7Qh5/5
         VmssEMppuba7ho+p0HXU6yKYYgtjJo2jqHb2qEBW8D6sjy+FTRM6OQ7m57ybRzmH7L8f
         UqNA==
X-Gm-Message-State: AOAM533NW7PKM172pQZtD2srtoiyfc6s2L14O12LS79b3vlaUElhv76B
        0IOS+f+1nJ/C5XyU/5BzrKy0VKVvB0faxQ==
X-Google-Smtp-Source: ABdhPJxIXufAKs8i9K74UgxCQtyenCYDdFXjjoY5WtjH0IjYaACJWxBB7uDVPtIXNxLTWz+HsWNl5g==
X-Received: by 2002:a19:8213:: with SMTP id e19mr299230lfd.600.1610999410333;
        Mon, 18 Jan 2021 11:50:10 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 29sm2003673lfr.304.2021.01.18.11.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:50:09 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id n11so19478377lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:50:09 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr470697ljj.465.1610999409083;
 Mon, 18 Jan 2021 11:50:09 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com> <20210118194545.GB736435@zeniv-ca>
In-Reply-To: <20210118194545.GB736435@zeniv-ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jan 2021 11:49:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+PF2J7PWRWdQR5nUAxGN4GDMezcxddWi6Aufw71+_Pw@mail.gmail.com>
Message-ID: <CAHk-=wi+PF2J7PWRWdQR5nUAxGN4GDMezcxddWi6Aufw71+_Pw@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:45 AM Al Viro <viro@zeniv-ca> wrote:
>
> do_splice_direct() does something that do_splice() won't - it
> handles non-pipe to non-pipe case.  Which is how sendfile(2) is
> normally used, of course.

Yeah, I agree, it's better if we do the pipe case specially, but if
it's too painful for a stable backport I'll certainly take the
one-liner..

Btw, your email setup is broken. Your emails now have a "From:" line like this:

    From: Al Viro <viro@zeniv-ca>

and that is not a valid email address.

              Linus
