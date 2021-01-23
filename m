Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239C23013ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 09:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbhAWIf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 03:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAWIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 03:35:52 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE5C06174A;
        Sat, 23 Jan 2021 00:35:11 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q1so16195096ion.8;
        Sat, 23 Jan 2021 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6S1XUbpw3sWz7PK1At9O27hDXZ4W5lBRqtANOwgjMg=;
        b=s+5D3eXqnSvljv1ptw/fN2geCT5dzJJXlUh/4TKf71d8gh+skSUSU9iXCastD8SNsv
         dsVtMvYRBSawQzzFURmXpL22zwRqTyvP7qf0QeQpPY7tUmec5VIwohyENlObvnhC56Zd
         5Mmt/fUl/EyH1Nx78oohQuxyj8lYXfp83yI5oxQqV+ZLdmkePcAFTtm9qGzWlcR3bkuu
         Rn7d6mWkNGXpzhtbQ4wl9PtBv11vqW0eyih/p5ZiufHMdSozRUOjJHJQ1y6/+3+BRJzP
         V8SusR6Y6NBghdSeiFe7UdWz3DxpdNRHU1BxXQ/Xw8Z0h4bMn2X4Kc18P6EXai6ST/gu
         VDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6S1XUbpw3sWz7PK1At9O27hDXZ4W5lBRqtANOwgjMg=;
        b=O3qGUviSJJ3mHLIorptCQMfKRiIcUxibsxDiL4JXZNvmAD26x/ziawBf8G0WJ2Xq+E
         HIvhSCx1T/lgnsWpSPRJkXUU5FRvPGAvFEN4jVgSd8Nvg38LNMa00/MinTZHEmkOGscs
         SG7xd4rm1DL2m0nx7rWxs2mYm2lJcOeCGG0kzu9H8ekNyqZFsFBBn/QVHX+QQ/ksaNEE
         OFyzFnrctl7+xSf2NaBu4BpyOLzUDMhba3PD8Bbl1i1tPCimmgyzkKjK3fYvRH56aI+m
         XSy5MSMJqt6lOcRiwsWsnT6+R+tujTjOnGGgADDcz5xJ32E05TX1NSuvjUP8EAJxcMRT
         YPxw==
X-Gm-Message-State: AOAM531nF0DFyEjPX0JmLRWsvyZDrelH3Dj+M3V2pIU86y7PNf7sktXK
        5cPYxD6NaZOOiJLk+hSZiM2zZO+lpFHlKc0K1sg=
X-Google-Smtp-Source: ABdhPJz2LKVhsK2qEpXCGfrtqDhLtJuXz1SLCCaVUUJbnxp4DfeTSjRNi8D06Ro2Jg9XkjMLPxgPw2zS/ncDdOEpZnU=
X-Received: by 2002:a6b:7d42:: with SMTP id d2mr6124418ioq.176.1611390910963;
 Sat, 23 Jan 2021 00:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20210117042539.1609-1-alistair@alistair23.me> <20210117042539.1609-4-alistair@alistair23.me>
 <20210118123158.GE4455@sirena.org.uk> <CAKmqyKMyXk_OjTKD24Qxn4QXJ4FwP4yDQqtmTsxAJMJzy34PcA@mail.gmail.com>
 <20210122133718.GB6391@sirena.org.uk>
In-Reply-To: <20210122133718.GB6391@sirena.org.uk>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sat, 23 Jan 2021 00:34:44 -0800
Message-ID: <CAKmqyKPsVkUDts=X1sLMyc7hWs_E=1hW6ydzPDXMDMNVWa1u0A@mail.gmail.com>
Subject: Re: [PATCH 4/6] regulator: Initial commit of sy7636a
To:     Mark Brown <broonie@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 5:37 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 21, 2021 at 10:24:10PM -0800, Alistair Francis wrote:
> > On Mon, Jan 18, 2021 at 4:32 AM Mark Brown <broonie@kernel.org> wrote:
> > > On Sat, Jan 16, 2021 at 08:25:37PM -0800, Alistair Francis wrote:
>
> > > > +static int get_vcom_voltage_op(struct regulator_dev *rdev)
> > > > +{
> > > > +     int ret = get_vcom_voltage_mv(rdev->regmap);
> > > > +
>
> > > Why is this get_vcom_voltage_mv() function not in the regulator driver,
> > > and why is it not just inline here?  It also needs namespacing.
>
> > I'm not sure what you mean, can you please explain?
>
> This is a wrapper for a function that has exactly one caller but is not
> only a separate function but also in the MFD header, part of a separate
> driver.  This seems at best pointless.

Ah I see. I think I have fixed this.

>
> > > Why do you need this delay here, and what purpose is this lock intended
>
> > The delay is to allow a power ramp up, I have added a comment.
>
> Use the standard ramp_delay, don't open code it.
>
> > > > +static int sy7636a_regulator_suspend(struct device *dev)
> > > > +{
> > > > +     int ret;
> > > > +     struct sy7636a *sy7636a = dev_get_drvdata(dev->parent);
> > > > +
> > > > +     ret = get_vcom_voltage_mv(sy7636a->regmap);
> > > > +
> > > > +     if (ret > 0)
> > > > +             sy7636a->vcom = (unsigned int)ret;
> > > > +
> > > > +     return 0;
> > > > +}
>
> > > What's going on here, and if you are going to store this value over
> > > suspend why not store it in a variable of the correct type?  In general
>
> > It is part of the vendor's kernel, they specifically added it to
> > ensure vcom is set on resume.
>
> "I copied this from the vendor" isn't really a great explanation...  If
> the device is likely to get completely powered off and loosing settings
> then presumably the entire register map, not just this one value, needs
> to be saved and restored instead of just this one value.  If that is the
> case it's probably best to use a register cache and just resync it on
> resume.

Good point.

I don't have a good answer so I have removed the suspend/resume part.
I'll have to investigate in the future if/why this is required.

Alistair
