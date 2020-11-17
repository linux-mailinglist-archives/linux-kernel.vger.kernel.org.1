Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB52B70D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKQVVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgKQVVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:21:37 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF06C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:21:35 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n89so20901989otn.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaFR/vbXEE/Fp6N4YA11Mip+TFc+3mxIxAGB0BrXskE=;
        b=VC75sZ0sI622cqRm8NQfeG/nHdIrHJG5hf4nb18w5Ezfn7dMY95pE7f6ymO6jyVG5b
         RHrNPQPAkIvmJQcyxl/7knSpyGi+tr36KXPjdVxT8PNSHF++jwPSbnADEtdQfMS8xGvM
         xybni7VT4JkWf5GIe8nK7+qGTJhJlnTpen1Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaFR/vbXEE/Fp6N4YA11Mip+TFc+3mxIxAGB0BrXskE=;
        b=iyqti0nZKMxMvOkIycaCRfkYUUYRVbyb4PTyrYI3OXWebI98FLrrQwCaSlu2kzSmFe
         ocbnMupFQ4Qlpz7iY7ZddMtER2fkYaRMu1tRr6VIZ8Hj4Gon5FbT4NlZQ6hcPIhZt4B1
         Wt1lKF9JGqztTD7P8r91wBaR5t+hKXx6ek4nnmPSI60Gdt5F2wdGWytACpPxByJ+ZgnN
         GV94vI+yw4OyXPoyIJ+bhOBLNs+VoKOrHs6wB/5XZ3vNdAtfBSvNha6DEXW5k00v8hF+
         /ZQ/UbeD2ZpDKMYB4Jl9jvo9H7KvKnGTZwqdSi22cfxvaL3rV0C5q62iL5kHQcpxlkAT
         gC9g==
X-Gm-Message-State: AOAM533RrW99C7FoJDcD6JTh3rnZa6PHrRDLoWhYGM2fW0uiUaLK5SvE
        VVNPPEgAw87mATCiWAJjgwYDhEIpcz4vbw==
X-Google-Smtp-Source: ABdhPJyQxffgSF7ElmnmXjA+esOncWYjCdx4ppBtvSHRGLxsS9XXoQIsYURDi88TntqRACWCbHJZ0g==
X-Received: by 2002:a9d:16f:: with SMTP id 102mr4632603otu.206.1605648094660;
        Tue, 17 Nov 2020 13:21:34 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id 19sm6670580oth.63.2020.11.17.13.21.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 13:21:33 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id c80so24235264oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:21:32 -0800 (PST)
X-Received: by 2002:aca:7506:: with SMTP id q6mr742413oic.128.1605648092412;
 Tue, 17 Nov 2020 13:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de> <20200930160917.1234225-9-hch@lst.de>
 <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
 <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
 <20201110092506.GA24469@lst.de> <CANiDSCsBUBV1WA2To9x26Uhc5SU-4xuh3m4wUwXBcGwA6n8now@mail.gmail.com>
 <CAAFQd5CCOrp0OA_n_SHNO5RAhV-MQ2KuQJA+oWHQ76h_So=M2Q@mail.gmail.com> <20201110095747.GA26574@lst.de>
In-Reply-To: <20201110095747.GA26574@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 17 Nov 2020 22:21:21 +0100
X-Gmail-Original-Message-ID: <CANiDSCtbZHe2pqKj+=DbEODBSNy1hrysTOAHYbTG4_DRBmH00A@mail.gmail.com>
Message-ID: <CANiDSCtbZHe2pqKj+=DbEODBSNy1hrysTOAHYbTG4_DRBmH00A@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

I have been testing with real hardware on arm64 your patchset. And uvc
performs 20 times better using Kieran's test

https://github.com/ribalda/linux/tree/uvc-noncontiguous

These are the result of running   yavta --capture=1000


dma_alloc_noncontiguous

frames:  999
packets: 999
empty:   0 (0 %)
errors:  0
invalid: 0
pts: 0 early, 0 initial, 999 ok
scr: 0 count ok, 0 diff ok
sof: 2048 <= sof <= 0, freq 0.000 kHz
bytes 78466000 : duration 33303
FPS: 29.99
URB: 418105/5000 uS/qty: 83.621 avg 98.783 std 17.396 min 1264.688 max (uS)
header: 100040/5000 uS/qty: 20.008 avg 19.458 std 2.969 min 454.167 max (uS)
latency: 347653/5000 uS/qty: 69.530 avg 98.937 std 9.114 min 1256.875 max (uS)
decode: 70452/5000 uS/qty: 14.090 avg 11.547 std 6.146 min 271.510 max (uS)
raw decode speed: 8.967 Gbits/s
raw URB handling speed: 1.501 Gbits/s
throughput: 18.848 Mbits/s
URB decode CPU usage 0.211500 %


usb_alloc_coherent

frames:  999
packets: 999
empty:   0 (0 %)
errors:  0
invalid: 0
pts: 0 early, 0 initial, 999 ok
scr: 0 count ok, 0 diff ok
sof: 2048 <= sof <= 0, freq 0.000 kHz
bytes 70501712 : duration 33319
FPS: 29.98
URB: 1854128/5000 uS/qty: 370.825 avg 417.133 std 14.539 min 2875.760 max (uS)
header: 98765/5000 uS/qty: 19.753 avg 30.714 std 1.042 min 573.463 max (uS)
latency: 453316/5000 uS/qty: 90.663 avg 114.987 std 4.065 min 860.795 max (uS)
decode: 1400811/5000 uS/qty: 280.162 avg 330.786 std 6.305 min 2758.202 max (uS)
raw decode speed: 402.866 Mbits/s
raw URB handling speed: 304.214 Mbits/s
throughput: 16.927 Mbits/s
URB decode CPU usage 4.204200 %


Best regards

On Tue, Nov 10, 2020 at 10:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Nov 10, 2020 at 06:50:32PM +0900, Tomasz Figa wrote:
> > In what terms it doesn't actually work? Last time I checked some
> > platforms actually defined CONFIG_DMA_NONCOHERENT, so those would
> > instead use the kmalloc() + dma_map() path. I don't have any
> > background on why that was added and whether it needs to be preserved,
> > though. Kieran, Laurent, do you have any insight?
>
> CONFIG_DMA_NONCOHERENT is set on sh and mips for platforms that may
> support non-coherent DMA at compile time (but at least for mips that
> doesn't actually means this gets used).  Using that ifdef to decide
> on using usb_alloc_coherent vs letting the usb layer map the data
> seems at best odd, and if we are unlucky papering over a bug somewhere.



-- 
Ricardo Ribalda
