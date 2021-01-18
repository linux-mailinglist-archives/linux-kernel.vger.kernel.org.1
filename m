Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DAD2FAAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394151AbhART4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394040AbhARTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:54:59 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5BAC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:54:18 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so10796127pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkhatLqEkgIoYwb7mkLwQ8lZ/MYBFBwFSP6oHKHVpXQ=;
        b=S2ufpP7+N7L91fhBl914NPNxyICKXp+sSmwGueCHAMWJQYF+woBsBCwxp3cgw/GjeS
         dr6WuA9pEBvnhojge12ecr6/KdQwK7dVSEjhbuxzxZOEYCzjfo3QvlX/arWVp4s545a1
         /XrpDiCKZNt1GWdCWj1vShOPbnZkIkRa4TzXU3XZ1LKl2OGOR0Kzaxzej5J6Q0beJ+iH
         LFI6cLHpgQJw/zVsG/Srpm8L9Iv9U+ZeaV7mcN2jqzZLaUN4E9X0jeQsJUahWvxMPQzz
         m/HNXnCZqhZfepW6XwzWcmb/WPdiCBr1BAEkAgb42PpyEqXm5IkeXrq6wWt1ZrV/g62+
         BO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkhatLqEkgIoYwb7mkLwQ8lZ/MYBFBwFSP6oHKHVpXQ=;
        b=Bbycjag6rba9P6oGoL6UdgR0X5qeE21/mmtc6fZ/b1mpCZUt50vCMwkEbgFMCk3H4E
         CtwKVstHDylL6NHsnVoVTTr/UOMz+KVyxcLPVMMiiziKiDAUuo1RFJTGUAoS0DiIwrRM
         dEzeRswg4NE8ljH9mrpVHBkIoBHF3WFvwZHWzJePhUMuJPp2EzMp0JaVSGW7KfZrbZnz
         Lh7q5pQKyMrmpdtgJm5oki/Cgjl7eoGdVpYcV7Cz58zDFBTJibd59KKJp0YoCIjckF8J
         VTBZwPJRmh7PEgeKtLiqLuI4fThAeIrwFVvSthV/AAFHwLGWyTQsupOW1OnUOgzsBKmc
         NibQ==
X-Gm-Message-State: AOAM531c4V6O/ih16c8epghTfAqIbVAikdYwPZg2+f9LZFDjaBd2O8j3
        X2ozNUhxcXKcdQs8Uu96BCNZoG+yuXqoPUBI4avLaA==
X-Google-Smtp-Source: ABdhPJz293yiVEmFyg9Ji6ORLpESmcRSjoRP14xcMxpV/RcJw8nEFFyC0vIwFDMo1uUMCwligXAeHNxYwVhl+kPaTCs=
X-Received: by 2002:a63:e049:: with SMTP id n9mr1162424pgj.339.1610999658487;
 Mon, 18 Jan 2021 11:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20210118190132.1045913-1-robert.foss@linaro.org>
 <db76aedb-de5e-2040-1e1c-777848614a7f@linaro.org> <357f6099-7a36-bbf6-723c-a4ca76835d00@linaro.org>
In-Reply-To: <357f6099-7a36-bbf6-723c-a4ca76835d00@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 18 Jan 2021 20:54:07 +0100
Message-ID: <CAG3jFyuzs00KoMQ2FZfqNAE9+hULTLoXJ2ja0pO-ikS8rvKW3A@mail.gmail.com>
Subject: Re: [PATCH v4] media: ov8856: Configure sensor for GRBG Bayer for all modes
To:     Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@linux.intel.com>,
        Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was going for row, but got a bit wild with the Ctrl-C + Ctrl-V, is
that alright with you?

On Mon, 18 Jan 2021 at 20:28, Andrey Konovalov
<andrey.konovalov@linaro.org> wrote:
>
> Oops.. I've missed a few mistypes
>
> On 18.01.2021 22:18, Andrey Konovalov wrote:
> > Hi Robert,
> >
> > Thanks for you patch!
> >
> > Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> >
> > On 18.01.2021 22:01, Robert Foss wrote:
> >> The previously added modes 3264x2448 & 1632x1224 are actually
> >> configuring the sensor for BGGR mode, this is an issue since
> >> the mode that is exposed through V4L incorrectly is set as GRBG.
> >>
> >> This patch fixes the issue by moving the output crop window of
> >> internal sensor ISP uses by one row, which means that the Bayer
> >> pattern of the output is changed.
> >>
> >> From:
> >> row 1: B G B G B G ...
> >> row 2: G R G R G R ...
> >> raw 3: B G B G B G ...
> - row
> >> ...
> >>
> >> To:
> >> raw 2: G R G R G R ...
> - row
> >> raw 3: B G B G B G ...
> - row
>
> Thanks,
> Andrey
>
> >> ...
> >>
> >> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> >> Suggested-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> >> ---
> >>
> >> Changes since v1:
> >>   - Sakari: Added mode information to ov8856_mode struct
> >>   - Sakari: enum_mbus_code updated
> >>
> >> Changes since v2:
> >>   - Andrey: Switched approach to changing the sensor configuration
> >>     to yield identical Bayer modes for all modes
> >>
> >> Changes since v3:
> >>   - Andrey: Improve commit msg to explain Bayer shift better
> >>
> >>   drivers/media/i2c/ov8856.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> >> index 2f4ceaa80593..8a355135c7db 100644
> >> --- a/drivers/media/i2c/ov8856.c
> >> +++ b/drivers/media/i2c/ov8856.c
> >> @@ -428,7 +428,7 @@ static const struct ov8856_reg mode_3264x2448_regs[] = {
> >>       {0x3810, 0x00},
> >>       {0x3811, 0x04},
> >>       {0x3812, 0x00},
> >> -    {0x3813, 0x02},
> >> +    {0x3813, 0x01},
> >>       {0x3814, 0x01},
> >>       {0x3815, 0x01},
> >>       {0x3816, 0x00},
> >> @@ -821,7 +821,7 @@ static const struct ov8856_reg mode_1632x1224_regs[] = {
> >>       {0x3810, 0x00},
> >>       {0x3811, 0x02},
> >>       {0x3812, 0x00},
> >> -    {0x3813, 0x02},
> >> +    {0x3813, 0x01},
> >>       {0x3814, 0x03},
> >>       {0x3815, 0x01},
> >>       {0x3816, 0x00},
> >>
