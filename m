Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8312A0E80
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgJ3TW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbgJ3TVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:21:31 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91224C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:21:31 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l62so2090289oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB/MV5GLyjNu8UDfEZUP2zhFQAq8WaUlOhnxP+WLczo=;
        b=Db7ytI3QoTKyC/bdolNU5gUWVNc46g31IGOBQ+DmMtde88iG8cUlKjZYe/983DcDhn
         qWnPuTHZ07E448vG3lG+8TfAGGOQd/Jm+diYaoq9lWNhWlQTZDObhaVr11DeKQPSRu3W
         1IzJaZ+F4GaDe5nt4o+U+ipzq/tCk5aVUlkQ1hQ9GbzA75QiCnd1NtwKBpjDeP1LXYu7
         6zyALkTqMti7sDAEJd9kNDwzPsAHerX6lJAKeHIa/BiD8rOEEL+QaRtbibbexyRGctUK
         s5lYr7r+FNoH2J9GqIvX/vZjg6fd5Jqy+Z9MJKi30pPMjpI1mcCXIa4RAqk66i/gDyNa
         2WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB/MV5GLyjNu8UDfEZUP2zhFQAq8WaUlOhnxP+WLczo=;
        b=MXXigk2P3Hhftf1wiF9/AN7m1EC4GEi4rYDjz2Vy2W2XletpnweBL4lFstenGsFYVg
         icbrA48gMMyWY+BFSUYVLVoPEFv/HPtMKpKNWKOHk+s1TJIKKEhjynhWOdyesfKnzZZC
         zZTCGJjOh6NvMlcQzWFimPmpEeS4CLe64ulAAGK51hcY+iiKyjTeDqPUZToGl0v0Evoj
         ZXJgwXbFVoBUNDX3YfzNzy1N6RX4dERU9r2mLJO/XhpBuUfMHoVlm3xgS+ZDC2sZrcNW
         4/t0N9dygLY0QwEPUW/NIjEyXccWnMtpUI8nV0eiQpUtjp3dtrU6XBZabNqeJU9ie4cD
         fIpQ==
X-Gm-Message-State: AOAM530sknl5J1q/MWjy28QjvYehaUc7VqW3OAtsEYiojlR+Dyekpkhq
        l8mvRsoSA9ZTDMxTOXuxuVuQCARl0c1mYjbIxX2/szy46MQ=
X-Google-Smtp-Source: ABdhPJyJXImIHpK83wwAip/CxzfDZ/jrYC8xy+ZEw+XNXk7wfku+ojOsZNj7E08ou2/Gb2qDLKqgTDw+df7YmNTNNJE=
X-Received: by 2002:a05:6808:578:: with SMTP id j24mr2827168oig.10.1604085690947;
 Fri, 30 Oct 2020 12:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201030075023.3250-1-hdanton@sina.com>
In-Reply-To: <20201030075023.3250-1-hdanton@sina.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 30 Oct 2020 12:21:18 -0700
Message-ID: <CALAqxLXVMnnoRDt8=_qD=ipipC69u35fqDv+vmJ2JWnZtxCG7g@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] dma-buf: system_heap: Add a system-uncached heap
 re-using the system heap
To:     Hillf Danton <hdanton@sina.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        Christoph Hellwig <hch@infradead.org>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:51 AM Hillf Danton <hdanton@sina.com> wrote:
> On Thu, 29 Oct 2020 21:04:30 -0700 John Stultz wrote:
> >
> > But I'll try to share my thoughts:
> >
> > So the system heap allows for allocation of non-contiguous buffers
> > (currently allocated from page_alloc), which we keep track using
> > sglists.
> > Since the resulting dmabufs are shared between multiple devices, we
> > want to provide a *specific type of memory* (in this case
> > non-contiguous system memory), rather than what the underlying
> > dma_alloc_attr() allocates for a specific device.
>
> If the memory slice(just a page for simple case) from
> dma_alloc_attr(for device-A) does not work for device-B, nor can
> page_alloc do the job imho.

Right. That's why userland chooses which heap to allocate from, as
it's the only one that knows the path the buffer will take.

thanks
-john
