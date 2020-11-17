Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D32B5E39
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgKQL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:27:37 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB061C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:27:37 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id t8so10865957vsr.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJ6od9McrPMmdAw4AV7uEvRIjejlQ+vKJRvVg9MI4ko=;
        b=K36hufdysbVWhCU4svS8Pc3+yb0iT4gKHBu5uOJokNvd6bDdJeWvsW7l33U1uIPh4a
         ZGRaGsmbSN0/iZvaDH57KJUchoU6Ii5WDoP6RzUMRq6cycTP5d/dFqU0T4Y74jH5vFMH
         EfvIpyeGcAVQjQcVXQ+Ci21MF962YwiYYRU88yn93KMHaw527KGXD0xEJfQ+1wKzi4ra
         Tlbu7mGyYhwTuQCcXwTcbGwOtOMNtkzcwgpPKrhIKMcxkw11n67HPt+DbynsXiC5oec3
         6l5sj2B571995pIrmsds6NzXl9sRSnkdEV1NqFW+k3eOavvkOBhjdbgkTw5/upeAlncd
         Slgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJ6od9McrPMmdAw4AV7uEvRIjejlQ+vKJRvVg9MI4ko=;
        b=OmgC4uvZqSV1jdvMnbGBLbK73PFUI74H3F3bXkBo1ntVuePnfm4ifc6Qaus6rEyFaP
         J9xBpx2g+9sYM9jPG7SZd7UjWrq7OXVljm7+HIcyMrEDDWr4QRpWyayoS90dZY3t66hb
         6XwfZ3vdMfYakW4wAiSkPHAHmIMXMKZiV9S2QHxPEgrKQyxdqWD1mxrwOEqKqawT6pBs
         MClPo3oFX101ucJUnftdXwUc0YPy1IwXp2cNl0KgvbturWqBNzlOWG8uKmhGIXGBVlkM
         Ztgx5N8JdsPaY90DWjmX09nAazE5hr7FS+hFRv+xE+To4VZj2+IMEaKG94VPZyXRY/r1
         m2mg==
X-Gm-Message-State: AOAM5326MoBpsUrxIeJPTs6pY2cfkEmRZpMAs85KGKOgdomDAyoejmzA
        8WIqSrNTQ7Nzsygg9G5k/PT0CdyC0SYHKr+LpFhFoQ==
X-Google-Smtp-Source: ABdhPJxkXnes2p6YHECDrKrrBG2GDdqrp5ut8s6gultvQTB+ovgHt1SMWFt+SHDNj4iDrRQdHuskHjfUkly50tbEFQY=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr3329095vsd.55.1605612456743;
 Tue, 17 Nov 2020 03:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
 <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com> <DM6PR11MB2876BB714DF701E81866B13EB8E30@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB2876BB714DF701E81866B13EB8E30@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:27:00 +0100
Message-ID: <CAPDyKFpVJ0jGkqa2j9W-Z-su3vT2eSKHkObYj1Z0C3MvRQrKwg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 at 15:22, Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi Ulf,
>
> Thanks for your review comments. I replied inline
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Monday, November 16, 2020 7:41 PM
> >To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> >Cc: linux-mmc@vger.kernel.org; Linux ARM <linux-arm-
> >kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> >kernel@vger.kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Raja
> >Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Wan
> >Mohamad, Wan Ahmad Zainie
> ><wan.ahmad.zainie.wan.mohamad@intel.com>; David E. Box
> ><david.e.box@linux.intel.com>
> >Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
> >Bay SOC
> >
> >On Fri, 6 Nov 2020 at 05:10, <muhammad.husaini.zulkifli@intel.com> wrote:
> >>
> >> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> >>
> >> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations
> >> handling") introduces platform specific SDHCI clock operation.
> >>
> >> This patch declares the clock operation for Keem Bay.
> >> Add clk_ops for SD, EMMC and SDIO operations.
> >
> >The above commit message doesn't really tell why or what goes on here.
> >Can please try to clarify that.
>
> We missed out the clock operation handling patch (Commit 16ada730a759)
> and did not handle the clk_ops  for Keem Bay SOC devices.
> These 2 patches (Commit 16ada730a759) and (Commit 36c6aadaae86)  are merged at around the same time.
> We catch the issue later when trying to boot into v5.10-rc1 with Keem Bay EVM.
> That is why I created this patch to handle the clk_ops for Keem Bay devices.

Alright, so the previous changes were simply not sufficient to
complete the support.

>
> >
> >>
> >> Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem
> >> Bay")
> >
> >Is $subject patch fixing a bug/regression?
>
> This is to fix issue on previous commit. It is a bug fix.

Has it ever worked?

Did the commit you point to with the fixes tag, break some other
existing functionality?

[...]

Kind regards
Uffe
