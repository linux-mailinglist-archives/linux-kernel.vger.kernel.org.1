Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA502B8D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgKSIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSIZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:25:11 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7758C0613CF;
        Thu, 19 Nov 2020 00:25:10 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id v92so4401656ybi.4;
        Thu, 19 Nov 2020 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e1f+fQfsOmUnA6/dHY7qSh+3HPGss0Yw9e5UG3bpbW8=;
        b=NGfgxj1h8FQPW7e3CjHZ3RlcUb228SM97kaapzzML3mtW4QiiIO3Ob79jefzelbrIe
         ym8XR9DqFaOCytU5uyeTMnw4LZV+8dTgxxWcGIhFARvuN6ds+AEFRq8sSqosLQ5swxfm
         w4I5B40yN9WLQr0vM5sGAdjkiFiPCeGYFMKclZrfPD/yXrhyXWvYQUyXjA69/2UvFJrc
         1LL2AKeBwBQzGomOUkIkGXHgrIWGiIDvfgGCiviuV1542nY22M2s0MjLLOT/NhAJDL/6
         B6n+2u44rWd+ARBI8Z1VlTf5k+Z+r8aFy+/eBYKvcw1Kaq4vlbAvQM9IFEnMV+dPHupy
         R1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e1f+fQfsOmUnA6/dHY7qSh+3HPGss0Yw9e5UG3bpbW8=;
        b=dPN/tABUjmGNH2JHn03s3530+OequxjCaBpb7XMnCFei5JN3wd2X0b/kVi9LA3AV/1
         tBAzMzXDcOa3FZZx328nTjhcNd9gCgVzzmIdeTo80ntsneS/on1W5sugJ88F+OOEG497
         lEbGXbs96A++/vzrhK99CGPRSjSVEvJnVi2WGbtIve3RQhTvDXRpyLMSRL7ydm+r3f52
         5hG0nAmJPRAlZQJFuiNPO5KU1iHCrgfj4KWUWKCwOSt14Xe93bh7UBjLPCqcYUPfRZZI
         G4sotFOSa4n0TTCjow4hfplCwybAaBY5RGjI717L5wY9BbIhdNBpOihW3fLIej6LPDIJ
         QaJA==
X-Gm-Message-State: AOAM531loW1eW3qX3aDc7P4WRlDAWeZD+VVc8EsbByoENcDHmRB5Fuq1
        mAS+16MBmwuuGzl6DpIih9wlqB5doZytOWR+Bn4=
X-Google-Smtp-Source: ABdhPJxJtpTCNTfjMxiXEt4eAsiY6NDQKYWYDWq4YpVFTsX/c7ppdtkLEPa6/tXeXuSG7d+CSSWFzVd3wXBb32hsYs8=
X-Received: by 2002:a25:bc0a:: with SMTP id i10mr11389858ybh.10.1605774306722;
 Thu, 19 Nov 2020 00:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20201113113423.9466-1-zajec5@gmail.com> <20201119062720.GE50232@vkoul-mobl>
In-Reply-To: <20201119062720.GE50232@vkoul-mobl>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Thu, 19 Nov 2020 09:24:55 +0100
Message-ID: <CACna6rzLwQFcTLU6WwhtAHZ-GXo7cJZGrCn+SXRTHa3B=ZQ9Mw@mail.gmail.com>
Subject: Re: [PATCH] phy: phy-bcm-ns-usb3: drop support for deprecated DT binding
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 07:27, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 13-11-20, 12:34, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >
> > Initially this PHY driver was implementing MDIO access on its own. It
> > was caused by lack of proper hardware design understanding.
> >
> > It has been changed back in 2017. DT bindings were changed and driver
> > was updated to use MDIO layer.
> >
> > It should be really safe now to drop the old deprecated code. All Linux
> > stored DT files don't use it for 3,5 year. There is close to 0 chance
> > there is any bootloader with its own DTB using old the binding.
>
> Applied, thanks
>
> While applying, it gave me a minor conflict, please do check the
> resolution

Looks good, thank you!

--=20
Rafa=C5=82
