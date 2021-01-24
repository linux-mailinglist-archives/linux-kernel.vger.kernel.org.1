Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BE5301E63
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbhAXTMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbhAXTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:12:43 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F2C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:12:02 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f19so3759082ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FltnDaP1pdLMy/1AZ3KJGldh9meikMJul70ITsQ9PE4=;
        b=SXfAEW8IG1zIJa+dlVIzgQua/nwASjCYnb7c0+PMlq+vPnBsfKK+advbV4kvPJEZEt
         ljjkZyST4J0mTxwaMlY64N0JlN5ByOuaN72tSzjiGw3JgfvaJht7VCF2/b28++Nr1nRS
         4LmcOqC4k3a35+JFGPHxfIBLXINdQTPAqto5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FltnDaP1pdLMy/1AZ3KJGldh9meikMJul70ITsQ9PE4=;
        b=EHwJAp1/G19VhoQ8egOOLZmHH36sz0l+k22dSubU+PjA5X+uZAMUfDJULqS1HfIsZ6
         NWmTTPZUAwzQ1hTu889ltZA1oNsP5ATNQvxzP+ObMJYblKHp91LBi1ParX6SDAYmfsXj
         rh06fkBDpRfe5PYwxpdqDLkZykqeoCORQO7d5/mwZnnkZ74NlLML6KotJdP2hWIaBObb
         lqeeGILUiX2VC8WcNxaFF0ecgOxqaXj6CgOk1Y1OX5jlvhgf7QgFe37HPiEXCAODEogK
         KSjFBcF3ICTExi+Vj2QtCtwta1prEQI9DzsJJFJTdSg1a2dzHbORnvGODYk6O6XthmEm
         kvjw==
X-Gm-Message-State: AOAM5320bYVxiVjyt82HhP8kbDO2MqXh7YgSZq9ldW9n/bUD7DqYp9h3
        1lhXArvLaDQYUCCxiko5JgoJA8TsCkxTFA==
X-Google-Smtp-Source: ABdhPJwDw1SgqM+yUwm1D2YkfrYa5kT+0k4857oRwaF+FQsWLow2DmWK9f0bx9CNjQpjXvVJNyZqSQ==
X-Received: by 2002:a2e:9c93:: with SMTP id x19mr510525lji.351.1611515520617;
        Sun, 24 Jan 2021 11:12:00 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v24sm464805ljj.14.2021.01.24.11.11.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 11:11:59 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id h7so14683519lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:11:59 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr94038lfc.421.1611515518744;
 Sun, 24 Jan 2021 11:11:58 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com> <20210118194545.GB736435@zeniv-ca>
In-Reply-To: <20210118194545.GB736435@zeniv-ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Jan 2021 11:11:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
Message-ID: <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
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

Al,
 coming back to this because rc5 is imminent..

On Mon, Jan 18, 2021 at 11:45 AM Al Viro <viro@zeniv-ca> wrote:
>
> do_splice_direct() does something that do_splice() won't - it
> handles non-pipe to non-pipe case.  Which is how sendfile(2) is
> normally used, of course.
>
> I'll look into that in more details, but IMO bothering with
> internal pipe is just plain wrong for those cases.

You clearly thought about this, with the emails about odd error cases,
but I get the feeling that for fixing the current "you can't
sendfile() to a pipe" regression (including stable) we should do the
one-liner. No?

I agree that it would be better fixed by just having sendfile()
basically turn into splice() for the pipe target case, but I haven't
seen any patches from you, so I assume it wasn't 100% trivial.

Hmm?

              Linus
