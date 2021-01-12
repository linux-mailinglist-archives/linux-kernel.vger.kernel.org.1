Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB832F2ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbhALMPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732817AbhALMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:15:35 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1DC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:14:54 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q137so3446003iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJL4JUyVXMfbMHqv+BM1N6i62BH9jhBqq5i/XcID/Eo=;
        b=II8D82E6AzHZZLtAWQVebainBcvHg800YO6VLekfQ2TUR6KefyDr9x97Gvi/tYJKJ8
         5rKNZT6/FZhfegQbsQQnS1wJWc8aXgi6O8V4fD0Qj7lsr5IM/yYn2krgnXKrxhwi5dT0
         2f9VZUV9GwdPDsCxHBEAqhzbCchtmJabRI7+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJL4JUyVXMfbMHqv+BM1N6i62BH9jhBqq5i/XcID/Eo=;
        b=pe4GjcF2GbKJYTk0crFGSsTz8NAd5klsk0WfYDSQyAnpoRBNECZF/pWsWNQKNNN+Cj
         r7zqxmuB+G6AYYdmNb18cvgRYYHY86XUKnoL9Grbg073bEuwjs7OQeUmJZuuYDZhouIm
         EXwhzIFffHyABogGBiOJMypWbTxMr5Uyvvhj4c9SKTYsJTMq0j2kLOyHSYn+3zDLRhEg
         VrmPsNrVcuqCyNjWg0sM3/lJO2OCv3E6ssXOapY9dM5B1ME6hapcSdw2xDRr/w+2ph6i
         tkfVYV9uEx/B5qAuXyeH9I5RYqEC4q6MWTFUZbr7RBCb61zf92QrBuNudiTqcU/JDaX8
         w94A==
X-Gm-Message-State: AOAM5333RtY28v96nJmvd72zwKA08oen9A/q0xNf7S+IzxXpyIMBU/bU
        4rs4E6ltncKtwkL9g+cDBACOqnwppb8Ti2WT
X-Google-Smtp-Source: ABdhPJzTAG4m8978Kw6UAY8BisK4i6kssPAZkvWvthscqV/+l9XDzsMwvyN3WEPrY7lNjOqg/B6fhQ==
X-Received: by 2002:a92:9ada:: with SMTP id c87mr3754442ill.5.1610453694013;
        Tue, 12 Jan 2021 04:14:54 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id t2sm2689097ili.31.2021.01.12.04.14.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 04:14:53 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id o6so3429850iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:14:53 -0800 (PST)
X-Received: by 2002:a05:6638:2243:: with SMTP id m3mr3857184jas.115.1610453692875;
 Tue, 12 Jan 2021 04:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20210111145445.28854-1-ribalda@chromium.org> <20210111145445.28854-2-ribalda@chromium.org>
 <8fb0c69c-bf17-328e-1b08-ab6316b65b83@ideasonboard.com>
In-Reply-To: <8fb0c69c-bf17-328e-1b08-ab6316b65b83@ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 12 Jan 2021 13:14:42 +0100
X-Gmail-Original-Message-ID: <CANiDSCsao8=gpSg_1sBdso97iLCPcGD4GM3jcMEQGB2mOcghaQ@mail.gmail.com>
Message-ID: <CANiDSCsao8=gpSg_1sBdso97iLCPcGD4GM3jcMEQGB2mOcghaQ@mail.gmail.com>
Subject: Re: [PATCH] media: staging/intel-ipu3 : Do not zero reserved fields
To:     kieran.bingham+renesas@ideasonboard.com
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran

On Tue, Jan 12, 2021 at 12:59 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On 11/01/2021 14:54, Ricardo Ribalda wrote:
> > Core code already clears reserved fields of struct
> > v4l2_pix_format_mplane, check: 4e1e0eb0e074 ("media: v4l2-ioctl: Zero
> > v4l2_plane_pix_format reserved fields").
> >
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> This is just 9/9 of the series right ? ;-)

I was just testing that you were doing a good review :P

My bad, I sent the mails with git email-send 00* and I forgot to clean
before :(. I already marked the patch as obsolete in patchwork. Sorry
for wasting your time

Best regards!

> --
> Kieran
>
> > ---
> >  drivers/staging/media/ipu3/ipu3-v4l2.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> > index 4dc8d9165f63..60aa02eb7d2a 100644
> > --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> > +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> > @@ -773,9 +773,6 @@ static int imgu_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
> >
> >       pixm->pixelformat = fmt->fourcc;
> >
> > -     memset(pixm->plane_fmt[0].reserved, 0,
> > -            sizeof(pixm->plane_fmt[0].reserved));
> > -
> >       return 0;
> >  }
> >
> >
>


-- 
Ricardo Ribalda
