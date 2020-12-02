Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520A22CBF37
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgLBOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgLBOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:11:21 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F6AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:10:41 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id s85so152701vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mi0N0NrtTfBp9SWKp7UeI7dL3VImNOs9+9L6eye9hMQ=;
        b=W5oi9bpnNacowsGe3g8WKzDbPxaVWK9Z6vjkhAlOtlMPfb4rzlnYJC8bQ1l5578EsP
         S1aNNlXgKQid/xF3zn87Yo57ohKtT7y8DUprvmREt5P2TODCiKWQB1/26li/tMQg2Lrf
         t/TJUCP/wrB8UpapxRhLFEeL9qHit4ESoWwZANRQkQBXmdp8tv0DNMgbkIVrJJ1ueE/6
         aOenXyN+I2SnzHTtD0CRIDBEZf2NVqgnE6OIr+fLPv/TV9oldt02l1EATBRN3sNJYENh
         wFW+RwvataYIyNNQdbAxxSi8p5WMhNhWKBfTAkK5V/MKLbVFUwkOPpYx9dYiSTg+onbc
         Bqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mi0N0NrtTfBp9SWKp7UeI7dL3VImNOs9+9L6eye9hMQ=;
        b=Iu5fKFo7B/Aa4gYG+ek3+LfM1QYn6THn0nFOQ+m4eoRHHXL9TCMznkv43khcGBIQbz
         JKgKyPNe3C+S56mOeTaKjFV9bDeIwuLUqDe5EkaSw+4J+Ka6ET7gnfb2gRj5X1iqxyCx
         DTCoBrt3092w2Ui+K48R5fzCMbaDR0c6pIWCuJCJUvmx1q2GAe0Q8jdJ0IgGmqSC7p1F
         3eHb0ob9PKEUh+IJMJsZ8l2jRUPNOHZtTPzZ9puMfg4PgsNHhb2reAAx58BAPN+4PO7R
         7iT0ahwyWIimla6EOfxClUJOADgr1l/YyjWOpOQGnKxpZTeU4sxg1dea+HSLtaYot0O0
         LXtg==
X-Gm-Message-State: AOAM532bIuthGSAH080vmKUlb6SQEfspvS8cIszuGkZrxk8DzFsLZHjF
        POYN2aCvlwVAkI+TqfMfO6QEYuW7vb6tji3kMsf3ng==
X-Google-Smtp-Source: ABdhPJw/WYc6FSbQLQIS3Efz1BJ3ypbPM9RtpcceJn07dNrX8Y+SBVFSagPCAp/cDLteavR5bRg9b8mXBmYfeHhTq+U=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr1471722vsd.55.1606918240884;
 Wed, 02 Dec 2020 06:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrg5ur3iTp-dAoVqV5fiFgcmt01j9R7z3_i=tqhWW3WNg@mail.gmail.com>
 <20201202122520.GD4077@smile.fi.intel.com> <CAPDyKFra1+HPGYjG30LkuPxPyN8mQaZan4+AFLKf7_gvd979PA@mail.gmail.com>
 <CAHp75VeXxPoNqJVQojDC1G3gzJUJEiJs2UOm6kob71Aqa_7v2w@mail.gmail.com>
In-Reply-To: <CAHp75VeXxPoNqJVQojDC1G3gzJUJEiJs2UOm6kob71Aqa_7v2w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Dec 2020 15:10:04 +0100
Message-ID: <CAPDyKFpfadG2-JPA1PC5Sx1_eM39AQUQTVj=m26Gu_=GQmjicA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 14:09, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 2:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 2 Dec 2020 at 13:24, Shevchenko, Andriy
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, Dec 02, 2020 at 11:53:42AM +0100, Ulf Hansson wrote:
> > > > On Wed, 2 Dec 2020 at 08:02, <muhammad.husaini.zulkifli@intel.com> wrote:
> > >
> > > ...
> > >
> > > > > Kindly help to review this patch set.
> > > >
> > > > This version looks a lot better to me, but I am still requesting you
> > > > to model the pinctrl correctly. I don't see a reason not to, but I may
> > > > have overlooked some things.
> > >
> > > I'm wondering why we need to mock up a pin control from something which has no
> > > pin control interface. It's rather communication with firmware that does pin
> > > control under the hood, but it also may be different hardware in the other /
> > > future generations. Would you accept mocking up the same calls over the kernel
> > > as pin control, as something else?
> >
> > Well, my point is that modeling this a pinctrl would keep the mmc
> > driver portable. Additionally, it's very common to manage pinctrls in
> > mmc drivers, so it's not like this is an entirely new thing that I
> > propose.
> >
> > If/when it turns out that there is a new HW having a different pinctrl
> > interface, it would just mean that we need a new pinctrl driver, but
> > can leave the mmc driver as is.
>
> My point is that it may be *not* a pin control at all.

Sorry, but I don't quite follow, what is *not* a pinctrl?

According to the information I have received from the previous
discussions [1], it's clear to me that the ARM SMC call ends up
changing settings for the I/O-pads. Or did I get that wrong?

> And in that case you will need to mock up (what exactly?) and update
> the MMC driver.
>
> --
> With Best Regards,
> Andy Shevchenko

Kind regards
Uffe

[1]
https://lkml.org/lkml/2020/10/8/320
