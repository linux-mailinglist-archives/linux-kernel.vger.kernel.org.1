Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B726C91C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgIPTDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgIPRsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:35 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F1FC0A888A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:42:04 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x69so7912420oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=czd653EAQqRd9y6KWSclqvh0oWs0wM7+eL3iGSU/nsI=;
        b=Lu3BjPbRiC/AX011FfwezqvylAv3ZKt1PhgO2s9ivkaAdFT+L+aU0tlTbH9aGB3QdD
         ZRH99A3CPlO3UqmOgNoRm+sYa3H4f9liy9wkSbTEbzeH6grEkhQUdoV/KEkl0b+7g6Fl
         aZYv0CeL8ooRR1NM3VZWi8l0zPzoTUe7oUQL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=czd653EAQqRd9y6KWSclqvh0oWs0wM7+eL3iGSU/nsI=;
        b=lVzyHWJE6k5kjcIOgj08rpMj3kMDR6NX2k26I776JTBZL1R6J4m+wb5pPyuhQp6d5t
         TQQAQwhAr/vnbvcUFpvWqkV2Myp4WiRJP3mivIOmHvxgDJyvClet29J7UY/v3cXll6Hw
         nB4U2mDlfHCkW22veHTCaRmJ5oavZNvrF7vlGiJJQa/stoDKyZcK/R/KjBSJYlu5uGL/
         ibrDhQA6AQExSDxaQquR0FvnIO08UAkyjzfWwqb1DDeW/M9Xs3l366ip6aZO3i/xjrbA
         tujO8w6cQjeH/xgvnNM6YqOCEXlgk7fbXoQCG7twaQTeBHqxDeRAqS8Q3s7BQT5ByqB1
         xcSg==
X-Gm-Message-State: AOAM53250qeVBM2aGv80xGYE+4LtECfh/OgIvws2PeM1L+JJ8L7bVs0x
        8q1XN9klHN2nRMQkZgPib8FP4bVOHe6yn6qttzywHw==
X-Google-Smtp-Source: ABdhPJwB+2iScSnSRjswx0wBN3crEjmROMPJs/KcyWAFLMOIPP9Nlf6b8MzVFM61WOlkTuWWi8Wacl+i3PJJq3k7BoM=
X-Received: by 2002:aca:6083:: with SMTP id u125mr3033440oib.14.1600260122457;
 Wed, 16 Sep 2020 05:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200914132920.59183-1-christian.koenig@amd.com>
 <40cd26ae-b855-4627-5a13-4dcea5d622f6@gmail.com> <20200914140632.GD1221970@ziepe.ca>
 <9302e4e0-0ff0-8b00-ada1-85feefb49e88@gmail.com> <20200916095359.GD438822@phenom.ffwll.local>
 <fc8f2af7-9fc2-cb55-3065-75a4060b7c82@amd.com> <b621db68-30b9-cc3f-c2c0-237a7fe4db09@amd.com>
In-Reply-To: <b621db68-30b9-cc3f-c2c0-237a7fe4db09@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 16 Sep 2020 14:41:51 +0200
Message-ID: <CAKMK7uGJVMj6Sb1nDTBoY8SsXc55y2ypUEsGhNLOkbbjFLuYfw@mail.gmail.com>
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

On Wed, Sep 16, 2020 at 1:45 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> [SNIP]
>
> But Jason pointed me to the right piece of code. See this comment in in m=
map_region():
>
> /* ->mmap() can change vma->vm_file, but must guarantee that
> * vma_link() below can deny write-access if VM_DENYWRITE is set
> * and map writably if VM_SHARED is set. This usually means the
> * new file must not have been exposed to user-space, yet.
> */
> vma->vm_file =3D get_file(file);
> error =3D call_mmap(file, vma);
>
>
> So changing vma->vm_file is allowed at least under certain circumstances.
>
> Only the "file must not have been exposed to user-space, yet" part still =
needs double checking. Currently working on that.
>
>
> Ok, I think we can guarantee for all DMA-bufs what is required here.
>
> While searching the code I've found that at least vgem_prime_mmap() and i=
915_gem_dmabuf_mmap() are doing the same thing of modifying vma->vm_file.
>
> So I'm leaning towards that this works as expected and we should just doc=
ument this properly.
>
> Daniel and Jason what do you think?

Well I can claim I started this, so I started out with naively
assuming that it Just Works :-)

I think we already have vgem/i915 prime testcases in igt which try to
excercise this mmap forwarding, including provoking pte shoot-downs.
So I think best would be if you could also add a variant for amdgpu,
to make sure this really works and keeps working.

Plus ofc the documentation patch so that core mm folks can officially
ack this as legit.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
