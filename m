Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20678285F06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgJGMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgJGMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:21:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8703C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 05:21:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c22so2673929ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rvcLVVp+iunfwmEIXwaT4iDFBQHHexJb1eiNV9hSvU=;
        b=IxPec1inBA3XKBVEkijHSe0RQpCGY6i5Zx4zjTGEvIdZRZSojpCqwegqlq2Nq47fA9
         ETWPZvj3lKfnnCodpnQMTpne/EEaRSnqKApQLAY/QOOMuJ6ODlUD5K+xr8MH0mWFKI+v
         b4AQOPg5faD6fDmYthS1vWnOiZeopihoSJ764=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rvcLVVp+iunfwmEIXwaT4iDFBQHHexJb1eiNV9hSvU=;
        b=d/4Dc8f0IAD6dffdk5WQ629RZdEqQDN3oD8/QgDqDPKzWZdgXm6yN4kceIiVpzK9Rx
         FRzVp6QAUtv0K8yW2UZvvRrbDxNUbiQEi3cATNq6MlDUvFaBlJ9AV7N6kAUmPj/iyMSH
         9MOEsAkL/SjbPwiGh8TZ9JYFZo8bB532+4gptSHWg0tucNbdKM/lC6du6GyeTCDb9qo6
         Zs60bWw8D9zFQsL29wfrj4R7/mkHw3X2cMZN42TV3wcz7RSvO0Dhvo5TR5+/N7mZXLlx
         c4DF2RJ5g4+pNqgPQsdp5/ftZoJLylm8re33vxzPFfyP5sHgedG3l05IbMnqpIA8KxuR
         V/PA==
X-Gm-Message-State: AOAM5315lhcrmJ4PN+g1b2FPF0aLGYraS/py/kXBLBEPUwGGKzvuTUXW
        Y35ASJibuHtjMVPQIQYyPhaBa/VcBIjQmg==
X-Google-Smtp-Source: ABdhPJxAERKKzCN7D6ldSnHYim4LDd1Y2B0vhMXg/bxHMj5eRvSI6a8duISsSbj/Bb5g2HSTo/w90g==
X-Received: by 2002:a17:906:c095:: with SMTP id f21mr3240036ejz.108.1602073316327;
        Wed, 07 Oct 2020 05:21:56 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id i14sm1409441ejy.110.2020.10.07.05.21.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 05:21:55 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id n6so1614509wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 05:21:55 -0700 (PDT)
X-Received: by 2002:adf:f2ce:: with SMTP id d14mr2420557wrp.32.1602073314520;
 Wed, 07 Oct 2020 05:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de> <20200930160917.1234225-9-hch@lst.de>
 <20201002175040.GA1131147@chromium.org> <20201005082629.GA13850@lst.de>
 <CAAFQd5DcFjTUpOYkaz4nGxozgOc9oGf9QngjbpXWdcwXTT=kmw@mail.gmail.com> <20201007062150.GA10601@lst.de>
In-Reply-To: <20201007062150.GA10601@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 7 Oct 2020 14:21:43 +0200
X-Gmail-Original-Message-ID: <CAAFQd5AtN-ykAF_2mAqGxVugeEegYxfYdS6gD4O3zCY1jznNYA@mail.gmail.com>
Message-ID: <CAAFQd5AtN-ykAF_2mAqGxVugeEegYxfYdS6gD4O3zCY1jznNYA@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 8:21 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Oct 06, 2020 at 10:56:04PM +0200, Tomasz Figa wrote:
> > > Yes.  And make sure the API isn't implemented when VIVT caches are
> > > used, but that isn't really different from the current interface.
> >
> > Okay, thanks. Let's see if we can make necessary changes to the videobuf2.
> >
> > +Sergey Senozhatsky for awareness too.
>
> I can defer the changes a bit to see if you'd really much prefer
> the former interface.  I think for now the most important thing is
> that it works properly for the potential users, and the prime one is
> videobuf2 for now.  drm also seems like a big potential users, but I
> had a really hard time getting the developers to engage in API
> development.

My initial feeling is that it should work, but we'll give you a
definitive answer once we prototype it. :)

We might actually give it a try in the USB HCD subsystem as well, to
implement usb_alloc_noncoherent(), as an optimization for drivers
which have to perform multiple random accesses to the URB buffers. I
think you might recall discussing this by the way of the pwc and
uvcvideo camera drivers.

Best regards,
Tomasz
