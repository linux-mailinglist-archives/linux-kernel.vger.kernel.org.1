Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865A82A4F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgKCSig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgKCSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:38:36 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A4C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:38:36 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id k1so17014432ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 10:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isZW9UVRWMUdUxodMEQrPHM1tf21oSlSUVW3kI8aBBo=;
        b=SPBvOimS59fQpOncR96IiIRDP3yFCHyir2PmoQOcNBv1nA0ac/tsGYlF9nSpHbLlY4
         RQxbetSpbbDR8g+jOMYH7C/ZhD0ijLXbY6j4+4jM2Qtu5BVjU2ARNX4PG7PTf6HY+W+5
         c5P8Dy7kQvIMcHlWiagl6v+fXAl5Dl8kGsVYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isZW9UVRWMUdUxodMEQrPHM1tf21oSlSUVW3kI8aBBo=;
        b=qM76zib5AE3kYOkErESgEikhJYGLQ3gdMJoKAChrZaTGz75/AGZk49q7FRcFuRPB+2
         jC2BmhQxmfzBdF4VHBnbvVSxXs7rtU5ZzmqrnEfmkzizUhfYg+BOuXMfKAuDutj35h2J
         ry2ILjrrS1nnZVPWnE3e6GObkp+W5kO2Ia50AvnBSLqasKR4JCHO7XUvBxmHm7kKPNlz
         InBHQx/LYZxCdgKrrXcloIFLy7AtSzXx+l8RSrCSsQhE3O7Gtp3Yxp8syrVzO1PpUUo8
         MXCM3GntCoZsJDXjU1EJQq+JUNhaXjBlf4UDRQ8nTTrZCjrMo4wrXw+wW0jJaeJxm2ZR
         Fj1A==
X-Gm-Message-State: AOAM532GcV2SdlBfZK5Abyl646CQsZSefSx4M5dIJPNxE/7k22xSeyPN
        lVFQr92xrOvtYuNwtv0Hq9ghckIzZn9pfOOd9ws1
X-Google-Smtp-Source: ABdhPJwP/4HvNurgeeX8oFZiCl1iSoi5erFepZ6/ponAvMH88+iqv0up8nMbyaDLWn5Niqr5+HH/Ks/yoC8t4gZnhD4=
X-Received: by 2002:a92:512:: with SMTP id q18mr15048300ile.147.1604428715567;
 Tue, 03 Nov 2020 10:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-3-atish.patra@wdc.com>
 <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
 <CAEUhbmUm6EyP33FU1n4LhEk-xcBtR13-xS+Tpt76ug1HQv8CEg@mail.gmail.com> <e9bad05c-db34-ba2c-df5c-ff2f7f53e15b@microchip.com>
In-Reply-To: <e9bad05c-db34-ba2c-df5c-ff2f7f53e15b@microchip.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 3 Nov 2020 10:38:23 -0800
Message-ID: <CAOnJCULkC65FgOakjPgoACdpiQFWTiEPCox3ayMWWZwVa91fVA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
To:     Cyril.Jean@microchip.com
Cc:     Bin Meng <bmeng.cn@gmail.com>, Anup Patel <anup@brainfault.org>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
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

On Tue, Nov 3, 2020 at 10:19 AM <Cyril.Jean@microchip.com> wrote:
>
> On 11/3/20 10:00 AM, Bin Meng wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Fri, Oct 30, 2020 at 5:08 PM Anup Patel <anup@brainfault.org> wrote:
> >> On Thu, Oct 29, 2020 at 4:58 AM Atish Patra <atish.patra@wdc.com> wrote:
> >>> Add initial DTS for Microchip ICICLE board having only
> >>> essential devcies (clocks, sdhci, ethernet, serial, etc).
> >>>
> >>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >>> ---
> >>>   arch/riscv/boot/dts/Makefile                  |   1 +
> >>>   arch/riscv/boot/dts/microchip/Makefile        |   2 +
> >>>   .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
> >> I suggest we split this DTS into two parts:
> >> 1. SOC (microchip-polarfire.dtsi)
> >> 2. Board (microchip-icicle-kit-a000.dts)
> > I also doubt what is the correct board name. I suspect the -a000 comes
> > from the SiFive board name convention, but does not apply to the
> > Icicle Kit board.
> >
> > @Cyril, please confirm.
> >
> Correct. Sorry Padmarao, I missed that one.
>

Ok. I picked that one from U-Boot. What should be the correct board
name in that case ?

microchip-pfsoc-icicle-kit ?

>
> Regards,
>
> Cyril.
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
