Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB422F7C15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbhAONJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732697AbhAONJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:09:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F2C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:08:27 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id b19so15428915ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTaj+kQTI0f7LZEXnhvKOz2cpPUJhSCbtgTVKj7/e7M=;
        b=EH9Lf/Qh5uutAxEfsjPu9Tu0c9s5EADzA4pymQanveSRfO8osic1lzoqlLFpKqmKgM
         ePUT9SwlH1pgv9q9fuQy6uxulz1L+MdF/UTIPxzPc9vEm7feTrhKPS0IT9sN69GG/h/D
         8x/BZqmWKrCkVwyxr6q7Or83KJQbyw2b5IrvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTaj+kQTI0f7LZEXnhvKOz2cpPUJhSCbtgTVKj7/e7M=;
        b=OqHjap5rs2nKt60/yPRnUKbsdh2OPxgbDEghBgNGEN4l6mfEEJvIyQ3f0LM+8mjqgM
         eXFd46EiF8fb5cuNZD2pDs+bYgIGBVpIoTPLUgVJ/bucpzO7XxFmoN5u7YPvB9BnRCZL
         IgsseXqN0TI+nurtPwdAmkN0xBtQoJa+hQagEMY0Ummhchcl8NOyDd4gQFIPtds/LfM2
         B3fnLUJqkORdMd7T/P2vUIPuj+oypQkpGsVaq//Lx5L094EB5E21zxspvYBtQGdMWdge
         tZzSDeo/jNuCLAgn67uejQHbntr4nHvJr5TwN9iWhCr/kD6O5VzXxycq58xruD6KuiKa
         b+2g==
X-Gm-Message-State: AOAM530AlqMoGjmPfeJ+SCsatl8rvkfy5YJDYNeP4+JcKIupZ4OFmwpE
        9K/5zrWZa6gLs/dmGyT10s4vLb6ZXw6u6Q==
X-Google-Smtp-Source: ABdhPJwxJdQXPlChskqWqsW7NIfFG2Fz0B2mnDZI8GKPschTSIWizKqgplzmjDjIk6gRb4uRhv6CJQ==
X-Received: by 2002:a05:6e02:194a:: with SMTP id x10mr10369689ilu.165.1610716106648;
        Fri, 15 Jan 2021 05:08:26 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id f80sm476666ilg.8.2021.01.15.05.08.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 05:08:26 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id y19so17981935iov.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:08:25 -0800 (PST)
X-Received: by 2002:a05:6e02:cc7:: with SMTP id c7mr10850857ilj.218.1610716105308;
 Fri, 15 Jan 2021 05:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org> <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
 <20201208071320.GA1667627@google.com> <20201209111639.GB22806@lst.de>
 <CANiDSCtsOdJUK3r_t8UNKhh7Px0ANNFJkuwM1fBgZ7wnVh0JFA@mail.gmail.com> <20210111083614.GA27589@lst.de>
In-Reply-To: <20210111083614.GA27589@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 15 Jan 2021 14:08:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCvuvj47=nhoWhvzc5raMxM60w+JYRWjd0YepcbcbkrUjA@mail.gmail.com>
Message-ID: <CANiDSCvuvj47=nhoWhvzc5raMxM60w+JYRWjd0YepcbcbkrUjA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To:     ". Christoph Hellwig" <hch@lst.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 9:36 AM . Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jan 07, 2021 at 03:14:08PM +0100, Ricardo Ribalda wrote:
> > > So I think we do want these branches for coherent vs non-coherent as they
> > > have very different semantics and I do not think that hiding them under
> > > the same API helps people to understand those vastly different semantics.
> > >
> > > OTOH we should look into a fallback for DMA API instances that do not
> > > support the discontigous allocations.
> > >
> > > I think between your comments and those from Ricardo I have a good idea
> > > for a somewhat updated API.  I'll try to post something in the next days.
> >
> > Did you have time to look into this?
> >
> > No hurry, I just want to make sure that I didn't miss anything ;)
>
> Haven't managed to get to it, sorry.

No worries!, is there something we can do to help you with this?

>
> >
> > Best regards!
> >
> >
> >
> > --
> > Ricardo Ribalda
> ---end quoted text---



-- 
Ricardo Ribalda
