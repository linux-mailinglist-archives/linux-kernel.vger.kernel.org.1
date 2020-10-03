Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A871928239F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 12:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJCKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJCKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 06:31:16 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C189C0613D0;
        Sat,  3 Oct 2020 03:31:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d197so4218404iof.0;
        Sat, 03 Oct 2020 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEW03emwbM/iyY0SspYu2AMTNIV4tsnpwwvPwoBdGRc=;
        b=OmnM9u+2AJV5cpYnayIjs0x0nrt2lSRUbj/RBhjWviYVFrh/HNGGFYbut+t3NX0s/e
         cELmxnbXE2SO1qAR59PzLrUuMFTZXCM6u9S3KtkT6/Z4AVbKF/gt7lA8j9iLmKMB/KC7
         fkXfpTtitU6kbGcDJTYZp5rn9I0x/MqgGRQS+vLQJBJWEgyt/EjdntghLwSLFFn/EaZT
         PG3FYCsDErz/mnabOpHNoDfDbQSHccNRLyJI59wYPLSnUEN5aE4n2a1iQuK8cGFza1Jg
         EY2cxZ1HLouhvbZ4KWlMW4RqqgVYr8vBDMgrhROgaRIUDRHFD9kMj63YS7E+blJc88Rw
         xkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEW03emwbM/iyY0SspYu2AMTNIV4tsnpwwvPwoBdGRc=;
        b=n/QObwIgUccOoPOryWLo/VWNaHb1jL42fOGNKjni9Z4toQVJK63WK1xZ3ImNRoOj+J
         GA8UGg68gbkYZWaXnkupfMO3ozTE9oP1CF7TTZakxgc8TGUjW3/GeR/Rl2gzdh8/EPXl
         zJXsPLHY73iEknRddswuN+tBobvBI4KJ+EKFaQw2/0xmK7jtrA+QO28O1F1m0YKjS99A
         tuiTJZzmpUkyZxKM6n1B/XTTf/jG3ZsYVTkc8d4QoH2HlgYETzFsCkAugAPJEjdZl0FU
         5C7F66pFkyuoQi6yDFF9GIOoPAc40EkKxWItYy/QlEJJBP06AxW16x0sG+q0ZhEi9/z5
         lecg==
X-Gm-Message-State: AOAM533KNusC9F6u90DYb/duBvhaxPxsBvHAPMCzg78h+ajrOD3Gvle1
        2Sa09/ecrgY+xBUF9p2Tl9Z8+OJyzsJoZVkKCzQ=
X-Google-Smtp-Source: ABdhPJypIXF2h3NouDp9HchvAsrQmwG8yx+yBR5+KrGawyAPeQ/FYfzZFaIJybHADJW857uITXwr4+iyNB9xI1B/F2U=
X-Received: by 2002:a02:8791:: with SMTP id t17mr5648145jai.89.1601721072584;
 Sat, 03 Oct 2020 03:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200923005709.147966-1-icenowy@aosc.io> <20200925151241.kfmytlff4grswtzh@gilmour.lan>
 <CAJiuCceT3NxwYSZKkCbMy5kfxgyN+iZcRwtHEorg6xGNnFhZzw@mail.gmail.com>
In-Reply-To: <CAJiuCceT3NxwYSZKkCbMy5kfxgyN+iZcRwtHEorg6xGNnFhZzw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 3 Oct 2020 12:31:01 +0200
Message-ID: <CAJiuCcdTTtyNjMnO7KqpuGC9gD9YtHtHd1oxxQPBB79kJ6okYA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 0/7] Pine64 PineCube support
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 25 Sep 2020 at 17:12, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Wed, Sep 23, 2020 at 08:57:02AM +0800, Icenowy Zheng wrote:
> > > Pine64 PineCube is an IP camera based on Allwinner S3 chip.
> > >
> > > This patchset tries to add support for it.
> > >
> > > In order to make sure the system do not hang when camera is brought up,
> > > a fix to AXP209 driver is needed (sent individually), otherwise the
> > > system will hang because it changes the voltage of LDO2 when LDO4
> > > tweaking.
> >
> > Queued all the patches for 5.11

I was on top of sunxi sunxi/for-next branch

Maybe I'm missing some dt-bindings merged in another tree.

Sorry if it's a false warning.

Regards,
Clement

> >
> > > Icenowy Zheng (7):
> > >   ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
> > >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
> > >   ARM: dts: sun8i: V3/V3s/S3/S3L: add CSI1 device node
> > >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel CSI
> > >   ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for I2C1 at PE bank
> > >   dt-bindings: arm: sunxi: add Pine64 PineCube binding
> > >   ARM: dts: sun8i: s3l: add support for Pine64 PineCube IP camera
> >
> > However, I guess for the next patches to the v3s DTSI we should just
> > have a simpler prefix (like v3), it's really taking a lot of characters
> > here :)
> >
> > Maxime
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200925151241.kfmytlff4grswtzh%40gilmour.lan.
