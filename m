Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C0D26CE07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIPVIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIPQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:03:39 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDBC02C2A2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:24:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id y5so7073591otg.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8V25O9GYxPP08UjsTrSAXuZaUN2B3+YItzTAVwD6sSg=;
        b=esGUjUoGlLjSkji8zHSk6CikzTaVw9WkEHVQsTXY8XGY5G0ETObzGADcSR1/+09WH0
         hF6/mPOLMGiLYfQETJ/ZudzDM17jV3+nhUaIO8GKCyhVG1PeNxTpmeh7CIIK8iLV7hTP
         v5VNVp+D32yvBdNdVY15b50wKe6sKtHVPV0ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8V25O9GYxPP08UjsTrSAXuZaUN2B3+YItzTAVwD6sSg=;
        b=BQtzhLkCKK+PRRO+cS7V+X5V5kTrFEnmGKZpnipU4E2JBcUf+/CJZADfHxMWWnRvRK
         VLTg39M+9UKZ6EK9hRl6qe3eFpzrLvxGr8t6/dVeq1Gzf+7tBeFlpFQYKLUKM9VKuYgz
         JiT8Dl5dWrG2x2rPVDYMzXM/0ATEcjosKHBQyEZag9VH9sPpi/8RW9wd3rcnZFTitsGV
         TOVx9kA6Xs6MfM1A14pxn7992mNi3eGv0cBKC12Ofux2fsCYkam48aHmr1PE7Vv9jKW3
         A+EDIu8Nm7wB5/VAY7uJKR2d9ksTVbI8d+tI+a7YBF+msFPB0VNC477BHxE/TGSNM+qu
         cTqA==
X-Gm-Message-State: AOAM5339FxVupvAbmXs7tt2/cMpLPpWO7/KbF8ShsFfy3ctkbuOaEl3Z
        7uskZmp4o5KlzI8MGiuFSz5gTwP1qlWEvducrTSlC0ws1jPuyg==
X-Google-Smtp-Source: ABdhPJzFIEzlayJbc8puDrgbDGaqrIK0mzqobwQtMVJQV/1fuTdhXaLAYKepB1sf6n0KyI9HMzUVHL2sC9vrHl1co8M=
X-Received: by 2002:a9d:4b99:: with SMTP id k25mr17762932otf.281.1600269857273;
 Wed, 16 Sep 2020 08:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200914132920.59183-1-christian.koenig@amd.com>
 <40cd26ae-b855-4627-5a13-4dcea5d622f6@gmail.com> <20200914140632.GD1221970@ziepe.ca>
 <9302e4e0-0ff0-8b00-ada1-85feefb49e88@gmail.com> <20200916095359.GD438822@phenom.ffwll.local>
 <20200916140710.GA8409@ziepe.ca> <8db2474f-ecb7-0e17-5f5b-145708fe44d5@amd.com>
In-Reply-To: <8db2474f-ecb7-0e17-5f5b-145708fe44d5@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 16 Sep 2020 17:24:06 +0200
Message-ID: <CAKMK7uFdwrT3HACPh3ADAKvhXJ-Hf3dExZmgJVAQ1KKjSai_0w@mail.gmail.com>
Subject: Re: Changing vma->vm_file in dma_buf_mmap()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 4:14 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.09.20 um 16:07 schrieb Jason Gunthorpe:
> > On Wed, Sep 16, 2020 at 11:53:59AM +0200, Daniel Vetter wrote:
> >
> >> But within the driver, we generally need thousands of these, and that
> >> tends to bring fd exhaustion problems with it. That's why all the priv=
ate
> >> buffer objects which aren't shared with other process or other drivers=
 are
> >> handles only valid for a specific fd instance of the drm chardev (each
> >> open gets their own namespace), and only for ioctls done on that chard=
ev.
> >> And for mmap we assign fake (but unique across all open fd on it) offs=
ets
> >> within the overall chardev. Hence all the pgoff mangling and re-mangli=
ng.
> > Are they still unique struct files? Just without a fdno?
>
> Yes, exactly.

Not entirely, since dma-buf happened after drm chardev, so for that
historical reason the underlying struct file is shared, since it's the
drm chardev. But since that's per-device we don't have a problem in
practice with different vm_ops, since those are also per-device. But
yeah we could fish out some entirely hidden per-object struct file if
that's required for some mm internal reasons.
-Daniel

> >> Hence why we'd like to be able to forward aliasing mappings and adjust=
 the
> >> file and pgoff, while hopefully everything keeps working. I thought th=
is
> >> would work, but Christian noticed it doesn't really.
> > It seems reasonable to me that the dma buf should be the owner of the
> > VMA, otherwise like you say, there is a big mess attaching the custom
> > vma ops and what not to the proper dma buf.
> >
> > I don't see anything obviously against this in mmap_region() - why did
> > Chritian notice it doesn't really work?
>
> To clarify I think this might work.
>
> I just had the same "Is that legal?", "What about security?", etc..
> questions you raised as well.
>
> It seems like a source of trouble so I thought better ask somebody more
> familiar with that.
>
> Christian.
>
> >
> > Jason
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
