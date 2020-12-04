Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0106B2CF363
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbgLDRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbgLDRx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:53:57 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E0CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:53:16 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id u7so21013vsg.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqihWCBkMsBsCD9BeoyI1g9VVkUVEnrNjSab8rvd76o=;
        b=Iav/LhPXwbicYbZPRxVD6NYEjmYhGak6V34EoZ/WJvkg0xce6/p+Tzgr9f1pVdXyuv
         2Wd/hwDPiRI0QCmE4Vv2pqVkVil4Ijop7o2B0NuKjxgc2GfiXvVDO+mq3ujHaC1+50Qw
         ba/It1cBhsW6uQb3pXoFWquTuibR4uZTXfGk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqihWCBkMsBsCD9BeoyI1g9VVkUVEnrNjSab8rvd76o=;
        b=HGkq2zUX2VHg91cx97JVsPx4T0SE0sznNq8o3kvPHgSmd9kJbc2ZpMyJYTjmfKY1cl
         lwNxY+04P0j0OpIzD6YWD6w++Vle8YG3m5qADBLcCyxqd1ZHPhnhMlPYpP+fEa0/c6fP
         oHOCQ/HuEMc8av3EHdS5r3uI64/USV9vfM04Qk5pc07wTQa/0I4S5GnSS2xy0OFpzzki
         AFOtSjn9jNHP48tR0UMWtjmMtKbDSNUyMKP5vAWv4Z7KCJFqDXEQb/12umHQKY4v171w
         7e6bK2wP/EaC4BDr3mmIJo+VufyPMJR1Bkkhj8uMcT7ZoBN5UaIIKLZeertEFro7LMSk
         P7AA==
X-Gm-Message-State: AOAM533cpBRwYYAj7k7wPWDTb5hGC0PVjBiUxHAShmr3b27U9bIUjg6o
        Bn/o/4y9/o9dysP4tYNUNx4hReiIpKI4Yg==
X-Google-Smtp-Source: ABdhPJzXsme9AVhhpbWCJE13s2LsDp4bKEQASC32f7t3RJ7rc5dWHEZ7oqgQqQK+mi0T6z2qdThCmQ==
X-Received: by 2002:a67:7307:: with SMTP id o7mr5282152vsc.41.1607104395405;
        Fri, 04 Dec 2020 09:53:15 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id w15sm193274uam.6.2020.12.04.09.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:53:14 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id 128so3699730vsw.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:53:14 -0800 (PST)
X-Received: by 2002:a67:4242:: with SMTP id p63mr5089432vsa.34.1607104394170;
 Fri, 04 Dec 2020 09:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20201201031015.23314-1-chris.ruehl@gtsys.com.hk>
 <CAD=FV=Wyk9BYR3cnfm=9tBh=XBxEP=udMTeaEYPzAqa5m8x=yg@mail.gmail.com>
 <f8a21465-91d0-9967-e559-d8f91f795028@gtsys.com.hk> <e6d351f9-232c-ebab-2f4e-bf2ff4dc8238@gtsys.com.hk>
In-Reply-To: <e6d351f9-232c-ebab-2f4e-bf2ff4dc8238@gtsys.com.hk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Dec 2020 09:53:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UjwK7qz-SOJNpZbq4bABWgDunZ0Yjk+Z9zs=wSH=sy-A@mail.gmail.com>
Message-ID: <CAD=FV=UjwK7qz-SOJNpZbq4bABWgDunZ0Yjk+Z9zs=wSH=sy-A@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-emmc: emmc_phy_init() always return 0
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 3, 2020 at 7:01 PM Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
> Hi,
>
> On 2/12/2020 4:36 pm, Chris Ruehl wrote:
> >
> > On 2/12/2020 12:05 am, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Mon, Nov 30, 2020 at 7:10 PM Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
> >>>
> >>> rockchip_emmc_phy_init() return variable is not set with the error value
> >>> if clk_get() failed. The debug message print 0 on error and the function
> >>> always return 0.
> >>> Fix it using PTR_ERR().
> >>>
> >>> Fixes: 52c0624a10cce phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
> >>>
> >>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> >>> ---
> >>>   drivers/phy/rockchip/phy-rockchip-emmc.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c
> >>> b/drivers/phy/rockchip/phy-rockchip-emmc.c
> >>> index 48e2d75b1004..75faee5c0d27 100644
> >>> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> >>> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> >>> @@ -253,6 +253,7 @@ static int rockchip_emmc_phy_init(struct phy *phy)
> >>>           */
> >>>          rk_phy->emmcclk = clk_get(&phy->dev, "emmcclk");
> >>>          if (IS_ERR(rk_phy->emmcclk)) {
> >>> +               ret = PTR_ERR(rk_phy->emmcclk);
> >>
> >> I'm pretty sure your patch isn't correct and it would break use cases.
> >> Is it fixing some bug that you're aware of, or you found it via code
> >> inspection?
> >>
> >> Specifically:
> >>
> >> * The big comment block in this function says that the clock is
> >> optional and that we're ignoring errors.
> >>
> >> * The printout in this function is "dbg" level, which is an extra
> >> indication that we aren't concerned with these errors.
> >>
> >> Arguably the code could be made better.  If you want to improve it,
> >> you could check for just the error we expect if the clock isn't
> >> specified (probably -ENODEV, but you should check) and treat all other
> >> failures as real errors.
> >>
> >>
> >> -Doug
> >>
> >
> > Hi Doug,
> >   I reviewed the code while hunting behind an other bug, with hs400
> > and yes I saw the comment that they don't care about the problem
> > if the clk_get() return an error, and set the rk_phy->emmcclk = NULL
> > regardless, not using the ret variable but define it isn't useful.
> >
> > If return a error code break something on the other hand, better it
> > hit it rather then suppress it in IMHO.
> >
> > Let me follow the caller of the function and see how they treat the
> > err != 0.
> >
> > If something is in danger, I will be effected with my rk3399 rollout :)
> >
> > Chris
> >
>
> I check my case, the dts properties emmcclk is defined for the rk3399.
> (checked it I do not have an error, clk_get() works)
> If clk_get() failed and we propagate error<0 to the phy-core.c which then
> not increase the phy->init_count, but throw error message that something goes
> wrong.
>
> Someone should explain to me, why we should cover up an error.

If you want to change this I'd guess you'd want to change the bindings
in a backward-incompatible way.  The bindings
(Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt) say:

 - clock-names: Should contain "emmcclk".  Although this is listed as optional
                (because most boards can get basic functionality without having
                access to it), it is strongly suggested.

Since it's officially listed as optional then the driver needs to
function without it.  It was a long time ago, but my guess about why I
needed to list it as optional was for the whole "device tree purity"
reasons.  In other words the goal is always that old device trees
should continue to work, so if you're adding new properties they need
to be optional.

It seems highly unlikely anyone actually has a device tree that
doesn't specify this clock, though.  If you want to cleanly go through
and mark this as required everywhere I won't personally object.

-Doug
