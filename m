Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE2E2EE65E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbhAGTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbhAGTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:48:03 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0668C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 11:47:22 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l11so17493951lfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 11:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ruY7+Hc6DwjfUtsIGmEMt3x9fL7QwNpww7Qmh8m5ao=;
        b=FqnqVnVRhdZ06qPkVepbc2d6YqyFCx6doQkSftj/eLt2k4QnSPYtgEpD3IcxBsg6Sc
         58CHR7Y5cSwWtGBBFbBHUOAu+DGUplKWy0JWSPQvWkeuwNRpNRO/Tp6sndPafmhBl9Wq
         iOWAlxJfkbmFP6NX+zwC7HF8T1R8D9wozuP5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ruY7+Hc6DwjfUtsIGmEMt3x9fL7QwNpww7Qmh8m5ao=;
        b=t9lc6IWUVusulgmGqyreFnr/+qKY44qmZI+Nai6IJG5csayYWbrq9Ob2RI8b2zIcqA
         bnvzVmc+7MjHpHEjUoBwOF+j77/x5e2mZHhythImm6OD9U8KNwyF/ZBZiFED2DY0KHuP
         eE8fvcWVm1QPVhAEX5ikkvCdBn262a5gyQ9nvynCegqVH7gCQm1H6CMw977P2MwGJvQT
         bFiJOTYoc5tGiOD7qdKb0a4MOVUKCzdOQxU7i58IC3KAY8UVKffLhCrtKIdVCm39mZ81
         BrJHD9cQ9xjMAkRV8TFNRkWWAmly8XEfGGOBSpP3Elp68u7Sn85+URSopjxwIIx3AGo4
         bZUw==
X-Gm-Message-State: AOAM532/URNnNps3TRleyFLxkBrfprcQYQR3lBwWtrvMSdrUBtbGs/pI
        Lx4qfOmRDErpxNYdTDWYlrMuk5vP2P6EpA==
X-Google-Smtp-Source: ABdhPJycKdMbNcWlRH8VncUoXqfcf6zaLhQlhMnjYXPdq8R/KUV0Dpa7al6KU/mI3dEcgAD07Bfvjg==
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr35471ljj.380.1610048840927;
        Thu, 07 Jan 2021 11:47:20 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p17sm1348915lfc.273.2021.01.07.11.47.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 11:47:19 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id b26so17375882lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 11:47:19 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr27794ljy.61.1610048838877;
 Thu, 07 Jan 2021 11:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20201118194838.753436396@linutronix.de> <20201118204007.169209557@linutronix.de>
 <20210106180132.41dc249d@gandalf.local.home> <CAHk-=wh2895wXEXYtb70CTgW+UR7jfh6VFhJB_bOrF0L7UKoEg@mail.gmail.com>
 <20210106174917.3f8ad0d8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+FuTSevLSxZkNLdJPHqRRksxZmnPc1qFBYJeBx26WsA4A1M7A@mail.gmail.com> <CA+FuTScQ9afdnQ3E1mqdeyJ-sOq=2Dm9c1XDN8mnzbEig8iMXA@mail.gmail.com>
In-Reply-To: <CA+FuTScQ9afdnQ3E1mqdeyJ-sOq=2Dm9c1XDN8mnzbEig8iMXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 11:47:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+KfbJ4Wrz4A+hFRRj7ZYWysz9L8s-BosC3bhV6vN-nQ@mail.gmail.com>
Message-ID: <CAHk-=wh+KfbJ4Wrz4A+hFRRj7ZYWysz9L8s-BosC3bhV6vN-nQ@mail.gmail.com>
Subject: Re: [BUG] from x86: Support kmap_local() forced debugging
To:     Willem de Bruijn <willemb@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Miller <davem@davemloft.net>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 8:45 PM Willem de Bruijn <willemb@google.com> wrote:
>
> But there are three other kmap_atomic callers under net/ that do not
> loop at all, so assume non-compound pages. In esp_output_head,
> esp6_output_head and skb_seq_read. The first two directly use
> skb_page_frag_refill, which can allocate compound (but not
> __GFP_HIGHMEM) pages, and the third can be inserted with
> netfilter xt_string in the path of tcp transmit skbs, which can also
> have compound pages. I think that these could similarly access
> data beyond the end of the kmap_atomic mapped page. I'll take
> a closer look.

Thanks.

Note that I have flushed my random one-liner patch from my system, and
expect to get a proper fix through the normal networking pulls.

And _if_ the networking people feel that my one-liner was the proper
fix, you can use it and add my sign-off if you want to, but it really
was more of a "this is the quick ugly fix for testing" rather than
anything else.

          Linus
