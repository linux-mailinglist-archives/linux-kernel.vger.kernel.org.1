Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF67A2FB4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 10:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbhASI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbhASI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:57:55 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE2CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:57:13 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p72so13327272iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BeiBtcm9SCY0g91u2WvZrEK8opo1/Kd2ZEOb1FMWyU=;
        b=DvwdpNezTQuRjskcmsqaM5J9cwAIeBpZNuG2isQwJyKqFxUDVF7ozHTubOBI1YUyEO
         Fjm3bHgbOjCBhtOyYF8g0SKCUrHrSov0dO1fBSkm6nBy2kUWbyO+vTR+tkyyRMKctN+3
         UkB2uNFIBTomMwVxT45RL1fIjT0vJKop142Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BeiBtcm9SCY0g91u2WvZrEK8opo1/Kd2ZEOb1FMWyU=;
        b=cnIiV3BE4Diu62aH8byNNCCrNeQ21r1u7UDimiE1mv+LTlTwZXlCEoFBQUoGRZX5Qf
         M3d3v+y2m0VU8ajxVea+uzYN3r4JE12WoRF/DKjb4JWrCiTqKa3RvZqeH1FOOc0GjbFG
         DPTHpHO80z6WtgZbq2yYQtyx8LpkNul8ovkhJZTM5sY6kWs8msfA4L1VCcixvpPPS0eU
         mBgUUi5lKb43/SLiUxT20HV5bPgJmruUenVain2ktWYVI/RFUZVDcN0x+/dijR+4fqh1
         4OuyPZq2OoH+AZIrU/lzm8JjdtfwNq3exD9QtBmgzi4s16evRFwzbqbozLiM/9KeMlwu
         eibA==
X-Gm-Message-State: AOAM531e5l4wI9a6lAIHEnE2UnxXdI8yvTzvRjFU5KZsAfSCCBWQaZXt
        xNLKMVza2mg2oVs5sBZpAkM532FHBNmZsA==
X-Google-Smtp-Source: ABdhPJzeiVmrCV3FDLVPj2t+iLj6ntrTgHs36nZ58VBEDXrUELO5pt1xFJwzw298uaXABrv1rbUHtg==
X-Received: by 2002:a02:a584:: with SMTP id b4mr2013425jam.135.1611046632769;
        Tue, 19 Jan 2021 00:57:12 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id f80sm6687126ilg.8.2021.01.19.00.57.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 00:57:12 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id p72so13327207iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:57:12 -0800 (PST)
X-Received: by 2002:a02:a58d:: with SMTP id b13mr2642407jam.115.1611046631587;
 Tue, 19 Jan 2021 00:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20210114130316.803231-1-ribalda@chromium.org> <d472a1b1-71d6-0c9c-0ead-d2287bd788ae@embeddedor.com>
In-Reply-To: <d472a1b1-71d6-0c9c-0ead-d2287bd788ae@embeddedor.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 19 Jan 2021 09:57:00 +0100
X-Gmail-Original-Message-ID: <CANiDSCt5o-k=8L2YhpYCQhWJhsE7vHJ_u6TFgFu0a9gAyT49TQ@mail.gmail.com>
Message-ID: <CANiDSCt5o-k=8L2YhpYCQhWJhsE7vHJ_u6TFgFu0a9gAyT49TQ@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: Fix reset_raw_fmt initialization
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo

On Mon, Jan 18, 2021 at 11:26 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hey Ricardo,
>
> On 1/14/21 07:03, Ricardo Ribalda wrote:
> > raw_fmt->height in never initialized. But width in initialized twice.
>
> Nice catch!
Thanks :)

>
> How did you find this?

Pure luck. I was backporting a patch and the duplicated line hit my
eye. Maybe we could just search for duplicated lines in the codebase.
I guess it is not the only c&p issue we have

>
> > Fixes: 88d06362d1d05 ("media: hantro: Refactor for V4L2 API spec compliancy")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> This should be tagged for -stable:
>
> Cc: stable@vger.kernel.org
>
> --
> Gustavo
>
> > ---
> >  drivers/staging/media/hantro/hantro_v4l2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> > index b668a82d40ad..f5fbdbc4ffdb 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > @@ -367,7 +367,7 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
> >
> >       hantro_reset_fmt(raw_fmt, raw_vpu_fmt);
> >       raw_fmt->width = encoded_fmt->width;
> > -     raw_fmt->width = encoded_fmt->width;
> > +     raw_fmt->height = encoded_fmt->height;
> >       if (ctx->is_encoder)
> >               hantro_set_fmt_out(ctx, raw_fmt);
> >       else
> >



-- 
Ricardo Ribalda
