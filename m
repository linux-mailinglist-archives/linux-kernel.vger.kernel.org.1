Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5ED2CFDA3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLESmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgLERic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 12:38:32 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D954C094267;
        Sat,  5 Dec 2020 05:14:24 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id i24so920821edj.8;
        Sat, 05 Dec 2020 05:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSWuLaWp7kbS1P3O0848/H0adnOKzlmdgp1RQ+ybx9E=;
        b=DfuNWu0nvI/vVGwzISzLSSGehEluoo+f6F2w8cnNEFZ6a5Yg2UrKW+I9A+SOR4/Y9R
         12c1zdDfc88FUXJ67ZddR7xaLyOd5DnO9WKZYsgYatjFSXOY7moPGweTQCCC7p80LKyc
         UL+ri58kmYox4rh31GYuaGdK7VI0dfTzYbM09MSxZf4YRJ2wlrzXi/e6bmt2IpQ4zy75
         X8oOVyrKZkkYE7JVDH39hOY8EZt21JZT8E7i//I1ME5t6VPD6EyHXZ0EIYo3X7YzG3V5
         ol/hHsJ/T9Jen4j89EYlphWclFthOV+h4p65gd0BgAiuDi6Mis8/o3fhJeqyecOtS966
         G5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSWuLaWp7kbS1P3O0848/H0adnOKzlmdgp1RQ+ybx9E=;
        b=i5rF2LOA+FkTAZ6Rs2rqdZyD3HHTREv+GXKkcS7NwW7Wp/wC+F4hJf0GTTV5Bcs7kl
         Z+t3ewwdND7YfiGHR2h5/7FluWhZ3FY8lu6BVZxovKv5cw/5RLuU6pMJippaMbdij//5
         Qw5qSp9CWF5T7/3Xt+cFnA7Thc6r0WP2OGtbAZnTut8YdFoXML+PfyEI9vyXt8FhGMWI
         C6k4U1DJlBy4GuXQvQJoV8x5ooVgWw8vx2i3f05UL+lhTQxFTDum8Vyza79T6jk5sm09
         3iXpQpy1ZasbrmLJP3+iZCjqgc6RrpzgKA/3XFEP13es4V8zkVFnWUvVAnWij7MeylTC
         8ZHA==
X-Gm-Message-State: AOAM531kSyT4o8GzimPk0fkzBW7VHKMJaSwXdcEZoXnbUA8eLYiQr8p/
        0OMOWgc6Y8V30FEc0XnXXRxDJhFP0JFRjONW0bgHoc3j458=
X-Google-Smtp-Source: ABdhPJzRPCNK8jPVIDmwevaTpwC/Fk3APx2o2HatJoY6Xlb9UvfG2YB3rpdT+mX5GocDIz0W4p7xxZX31yeO4wv3RmI=
X-Received: by 2002:a50:fd18:: with SMTP id i24mr12318534eds.146.1607174062920;
 Sat, 05 Dec 2020 05:14:22 -0800 (PST)
MIME-Version: 1.0
References: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
In-Reply-To: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 14:14:12 +0100
Message-ID: <CAFBinCCBQupdpm0CmxZo_VeRyk_Kqwqsf+Q66aaxqcNv3hsA9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: dts: meson: g12b: odroid-n2: fix PHY
 deassert timing requirements
To:     Stefan Agner <stefan@agner.ch>
Cc:     khilman@baylibre.com, robh+dt@kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        christianshewitt@gmail.com, jian.hu@amlogic.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:21 PM Stefan Agner <stefan@agner.ch> wrote:
>
> According to the datasheet (Rev. 1.9) the RTL8211F requires at least
> 72ms "for internal circuits settling time" before accessing the PHY
> egisters. This fixes an issue where the Ethernet link doesn't come up
> when using ip link set down/up:
>   [   29.360965] meson8b-dwmac ff3f0000.ethernet eth0: Link is Down
>   [   34.569012] meson8b-dwmac ff3f0000.ethernet eth0: PHY [0.0:00] driver [RTL8211F Gigabit Ethernet] (irq=31)
>   [   34.676732] meson8b-dwmac ff3f0000.ethernet: Failed to reset the dma
>   [   34.678874] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
>   [   34.687850] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_open: Hw setup failed
>
> Fixes: 658e4129bb81 ("arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY reset line")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
with the "registers" typo above fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
