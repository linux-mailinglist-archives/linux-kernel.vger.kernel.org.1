Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C129427B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbgJTSwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgJTSwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:52:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D8C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:52:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id bf6so1503623plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aD0rsjChFgmBFrGRr+ZINPnxBO8DGrKJ4f6ys0irM0o=;
        b=CWl+kqbJkhlLH+jDxhcsjhggQnm7voiaf698QPDOV61snsAvl4WcpPrceM6JgFVQ9L
         WRXjMiV2RvKXIbuwCt2vOjGYO4jwbrg7GeIG+1u5CtL1f/edqH8wJth8Y1BZhiCEHmgF
         8AHDS5AT9TCUD2el9EA+Oqw5U25p02cueW0MUWJfCbE9Yv/ktlok7tsl3u9iZL5ZuYVW
         G8eaSCzcwDY4hMqESP4YVB5mZ1cus+LjE+F8q1X9znjWAWxkYQukHXbpc5mSTpVfc4qn
         IKOTRNYSbSBR/XYTwXkSZzv9v5Vrorzq6JXQP/n7P8cuqZ9sjWVfQPOloo2F2JoTHvcI
         sCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aD0rsjChFgmBFrGRr+ZINPnxBO8DGrKJ4f6ys0irM0o=;
        b=eilHEhRasa76I6JCREyGy+lrbc4eLveXovwAvaSNFD71995YDb83iAd7ZBGdM3sdRP
         0T0A7OhdPhtjWdRYWOYET0yag7qZrlTl8e3Ymr6nncYOv6rsueLHXOYP0cG9KwU1YZLe
         cEr2QeJriESPZeOexcMhaQDcPaMcTIPIy+BKFArbAR+i4qi6FtKbTXRjvpCmYs7SvUWH
         bmTnQXv8bFq8i5s82z3p4L9tBwfelRP9wTsOWcNNqndhXO67cST9B8vcZzrzEVQ5AHNp
         N28rlKfifz/2oUc5WCHB1Z6wqGluN/GUgBnMCI0CYOc7NEvLScrAySWW2+HZKddjnKjn
         eVSQ==
X-Gm-Message-State: AOAM533aNPckAwvLFnyO1QTSygKYyHgmheOp9ZuIKP9W3aQ+I1wekTqr
        +xyHggWo5YbqUgqwNQaVj/6QHaVnP969xOE8kVepaw==
X-Google-Smtp-Source: ABdhPJx7RODBw5W3V6O/H8e6kNCVew/gEWo6Kx/j9yk2iOZvoeB153fS2hJCMBh2H6fpIaCNY4tNVaku7n0u9tRsJ9w=
X-Received: by 2002:a17:902:8a8b:b029:d5:f871:92bd with SMTP id
 p11-20020a1709028a8bb02900d5f87192bdmr1316366plo.10.1603219920825; Tue, 20
 Oct 2020 11:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201017160928.12698-1-trix@redhat.com> <20201018054332.GB593954@kroah.com>
 <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com> <3bc5c2e3b3edc22a4d167ec807ecdaaf8dcda76d.camel@perches.com>
In-Reply-To: <3bc5c2e3b3edc22a4d167ec807ecdaaf8dcda76d.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Oct 2020 11:51:49 -0700
Message-ID: <CAKwvOdmhqq0DT5csX6W8xDF=nuXgJJ_Rtc2xf++=Q9uA4tZEvw@mail.gmail.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To:     Joe Perches <joe@perches.com>
Cc:     Tom Rix <trix@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        George Burgess <gbiv@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 11:42 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-10-19 at 12:42 -0700, Nick Desaulniers wrote:
> > We probably should add all 3 to W=2 builds (wrapped in cc-option).
> > I've filed https://github.com/ClangBuiltLinux/linux/issues/1180 to
> > follow up on.
>
> I suggest using W=1 as people that are doing cleanups
> generally use that and not W=123 or any other style.
>
> Every other use of W= is still quite noisy and these
> code warnings are relatively trivially to fix up.

The 0day bot folks have enabled W=1 recently; hence the uptick in
reports of -Wimplicit-function-declaration.

If it gets added to W=1, it's effectively "on by default" for new code
tested by 0day bot.
--
Thanks,
~Nick Desaulniers
