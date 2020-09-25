Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441B72781C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgIYHhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYHhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:37:18 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC57C0613CE;
        Fri, 25 Sep 2020 00:37:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so2277412ejo.9;
        Fri, 25 Sep 2020 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oO3KK8snieqPMUUKGMVuOjt3ZFHB4wo5QOmyUorjL8=;
        b=KGNM01PYtivbm17hMCFvYLcM6BAQ7qIuWCYCuBpMH0TI0F0lJ7ItFxFr/is4+Q3wkO
         Wg9z66CXh8cZCAchsDLZJwu0CJGnKNlX5Rl8wVVGvJknirFE+jMMW32V16Suc6Ubajfw
         I1og0+Gf930nIqGzd11OYkU9xyIPAqLfDByGBHGcNdbC8whIeNHf7H8uDpAdoqmrMjP3
         XItn7Q+gymZR+sCw096/U750YPsUmhgP0kHM67KBnfH/gFoUW8bLT4ZpGgSN1m8GQ9Dd
         K7nrHRevtkObAoO6IBcWaY6KnQyH51OHG1w6nMVpFExrUtmE/nr0RlF/hkHC/dKjssH+
         vgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oO3KK8snieqPMUUKGMVuOjt3ZFHB4wo5QOmyUorjL8=;
        b=O53grgW2034YDiHy7leqp5JRFs5d9cfbdpP2E6hEIkGveejVNopCik3iP5y7bcxhk9
         UlSzBWhvHpzwvJQPWz53mqXlSXBRCGVDoiE9dmezxzInMEpxbPXp+qJIr49+0Lvr0KTC
         x0STfPMLVc//3nLzrk40FB/+hCceiMMjYD+fSn4btXGlZYJ4XARt7D5BoAYDEO7Zu97b
         py7F0JvPKoMnGcjkyci4y7ds9NRVDHJhw3B4t3cRHMF9bGL5y424IfXZJGnRmNryEbVv
         sZ+qwLR530IJhbMuecYy8GSf3iZv4dUT5R8ASNO+9ujOwnbCcdvKN2L7ud/5YC9+ns4d
         gUyw==
X-Gm-Message-State: AOAM532PSk+Ikh+JwLTIm9GuQwnt8PZ6yh06THl8VWfcp3Q2GuSOggd0
        N5e1Mbx/ODvTodgX985uIRqhjAaixozJ4NIi5ZQ=
X-Google-Smtp-Source: ABdhPJwKI32Gw0KZUMGXfjdE646zJUv1IDe4mNilpvS4ifoio6qRggDp4Pownpp7NnJe36I/+xa4t0K8VIAy1RJBQ2A=
X-Received: by 2002:a17:906:344e:: with SMTP id d14mr1528418ejb.42.1601019436358;
 Fri, 25 Sep 2020 00:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200925033017.1790973-1-art@khadas.com> <20200925033017.1790973-5-art@khadas.com>
In-Reply-To: <20200925033017.1790973-5-art@khadas.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Sep 2020 09:37:05 +0200
Message-ID: <CAFBinCBtGqDgPH0VhW2awPzYSVFN++HNCA5=L6VVMRW64=AY9A@mail.gmail.com>
Subject: Re: [PATCH 4/8] arm64: dts: meson: remove fixed memory size for
 Khadas VIM3/VIM3L meson-khadas-vim3
To:     Artem Lapkin <email2tema@gmail.com>, robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Fri, Sep 25, 2020 at 5:31 AM Artem Lapkin <email2tema@gmail.com> wrote:
>
> no need force setup memory size!
> VIM3 boards have 2Gb and 4Gb variants
> memory size will be automatically defined
>
> mainline uboot works properly in any case
> but old vendor uboot works not properly for 4Gb variants
can you be more specific with what "does not work properly"? is Linux
then only able to use 2GB or is there any other problem?

overall this sounds like a bug in the vendor u-boot to me
I don't see that we have any other Amlogic .dts which needs this hack,
so I'd like to hear the feedback from the device-tree maintainers (for
example Rob) as well


Best regards,
Martin
