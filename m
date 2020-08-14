Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32743244FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 00:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgHNWk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 18:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgHNWk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:40:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D59FC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:40:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so11540124ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cw/Xi+zTnVph1e4MFSY/wz6yqwLJpsrk++bjsEyga4k=;
        b=gBmiWZUczwz3Q1oPbPKyqeSDui1X6O9Kt/ZmsnT8NLd59EQmQWhvQdSCRYGjswsOPw
         MHKj25WfDZYFKZsMyBVQks4287vVbGdrDRd3GeBmkPlM7zgqOIkH+aR3ebuNjPEYwh3z
         vPg4TJKNWq+J0d1Au0Y3jxKtyUtjlWDJJCEhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cw/Xi+zTnVph1e4MFSY/wz6yqwLJpsrk++bjsEyga4k=;
        b=oRulHqa7zz6dZCA7zXLDGpA6PAmjRG51Uw7kkwATnBZsLCyGzO4TxgOfi3bifk2iYT
         jwFH+frp+PXGlrfzcNTKyS9dBMlcWiV4nHTSe5DWpdqZQxmRP4Q2XPh7WdjQhrb9Ee8R
         U+0OffD9e40rhtgLGYMy+9WLoGID0WTqYx+nagm9PpD8Xvq6iTDMA6d+NiIM3o+Jf330
         EPQpm7Owi+poNwtuHtOO0RwRUZqNIPxlG3QDn6fzdVXqLiiFGDed8ayjBel8wfZHtmS9
         dHDTo+CEyPmJZ+SQqRp8fCvi/Bfts8qPbPKu41Rs1FDkwKB8jEy1uobgV4VY0Jmdckmm
         AdaQ==
X-Gm-Message-State: AOAM532wsDGDKQM8+WaIfT0FLogXs4XDWmllLBZNFu+yYt7im3fogHmd
        o8Vl6mpeoUi/UBtjn7ce4yDDH1ecc2d/Yw==
X-Google-Smtp-Source: ABdhPJzXtaKcveye7ueZYmY5nPv4IDStCpmEG5ii3y8x/j8FlENz9WJhXdHQVf/HPw6Xt5PRb6DEVQ==
X-Received: by 2002:a2e:a58b:: with SMTP id m11mr2187780ljp.135.1597444857004;
        Fri, 14 Aug 2020 15:40:57 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id e19sm2154262lfc.7.2020.08.14.15.40.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 15:40:55 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 185so11507919ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:40:54 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr2094857lji.314.1597444854609;
 Fri, 14 Aug 2020 15:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
 <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com> <20200814054241.GA719@lst.de>
In-Reply-To: <20200814054241.GA719@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 15:40:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifNX6U28sjPay+1ZJ5BmxRG8Bac7W1sP_Ft1yTqLj+GA@mail.gmail.com>
Message-ID: <CAHk-=wifNX6U28sjPay+1ZJ5BmxRG8Bac7W1sP_Ft1yTqLj+GA@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(), use rcu_read_lock()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The whole thing predates my involvement with the code, but I defintively
> think the patch from Hugh is a major improvement.  But I would also
> have no problem with just removing it entirely.

I decided to just do both, since neither you nor Dan seemed to really object.

I applied Hugh's RCU read locking patch as a clear improvement, and
then I did a second patch that just removed this function entirely.
That sounds a bit odd, perhaps, but in case people decide to resurrect
the debugging code, I didn't want us to lose sight of Hugh's
improvement just because I then decided that we might as well go one
step further and just remove it entirely.

And the only real reason I care is that this whole COW and page lock
thing has showed up lately, and I like removing code.

I'm _very_ tempted to just apply my COW simplification patch that gets
rid of all the complex try-to-share cases entirely (and would also
obviate the whole forced-cow patch). I suspect it would effectively
remove almost all of the [un[lock_page() bottlenecks entirely, but
that code has decades of history and I suspect it's a bit too drastic
wrt KSM and the swap cache pages.

It would be lovely if the main source of page locking would really be
about just IO, but the page lock has also become the thing that
serializes almost everything related to page state. Which is why you
find it in contexts that are really not IO-related at all (not just
COW - page migration is the other one that has shown up a lot under
"heavy CPU loads" without really necessarily any IO component to it).

                         Linus
