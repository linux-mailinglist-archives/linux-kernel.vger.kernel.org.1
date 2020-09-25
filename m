Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5FF278192
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgIYHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYHbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:31:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736BAC0613CE;
        Fri, 25 Sep 2020 00:31:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so2331254ejk.0;
        Fri, 25 Sep 2020 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/nsln8uCL2jZ2YNTI+Z+HE6p0bio3wjBPlgzoNnPDY=;
        b=pzwFXYCzz9oSeS/D7ZP1IH04hn/IKmpBaG3+fZj0Lf7Y97nS+abTAYsj/1C7SYisrb
         4RY70z8jCZM3YISvuroWLa2QC0jcpl6jvcsy3pxAqh6J6Rbe9sEBRhohj3ZUbFGcI9Cp
         FVo1VsjFXprP7z86VMKwY5QXb7ynhQOru5myEOKokzFg/2/5Wb57xEkNHsztdMHcRe/C
         P1dv1OfwMviMeB4ceUduc3uZFlCCMNZG4y0MX9vI1ph64t/I0rFG7jQ3SiiXx0QqNo5y
         +CPs4kkITJObJFiFDHLhNSrTAXErSnA5DhSOXmFX9g+zn1PmjwF9yBSBQoFLZE9v7WGJ
         PL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/nsln8uCL2jZ2YNTI+Z+HE6p0bio3wjBPlgzoNnPDY=;
        b=gazZGlxli1VXpKMEmSIdgXWEaQ+wSlOa7mrWL2l2aiWvjuiZV5ViKyKHzYme4640Na
         mU+sORLNSRP6Hp201PLQCCFI6Xh+IpnbuQPEYHLL2ldhxVw+P4b4AnWO7RQxrNymos7C
         Jns1TWGw/1XvgdhTJSYw92xOjN0ApOwbObMDjZG9B7IcV9D6fRowhLLkiYsgLMHAYT9m
         FssEPkrO/Ux1WbLmVWl4l1ORvUswd3Di1PnqlLTLCBRkMDufFDCId0eH9iSu1nwBHLQK
         bh2m9kVMkApr2XFG0KPXtDwXgtV92ThbvhmFeqRftHsNd0FlAMGRxpk9+eLrElKJ+hU8
         GLaQ==
X-Gm-Message-State: AOAM531XZg9F0lsriQRi/LsDaA8vZ+cGlf8yybsUY0UmQqpveOUD6jTb
        7DgMD2psTLg1/+UO3sNXL9XEunggMbKxO/HGKf4=
X-Google-Smtp-Source: ABdhPJzJjHU+hyv4iRkRjRy20B6asyj39Ew26X4S50nuLfsIkVNLeN1t4qiY8E216P3raQCdxC39+JrSkBifH1fb28g=
X-Received: by 2002:a17:906:af42:: with SMTP id ly2mr1345909ejb.362.1601019082036;
 Fri, 25 Sep 2020 00:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200925033017.1790973-1-art@khadas.com> <20200925033017.1790973-8-art@khadas.com>
In-Reply-To: <20200925033017.1790973-8-art@khadas.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Sep 2020 09:31:11 +0200
Message-ID: <CAFBinCC+iTScTc76aFmqJ0NyhKB9pVwqVjFqBQvcQPVBE34izQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: meson: enable RTC for VIM1 meson-gxl-s905x-khadas-vim
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        robh+dt@kernel.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Fri, Sep 25, 2020 at 5:31 AM Artem Lapkin <email2tema@gmail.com> wrote:
>
> enable RTC for VIM1 meson-gxl-s905x-khadas-vim
I think the commit message should always explain *why* the change is
necessary (what problem does it solve?)
for trivial changes the diff itself explains "what" is being changed

[...]
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> index 8bcdffdf55d..354f21d4171 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> @@ -98,7 +98,7 @@ &i2c_B {
>
>         rtc: rtc@51 {
>                 /* has to be enabled manually when a battery is connected: */
why do we need to keep this comment?

same feedback applies to patch 8


Best regards,
Martin
