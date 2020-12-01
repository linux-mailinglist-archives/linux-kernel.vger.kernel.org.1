Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E92CA7BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391941AbgLAQGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388498AbgLAQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:06:13 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B82C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:05:32 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id k17so1165558vsp.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OuJ+iD6xtM+VMtARqwefKzhnGpcfRpOS7XnUWAe2JEY=;
        b=S26NKxDQQMuZxt+1oFstIH0f+WpADwmUSiWsrMAdTuElMG8Tk8kY59fXqelvjthP2f
         8db5WERWrK0YCQ4FqlHnBMH/ZATTA6HxEq1tiNLnrLiqZSw/17r/KXgIXCoHSH+Gy1Ww
         SMYLtA7y7XlkxaPsi0YpsQTcdqtJX+8n/g450=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuJ+iD6xtM+VMtARqwefKzhnGpcfRpOS7XnUWAe2JEY=;
        b=T3V7yyfpX4c+zhP2Aqdn3GFwVrisPCEbYL5jumJAX0ekpknz3b2z0eMN177aDjaSTw
         0ADsQHcFlqsOKGwmQa05oSukC5Vqns1u6QMkfPu9ekPIafnWBva/WvnWoRWJA+9U++Hw
         gdm1kYD303hyvP9yat2m2x7EXeUuo2VJjot9/5Q7Qdz0lus48V88uxZn48pXSIRRoCBV
         Ee+efbpiA2ylGaCBfsJGVFLkx2WDiuPnmEcT0o24mlH8xVaayb8jYHkJXt5ibo0H2TwP
         RR3yah+pBLyVIlvnUcevt0vJzocXXoPCWhwfgiD+1/k176nHN5aDEO9QOf6Kx5BzH/E4
         f+vw==
X-Gm-Message-State: AOAM530f6QqY4o23V3PU6301Jh61BPyYdHiDZCZX9cgeAONBYYboiED2
        JhYqEYuyMK6qYEHBJ8pbZgGXwzsgNW4EWQ==
X-Google-Smtp-Source: ABdhPJzkU20fIphNTX2PPQQAxW+TNX9maMZo/mZ7GY2FWS4NTMgRUpdYOuWZ0aP1HC5YemnET1e+lA==
X-Received: by 2002:a05:6102:308f:: with SMTP id l15mr3089882vsb.15.1606838731397;
        Tue, 01 Dec 2020 08:05:31 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id m123sm378619vsd.17.2020.12.01.08.05.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 08:05:31 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id q68so736322uaq.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:05:30 -0800 (PST)
X-Received: by 2002:a9f:3dcc:: with SMTP id e12mr3008143uaj.121.1606838729851;
 Tue, 01 Dec 2020 08:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20201201031015.23314-1-chris.ruehl@gtsys.com.hk>
In-Reply-To: <20201201031015.23314-1-chris.ruehl@gtsys.com.hk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Dec 2020 08:05:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wyk9BYR3cnfm=9tBh=XBxEP=udMTeaEYPzAqa5m8x=yg@mail.gmail.com>
Message-ID: <CAD=FV=Wyk9BYR3cnfm=9tBh=XBxEP=udMTeaEYPzAqa5m8x=yg@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-emmc: emmc_phy_init() always return 0
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 30, 2020 at 7:10 PM Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
> rockchip_emmc_phy_init() return variable is not set with the error value
> if clk_get() failed. The debug message print 0 on error and the function
> always return 0.
> Fix it using PTR_ERR().
>
> Fixes: 52c0624a10cce phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
>
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
> index 48e2d75b1004..75faee5c0d27 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -253,6 +253,7 @@ static int rockchip_emmc_phy_init(struct phy *phy)
>          */
>         rk_phy->emmcclk = clk_get(&phy->dev, "emmcclk");
>         if (IS_ERR(rk_phy->emmcclk)) {
> +               ret = PTR_ERR(rk_phy->emmcclk);

I'm pretty sure your patch isn't correct and it would break use cases.
Is it fixing some bug that you're aware of, or you found it via code
inspection?

Specifically:

* The big comment block in this function says that the clock is
optional and that we're ignoring errors.

* The printout in this function is "dbg" level, which is an extra
indication that we aren't concerned with these errors.

Arguably the code could be made better.  If you want to improve it,
you could check for just the error we expect if the clock isn't
specified (probably -ENODEV, but you should check) and treat all other
failures as real errors.


-Doug
