Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB2278CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgIYP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgIYP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:28:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6DC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 08:28:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b12so2870632edz.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXmuOZs0DtJBI5d4YWGL14ALmZnj964Bo0N22tOY/CU=;
        b=sT0nysylsyeePQrg0Wyo/iQOddOxzcLVRdDOu2h3ce5aCydGJhpmWHad3J2VPu1BmL
         pnPP1w2Hm9TFX4LAU9QzKE/5nd5BXJkvSx/LkWy2HWunkz3cpMPhRS7zpGhgxCh5+bUz
         SyNOgp43hnDX3Kf8SfOoWpOM+ueD7KKTKDpg20709uuuV9u54JD8+C5qyIGK+88x0dvo
         SaG7jtSlJvbIoY5XHlawwDHhefiuxlFxR2RGP4UtJFBk/OFL6OIBbd8BRJtk8EnzDaRI
         Cb3HK2+QWfi41X/SUJ2pxVAPjD2KsF6AtiQ+xbFBKFB98mhRywxcFas/j1WPFMxVHKJt
         dY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXmuOZs0DtJBI5d4YWGL14ALmZnj964Bo0N22tOY/CU=;
        b=Si6F4OANJ4zmb8Pc8Wgn10EToES0wYYUHGEWzAE/vZzFRkJaL2TuJeBwmmBkAbPTjZ
         bqvxA55JIhGO1bQzO088548r6fNvgnbnuhczH1FY1NNGus2RxuE/NwLHEFf5AD+jxhML
         o9MrFgrYS77UosmmcJduTEbQE/5jTHEEqBUFnJ5TXO/UMmDdVmjzOIdri3QHY9wa8hMv
         o9VnyBMdx70w8QrkDIEb8fcnY+OB/UhpHcD5kwfITQdHoqaxrnhmi0FoS+rufiwbGtGe
         yMZwr33hpDZeKb+2SsWn+uU+yAh63i1CNwOt97bTBViKrukATUfXsh4lyns+lHgSAzP3
         JMMQ==
X-Gm-Message-State: AOAM531Il7AdWCyV0rJwKdzVuqpzRX33zhdYvegWF60JYzxWBFdwoWE5
        aTER8j52JseSeFpEA4dVwlEAZoYAVqoxowgAZn4=
X-Google-Smtp-Source: ABdhPJxwBbbU1UpXBELIWwegXfSCZxQOgGDN3fGNZ4ZeTBDazTeqn5IvL2gzzsvqFbFMDfSYKrQfRnHb2/4i6NGlqWA=
X-Received: by 2002:aa7:d697:: with SMTP id d23mr1949423edr.13.1601047696366;
 Fri, 25 Sep 2020 08:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200815181957.408649-1-martin.blumenstingl@googlemail.com> <159830380185.24712.3464811968459073992.b4-ty@baylibre.com>
In-Reply-To: <159830380185.24712.3464811968459073992.b4-ty@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Sep 2020 17:28:05 +0200
Message-ID: <CAFBinCCrbVzK8A0s-=Q++n4yUFO6+Wm_Ayh_vdxkATJh7oSx1A@mail.gmail.com>
Subject: Re: [PATCH RESEND v1] ARM: dts: meson8: remove two invalid interrupt
 lines from the GPU node
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Graichen <thomas.graichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Mon, Aug 24, 2020 at 11:16 PM Kevin Hilman <khilman@baylibre.com> wrote:
[...]
> Applied, thanks!
>
> [1/1] ARM: dts: meson8: remove two invalid interrupt lines from the GPU node
>       commit: b468412409c0e5752ad3396b147cac563ff8dd3b
this one still seems to be sitting in the v5.9/fixes branch
I don't see a reason to rush this, so can you please queue it up for
v5.10/fixes?


Thank you!
Martin
