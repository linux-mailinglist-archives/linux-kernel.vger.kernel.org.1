Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E62AD28B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgKJJdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgKJJdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:33:20 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C14C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:33:19 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m13so13582571oih.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UkFzS0xqfoJt9doPeSUXNjV1Z9m4QzgZeqM5Nk8Yss=;
        b=i7K+5/+7cLZ5ZRdhNEamXRcWw2QQ5XKCYG2d+/ImIPCzSBjpmq/0TvrywlA9n7NxpH
         B766buJa+ieQ3fgGJlGjHosI3xzo0781KmeChVDqeRbxFFNxJfRC7WWIFV7adexCwpx+
         NTIuE0Bpoi0kHCRsaU97HNjA1Reud/62RUqaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UkFzS0xqfoJt9doPeSUXNjV1Z9m4QzgZeqM5Nk8Yss=;
        b=CYxnjn0ZD8tVoh/U7Ei7bXAs6UlXVvOOs9bdJXFMrbi1xoKFT21xQCy2bmBarf5SbV
         TXCiMdlDpz1yevwWorDyiRT7M4b7DC7xqilNhMBrimLYsX5rCw1dDd4clYzpaOyKMAeW
         F/IIilSLuDkma4HJ8hir4F5rVvVox2Tk/aJN+d3n7DoLvOHxkKYEbbd4qbeK4NFMmE+G
         cBF9XFXxHR26ake7k01OqRL994WLcNb5fKFl0kaiQoUXl2ub7e/aS9L3lgxT3YZi1meK
         7AMWmuUW5MpBFuOEAtCJN9xL7lIzJtsTQXZ+EHQjOOp4M9kXE+Xb30rKHqFezlmaZgU6
         OYcQ==
X-Gm-Message-State: AOAM530FA4hTa6cNkmeHn0vdgoBpiJM/PGrCPgPJfQCuuVB1E6n6yIta
        dNK2e9zk0qBAUoAEl8cfUrZiSPFX3dna9xkt
X-Google-Smtp-Source: ABdhPJySu/R8bwtb8xcvq7oj0meZkdx88hgbvbwND0pd37UGxV9JMagavmvEihas4xxkmeDLxB5fpA==
X-Received: by 2002:aca:ef56:: with SMTP id n83mr2179780oih.30.1605000798297;
        Tue, 10 Nov 2020 01:33:18 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id d62sm1055541oia.6.2020.11.10.01.33.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 01:33:17 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id c80so13602535oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:33:17 -0800 (PST)
X-Received: by 2002:aca:3c54:: with SMTP id j81mr551270oia.11.1605000796616;
 Tue, 10 Nov 2020 01:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de> <20200930160917.1234225-9-hch@lst.de>
 <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
 <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com> <20201110092506.GA24469@lst.de>
In-Reply-To: <20201110092506.GA24469@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 10 Nov 2020 10:33:05 +0100
X-Gmail-Original-Message-ID: <CANiDSCsBUBV1WA2To9x26Uhc5SU-4xuh3m4wUwXBcGwA6n8now@mail.gmail.com>
Message-ID: <CANiDSCsBUBV1WA2To9x26Uhc5SU-4xuh3m4wUwXBcGwA6n8now@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Tue, Nov 10, 2020 at 10:25 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 09, 2020 at 03:53:55PM +0100, Ricardo Ribalda wrote:
> > Hi Christoph
> >
> > I have started now to give a try to your patchset. Sorry for the delay.
> >
> > For uvc I have prepared this patch:
> > https://github.com/ribalda/linux/commit/9094fe223fe38f8c8ff21366d893b43cbbdf0113
> >
> > I have tested successfully in a x86_64 noteboot..., yes I know there
> > is no change for that platform :).
> > I am trying to get hold of an arm device that can run the latest
> > kernel from upstream.
> >
> > On the meanwhile if you could take a look to the patch to verify that
> > this the way that you expect the drivers to use your api I would
> > appreciate it
>
> This looks pretty reaosnable.
>

Great

Also FYI, I managed to boot an ARM device with that tree. But I could
not test the uvc driver (it was a remote device with no usb device
attached)

Hopefully I will be able to test it for real this week.

Any suggestions for how to measure performance difference?

Thanks!

> Note that ifdef  CONFIG_DMA_NONCOHERENT in the old code doesn't actually
> work, as that option is an internal thing just for mips and sh..



-- 
Ricardo Ribalda
