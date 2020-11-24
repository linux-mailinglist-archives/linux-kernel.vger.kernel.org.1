Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3605E2C252A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgKXMBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733212AbgKXMBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:01:47 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00CCC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:01:47 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id s10so21673900ioe.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OtTStFZ1K4vG9mf1OSlywjo0WPS9A+qPTfMdwg+0WeU=;
        b=B3BwzQbaXFU3fhtDdHR+Fmv8MKnhR2mxgOp2ryIc5wuXL4rXiS85tpU6q5H3eR6qE+
         6qzQoaoL8DgM+BofPoZTBWmfryCnozhhBT+EEK6ATwmvGtVQzE0xjmM4qt+tQ5k0iE0J
         0hdGRkNaK/blbkiRCF/yNOj+MFI3+N1/U+yak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OtTStFZ1K4vG9mf1OSlywjo0WPS9A+qPTfMdwg+0WeU=;
        b=flHByJmgNyDdmImLLmlugv9jgG2gGsoPnvDiKaTBGqitRJMqNSYRmABTTla4g1gO28
         8jo7HkdFCNL/t3kMCRJ7pJ9T+J0RoOLn4TjUgtrd/K8s3U4k16ZKi1tEAE5l23F+0YOX
         TTSplffUcnVLuD8mhqKr3uXuMpx/5xljv7qwOFPZGOMrakLu7Q8QcHAKbc0gYdJMU1x3
         VohIkJbRGhnw4jJNxkL7kSujZL2gR7V4f7iPKXwLhRrEGW7K/SQphEXzWIMN1e0w9KG1
         sZjnzBamEuT+CLSofTlHPF0E6i5tJ42UaY18ElwyOXbooq53YDPl1E3lWFEHkfWv3X0l
         fKNw==
X-Gm-Message-State: AOAM532EFqVMqcOWY9MtrczrwuckjXtqZFcy/gVO3h6jp0XPGuGLSe5n
        SM1HHbUbaDMOcWH3xu/PBXnnfCc47LfCoA==
X-Google-Smtp-Source: ABdhPJzvDXFD81L4qj6F5SoyjzmZLjgSLc55iFM6MECoH0EtvugA7HYjWMIS3oXT/Wcgvj1pxl3IaA==
X-Received: by 2002:a5e:df03:: with SMTP id f3mr3715351ioq.182.1606219306769;
        Tue, 24 Nov 2020 04:01:46 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id s134sm10239219ilc.64.2020.11.24.04.01.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 04:01:46 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id y9so19042098ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:01:45 -0800 (PST)
X-Received: by 2002:a05:6e02:12ab:: with SMTP id f11mr757703ilr.89.1606219305436;
 Tue, 24 Nov 2020 04:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20200930160917.1234225-9-hch@lst.de> <20201118142546.170621-1-ribalda@chromium.org>
 <20201124113512.GA21974@lst.de>
In-Reply-To: <20201124113512.GA21974@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 24 Nov 2020 13:01:33 +0100
X-Gmail-Original-Message-ID: <CANiDSCtLrqWBOmC9X91V8P-aahQr2=L-GQNjHM6YauT69_QcEg@mail.gmail.com>
Message-ID: <CANiDSCtLrqWBOmC9X91V8P-aahQr2=L-GQNjHM6YauT69_QcEg@mail.gmail.com>
Subject: Re: [PATCH] WIP! media: uvcvideo: Use dma_alloc_noncontiguos API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Christoph

On Tue, Nov 24, 2020 at 12:35 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 18, 2020 at 03:25:46PM +0100, Ricardo Ribalda wrote:
> > On architectures where the is no coherent caching such as ARM use the
> > dma_alloc_noncontiguos API and handle manually the cache flushing using
> > dma_sync_single().
> >
> > With this patch on the affected architectures we can measure up to 20x
> > performance improvement in uvc_video_copy_data_work().
>
> This has a bunch of crazy long lines, but otherwise looks fine to me.

That is easy to solve :)

https://github.com/ribalda/linux/commit/17ab65a08302e845ad7ae7775ce54b387a5=
8a887

>
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >
> > This patch depends on dma_alloc_contiguous API=EF=BF=BC1315351diffmboxs=
eries
>
> How do we want to proceed?  Do the media maintainers want to pick up
> that patch?  Should I pick up the media patch in the dma-mapping tree?

I was hoping that you could answer that question :).

Do you have other use-cases than linux-media in mind?

I think Sergey wants to experiment also with vb2, to figure out how
much it affects it.
His change will be much more complicated than mine thought, there are
more cornercases there.

>
> Can you respost a combined series to get started?

Sure. Shall I also include the profiling patch?


Best regards
--=20
Ricardo Ribalda
