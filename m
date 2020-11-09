Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E72AB571
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgKIKwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgKIKwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:52:36 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7792C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 02:52:34 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id x7so7859874ili.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 02:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwWZURMOGPzlalkhwCJ/f3k1WENAaO9Y9Meee7VB2IA=;
        b=wO/OzuTRPTWurO76xGlv8nc1TqwnqHDwlTi4ZWbo372fTDrk4WhsA/86p6Kgn9IaMz
         x4YcMHVdBMXsuqaomm1x0u4Meou5jgV6M+e0lNQMrwSSPgeBKN8Q8UmFP71vy0rxvHco
         YiogY0HoB/z6VckeGu6aXQmEarqYWn9H9noIC6JyOZv4Uo9Kybwi1nN6LV6P89VLJj16
         sY5l+xyRHWLEWSVxpusZ1mOt5UvjqyCs0/D4idupyPFD/nLQn1Zxy/MEKT6ksGcM6t1w
         qK/dccaE23/eJdhLxvrLURx1dUYWMLbwxOqjCE6pQm6WeF1/ud2MPUEERQtwtLMUSi//
         DDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwWZURMOGPzlalkhwCJ/f3k1WENAaO9Y9Meee7VB2IA=;
        b=LiF/j6GVTw/XpD7ng2SOzYBKyvJW/4rSGrP+3bT5g1S4tRbXAd54Z06zlEcTE9+tSr
         riKGHmvgWfBKmlfAONGsoOdJCPIpb4BleUFIoXhf0kN3S/6pFdr9xexoqXkEOF5GbeRp
         g1IPH58dHXhLUvm9LJ3i4w73NTqKd/qM0Odd7CPEZCTAwNDbwDHJgU1J86QTTWdh/86z
         MuFBFz5UunmIGulxnJCkPeHbmW1e2vJZjebiynU3QXx144BEQueBax0rpOq+xJHU0XI4
         G1sly3AZSJ7kgHAHMSs3Rt0a9zKvZYQy7av5y25OUI9pz62CFjrCX7xzsL+M/P+tRNcG
         PJSg==
X-Gm-Message-State: AOAM533Gn5S7ylYyKpoH259k5965+JcX+SdOh0/LCYGf14awI/9/QSei
        Jv+jGWRIboK4MmIHsP4QzSE3jFgt8vdf1poN6g2C5Q==
X-Google-Smtp-Source: ABdhPJyS/89M7Xy9MbFvdXk3zEeNLiWgzsNdo2bTjLNeFc4/AQN4cILMilqgs8vdZ3MBG3hfjNPFuE0v/8aGzMC5wII=
X-Received: by 2002:a92:d4cc:: with SMTP id o12mr6514962ilm.6.1604919154385;
 Mon, 09 Nov 2020 02:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20201102142228.14949-1-brgl@bgdev.pl> <20201102142228.14949-5-brgl@bgdev.pl>
 <20201108170813.3efab72a@archlinux>
In-Reply-To: <20201108170813.3efab72a@archlinux>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Nov 2020 11:52:23 +0100
Message-ID: <CAMRc=Mfx1dpOc+jAV=-aeuP_EB5ZiSH9UzWW+qhJPcuZ+LCfrQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: xilinx: use more devres helpers and
 remove remove()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 8, 2020 at 6:08 PM Jonathan Cameron <jic23@kernel.org> wrote:
>

[snip]

>
> I haven't checked carefully, but it looks like you don't need
> this any more as there are no remaining calls to
> platform_get_drvdata().
>

This looks to be correct.

There's a call to iio_trigger_get_drvdata() and it accesses the same
drvdata but it's called on the trigger device and there's a
corresponding call to iio_trigger_set_drvdata() for it.

>
> I can clean that up whilst applying as long as you confirm
> I'm right!
>

Yes please do, thanks!

Bartosz

> Thanks,
>
> Jonathan
>
