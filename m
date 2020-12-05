Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584C72CFD2E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgLESTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgLERqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 12:46:43 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E8C094268;
        Sat,  5 Dec 2020 05:14:41 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id u19so8794074edx.2;
        Sat, 05 Dec 2020 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOdygsnRTcmY5yyVYCdXMa08JVvP1+QIC39sK4BshGQ=;
        b=RiNPDmiwqdFc1DJHL8RCiXpBzhQxZt5gZVftzubtM7mE+TLT3+b20CfiR2Jh6TBsMX
         dXvqnnKrJWni8XXN4dl0ALFQ1fS0PRwKJkR3lSbOVt6qLQDGEZ2YAWrUzf6bBnMuEm7n
         y5j4xWQk/bAECDd+Pl1Y+hX+MGmhdk04KaVgKUWqcsmzzDJuUcqyvxd+ThQ1GBwkRa2+
         JpmggYQqfbpNXmL+sXYYq4llUtqDS82UeKlnU+3SmPCg901NRkuCjO8MtE2dAMAJ6hf1
         kpgiRmJWgR3yjJj6uZ570VCz/DsdrpsLWkc8d2tYTU5h1Z8aLdd89xHxhNy5QDg6vgVC
         FEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOdygsnRTcmY5yyVYCdXMa08JVvP1+QIC39sK4BshGQ=;
        b=r/MRKz9CL+RRWpKlyi9IBCdEB/POkEgnkqNdG/Ufp0Zlcxu8mMEX+1lUbvvlsFzF7N
         kBj/v24y3Rzqr/tBxHdnS51oSECB2j/CtBYAURx80aVcmicIIwZ7OTO6V33B6zN1ZDV1
         3d9DLp7Vp6vxYlAPRZuBYjiz6w24Hm1yv61QGq0I5JpZGhzecbwtpss+shPYBlZPofni
         GOEhYYaXILRlQvddSWrFX4DvJ0ZsgVQFqC55Ege6ETQlAUNPso9eLcHEXst1YoqgPFpz
         0cDmlIEEF19vZSzzGSTa+rrQy4oBknH/G28bjgUWkACVsJe8xSZT9eA6kCU71zQvSZ1z
         o6Dw==
X-Gm-Message-State: AOAM53153YTqILW8e178KcRPbx1f/w7oRdY3ItT22Cn18Y1EAEwYGkCZ
        rjFQKN1Jsg9Gvsci9Y5kKSo20SsfD0FHQDLABxw=
X-Google-Smtp-Source: ABdhPJxkHWS2MXLkIwjQevBOf3omAxxvSE/4W/+chTvVrdnb3br9RamrvE8OxnoDaFv0wrveP2r+4sEjjYeg3Fuo2kY=
X-Received: by 2002:a05:6402:2059:: with SMTP id bc25mr12126364edb.13.1607174080529;
 Sat, 05 Dec 2020 05:14:40 -0800 (PST)
MIME-Version: 1.0
References: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
 <fe0fb54d4c7b99fb148954c1c9a8b1902c2b7b9c.1606828668.git.stefan@agner.ch>
In-Reply-To: <fe0fb54d4c7b99fb148954c1c9a8b1902c2b7b9c.1606828668.git.stefan@agner.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 14:14:29 +0100
Message-ID: <CAFBinCAMFZDRBekFW_+BRaCgAX7ofyFR0Vu74Kj16h4=KR78XA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: meson: fix PHY deassert timing requirements
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
> egisters. This fixes an issue seen on ODROID-C2 where the Ethernet
> link doesn't come up when using ip link set down/up:
>   [ 6630.714855] meson8b-dwmac c9410000.ethernet eth0: Link is Down
>   [ 6630.785775] meson8b-dwmac c9410000.ethernet eth0: PHY [stmmac-0:00] driver [RTL8211F Gigabit Ethernet] (irq=36)
>   [ 6630.893071] meson8b-dwmac c9410000.ethernet: Failed to reset the dma
>   [ 6630.893800] meson8b-dwmac c9410000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
>   [ 6630.902835] meson8b-dwmac c9410000.ethernet eth0: stmmac_open: Hw setup failed
>
> Fixes: f29cabf240ed ("arm64: dts: meson: use the generic Ethernet PHY reset GPIO bindings")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
with the "registers" typo above fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
