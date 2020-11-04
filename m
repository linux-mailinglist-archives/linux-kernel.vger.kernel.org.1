Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526932A7086
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgKDWcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbgKDWcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:32:03 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A32C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 14:32:02 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id t143so12355949oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 14:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyCrLipxpUSH3s5JKD4KJs2gnedOuRhvcE+wVQyXqrw=;
        b=je27MR45BEcR4fBsFJd9VVbBkBmDzxyQJ14acFX/tbYK8BSPmUiBZzCDSH1cCyYUYd
         Mq2zmZvncoR8YMCpEN1vnIPif+/Ms5eunHoR+N1CLIjtr8ibOszSS4FZHvys6LuSydAI
         /Igsszp6lvAgmrPviL5OeauaTwA+I90ldrFAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyCrLipxpUSH3s5JKD4KJs2gnedOuRhvcE+wVQyXqrw=;
        b=KjSgbyrXQm2unVE8FbmHAzPcHTkmgHzdk4U7Ou9lm/kQvIgJV0Ph0hzrorC+xPV4eN
         vLJm5NSgFI0V4TqI0lqHuRUgQrdXTzO/UhWdaB8tz3po84HQndLIi6HuRH/d4tlFYh6B
         bJQwLhP8u8dqadEkcCrADm436z2SmmOCpwJlxFIl88Do69qySS3E3TqhzjeJLgh5/F1d
         FH0qYX/M+Ad8apLPiqurZHlcBhPrtlokbVrNGPtYBsPdZ/C97qZNhnnl8+Qo3Sg6q5DB
         sJiINhhBE3hrR8RIy71722uMYb1yBMR3/Nzcll0KVXSEKP2lBQssEl7vZI99cQYYg5s5
         MG7Q==
X-Gm-Message-State: AOAM532LkRfxp+jY/yNqlTxrTx7tBBmp0d+KYb7WBXHJk9bZsWcVjzdb
        vx+b38ZOO5P+VwK0/2Y6NfJ/UNXw+UjGiBq8
X-Google-Smtp-Source: ABdhPJwTtdDOzbnOKKZWkA9PsDk5GGwPzK9RfQbYeJt3GtQ0TyFqWedHf5pLH4u27TnHlXCjBrxpYw==
X-Received: by 2002:aca:c188:: with SMTP id r130mr4172308oif.99.1604529122057;
        Wed, 04 Nov 2020 14:32:02 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id 85sm804528oie.30.2020.11.04.14.32.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 14:32:01 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id m17so2653889oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 14:32:00 -0800 (PST)
X-Received: by 2002:aca:d07:: with SMTP id 7mr1874oin.15.1604529120516; Wed,
 04 Nov 2020 14:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20201104180734.286789-1-ribalda@chromium.org> <20201104180734.286789-2-ribalda@chromium.org>
 <87769d554b4575bf9371380b013e66d70f1b21c4.camel@perches.com>
 <20201104214201.GH29958@pendragon.ideasonboard.com> <9d439214e8c83ebf7b93dccca2f848fbaf75b9d4.camel@perches.com>
In-Reply-To: <9d439214e8c83ebf7b93dccca2f848fbaf75b9d4.camel@perches.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 4 Nov 2020 23:31:49 +0100
X-Gmail-Original-Message-ID: <CANiDSCvwvQUTt1QMQGGyZPag9VeHj4Ugmj8QJdBNtw00UNt6Pg@mail.gmail.com>
Message-ID: <CANiDSCvwvQUTt1QMQGGyZPag9VeHj4Ugmj8QJdBNtw00UNt6Pg@mail.gmail.com>
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

Hi

On Wed, Nov 4, 2020 at 10:51 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-11-04 at 23:42 +0200, Laurent Pinchart wrote:
> > Hi Joe,
>
> Hi Laurent.
>
> > On Wed, Nov 04, 2020 at 11:29:30AM -0800, Joe Perches wrote:
> > > On Wed, 2020-11-04 at 19:07 +0100, Ricardo Ribalda wrote:
> > > > Replace all the uses of printk(KERN_CONT ... with pr_cont().
> > >
> > > Perhaps remove the uvc_printk macro and uses and use the more
> > > common pr_fmt and pr_<level> mechanisms.
> >
> > I'd actually go for dev_* instead, to give some context. It's fairly
> > common to have multiple UVC devices connected to a system, so printing
> > the device name would be useful. It can still be wrapped with
> > uvc_printk() if we want to wrap the cast from uvc_device to a struct
> > device (we should actually try to get the device corresponding to the
> > USB interface where available, so we should use uvc_streaming->intf->dev
> > where possible, and fallback to uvc_device->udev->dev otherwise), or
> > drop the wrapper completely.
>
> Of course yes.  I was not going to look around and update the existing
> call sites to find whatever controlling uvc_device * or other struct *
> to a real device that exists though.
>
> It's not even clear from the changes that an appropriate pointer to
> some struct exists in all the functions.
>
> That's work for someone that knows the actual subsystem and I do not.

I have updated my tree with the dev_ variants

https://github.com/ribalda/linux/commit/b8785fd8efb4f2e5bbf5d0f2df3e0d69a5439015

will send it to the tree when I get more feedback from the other patches.

Thanks!

>
> cheers, Joe
>


-- 
Ricardo Ribalda
