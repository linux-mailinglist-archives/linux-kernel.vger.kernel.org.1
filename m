Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014D32A879C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgKETwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKETwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:52:41 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 11:52:39 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k26so2960435oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fYz8aC7HmU4RPQ9E3HZGpGRuATg2yAKc0UIFwqines=;
        b=EyekuhPCdaUoyLZW3VaT9wjMJVHHKROZZrfHbqNDap7kYHxc8yqoAvBmyM5PmFAEqz
         gMA3M41RIQQ7bRUsV0rUExPqD8wvkOJClI0sHF3wLpH2XvtqPlQKmf1FGHaLE69PkfVK
         Lu0TgnW6bBDs1U8+yEYzgvbDq1ZSq1U34kDqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fYz8aC7HmU4RPQ9E3HZGpGRuATg2yAKc0UIFwqines=;
        b=HC3nqOwEV+VAsl1G6xgdA3S2XqVy4pSBKVKI4SWUMsNuUCRhXye9nGsqQ7SIrP3+8q
         NmQNferagVO31Qo+f5T6ZfE0ZiyTTMHkjph1bOxyEA1GBtuNSNVqXqbMXw2BVztpwWVa
         AyjOQnxdPKEEDeW4zSJEldfa6NtqbrpR/AKHiiInT8DAqkI8ewBtmOAZhEycmvAd9lRS
         /8p/FWE840BkAT20D13rR+1sG6oOvsiO+9KXq3lo8mtOgj+N4mhk9vg7WQhLHV6sUHcV
         pErixwdwopY5LFjIn8fI9D4ZxMW8B7mp3EIsKKXahfc5OK0hImN2YauAjJQeEcobMUOx
         lo0A==
X-Gm-Message-State: AOAM533hNtQhq5qMqZRHrapiX4m85TLH/YvGiI5wrqMZOwxp7JcZYkNe
        LJzGlay9mJzc/oOWfethOp2RpoWYN+YYdqWY
X-Google-Smtp-Source: ABdhPJx4mt/uylc9mRqR7CkJSZnNuFJ0tbYmoO0SbP08XorWzhDep4cjie1753C2FleEl6mu+8bc/Q==
X-Received: by 2002:aca:450a:: with SMTP id s10mr654402oia.104.1604605958775;
        Thu, 05 Nov 2020 11:52:38 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id j3sm601602oij.9.2020.11.05.11.52.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 11:52:38 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id u127so2928188oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 11:52:37 -0800 (PST)
X-Received: by 2002:aca:d07:: with SMTP id 7mr642992oin.15.1604605957416; Thu,
 05 Nov 2020 11:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20201104180734.286789-1-ribalda@chromium.org> <20201104180734.286789-2-ribalda@chromium.org>
 <87769d554b4575bf9371380b013e66d70f1b21c4.camel@perches.com>
 <20201104214201.GH29958@pendragon.ideasonboard.com> <9d439214e8c83ebf7b93dccca2f848fbaf75b9d4.camel@perches.com>
 <CANiDSCvwvQUTt1QMQGGyZPag9VeHj4Ugmj8QJdBNtw00UNt6Pg@mail.gmail.com>
 <a00078e1311c09361e9e3357ba5dca037d7a8bff.camel@perches.com>
 <CANiDSCteVWin-Yy2ZVSMUJBPvJ-F0Ti+fEpi26apsDW0XXrpwg@mail.gmail.com>
 <79cad1a6a296761e672cfb0d85e7424fcb740032.camel@perches.com>
 <CANiDSCt8twP=JTkGjSVKdDwRhuHb7Jkv+=08U6oFdGtAjtrELw@mail.gmail.com> <92c85080ad6e1ded9c15479efe79a7eb7b0c7ee2.camel@perches.com>
In-Reply-To: <92c85080ad6e1ded9c15479efe79a7eb7b0c7ee2.camel@perches.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 5 Nov 2020 20:52:26 +0100
X-Gmail-Original-Message-ID: <CANiDSCsgOYod3gMnL6VNM4FAQyjU3V3CLw5scPi-aZ9HMmfcOQ@mail.gmail.com>
Message-ID: <CANiDSCsgOYod3gMnL6VNM4FAQyjU3V3CLw5scPi-aZ9HMmfcOQ@mail.gmail.com>
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

On Thu, Nov 5, 2020 at 7:58 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-11-05 at 10:50 +0100, Ricardo Ribalda wrote:
> > Hi Joe
>
> Rehi Ricardo.
>
> > On Thu, Nov 5, 2020 at 12:59 AM Joe Perches <joe@perches.com> wrote:
> > > It looks as if all the pr_cont uses in the code are odd and repetitive.
> > >
> > > Perhaps it'd be sensible to add something like:
> >
> > Looks like a great idea. Queued for my v3
> >
> > https://github.com/ribalda/linux/commit/1623b648331d7f69c8a9f6b199e119f6c8ee61c6
> >
> > I let Laurent decide if we should squash with the previous patch or not.
> >
> > Thanks!
> >
> > >
> > > #define uvc_trace_cont(flag, fmt, ...)                                  \
> > > do {                                                                    \
> > >         if (uvc_trace_param & (flag))                                   \
> > >                 pr_cont(fmt, ##__VA_ARGS__);                            \
> > > } while (0)
> > >
> > > and change all the uses like:
> > >
> > > -               if (uvc_trace_param & UVC_TRACE_PROBE)
> > > -                       printk(KERN_CONT " <- SU %d", entity->id);
> > > +               uvc_trace_cont(UVC_TRACE_PROBE, " <- SU %d", entity->id);
> > >
>
> While I know the only uses of uvc_trace_cont are with UVC_TRACE_PROBE,
> there are other existing uvc_trace(flag, ...) uses.
>
> I think the uvc_trace_cont mechanism should require a flag and not
> assume UVC_TRACE_PROBE so it's possible, even though currently unused,
> for other uvc_trace calls to be continued.
>
> $ git grep -Poh '\buvc_trace\(\w+' drivers/media | sort | uniq -c
>       1 uvc_trace(flag
>       6 uvc_trace(UVC_TRACE_CALLS
>       1 uvc_trace(UVC_TRACE_CAPTURE
>       2 uvc_trace(UVC_TRACE_CLOCK
>      15 uvc_trace(UVC_TRACE_CONTROL
>      42 uvc_trace(UVC_TRACE_DESCR
>       6 uvc_trace(UVC_TRACE_FORMAT
>      12 uvc_trace(UVC_TRACE_FRAME
>       7 uvc_trace(UVC_TRACE_PROBE
>       1 uvc_trace(UVC_TRACE_STATS
>       6 uvc_trace(UVC_TRACE_STATUS
>       4 uvc_trace(UVC_TRACE_SUSPEND
>       6 uvc_trace(UVC_TRACE_VIDEO
>
>

There you are:

https://github.com/ribalda/linux/commit/7b3e2214dde38dc4534eec7399a4053881c2589e

Thanks!

-- 
Ricardo Ribalda
