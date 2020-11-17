Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EAA2B703D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgKQUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgKQUhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:37:08 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4D4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:37:06 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id b17so25796836ljf.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VBawTBZeGDei1h6v3qT5rtQtXBaTES0YnmaYqJM2GNs=;
        b=D+N/vgCe2QB5LLybajWeW3aLxWfyO6wqQ0s1MXm5AKuHEiaMK+zq0b6I+SbTc5jNMb
         fVgahe8wLHQTjRL5PEMhtUFS1/zunYiAzwibsGLFHlmb2q/q+sOyfThNJAnFdXDcMlQa
         bDPDKADnIiE60UbmgItJ1BP+RNIVmplSStluy/36J3KtDJGRcDhPKtwGXBBs4bfz4hrX
         C/d7fAogdTgk+F6kFerrwo9wl+7tG2esiZEaD40ieVHUuezWchN/w/Sm1m8u0lDcwNWl
         SZ8pg1OE1r/N3fKHQKDeD7b9bGEJ+2FKWk2HKvAFuufmRDSmP8qqeR691T4cNIzfkYJW
         m48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VBawTBZeGDei1h6v3qT5rtQtXBaTES0YnmaYqJM2GNs=;
        b=PTBveL2SbwWMOTj/AirfO8xqqQUGoM/eBcwbUBtNinn+O6Kkmdtb5MLcQqnINAAOxk
         3hXIKVX94oL0fTNqRjhWtOrTQEt87qQsv5D9K1ecqwQFqJr43sgu0jjmFHKBMVDBtlWf
         HqeuXmRnKrAVSL5vIOZGbPoD9/F7ds6WdXh5pZiv2AyiIHbmJ2Fs1GLM+lPJjJbM/ggH
         HpzDxmzxn/c/aW7IqYnwVzXoCqbWVsJwdFDyQnHZf4pgLnhh/6Bk623gtII2lLCpD/X5
         uMXaJqdh6BUsvel2ltU0deIUFJ7YkUS96ZPl/VLaJ/L7enG1z50me63k3m5koT5LEZOv
         1lyQ==
X-Gm-Message-State: AOAM530W3AHnLFGqd7ghgpJdqZNDX+koUm1EQ73kTqGyAwcmEevRyEJS
        HJfT7t2fqwy+OESkp/mGQ/ffezLoINJZ3HYjlpp1cA==
X-Google-Smtp-Source: ABdhPJwaS2B6HfL/+PScb1mQInpJJpSlRKinA0MJAmBjiWs9aJ0EGtMf1sjwzqSjWpH0V50ABOt7UCdKF0FZIH63EBE=
X-Received: by 2002:a2e:b1c9:: with SMTP id e9mr1535370lja.283.1605645424802;
 Tue, 17 Nov 2020 12:37:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605635248.git.agx@sigxcpu.org> <1321f3abdc3df6e9d1999bd32b436ae71e89c27e.1605635248.git.agx@sigxcpu.org>
In-Reply-To: <1321f3abdc3df6e9d1999bd32b436ae71e89c27e.1605635248.git.agx@sigxcpu.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Nov 2020 21:36:53 +0100
Message-ID: <CACRpkdbkcYz7RHz8_7ab-vVvBpOaD+SEosPZpvh8NNqDBuzfqA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] drm/panel: mantix: Tweak init sequence
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 6:49 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> We've seen some (non permanent) burn in and bad white balance
> on some of the panels. Adding this bit from a vendor supplied
> sequence fixes it.
>
> Fixes: 72967d5616d3 ("drm/panel: Add panel driver for the Mantix MLAF057W=
E51-X DSI panel")
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
