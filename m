Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC2A26E852
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIQWZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:25:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21A5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:25:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c2so3366481ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRAUbmInUiqP/WbwfvunToW9UzvahCwMncy+b1qkhqg=;
        b=YYkU5m9XeRDXjzSEnA7vwi17L60Cp0ziRma2cQ2SDktGTHyJtA9I4Eb6RpHtyVg7jk
         59G0u2LYoMx7A8D30rKwm69ZapWlw5WtVN1JuqByirafx7lSoCfc6YLIkK3gkJdnrpBO
         em2p6bmd9TNWAhmT9CLMEIzr1qSmxB384cbak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRAUbmInUiqP/WbwfvunToW9UzvahCwMncy+b1qkhqg=;
        b=k12R99gZemT8yFWJXrRcEvQIf9Cc3xkydHW+9mQjqyNK8LHzlFTbMTIJtky+IrPZtv
         x8o8XnZ6hDkC6TXQ4h/ZlhdzQiNoRe+0IOmKNvERaMc/16KnrYrJ1oYgjg0W4mtnIzk4
         5fIPKdHn+s2C3fp37sBeF2aD5UaIjY0/WQxfgJZa83kr58n0mAwPzzfGUh+fyL4d3odR
         y93IHXppOF7UsZXbsGX9r3U/Ml9vUNUJAFwh9c2KQOc5vG1pW87Vf9kmAEMgJM5tvpSj
         d+kmXGWS2kse3Ummn9Zvm4pKjW+oscfGINI4/Vq+iEw+f0/bDsNj2OG0SzYXDPRYLxxG
         XCyw==
X-Gm-Message-State: AOAM530qGWl79iDJmzOGq1j6jINHIJebglZ54dcxEnzTS/gpPsMig3G+
        REyahptM+Woo/tvwFNDvnLsH9gi3v//vdw==
X-Google-Smtp-Source: ABdhPJxpOpafUTWDi48ATMt/qF5QgQ5vTJpKkXtqmvU8ReXacExoLRhmEWr1UuJgpBvXtkpIMNjcMA==
X-Received: by 2002:a2e:7410:: with SMTP id p16mr10119644ljc.156.1600381553835;
        Thu, 17 Sep 2020 15:25:53 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j20sm176201lfe.181.2020.09.17.15.25.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 15:25:52 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d15so3907048lfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:25:51 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr11015777lfb.133.1600381551270;
 Thu, 17 Sep 2020 15:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200916174804.GC8409@ziepe.ca> <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca> <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1> <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
 <20200917200638.GM8409@ziepe.ca> <CAHk-=wh+qz0oOjyiQFXR_73RYSDUmJwHC8xd=KG0RzELnbS5OA@mail.gmail.com>
 <20200917214059.GA162800@xz-x1> <20200917220900.GO8409@ziepe.ca>
In-Reply-To: <20200917220900.GO8409@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 15:25:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXHrZsa+ATYSd2SxyKVY6=KWsj7_4Y2rhwEkt69hcWuA@mail.gmail.com>
Message-ID: <CAHk-=wiXHrZsa+ATYSd2SxyKVY6=KWsj7_4Y2rhwEkt69hcWuA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 3:09 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> My advice for this -rc fix is to go with a single bit in the mm_struct
> set on any call to pin_user_pages*

Ack, except make sure it's a byte rather than a bitfield that could
have races. Or even just a separate atomic_t.

Keep it simple ans stupid and obvious. As you say, we can aim for
cleanups later, make it obvious and reliable right now.

             Linus
