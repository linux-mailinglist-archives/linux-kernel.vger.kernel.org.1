Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37CD27A2D2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgI0TgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgI0TgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:36:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AFBC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 12:36:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r24so6611753ljm.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nmope1OKcgHKIN0lUkmnZDt19fb2tVenNuLLHWBLiKs=;
        b=aD1ptY13jrKXQ+n8IhaxEaouzjLaeDMBc3wJDUdcFpr2RLNAqh58cEZMo8uG8P0q8D
         3NWP56+G/OtcMLivSGDU9UxUTr5z49ricmyKju6+L69zq3I4jfR3HIvSiq6+/G26r4F8
         QaZ3bMwcHl7GfGyT0IoQONGz667rqj05Csbjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nmope1OKcgHKIN0lUkmnZDt19fb2tVenNuLLHWBLiKs=;
        b=TvEBdFEoEyL8cKCwyKgJUICW1cqU8d7gEvoCfvk58NngY6jrN9lNXXX87LvNPBGF9n
         +cDd61dIMPSGxD9ZgbTxPyaMpJV08i6rluEs2l7w55GprXzPnGW1joUH0Jw/RzIIppsF
         ew0EYmuxulBEhvwh0RwD3XL49cRqDiZhE8PqIyuL1gENPrmO99P7OQcVu4s52vuIYqwJ
         MPxcV7SisZATXB0yD97aPcFYJ96G3J3NQ3BAUdu/hT75DLlQT3Pka+Og8pbYK8GUq3yo
         VPo0kpLu5EPrwud94NRRWYU0zpz+RS7oTpVWTVPab8rFEb/PSrqi4Q5Ba5dWbDXCrHA2
         hZ8Q==
X-Gm-Message-State: AOAM531VAsjFoimuoDiKn3qQerjchC9JsDL25HQLLwS427Q6DkTxTC/6
        L0i9ZiqWlI4RR4SnIrX2EGJhVQAff73RoQ==
X-Google-Smtp-Source: ABdhPJxzVI7dzI/ypXp7Flhu0mFEWkupSfp6SIAxCG/+tZ/VQhajMs0Y5LNcm0QFYwZ5T8XOo3AYOA==
X-Received: by 2002:a2e:814b:: with SMTP id t11mr4300387ljg.367.1601235379502;
        Sun, 27 Sep 2020 12:36:19 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w9sm2565652lfr.220.2020.09.27.12.36.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 12:36:16 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id w3so6596944ljo.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 12:36:15 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr4346496ljm.285.1601235375523;
 Sun, 27 Sep 2020 12:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200925222600.6832-1-peterx@redhat.com>
In-Reply-To: <20200925222600.6832-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Sep 2020 12:35:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWyUg0x72nVQaCjq2xvy=S=x0=_9EuV6Qp4pTarGiaeg@mail.gmail.com>
Message-ID: <CAHk-=whWyUg0x72nVQaCjq2xvy=S=x0=_9EuV6Qp4pTarGiaeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mm: Break COW for pinned pages during fork()
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 3:26 PM Peter Xu <peterx@redhat.com> wrote:
>
> This series is majorly inspired by the previous discussion on the list [1],
> starting from the report from Jason on the rdma test failure.

Ok, this is now in my git tree with the changes I outlined in the other email.

> I tested it myself with fork() after vfio pinning a bunch of device pages,

.. but _my_ only testing was to just add a nasty hack that said that
all pages are pinned, and made fork() much slower, but hey, it at
least tests the preallocation paths etc. And I'm not seeing any
obvious failures due to taking that slow-path that is supposed to be a
special case.

Let's hope this closes the rdma issues.

                Linus
