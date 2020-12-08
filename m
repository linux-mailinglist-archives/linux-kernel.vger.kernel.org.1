Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A72D2286
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLHEy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgLHEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:54:57 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EDEC061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:54:16 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id i24so8357750edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/HsXaIACwTyoNaST+7tlYLda7+69QnFbCYHF3SGybM=;
        b=NHsKtZ9ZOwK+YAUpwafqbwPyEYnaQlamxFuqZ5sx2/0AONSSemfZtgg6vaRYU7xMnz
         77hLn6qr8fZNf18KjA10NS1l9fT9uZjhO5l20wU8SjXk6PeV+cqAxSBJQCDlYwdIqnKx
         YIKIJbr2H7A/xU0s4wwnhf/QpGitRIJ5AI3KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/HsXaIACwTyoNaST+7tlYLda7+69QnFbCYHF3SGybM=;
        b=X1iwa9/v0m/d/5bl0TD/uVUxMQLG1I8DsLpeRdCTMudnVTwTrORQMAZVsD3NsQXGQZ
         Pf+TTIAUWKimHrchNbePWNF67cEW7jZabTvYH8dQLBztZfg/fD33++EDGnh4IaZcM6Hi
         AB7iHiEoJP1SdPr7LcMgJqO641xtypryDQUBbMBK/2K1bQP/upHHV/aiKwTuZOlNtTrK
         cHOXKkoSPpwPhWHNN7fFCxAj05p7JK8VcQ7og610I8l6MFZvbjqCYMybHbECciArbcbx
         h3uwuLaj1jn7VmI3XNVh9jOSsbomZT3bGcxb+NuRwS1P0BuIqa2HzEo/VD4bBrcrW9yt
         zNeg==
X-Gm-Message-State: AOAM530MFCJZJ+VT5S7yp8LthpONNTQGrGjHUwY8phxfff+Kzut9DklZ
        wvRYiVtDWYfiUWUJqopjCmscKINMHSzUlQ==
X-Google-Smtp-Source: ABdhPJw+9L3aVwcJZjs7N0msz/iizvyOhNt00nV9VQolU7+zSx/2EUTTGueHlHIMR3Tk3jMaLPdqfQ==
X-Received: by 2002:a50:ff0c:: with SMTP id a12mr23222754edu.79.1607403255117;
        Mon, 07 Dec 2020 20:54:15 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id a6sm15854247edv.74.2020.12.07.20.54.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:54:13 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id x6so10977211wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:54:12 -0800 (PST)
X-Received: by 2002:adf:f881:: with SMTP id u1mr22668227wrp.103.1607403252411;
 Mon, 07 Dec 2020 20:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org> <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
In-Reply-To: <20201201144916.GA14682@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 8 Dec 2020 13:54:00 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
Message-ID: <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
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

Hi Christoph,

On Tue, Dec 1, 2020 at 11:49 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Dec 01, 2020 at 12:36:58PM +0900, Sergey Senozhatsky wrote:
> > Not that I have any sound experience in this area, but the helper
> > probably won't hurt. Do you also plan to add vmap() to that helper
> > or dma_alloc_noncontiguous()/sg_alloc_table_from_pages() only?
>
> Yes, I think adding the vmap is useful, and it probably makes sense
> to do that unconditionally.  I'd also include the fallback to
> dma_alloc_pages when the noncontig version isn't supported in the
> helper.

From the media perspective, it would be good to have the vmap
optional, similarly to the DMA_ATTR_NO_KERNEL_MAPPING attribute for
coherent allocations. Actually, in the media drivers, the need to have
a kernel mapping of the DMA buffers corresponds to a minority of the
drivers. Most of them only need to map them to the userspace.

Nevertheless, that minority actually happens to be quite widely used,
e.g. the uvcvideo driver, so we can't go to the other extreme and just
drop the vmap at all.

In any case, Sergey is going to share a preliminary patch on how the
current API would be used in the V4L2 videobuf2 framework. That should
give us more input on how such a helper could look.

Other than that, again, thanks a lot for helping with this.

Best regards,
Tomasz
