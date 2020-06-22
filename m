Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50C2032CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgFVJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgFVJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:04:44 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B77C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:04:43 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id d64so1074953vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hwidXab7KcGUBateRVXW8zpxh0rBFCmS1LBPPNCnOFs=;
        b=yMwSFW9zn/x4voNySBTlnA26fMQCe4mTWRT02T7FplbayAJ04otvMsASKWc9/mo6jF
         NCbgO3o4LZvSVnMWo9ZAGeT9aIS+j2p5q35tzoV5hI3hUXT3n8foHNu96J0NmK7XFhXY
         RJfsg3taQ+egVgLEXi1g5+mL2IkbqBXh/nZZJjhIpgb4GvqfNp6PJ4I/fzS4uzN0512k
         dg2OvIB1wckClNQPR8wJEj8enOKvi5Q4CyvYEB4mhiJN1sqhfaCzn67EX5enZ4fWse1B
         xLZQVxhTmpkbhDcoqyGRAbHCvd/kj555Mht2nywkotfdw/kw5emLe8bAM/VNLUxmX0pk
         aFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hwidXab7KcGUBateRVXW8zpxh0rBFCmS1LBPPNCnOFs=;
        b=Sr3Guj4Eg7MtuG6Al5x7FQlUhSFT2PKeungFs5n+bMTB3lVgJai6qHyassclzcWxP/
         XvXI8xkZXh29AMozsFhro3ZRkYGw0qb4ZCKfM1YM2JX1YVa/CG17UgWfIIn5RCzh9p0c
         uMMpUjqZjLIJyop4Ta/n0ifJPYFMZTJGMAvzL7OFtqceEh3tpFym1VAMJ0gb4yoMNesb
         s2yP42iWP94Zu8cJDTGJmj/Ix/LCbCZtFWTQ9UXSnNWPlqPadU3mmv8JqxgBV0MxV4RC
         H370YMsmeX0xhN+8TcSAdqMaOaqtAlTwquSNpNgaNdVOqT+hucn7gn1XRu/+JAgZC4Mo
         v5Eg==
X-Gm-Message-State: AOAM531pEGiBrEpm+FKdSZMSvos0rTiEDL9CS0K80lZ3KtngR+R+yghS
        saSVDEy3GBUCRQfwbg3JAbBPKQMQVQ1X4Hq93zNbWw==
X-Google-Smtp-Source: ABdhPJyYmko8VFPBAPnfwHC3JEX6GmA+fgmMjI/QiUkeFxLgLTGx8SZ1A85OHGZzC1aUZkecXh9bz8L+3a6d3inzdaY=
X-Received: by 2002:a1f:b202:: with SMTP id b2mr15315183vkf.86.1592816682850;
 Mon, 22 Jun 2020 02:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200618133818.15857-1-narmstrong@baylibre.com>
 <20200618133818.15857-2-narmstrong@baylibre.com> <20200618162849.GH954398@dell>
In-Reply-To: <20200618162849.GH954398@dell>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 22 Jun 2020 14:34:31 +0530
Message-ID: <CAHLCerOvR2adMOyADyQhhm6TrLd=eaCoMMUzk+nJH-6mwgr7GQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] thermal: add support for the MCU controlled FAN on
 Khadas boards
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 9:58 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 18 Jun 2020, Neil Armstrong wrote:
>
> > The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
> > on-board microcontroller.
> >
> > This implements the FAN control as thermal devices and as cell of the K=
hadas
> > MCU MFD driver.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> Is this an Ack?

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> If so, do you require a pull-request?

I'll let Daniel comment about the PR but AFAICT, this can get merged
through the MFD tree.


> > ---
> > Hi Lee,
> >
> > Could you apply this patch via the MFD tree since it depends on
> > the linux/mfd/khadas-mcu.h header ?
> >
> > This patch is unchanged from the v3 serie.
> >
> > Thanks,
> > Neil
> >
> >  drivers/thermal/Kconfig          |  11 ++
> >  drivers/thermal/Makefile         |   1 +
> >  drivers/thermal/khadas_mcu_fan.c | 174 +++++++++++++++++++++++++++++++
> >  3 files changed, 186 insertions(+)
> >  create mode 100644 drivers/thermal/khadas_mcu_fan.c
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
