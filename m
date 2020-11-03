Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B4A2A4110
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgKCKAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgKCKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:00:37 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B03C0613D1;
        Tue,  3 Nov 2020 02:00:37 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id o70so14340603ybc.1;
        Tue, 03 Nov 2020 02:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pYiU3lXK+jystxaKH+sxvcQtmhQVjgO3tVqUS8438E=;
        b=cs/xi2EpfFHUPI17/QF4ssFf7CdMQ4OqwJt9DLmIWEurK7jAB4a1+4HIfVRbNQlEDx
         II0yHB7R3QB0DVUtRX7CNSzyg5nzwbj5dcZxCLO2usYXGjLTqyD9DVZhrcfp1tfrgwT8
         UD7Zwp9jbSJpUsYsPWQX72aszEQKpr4kYNCf/TXcudNWJBYi3NnIA7sa9oxfjPRMSJzq
         vxsj5U0nVJnEfGBn4mLZZlDoyCTgxevzNuJq3Z1d0avJo681mrcjXuPMd2WXRbI4SI2a
         XQc2pC+TUMXeaSIdIXSs/9rZz5rfQbNOqM4HUFvav3vC2GvB/QZYSaAmjP15dmmMSs3K
         JGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pYiU3lXK+jystxaKH+sxvcQtmhQVjgO3tVqUS8438E=;
        b=r4BoKDX4iGjqOEMsKSThYBds4QXLk+124KuxqL5Nuh6V6DhHpKd0uoTEBkp1z1gxAd
         92i20C/se1sY9Kieu1ovEzyGVDBwa9RWJDez5USVuADvNOZkgKw3tOnyXiWafiwjSSaw
         JO+ZWizp/1fcFzjY8f/wWs60A0WDgbTgU5qc6L1FmLbTUqJ5a/KydMIqGX+WI10zZaNL
         dF2DoH0Ta3gIsdkg3K+tiqDQGRmQpBU31HO+N86H14faH110myfTFvJxzXEyvaunve4n
         bBwX7q2DSBzrRJKa9dbJMGbtABUgUIvT5ZcmIIEYVzgblDVubd2rTu1URVVSGJQBCMdn
         LKNQ==
X-Gm-Message-State: AOAM532F6tskaerCl/ZHznQhxkLuZDvXhYwq73Z7BBPD1R1VI9LEvrwh
        SK3qdj6Zh/j/HYVBj2Owa09bGnG2Bpm0dhOhL7s=
X-Google-Smtp-Source: ABdhPJzwK5OJBwmkhIfZ55negrHImNV14+iO939LGyydy5v9JU4bBlOnmiVTVesZWmqDN25CD/mCHkqeh0E11CSDDhI=
X-Received: by 2002:a25:328a:: with SMTP id y132mr25819789yby.306.1604397636640;
 Tue, 03 Nov 2020 02:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
 <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 3 Nov 2020 18:00:25 +0800
Message-ID: <CAEUhbmUm6EyP33FU1n4LhEk-xcBtR13-xS+Tpt76ug1HQv8CEg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Padmarao Begari <padmarao.begari@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 5:08 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Oct 29, 2020 at 4:58 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > Add initial DTS for Microchip ICICLE board having only
> > essential devcies (clocks, sdhci, ethernet, serial, etc).
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/boot/dts/Makefile                  |   1 +
> >  arch/riscv/boot/dts/microchip/Makefile        |   2 +
> >  .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
>
> I suggest we split this DTS into two parts:
> 1. SOC (microchip-polarfire.dtsi)
> 2. Board (microchip-icicle-kit-a000.dts)

I also doubt what is the correct board name. I suspect the -a000 comes
from the SiFive board name convention, but does not apply to the
Icicle Kit board.

@Cyril, please confirm.

>
> This will be much cleaner and aligned with what is done
> on other architectures.
>
> >  3 files changed, 316 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> >  create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> >

Regards,
Bin
