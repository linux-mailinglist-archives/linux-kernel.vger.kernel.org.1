Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E6268ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgINMYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:24:37 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37284 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgINMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:21:16 -0400
Received: by mail-yb1-f195.google.com with SMTP id h126so11659775ybg.4;
        Mon, 14 Sep 2020 05:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdE+LuX+2Qm0gSEGuHp+5gVUIvIevbsDt3zyJVz18a8=;
        b=q7lMlPShKuNP/naeiX+TIkbDR9NIp5fLxRRB9IcV2jkwebfUAi7sBAjFiZdZG6Z6vy
         AeRrPW2ZIU3YZRrBPEBKCH3ECTkwa1pUFHfIjzhhlthn7i/TaCLbVZghidhD9Nmxt1yF
         zHPiu/r+zxS5LeYVJ2Q1sdnyiIshIYnN2MHE5omg5YhfvDzxVZMqdZpktWBxQ3a7CmUV
         6hi0EddUtZ2k0NXr1FtZ05DkR4g0atDjjTh3n3GJ4hrBaRrvnIJX7qeum9FAAt+tFxWC
         rp6zy34t9RK8y2Gmvd2cqOMUAkfrMk/Ec/A/jS8Y6JrREoNchG4b7tcCDryALXJaYqH+
         hVNQ==
X-Gm-Message-State: AOAM531x1kLJ+Z7Ei5BGBgxxfqFrDNda6UNtqk7gDJTuSpyS+xjzvrLk
        wnBofxoAe05SbY3vpk/TFcD23SVxq3MVGne3yKjhF1Jg7r8=
X-Google-Smtp-Source: ABdhPJzUxCOjVtmAzH9z/y7jXufNCW8ofbrULZBtHNZfFSSc9+zcC9VH4EYPvpflzezGIBdaiPfjNspKcpw1qV1m7Vc=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr8304418ooa.1.1600085409099;
 Mon, 14 Sep 2020 05:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200911101912.20701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200911101912.20701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Sep 2020 14:09:57 +0200
Message-ID: <CAMuHMdU0YuF2DqndABE5RGS1ymK2hqFyim6aYsqnPkW_PHe9xQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: Kconfig: Update help description for IPMMU_VMSA config
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 12:19 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> ipmmu-vmsa driver is also used on Renesas RZ/G{1,2} Soc's, update the
> same to reflect the help description for IPMMU_VMSA config.

... update the help description for the IPMMU_VMSA config symbol to reflect
this?

>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
