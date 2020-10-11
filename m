Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9FD28A97F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgJKSxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgJKSxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:53:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF06C0613D2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:53:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l18so2804223pgg.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nlp2koKuQPol8YlKp8/Psy2arD2kGeXLj/kBWBMZhrs=;
        b=nnryzzC6T0pyBVF20/k1rNuBjO9bNchPlai67Pq4CZOa2U8wy/KC6Hx0aNuv6B2QUX
         WKdY5GFURbSUcqcYHmhT20OT7aBsKdWrfcqgTvqRJ3rpNEtt+PnlaL0uofaR+lohyo0S
         6h9GPkHZH11birXRoD/uJI+sg8+SEreiBJsYjoyX0c0nDysokLEow5mEVhVOIfLT+ZH7
         9bdNDvA986GNm8rqrwkIhc6186SDqkdysPs8mTd2kcUaC6cuGAcoShIE3DzWXSuCWJsW
         +BxLdlfo+rMeSLwDEEB9Z9oR7M4k5lG0/7KJheGk9sAcAb72UT1WKXWlypc0h5I4QJ08
         WiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nlp2koKuQPol8YlKp8/Psy2arD2kGeXLj/kBWBMZhrs=;
        b=hGIFG1tTvqnU9J12uWxrO4pw7eZHcY8U3Wx6Fsxs7BYrg6FIy1MStv3yhwN3R0qcN/
         bOV8hz7e69GKdxwmvW4DDPrPp2O3LnMX421FgoXp31JV/oWHLnEjgFFF9YeXggKBpwic
         AaV/Ep5LOlEj771tJ5Lwkl+NfAaBu/Vy0NZ/ks9L/aAn/evQMpQ7TZqMraWXcn9VofX6
         yQocAC1M4Y7L4hGO6/qnI+Y5iVbeDKVPrxqxGnrvX0IGdEkfMFqhBZAE24Y6MrD9lTBA
         NvT4MXP2ItAn8dS4Kg4/LtIQ18RuTXwTxRoZsOCTT+vIUj/pssU+mSsE8RbV4f/OEsUR
         Az1w==
X-Gm-Message-State: AOAM530JYNAhYSWsMoIZ6icYZRQtLK5iVl6TDb1s/XHJZuvLt9UbTwB5
        yl1pK8ZOMi+xMJQ+FVtp4P/yv/SxYUHpPS0ldVkuyA==
X-Google-Smtp-Source: ABdhPJyY5AWdJ4kh4tWqQSOizBmz/3pEctCN1xhSb3L68hRDFALws3ju7pGh8GmQErpholv7sc6lef1+fcJO7iQ/5os=
X-Received: by 2002:a63:1906:: with SMTP id z6mr1042584pgl.286.1602442426499;
 Sun, 11 Oct 2020 11:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201009170202.103512-1-a.nogikh@gmail.com> <5d71472dcef4d88786ea6e8f30f0816f8b920bb7.camel@sipsolutions.net>
In-Reply-To: <5d71472dcef4d88786ea6e8f30f0816f8b920bb7.camel@sipsolutions.net>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Sun, 11 Oct 2020 20:53:35 +0200
Message-ID: <CAAeHK+xfc=oqtXTx1m0gAaz9naDRzRXnUsWbPMzPxQHdaYj=qQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] [PATCH v2 0/3] [PATCH v2 0/3] net, mac80211,
 kernel: enable KCOV remote coverage collection for 802.11 frame handling
To:     Johannes Berg <johannes@sipsolutions.net>,
        Aleksandr Nogikh <a.nogikh@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 8:50 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2020-10-09 at 17:01 +0000, Aleksandr Nogikh wrote:
> > From: Aleksandr Nogikh <nogikh@google.com>
> >
> > This patch series enables remote KCOV coverage collection during
> > 802.11 frames processing. These changes make it possible to perform
> > coverage-guided fuzzing in search of remotely triggerable bugs.
>
> Btw, it occurred to me that I don't know at all - is this related to
> syzkaller? Or is there some other fuzzing you're working on? Can we get
> the bug reports from it if it's different? :)

Yes, all this is for syzkaller :)

>
> Also, unrelated to that (but I see Dmitry CC'ed), I started wondering if
> it'd be helpful to have an easier raw 802.11 inject path on top of say
> hwsim0; I noticed some syzbot reports where it created raw sockets, but
> that only gets you into the *data* plane of the wifi stack, not into the
> *management* plane. Theoretically you could add a monitor interface, but
> right now the wifi setup (according to the current docs on github) is
> using two IBSS interfaces.
>
> Perhaps an inject path on the mac80211-hwsim "hwsim0" interface would be
> something to consider? Or simply adding a third radio that's in
> "monitor" mode, so that a raw socket bound to *that* interface can
> inject with a radiotap header followed by an 802.11 frame, getting to
> arbitrary frame handling code, not just data frames.

I'll let Aleksandr address this part.
