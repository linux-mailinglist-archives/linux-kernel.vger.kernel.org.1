Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358CF2CDF3A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgLCT55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgLCT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:57:57 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4225C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:57:16 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id t22so3953531ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OX2SMwG51HvUvi+B+PocF0hk7d7exgcj6lP8+rKrjjs=;
        b=FFyRD27Mubz6B1RzFoK/vfuBNBlicnF5AqVaBzfkspFWarDQXm1G48GRCwRJ5WnVFV
         ceCpLDkx5GiSh/lBWd0aN71pqGdEd7ruda+cx2S/bbW0fAoDoycU7rYrYMDw5Vk5NUA4
         NoxUJal2d/tWgsWLVeLqj1vvs0QHd2cAQvDmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OX2SMwG51HvUvi+B+PocF0hk7d7exgcj6lP8+rKrjjs=;
        b=QhRkjV582ra3O0kWphVX75WsI2VOgZQYqabQSf8q0dBRIhjfvVhm5T3wHlG80T9ioa
         2keQvRi6udaYFjjottkAzPmdo7Zf2Sh6ZZ/bhbzTJYSUWwxBAWKdKGDBPNLJFFckw+Sd
         7X9ERdbw0mXpYXOi13tk3ORzV55BQCIBVuD8fVALdfHTnl5TtShmF3imA4h3SVCcy7k5
         /leoMXOzjpsUVigJ0HFbdOJMrwEJmyvpN6UDKn9phkIzXxE7RqkKHMqQofFuJRVevRc9
         WQJTDxTzR31wm44N+G0jtbkInMujSr/RA+A+lAf8MkXYkErJBzjMmJEat8PoCsgcrOlT
         bNxg==
X-Gm-Message-State: AOAM530OptvWkRaYGkwi07vQ3pcYgS7tFCORQ67+fYG0BKjth1kNaLnF
        K43y7YFroBDGKI0FTF5JjsXqIWhxIiZI6g==
X-Google-Smtp-Source: ABdhPJy0mOPY4dnGyXOFpiG2uBI7b6KEN5BJ7cLM8GwZAopdHl0nnbJ13Pb5geKi+34XneO+cxNzmg==
X-Received: by 2002:a2e:b4a9:: with SMTP id q9mr1958808ljm.140.1607025434680;
        Thu, 03 Dec 2020 11:57:14 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f2sm747679ljc.118.2020.12.03.11.57.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 11:57:13 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id q8so3881715ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:57:13 -0800 (PST)
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr1977070ljp.285.1607025433176;
 Thu, 03 Dec 2020 11:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20201203103315.GA3298@nautica>
In-Reply-To: <20201203103315.GA3298@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 11:56:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigRSokT5YLRGH5Jyun1CwgYHR_1RMcoHjUyz7NJ8wG_g@mail.gmail.com>
Message-ID: <CAHk-=wigRSokT5YLRGH5Jyun1CwgYHR_1RMcoHjUyz7NJ8wG_g@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.10-rc7 (restore splice ops)
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Netdev <netdev@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:33 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
>
> Hi Linus,
>
> Someone just reported splice got disabled in 5.10-rc1, here's a couple
> of patches to turn it back on using generic helpers.

Pulled.

> (Thanks for letting me know my mails got flagged as spam last time, I've
> taken the time to setup dkim/dmarc which brings its share of problems
> with some mailing lists but hopefully will help here)

It looks good here, but I would suggest you edit your DKIM configuration a bit.

In particular, you have "List-ID" in your set of header files that
DKIM hashes, and that means that any mailing list that then adds that
header will destroy your DKIM hash.

So you seem to make it almost intentionally hard for your DKIM to be
valid when you send emails to a list.

I'd suggest you keep the DKIM hash to just the basic fields that your
MUA will fill in, ie things like

  Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID

because if somebody messes with *those*, then I think they are doing
something wrong - in ways that adding a "List-ID" as it goes through a
mailing list is not.

(But I'm not a DKIM expert, just a spam hater).

              Linus
