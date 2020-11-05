Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBEE2A7B00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKEJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:50:59 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3EAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:50:59 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f16so779570otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dX0vDqom8ha6YU5ZReUcsQtcVPHPjeNXiBGF2ngLEnw=;
        b=FQiVrGaLODrUUaqHrd8MUV+2jfG4zXyZcp645Hz8Hi2Z2Eh0gNkwuONW1bano0KYSf
         OUPgJ7K0ia9zwh2Ic5E5yR+0sJQsounbGX5x1hedn1xg0hN/GKElRrLU+WMF8mU6AgWF
         3oeLNr8r2BYpCFPbh4qyNmGJGpVGif0bCmE+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dX0vDqom8ha6YU5ZReUcsQtcVPHPjeNXiBGF2ngLEnw=;
        b=cgT++qGN6kodN31iLeMq3js+4z8dxocj35mBFh/fAt8k0w2RB/zTSvhpVf0ZReRfOQ
         fW5L/oNH+Wu+RCw5mWzj10+mulCNeEub/0ah9NQatTN/WQ62Zo0wHIf7c8ggjXpBAKIO
         nZ9D9iPjSvO7yAPRdUz29Yo/fnwfJNlwNM4He+nPA9EqjyBlocRwF1KJMRdTXFFakw+W
         kf2ELCA+AA+1GJWupUkRki+GKmKGh84xTsp+fsHLuGfe/NYfwIsxjYSykLLMxLTEncRj
         Eoa9GID0vfOHlHTaNyjz2gdZbMLxLV+quH6Y9oCb1IewL4Z4BLhnRwElf68Kwr21IOLO
         h6zg==
X-Gm-Message-State: AOAM530Grwm6RcJhijxQrzXI3DVSGZJWEjI5yn043+1MWcaLvW5lFLSM
        Z2Y3U3ckvmIczTOiiPXnYTCoIzEcYMwt0ljI
X-Google-Smtp-Source: ABdhPJw1m2B2252+PmsEJdfyldG9uyfU3QgLdoqERSCuApg8LX+BZoBXin92mQGGwdr52wwIqhXwzQ==
X-Received: by 2002:a05:6830:11a:: with SMTP id i26mr1054241otp.87.1604569858363;
        Thu, 05 Nov 2020 01:50:58 -0800 (PST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id m23sm234947otk.10.2020.11.05.01.50.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 01:50:57 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id j41so271106oof.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:50:57 -0800 (PST)
X-Received: by 2002:a4a:6251:: with SMTP id y17mr837922oog.17.1604569856931;
 Thu, 05 Nov 2020 01:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20201104180734.286789-1-ribalda@chromium.org> <20201104180734.286789-2-ribalda@chromium.org>
 <87769d554b4575bf9371380b013e66d70f1b21c4.camel@perches.com>
 <20201104214201.GH29958@pendragon.ideasonboard.com> <9d439214e8c83ebf7b93dccca2f848fbaf75b9d4.camel@perches.com>
 <CANiDSCvwvQUTt1QMQGGyZPag9VeHj4Ugmj8QJdBNtw00UNt6Pg@mail.gmail.com>
 <a00078e1311c09361e9e3357ba5dca037d7a8bff.camel@perches.com>
 <CANiDSCteVWin-Yy2ZVSMUJBPvJ-F0Ti+fEpi26apsDW0XXrpwg@mail.gmail.com> <79cad1a6a296761e672cfb0d85e7424fcb740032.camel@perches.com>
In-Reply-To: <79cad1a6a296761e672cfb0d85e7424fcb740032.camel@perches.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 5 Nov 2020 10:50:45 +0100
X-Gmail-Original-Message-ID: <CANiDSCt8twP=JTkGjSVKdDwRhuHb7Jkv+=08U6oFdGtAjtrELw@mail.gmail.com>
Message-ID: <CANiDSCt8twP=JTkGjSVKdDwRhuHb7Jkv+=08U6oFdGtAjtrELw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] media: uvcvideo: Use pr_cont() macro
To:     Joe Perches <joe@perches.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe

On Thu, Nov 5, 2020 at 12:59 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-11-05 at 00:01 +0100, Ricardo Ribalda wrote:
> > Hi Joe
> >
> > On Thu, Nov 5, 2020 at 12:00 AM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Wed, 2020-11-04 at 23:31 +0100, Ricardo Ribalda wrote:
> > >
> > > > I have updated my tree with the dev_ variants
> > > >
> > > > https://github.com/ribalda/linux/commit/b8785fd8efb4f2e5bbf5d0f2df3e0d69a5439015
> > >
> > > I looked at this link and was confused so you made me look.
> > > I think you meant:
> > >
> > > https://github.com/ribalda/linux/commit/83cb6eb3a9f7bd1954acbfb4fb3d56ddf54bce73
> >
> > Yes, thanks :) Sorry about that
> >
> > This is why I should be away from a keyboard after 23:00 :)
>
> Sleep is good.
> There are lots of sleep deprived people here in the US today though.

Today and tomorrow and the day after. Seems like you are not going to
sleep for a week if you want a final result.

>
> It looks as if all the pr_cont uses in the code are odd and repetitive.
>
> Perhaps it'd be sensible to add something like:

Looks like a great idea. Queued for my v3

https://github.com/ribalda/linux/commit/1623b648331d7f69c8a9f6b199e119f6c8ee61c6

I let Laurent decide if we should squash with the previous patch or not.

Thanks!

>
> #define uvc_trace_cont(flag, fmt, ...)                                  \
> do {                                                                    \
>         if (uvc_trace_param & (flag))                                   \
>                 pr_cont(fmt, ##__VA_ARGS__);                            \
> } while (0)
>
> and change all the uses like:
>
> -               if (uvc_trace_param & UVC_TRACE_PROBE)
> -                       printk(KERN_CONT " <- SU %d", entity->id);
> +               uvc_trace_cont(UVC_TRACE_PROBE, " <- SU %d", entity->id);
>
>


-- 
Ricardo Ribalda
