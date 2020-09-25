Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8CC278229
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgIYIEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIYIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:04:33 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E485C0613CE;
        Fri, 25 Sep 2020 01:04:33 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so1573667edt.4;
        Fri, 25 Sep 2020 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nCoifbkeuSkm32g7FfRMjrrGtoOLRMD6Zxww8rwgSY=;
        b=k4bh6DUjkzSke+B7L/UMoe1ivoznzvxi0ad4wPwtsZGoWWxk3Udc+bdz7nyo6ZmxfS
         qkPJshm7a2kWgy6KAEhURguLEO4FJflS+R/I1mdeCCmfiU0BhzyucFSgjoSIiknjqS/3
         5LDc1Qz9DCmxM2zeZzyCXs/M58SfCe0gx94TBzDZfRMHZIqRM3vulgl2BldpdenUS4DZ
         kpg0EXJManOmZwY0vT1SeOP6Eelac7dtp/TS1xaLt96PfJmjz0QCDPIep9SaoEuM/8kK
         01FVFLu6nuBWpYrWDrn1QrmQ4azWiIXsyAjZ5Qn35TwO0+DxfgkqlpufcovPi7zAnE2S
         xJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nCoifbkeuSkm32g7FfRMjrrGtoOLRMD6Zxww8rwgSY=;
        b=I8jH8rObMLf/jHiPZz2Palh2ChFKmL7HWibRRy2aVFoJ8jEd6TEUpjrtYVPn2m5+Dz
         /a2Dyvmr/QvsaCX1DC60mCE4vW/nA0E3nnAagg2Ffwy2VV+yV/DVFyBzTbNmybWrYwwS
         5T79fWLl4nKSSjvvQls1PBvSwb9uRZaVxbXd91lXN3PhT1eKZkIpR+b81tpZ7giPV7Au
         A9IT63eIwdlwI+Aqa+Y4F7rbkRkoe6zeEBJQjxpY1xnAwZsbYt1v56Z0IMK1uzteIYRY
         enre3o7FHVXVWmwKfMKm+waXdZGoOAe1m9T9BUlucJqFJlbe03wHSw+ZF3p4gtA5RvKK
         jf9A==
X-Gm-Message-State: AOAM531R6XI4dEZm59YjXvJn+D5RDjLt7FDAunv5LZktVfnEieNNPO0g
        0Wg5PtOoU2Wg3mv3vFifNYr6qsgImP2PBePRPJI=
X-Google-Smtp-Source: ABdhPJxeDIGT9fA+GFpnV/N6d8qqejXu7XMaJ3dwMmOkk5HsY/gbxhunvPYF46+CM+RrsH5NNhmumepRvh+9msyzJwg=
X-Received: by 2002:aa7:d6c6:: with SMTP id x6mr14862edr.338.1601021072020;
 Fri, 25 Sep 2020 01:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200925033017.1790973-1-art@khadas.com> <20200925033017.1790973-6-art@khadas.com>
 <CAFBinCAJ6svwiv9OM6EHz7468D9h+jW_ULiGrorgLetcODsAKQ@mail.gmail.com> <CAKaHn9+CWLJYN1Tt46VxBGNBEbVVJZWeL6ZJSf9w-5DmoxrvgQ@mail.gmail.com>
In-Reply-To: <CAKaHn9+CWLJYN1Tt46VxBGNBEbVVJZWeL6ZJSf9w-5DmoxrvgQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Sep 2020 10:04:21 +0200
Message-ID: <CAFBinCD0_QgKKcH+Kb2QbMWnx_csoXMEhSFYzmDscdTVB2TUJw@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: meson: remove reset-gpios from ethernet
 node for VIM2 meson-gxm-khadas-vim2
To:     Art Nikpal <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        robh+dt@kernel.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Artem,

(adding back the mailing-list recipients)

On Fri, Sep 25, 2020 at 9:50 AM Art Nikpal <email2tema@gmail.com> wrote:
>
> hello
>
> > what is the problem that you observe here?
> > did you investigate further why resetting the PHY changes this?
>
> just try next commands
> ifconfig eth0 down && ifconfig eth0 up
> and ethernet never up again - need full reboot only
this means that "something" is either set up incorrectly in the Linux
kernel or that u-boot does some magic (and the same magic is then
missing in the Linux kernel)
I'll dig out my Khadas VIM2 to test this. what should I look out for
(are there any error messages, dhcp not getting an IP address anymore,
etc.)?

> but if reset-gpios will be remove it works fine already - i have checked it many times
>
> for example VIM3 same didnt use reset-gpios
that's interesting - I'm surprised to see this
I did a quick check and for 15 out of 18 .dts(i) files with RGMII
phy-mode we use the reset-gpios:
$ grep -R 'phy-mode = "rgmii' arch/arm64/boot/dts/amlogic/ | wc -l
18
$ grep -R 'ethernet-phy@0' -A10 arch/arm64/boot/dts/amlogic/ | grep
reset-gpios | wc -l
15

so really I would like to add the reset-gpios to the VIM3 .dtsi as
well once we figured out what's wrong on the VIM2


Best regards,
Martin
