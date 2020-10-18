Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C25291FA8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgJRUBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgJRUBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:01:52 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBABBC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:01:51 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k25so10564623ioh.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRw0/o5oGZTZDjjB3gqNIBPtxjJHtDVQ+1IUMXih6zw=;
        b=gvDwqRVNDojHEaRSR9D1CBu8YuHYcAxmjdzaT9DBoFJeXkdNv/dKZqnBe8DOjNgnlL
         nr/JbAzCYLqeXD3NgU3Ranu+PyyI0jhgr1L1b1NoVja30nViV7obzDbT5Ob7+F15u0gt
         h00ddz2XJMsMueX17SmCXYR1PvIkF9U6edigDrX0fdupBWOjIUZLVN8+vvrmvuKkOJ6e
         FUywBdobrBeEXdUlVfVn/PPuwW0wIYir7mEfCTwlxn5/83kQDg39PJWUVgRuTTmnwBeF
         tdqsfGjU6xR4svByJOpkuWvG1QKrqtlP4M6Jmsjpi8StAPhwYNjDfyAOnUZC8Le+Gw2Y
         JLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRw0/o5oGZTZDjjB3gqNIBPtxjJHtDVQ+1IUMXih6zw=;
        b=YUrQHbiYUiyFHjU09+XXIIWY0WKn8+nPuJ5+h3jzqSlLJ/ei3PviV6GRLQjx3xEFey
         4ofYwNFOS5PyCwSjd1WxDMHgQNni2FYYRrIwuvpIhCyZxCU7+yDrlr10xOFXGDc1bbpC
         mh7x46LOfyxdJyFcK2TJW8/tUaEBCZlH0amn8axWFB5Xo6DmBV7YE40NC4kmDU/u9mIX
         Bf8/EZJVGr27wltNrcyWulQIL+2vqNRt42XWJFYxWbhryse2ys6wN7uvS6u76HL0uNbi
         BBpnkzvk8v1V03v+not9g+BMuOZJcg89Janj3CZQgPcRSvhnUMh2Wklab2f5RlJFoKSV
         Ip4A==
X-Gm-Message-State: AOAM531M62HELZRBkN1Hl2931YLoHVrKVEzRTTTvV5xhtiJrznO4taOR
        wPePRYhgCtT/QSyZPaEwQa4hf6Wnpocp4p0Vselw
X-Google-Smtp-Source: ABdhPJwSkNVofX2Rs4udoFZfsL1pIQx70wVs4ruhTz3vz35pvUxHZs8N+2Bm/9qad7XzQYL36FuETG0/KDTY+IzxMKU=
X-Received: by 2002:a02:6cd0:: with SMTP id w199mr9067803jab.121.1603051310571;
 Sun, 18 Oct 2020 13:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201018150442.GA219064@ubuntu> <CAHp75Vch2jPwZm8gVC6zRs6k=BR23Mb15Q4R4VbpMZ5FwshNLQ@mail.gmail.com>
In-Reply-To: <CAHp75Vch2jPwZm8gVC6zRs6k=BR23Mb15Q4R4VbpMZ5FwshNLQ@mail.gmail.com>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Mon, 19 Oct 2020 01:31:39 +0530
Message-ID: <CALudOK5Hy3cU6W+yWAgpqxP-27K2MXiwSwR1x3z=mJjq3y3K8w@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: vcnl4035 add i2c_device_id
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 11:59 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Oct 18, 2020 at 6:47 PM Vaishnav M A <vaishnav@beagleboard.org> wrote:
> >
> > Add i2c_device_id table for the vl53l0x-i2c driver,
> > helps in device instantiation using i2c_new_client_device
>
> In all your patches please refer to the functions like function().
> For example, here is i2c_new_client_device().
>
> > or from userspace in cases where device-tree based description
> > is not possible now (Example: device on a gbphy i2c adapter
> > created by greybus)
>
> Don't forget proper English punctuation, like periods at the end of sentences.
>
> --
> With Best Regards,
> Andy Shevchenko

Thank you Andy for your review, I have updated v4 patch with your suggestions,
https://lore.kernel.org/patchwork/patch/1322219/ (sorry about the
incorrect driver
name in the first-line of the commit message in the v3 version). This is
also fixed in the v4 submission.

Thanks,
Vaishnav
