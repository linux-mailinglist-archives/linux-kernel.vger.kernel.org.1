Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860ED2A4EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKCSg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgKCSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:36:55 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA0C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:36:55 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id e16so2690871ile.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYbQzlD7g6CgMEWc3wST+ZDYhV+JHgWV0zK7h/WfMj0=;
        b=iG5fZ4XP9AuvacaY3DzFjo+WannOzars7jtIdP0wgaDlrlYSJvqAaB6jd7l1j4CO8p
         9/kZcI/PuZpz3E7mNyYf0nvFqoK5bHBPZQH6nRMdWE5/zcPThauK4IdPzuZBEUeI/TpB
         OktHTxoGsI4069vUpZ22tgkm1d/C77ndMad64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYbQzlD7g6CgMEWc3wST+ZDYhV+JHgWV0zK7h/WfMj0=;
        b=jAE7GBnD9RejqNdKIBlCTBdDF4aZ5qVUh8zuc/wuURs9Oy0pab9XbnXK7cfVDhOs7q
         xsBO+7glfOpeteXdUyFm8J3DA1YbxstwrrE0jSgbrtdY8a5D3vi1a88+xoo9eVahOkcP
         o/dKrHBzY5uSgrGQZfdb7KP8J9+TVNjeA6noKdIZFOH70USVAof+DGIQ/HkgKp4d43xY
         NFYl5yBvBLdh/9svsFb6c+PNQjsV7B8bE5QRmXe+janGsryrIQLJ2vTlMJinKtblz7J6
         UI1GHeR/ymqaDa0fnpLXvEupibTP2lgSC9RKbJJCiuWN3SSlUN/ykLRiBC8ZKcR4e1W3
         iqTA==
X-Gm-Message-State: AOAM532GG2KNlFHFuWqew3lFR4gE0HMP2YLUlaBcCzF4/V12GvnKdubO
        MYK+86Uc4hY9IWH20NbqYvKA9EA0GXoelV/NBIz6
X-Google-Smtp-Source: ABdhPJx+f5Ogky6p999+76oktJVi6X+vrRgYJsuz5k2oZd0lveLH427nrSylT9VxPXleQYaNaD7hBezO9gV6D/ZVbcc=
X-Received: by 2002:a92:3305:: with SMTP id a5mr174396ilf.219.1604428614935;
 Tue, 03 Nov 2020 10:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
 <41f1248b-78c6-bac1-410b-9e222368c5f6@codethink.co.uk> <CAOnJCUJhQ=Zv0S4iCK4CDzQr_dfkw3J6ycdM=p6=5B2_sL1Ekg@mail.gmail.com>
 <2d7cc829-5df6-6b94-4c8f-9bae6080444e@codethink.co.uk> <CAOnJCULejyF9xyLk5M0TXqW_=nn0KM5aE8nhK+1h0Xayd2pKUg@mail.gmail.com>
 <fbe404b5-3bb1-dd00-e558-e4a55960b767@microchip.com> <fe079b4a-5410-5cc8-3f5e-8a95b573078a@codethink.co.uk>
In-Reply-To: <fe079b4a-5410-5cc8-3f5e-8a95b573078a@codethink.co.uk>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 3 Nov 2020 10:36:43 -0800
Message-ID: <CAOnJCUKH77XDymG+jAUYHP+5TC2aabTR4f8jF6s6FqqQNR=_CQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Cyril.Jean@microchip.com, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <Daire.McNamara@microchip.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Padmarao Begari <Padmarao.Begari@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 10:28 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 03/11/2020 18:10, Cyril.Jean@microchip.com wrote:
> > On 11/3/20 3:07 PM, Atish Patra wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> On Fri, Oct 30, 2020 at 2:20 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> ,snip[
>
> >>>> @Cyril : Can we enable both eMMC & sdcard at the same time ?
> >>> I would put /both/ in but only enable the one in use for the moment.
> >>> Our boards are booting of eMMC as supplied, so this isn't going to work
> >>> as well. The eMMC is 8bit wide, and thus is only delivering 11MB/sec
> >>> instead of 22MB/sec. This performance is still not great, but losing
> >>> half the data-rate is just not good.
> >>>
> >> I am not sure what should be enabled by default. Updating sdcard is much
> >> easier than eMMC card and we use that approach.
> >>
> >> @Cyril: Is there a way that we can enable both ?
> >>
> > Yes, we can enable both but this requires a modification to the FPGA
> > design. One of the guys prototyped this while I was away. We will move
> > this along. This will require reprogramming the FPGA with a new design
> > and HSS version.
> >
> > Regards,
> >
> > Cyril.
>
> I either missed or couldn't find a way of forcing the boot mode to be
> from the SD slot. Have I missed something? At the moment we'd like to
> have more storage available as the ~7G free on the eMMC is not enough.
>

I use tftpboot to load the kernel & DT from the network. SD card is
enabled in this DT and Linux
kernel uses SD slot instead of eMMC.

To summarize, eMMC is used for HSS & U-Boot while SD card is used for
Linux which makes
more storage available to Linux.

IMO, we should enable the sdcard for Linux DT until updated FPGA
design & HSS is available.

> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html



-- 
Regards,
Atish
