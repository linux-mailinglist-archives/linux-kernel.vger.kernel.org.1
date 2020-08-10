Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82282241229
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 23:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHJVP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgHJVP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:15:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8832C061756;
        Mon, 10 Aug 2020 14:15:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l2so9498964wrc.7;
        Mon, 10 Aug 2020 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+iG0rPie0hGjlqBkimyNljZ85YQMu0uvsdwoC84m+No=;
        b=k4HUFyf+BceKxHAdT4A8JrLP35Ktd/vLhR11JAVViOn3b5YEPr+PgGF4NDrE0X0F9g
         EtK3inRncxd4qoQQ3dca8VQxl194uuWnR4aESyHwGOrzPUF+SGTxZMMBzHK0VgomCBHw
         BOrG4uelEGMS63t5DCMz2ktzxSS9oTdzbLtFunyu723WtYerYLD8uzXQBqMMreUDOVCd
         meue7f70Q/12rN3oOYL2WONEZkCVM1Q7VkOjuyYzbVJ3Yf3dQzcVEU5Q8Yzj35KrkWni
         dj/UQHKDGJ6/Js4Ul4BXGu4INFqr6aUdZBuYSIL0MkJMyKeG0gRBe8wrc3mgwWkI/N5u
         vg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+iG0rPie0hGjlqBkimyNljZ85YQMu0uvsdwoC84m+No=;
        b=RybTGOh30tmKz2UWWpHC76TTlZ9Rraqxt2loHt2SOhN8hXJkzIZPV4b2j1Lp/ipKTV
         lSMQzrM9+aHpEZhIY9QOwRwsfB7idPFrNKY3PnaYWWLgCqiLu73u/zBfc69QB9CSvGZh
         VLOBCr69wAdJH3Wun90Ez0878Wix3Sp7/XPcrexv5o/w3goKwpiewjgicQYDcvna3Cxr
         xFttx4JgXF7nxh/h6ATcFN/gCNwzbKIvB5GOwSq8jkwTymRCKqdbI081oPWxbeE7K1Y4
         FGm3Djom/DrHEASCkWKH6QPEzdJ9aD+PvtO/Yp3NXo7nXv+0spJ1vDq1GD8C0T5XiMWY
         BaJQ==
X-Gm-Message-State: AOAM530jwP6UjMKhWMJ53sbpnoyljn9+4y1CnMfZtjYXpZNgXA4MtmF8
        6j+/qA8SrP4PHDtgEEJvolYbXNsaWRLZyyqdYrM=
X-Google-Smtp-Source: ABdhPJyo9VaZLguZx1FF1wevl9ZhOdjkbjDW75ZekxD0csEl1es3BieqGxzgri3k5dRW/9uzGQhPDjZyl33aMhozIyU=
X-Received: by 2002:adf:a351:: with SMTP id d17mr26017853wrb.111.1597094155668;
 Mon, 10 Aug 2020 14:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200809203406.751971-1-christophe.jaillet@wanadoo.fr>
 <20200810154213.GM1793@kadam> <8c414dd7-4a80-6ff2-03de-5340fb0d9c61@wanadoo.fr>
In-Reply-To: <8c414dd7-4a80-6ff2-03de-5340fb0d9c61@wanadoo.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Aug 2020 17:15:44 -0400
Message-ID: <CADnq5_NURN9_ONyXoLd5gMK6mTxotRZiP7N27UC1n_RNpQKimA@mail.gmail.com>
Subject: Re: [PATCH] drm: amdgpu: Use the correct size when allocating memory
To:     "Marion & Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Messinger, Ori" <Ori.Messinger@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Bernard Zhao <bernard@vivo.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Colton Lewis <colton.w.lewis@protonmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied and updated the commit message to reflect the sizes.

Thanks!

Alex

On Mon, Aug 10, 2020 at 3:07 PM Marion & Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
>
> Le 10/08/2020 =C3=A0 17:42, Dan Carpenter a =C3=A9crit :
> > On Sun, Aug 09, 2020 at 10:34:06PM +0200, Christophe JAILLET wrote:
> >> When '*sgt' is allocated, we must allocated 'sizeof(**sgt)' bytes inst=
ead
> >> of 'sizeof(*sg)'. 'sg' (i.e. struct scatterlist) is smaller than
> >> 'sgt' (i.e struct sg_table), so this could lead to memory corruption.
> > The sizeof(*sg) is bigger than sizeof(**sgt) so this wastes memory but
> > it won't lead to corruption.
> >
> >      11  struct scatterlist {
> >      12          unsigned long   page_link;
> >      13          unsigned int    offset;
> >      14          unsigned int    length;
> >      15          dma_addr_t      dma_address;
> >      16  #ifdef CONFIG_NEED_SG_DMA_LENGTH
> >      17          unsigned int    dma_length;
> >      18  #endif
> >      19  };
> >
> >      42  struct sg_table {
> >      43          struct scatterlist *sgl;        /* the list */
> >      44          unsigned int nents;             /* number of mapped en=
tries */
> >      45          unsigned int orig_nents;        /* original size of li=
st */
> >      46  };
> >
> > regards,
> > dan carpenter
>
>
> My bad. I read 'struct scatterlist sgl' (without the *)
> Thanks for the follow-up, Dan.
>
> Doesn't smatch catch such mismatch?
> (I've not run smatch for a while, so it is maybe reported)
>
> Well, the proposal is still valid, even if it has less impact as
> initially thought.
>
> Thx for the review.
>
> CJ
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
