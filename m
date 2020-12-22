Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD59B2E0FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgLVWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgLVWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:02:20 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1559BC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:01:40 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o13so35476761lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWeDwihFxTAhPlT/W6WCEEMXK+OSXU/rLqIMA122Kog=;
        b=GjeV9Ro1lac75aJ1KhE1sLyHOPZXVUp/KPe4acgRmCwKMsU9DeFCk+XqwMBKtfrRVH
         FaezK4cxCAXlid5LxjkWJT0btYkMqhexFp2DXti9Vq/0oH/3FpIXcfV9VGJLdEjS/1XP
         BAPUt7f+o5dbn1daNL+Qkzu9xrbRHZq9ha5ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWeDwihFxTAhPlT/W6WCEEMXK+OSXU/rLqIMA122Kog=;
        b=KcvCdMAwwmoFR3FirxFYupI9jcyaU4QGMLcGl+a/F9lSZR4nqDf+dAiz5o07IlV2Q7
         uMV3g2ZTUFEhzos2hS2rJmTjC53WnFdZ3wUOHakmlcD4wsWb5VkjRx+JT11dkTQWKNqU
         WAfs8rfeEeWJt0fHqSzT0ya2wF325kgmM0iUYHi9RSGltIbMOfqr0t9WHS8Eti7QIxl2
         EeNNC4Rm8FSV9JIkwNeNbsO/ciyFWuXqqiILVKkamFEVlowldC1UP9QiTlE723T4xfUo
         gcTvNuzWtqC/YguWxc9HfLfKtLV4vE2+8Zr7ys2QChutBoSSROz4uaCJRZ3KrBw1X+Qw
         2FOA==
X-Gm-Message-State: AOAM531K9kECm0FLo6Eo1B7uqFF/Bvhbwp+9Cc+JUk45B5Hnrhwnb3Df
        2Y5VcckfVsofp/rnwuEY1qK4T440hupoqQ==
X-Google-Smtp-Source: ABdhPJwcvIXRWBNDaUzTyaXcWUooDGVLyTB0dQvIjXfClgtVLD1aUMNAeOKEjf9O9lPuxOT9d3tviA==
X-Received: by 2002:a19:8182:: with SMTP id c124mr9179926lfd.106.1608674498507;
        Tue, 22 Dec 2020 14:01:38 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id g2sm2825598lfb.255.2020.12.22.14.01.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 14:01:38 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id m12so35469668lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:01:38 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr10182715ljy.61.1608674497556;
 Tue, 22 Dec 2020 14:01:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000fcbe0705b70e9bd9@google.com>
In-Reply-To: <000000000000fcbe0705b70e9bd9@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Dec 2020 14:01:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com>
Message-ID: <CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com>
Subject: Re: kernel BUG at lib/string.c:LINE! (6)
To:     syzbot <syzbot+e86f7c428c8c50db65b4@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, coreteam@netfilter.org,
        David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jakub Jelinek <jakub@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 6:44 AM syzbot
<syzbot+e86f7c428c8c50db65b4@syzkaller.appspotmail.com> wrote:
>
> The issue was bisected to:
>
> commit 2f78788b55ba ("ilog2: improve ilog2 for constant arguments")

That looks unlikely, although possibly some constant folding
improvement might make the fortify code notice something with it.

> detected buffer overflow in strlen
> ------------[ cut here ]------------
> kernel BUG at lib/string.c:1149!
> Call Trace:
>  strlen include/linux/string.h:325 [inline]
>  strlcpy include/linux/string.h:348 [inline]
>  xt_rateest_tg_checkentry+0x2a5/0x6b0 net/netfilter/xt_RATEEST.c:143

Honestly, this just looks like the traditional bug in "strlcpy()".

That BSD function is complete garbage, exactly because it doesn't
limit the source length. People tend to _think_ it does ("what's that
size_t argument for?") but strlcpy() only limits the *destination*
size, and the source is always read fully.

So it's a completely useless function if you can't implicitly trust
the source string - but that is almost always why people think they
should use it!

Nobody should use it. I really would like to remove it, and let
everybody know how incredibly broken sh*t that function is.

Can we please have everybody stop using strlcpy(). But in this
particular case, it's that xt_rateest_tg_checkentry() in
net/netfilter/xt_RATEEST.c

That said, this may be a real FORTIFY report if that info->name is
*supposed* to be trustworthy? The xt_RATETEST code does use
"info->name" a few lines earlier when it does

        est = __xt_rateest_lookup(xn, info->name);

or maybe the bisection is right, and this points to some problem with
__builtin_clzll?

                 Linus
