Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C992EFE15
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 06:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAIF3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 00:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbhAIF3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 00:29:13 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C2C061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 21:28:33 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id v3so12590870ilo.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 21:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGJ+rw+W4GURXrNK2pmbCTTGByeuvg3W5dm2nsGXVqc=;
        b=e6nx/kwcJM7VPuCBH5IWplKbkraC/qn24FmETITfB+AdMox+nSM0xHvvv708lOonRF
         DLeZ5Rv5WL3zZH7s3BMkI6yYsuPJPviDM+EONQoJBoZsQknXIkUtDrm1XLtJ98j2DZZU
         +A9uP+JUBpcUhflklMJS0Udebfu+ItwwQMHHm8CPwnlFVGUHruVn3bxs+ieOXxcQtbBm
         PZUdp6y2kDD/E3NJSdlQVlwg9ALQ3m1kV0xWLmtyseEI1E1xXowMUAqcS9rZG3ibxGkw
         j0jKB8OMKpdsZyCG5jGmwn2n+7/kV+Q6Svk1AVRJBlVrV2y8XOV/IJGVQ7nKPPt5yRdK
         Je6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGJ+rw+W4GURXrNK2pmbCTTGByeuvg3W5dm2nsGXVqc=;
        b=Yw8eukr/SLxZ1M3yLp+oxzeiZuJCd94tX5NniiMf52W9ispkVU0yXXZQJb5JVvDeex
         4xj796p73t0rT/lOpGqJm7PK8E503j8U2Xo6vprvHVUKCN1wFEQPeh6kIp6a9SHbmlee
         Yvcsoj6Shzt2yKS4JmNbDQnGkdhbempdFu03CR+Ceywinz4qERJStHYRK8xpxZpfpuik
         ZRPMEWpGkxPwMrGmJoYLpoCabXBI3LMlEHp7o+voVXt0SF1s3pRFjYdNgmjsMOxRpOBZ
         cHZhrDATwpetk1RynVQMlisDarals0BxiokI7tQdTmxWiytBaVachdRkcwGtCsc+1+EK
         Soyg==
X-Gm-Message-State: AOAM5335Y5dnLHMDrCLkmxFjwMWNlE8mSeQLBixWadA5jX3/xLbFV46O
        1uHHO6nezbAo4ggjCNm5kSqCC8/YtLNl44PnLRxv/q+R1aY=
X-Google-Smtp-Source: ABdhPJwXmdm0hnvBNMln0jDzDSyCadfT8/QRKEJtLxxdHSdh9mYMK50aw50mzokAvARDzxSWoWjR2ryTm1PXaEOQz5w=
X-Received: by 2002:a92:d40a:: with SMTP id q10mr7326896ilm.20.1610170112894;
 Fri, 08 Jan 2021 21:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20210108025155.31556-1-dqfext@gmail.com> <X/ijjWpq4eLQEDot@lunn.ch>
In-Reply-To: <X/ijjWpq4eLQEDot@lunn.ch>
From:   DENG Qingfang <dqfext@gmail.com>
Date:   Sat, 9 Jan 2021 13:28:30 +0800
Message-ID: <CALW65jaWwhiWbr1kcEW3OZEUcGYUO9_vmT7PhA+u4SvVGdEgRQ@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-dts: remove obsolete switch node
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-kernel@vger.kernel.org,
        Rosen Penev <rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 2:25 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jan 08, 2021 at 10:51:55AM +0800, DENG Qingfang wrote:
> > This was for OpenWrt's swconfig driver, which never made it upstream,
> > and was also superseded by MT7530 DSA driver.
>
> What about
> Documentation/devicetree/bindings/net/mediatek,mt7620-gsw.txt ?
> Should that also be removed?

Yes.

>
>        Andrew
