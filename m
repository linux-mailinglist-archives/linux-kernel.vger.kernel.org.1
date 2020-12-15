Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB52DA9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgLOJTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgLOJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:18:56 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29EC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:18:09 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id b64so14374947qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bkM2HbhDcW0W7natkzNnj9048me2YUlGqvZ/Ms8LWRY=;
        b=v+qyurL3slnKuwSPDsELpzzsc50fSVMPcAZBbsFiRPhaPFh3tabqlSbjpu3erjAZXl
         Ld6OYWnssIrKYY12qg5+6UQxLhjD/FbSa6bmJGGBpCP666O6EqyGHzKv4BIqGqT1fOlj
         zyitO2VGDTL5UBBj+hC1sIJg+wcA2feF+VMuU+waAOrkUy+Oz4H2fdPi2jAKk/36QgX1
         1kKJykJSn8JxzTULwyOL2hpnA/ejDukDh7FzTO5TDAP7BSxr54VIJYz601bg2JyigPYI
         Q1T/3EpnvxupDzoR/OR9yIThXAssgKCxpnQLvJw3f6ZS4ENYRscJr3sem5ivPulPCr+/
         B1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bkM2HbhDcW0W7natkzNnj9048me2YUlGqvZ/Ms8LWRY=;
        b=FRA8oOQDU0YytyLaG40vrgg4tQFk8uZLfKga8krFXYInCXS0m2/1WvhNEeFxAzKvB+
         a4h/gyXAtqNE0AAsqlxBJrQ86X6hDbDaUQGscAEt5S25jyou+gqpn7w1MXiTMi7rsgrH
         jgUkWenE0LJg5NrztWkGEpqsgXyCV8dw0CyLeF9Gx5fL88XPqmbYPl9UfapdF0Y3IEhF
         rsDYbFl69rliTu7ThuqkU/yb5BL1+ch6C3vMUUFNGZTbqf4s+xEwL3G/miVxZuLxnMJW
         k/s9s5tnkC3lN6NSM/wj1Qq51MCA5vbVmVRfeIbX86oAg7VkTwZfM3JPJAQssjbB7k+M
         FDow==
X-Gm-Message-State: AOAM5301+6zIVYi+QvzZvUhLEgQ9VEo5gN6pqyjsZVIsrQbQ6XcIh8M8
        CdWtaYu90TCQS1/xLxGia58kJpUQgbtu1Cg5LngGjQ==
X-Google-Smtp-Source: ABdhPJxgmDF7FB4QO+7Fwlq6nJzZlVTHDITT9LbIKhf3znJs+qjDoODiKucjR2feitnWooIGigYul+2I+Ga8L/Bs7+A=
X-Received: by 2002:ae9:e855:: with SMTP id a82mr38490647qkg.300.1608023888983;
 Tue, 15 Dec 2020 01:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20201211141656.24915-1-mw@semihalf.com> <f6d0f22c-2a19-d1dc-b370-4238a7d2d9b3@intel.com>
In-Reply-To: <f6d0f22c-2a19-d1dc-b370-4238a7d2d9b3@intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 15 Dec 2020 10:17:57 +0100
Message-ID: <CAPv3WKfsfDC9PFYFWZBXWk=h+bfyQaaLwca-vujS_G8=Rd1jSQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: fix 1.8v regulator stabilization
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Ziji Hu <huziji@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        Alex Leibovich <alexl@marvell.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 15 gru 2020 o 09:04 Adrian Hunter <adrian.hunter@intel.com> napisa=C5=
=82(a):
>
> On 11/12/20 4:16 pm, Marcin Wojtas wrote:
> > From: Alex Leibovich <alexl@marvell.com>
> >
> > Automatic Clock Gating is a feature used for the power
> > consumption optimisation. It turned out that
> > during early init phase it may prevent the stable voltage
> > switch to 1.8V - due to that on some platfroms an endless
>
> platfroms -> platforms
>
> > printout in dmesg can be observed:
> > "mmc1: 1.8V regulator output did not became stable"
> > Fix the problem by disabling the ACG at very beginning
> > of the sdhci_init and let that be enabled later.
> >
> > Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core fun=
ctionality")
> > Signed-off-by: Alex Leibovich <alexl@marvell.com>
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > Cc: stable@vger.kernel.org
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Thank you, I'll repost right away with the typos correction.

Best regards,
Marcin

> > ---
> >  drivers/mmc/host/sdhci-xenon.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xe=
non.c
> > index c67611fdaa8a..4b05f6fdefb4 100644
> > --- a/drivers/mmc/host/sdhci-xenon.c
> > +++ b/drivers/mmc/host/sdhci-xenon.c
> > @@ -168,7 +168,12 @@ static void xenon_reset_exit(struct sdhci_host *ho=
st,
> >       /* Disable tuning request and auto-retuning again */
> >       xenon_retune_setup(host);
> >
> > -     xenon_set_acg(host, true);
> > +     /*
> > +      * The ACG should be turned off at the early init time, in order
> > +      * to solve a possile issues with the 1.8V regulator stabilizatio=
n.
>
> a possile -> possible
>
> > +      * The feature is enabled in later stage.
> > +      */
> > +     xenon_set_acg(host, false);
> >
> >       xenon_set_sdclk_off_idle(host, sdhc_id, false);
> >
> >
>
