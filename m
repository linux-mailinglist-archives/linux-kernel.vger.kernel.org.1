Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F082783A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgIYJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIYJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:11:22 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76B5C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:11:21 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id h23so478953vkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWJwSkHcQYbNKOEWZ1TVdIJh2rPz2r71PSLyhlvFLUY=;
        b=YT92ZyhcCSVct41NNQJ5H+v81DH6N1/Fnpgnd2suwGKDa9o/WkzKzVBD0cv5tjXW6b
         gbauj156FnyzRcly7lGjMDF7C0FMl0mpSP3FK8ozUizc2poL7h3CF7JkfkaP7r/3cYJJ
         2/2HcNxFG/PN129V+7xqesUxl9evRU8A24jS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWJwSkHcQYbNKOEWZ1TVdIJh2rPz2r71PSLyhlvFLUY=;
        b=OXjenl3BEt/NlMht4B2zIEM/PaxiItYiQxrJ/6MJFNIVtbdgnszTJnAuiH0TTm++MC
         4M9La0IfjKkHlKDVpxgPJR/xgXPap4jjcrtojX3ww2WktnbjjNgD5sKM3AG4f60thevS
         xbXflxPlks0DfUfZoAUGANrIo0vUHVzSXzARv5CsDkmqPSYuv2vK08fBqCAu3jZv4EMo
         Z7AslS3Ob5i5dZURhz85y3JNWQnHG9puHlaeqACGC5lurJczuwVxvf59SjSpHrgf0Wbi
         r0eynHZv/diStWOIjMvTjZ8M3pmb3oZP4CZC+q0YuzxUtYSxMl3gjGuq/EnTfmtlzahn
         WOgA==
X-Gm-Message-State: AOAM532YtUZzJCAp4fLAOYFw80y7e1ifPKCUUqM6dUhPN4YExAZ1RhAM
        UwZCpvn7x5kA3l0/iKLpSu9yIE62vU46SLxxdwye4w==
X-Google-Smtp-Source: ABdhPJxuiIE50tiO0iM0XKiceVHkTJpArQPlcp7pIYzNrV16sQaJzDwMqt8DYhjynnNrl2S33JiyhZ3ih3qhCGU0LVU=
X-Received: by 2002:a1f:434b:: with SMTP id q72mr1948481vka.5.1601025081001;
 Fri, 25 Sep 2020 02:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200925065418.1077472-1-ikjn@chromium.org> <20200925145255.v3.5.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
 <CAJsYDV+EifAeMKEGwi0oH6A5EvPN8tMZQ+oqY5JGe=+kqzjMLw@mail.gmail.com>
In-Reply-To: <CAJsYDV+EifAeMKEGwi0oH6A5EvPN8tMZQ+oqY5JGe=+kqzjMLw@mail.gmail.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 25 Sep 2020 17:11:10 +0800
Message-ID: <CAATdQgC7GQ5fhkFBg7y6fpzdbFAiv+3ONdnk+jLytumB7a9pXQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] spi: spi-mtk-nor: support 36bit dma addressing
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 4:27 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>

[snip]

> > +       if (sp->high_dma) {
> > +               writel(dma_addr >> 32, sp->base + MTK_NOR_REG_DMA_DADR_HB);
> > +               writel((dma_addr + length) >> 32, sp->base + MTK_NOR_REG_DMA_END_DADR_HB);
> > +       }
>
> I remembered kbuild test robot reported a warning on this on 32-bit platforms
> in your v1. [0]
> I don't know what's the fix for this though :(
>
> [0] https://marc.info/?l=linux-spi&m=159982425706940&w=2

yeah, I'm not sure how to handle this properly,

"warning: shift count >= width of type",
(sp->high_dma) is always false on 32bit arm kernel.
I think adding size check on here is unnecessary, should I fix for this warning?

> --
> Regards,
> Chuanhong Guo

Sorry for resending, Chuanhong.
