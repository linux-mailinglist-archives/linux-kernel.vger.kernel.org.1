Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688011DE136
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgEVHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgEVHoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:44:46 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5FFC08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:44:45 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a14so9834928ilk.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCkLyZXcgLXsj7dmJQa9iDLscNMkrkvWsu5Kx85OjLg=;
        b=ge+b+0kLRvCWW+i7FZpDx3vEx/9YzZzTihd0/kwhJML/57n7AN8tpGRlBKOd+v/Vkq
         MlxvKA+QiiJgfLN2IMjGjgls4JTBYwCh5dcsZV0voXh1SJfMbIUYGEVZDExaAXMjR3pa
         CKh1er6geLM8qsCE1e0SxIxJeURG2LJHvzNxit1NXDK1sPbtEhbTGDwYa9nhr9S8RWX2
         JkvxTxEfzcF8tSYMk40YQL/8EzhgTte5EbE1gvYUFSKrSOWSIszGfPqf7X37cvEcPmiv
         HtMLTvK3kwmmT4cJ1y/3uuYXGkJ0n7Yt19IT8mO/KAmbN5lRd5Gbl+V1Hb+NVkOed3T5
         CrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCkLyZXcgLXsj7dmJQa9iDLscNMkrkvWsu5Kx85OjLg=;
        b=nC1Xog94CLPzIyXR1NhtrzCTxnRiKBHXcE2F3tylR7/QSW3yh3MiHOKHARgdJgZcU1
         nsONthVfofr2pbleRFl371cjRfRg6p4ofkp/8h6P4px8kgNx32rMxa9y+XnOsxBTZioO
         R6G2KwEjEp9Wsn5grPPS9egXB9Lgb0aPk3POm9bB67zOBBHSBTN5+eu3lCc3g/z27RmE
         RZ7T0HVQz8tPJ4OUdGciFhNpEQpMBfl4JB47AG4X4H9r7afG6AxCqFEWlIltsCxMZ0jI
         o8I+bqvxAj+wiBn59T1C8Cqu/kQDAPXXTBg9fadFSJ7yS/4nnHsF5mPQ9TPRnggfZfMk
         Xshg==
X-Gm-Message-State: AOAM531smypWDTFLXXD1rRYrhozuOqVhU2YTmfOxYr9jRyTQLBFbk0Vf
        zzWAU41Yb6V7y03gnyZ54bCYkaWgaio2xQcFbAdsOg==
X-Google-Smtp-Source: ABdhPJyMFYW+VQGw9RND8F1TlWx6v0Sfg+2mzq6aucXwYl+4J0CTaHFg5jMebQ8YJqZw5nl76kjU2nOYVhi3sG6Wx5A=
X-Received: by 2002:a92:d946:: with SMTP id l6mr12913271ilq.6.1590133484494;
 Fri, 22 May 2020 00:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200520112523.30995-1-brgl@bgdev.pl> <20200520112523.30995-7-brgl@bgdev.pl>
 <CAK8P3a3jhrQ3p1JsqMNMOOnfo9t=rAPWaOAwAdDuFMh7wUtZQw@mail.gmail.com>
 <CAMRc=MeuQk9rFDFGWK0ijsiM-r296cVz9Rth8hWhW5Aeeti_cA@mail.gmail.com> <CAK8P3a1nhPj6kRhwyXzDK3BGbh66XG6Fmp44QuM1NhFPPBTtPQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1nhPj6kRhwyXzDK3BGbh66XG6Fmp44QuM1NhFPPBTtPQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 May 2020 09:44:33 +0200
Message-ID: <CAMRc=MfVkbDSfEV71SD57dpYthdx5epD0FOvjRx8qQGT+SgsTQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] net: ethernet: mtk-eth-mac: new driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 20 maj 2020 o 23:23 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a)=
:
>
> On Wed, May 20, 2020 at 7:35 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > =C5=9Br., 20 maj 2020 o 16:37 Arnd Bergmann <arnd@arndb.de> napisa=C5=
=82(a):
>
> > > I just noticed how the naming of NET_MEDIATEK_MAC and NET_MEDIATEK_SO=
C
> > > for two different drivers doing the same thing is really confusing.
> > >
> > > Maybe someone can come up with a better name, such as one
> > > based on the soc it first showed up in.
> > >
> >
> > This has been discussed under one of the previous submissions.
> > MediaTek wants to use this IP on future designs as well and it's
> > already used on multiple SoCs so they want the name to be generic. I
> > also argued that this is a driver strongly tied to a specific
> > platform(s) so if someone wants to compile it - they probably know
> > what they're doing.
> >
> > That being said: I verified with MediaTek and the name of the IP I can
> > use is "star" so they proposed "mtk-star-eth". I would personally
> > maybe go with "mtk-star-mac". How about those two?
>
> Both seem fine to me. If this was previously discussed, I don't want
> do further bike-shedding and I'd trust you to pick a sensible name
> based on the earlier discussions.
>
> > >  +               /* One of the counters reached 0x8000000 - update st=
ats and
> > > > +                * reset all counters.
> > > > +                */
> > > > +               if (unlikely(status & MTK_MAC_REG_INT_STS_MIB_CNT_T=
H)) {
> > > > +                       mtk_mac_intr_disable_stats(priv);
> > > > +                       schedule_work(&priv->stats_work);
> > > > +               }
> > > > + befor
> > > > +               mtk_mac_intr_ack_all(priv);
> > >
> > > The ack here needs to be dropped, otherwise you can get further
> > > interrupts before the bottom half has had a chance to run.
> > >
> >
> > My thinking was this: if I mask the relevant interrupt (TX/RX
> > complete) and ack it right away, the status bit will be asserted on
> > the next packet received/sent but the process won't get interrupted
> > and when I unmask it, it will fire right away and I won't have to
> > recheck the status register. I noticed that if I ack it at the end of
> > napi poll callback, I end up missing certain TX complete interrupts
> > and end up seeing a lot of retransmissions even if I reread the status
> > register. I'm not yet sure where this race happens.
>
> Right, I see. If you just ack at the end of the poll function, you need
> to check the rings again to ensure you did not miss an interrupt
> between checking observing both rings to be empty and the irq-ack.
>
> I suspect it's still cheaper to check the two rings with an uncached
> read from memory than to to do the read-modify-write on the mmio,
> but you'd have to measure that to be sure.
>

Unfortunately the PHY on the board I have is 100Mbps which is the
limiting factor in benchmarking this driver. :(

If you're fine with this - I'd like to fix the minor issues you
pointed out and stick with the current approach for now. We can always
fix the implementation in the future once a board with a Gigabit PHY
is out. Most ethernet drivers don't use such fine-grained interrupt
control anyway. I expect the performance differences to be miniscule
really.

Bart
