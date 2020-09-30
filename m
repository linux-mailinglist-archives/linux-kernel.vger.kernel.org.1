Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320F327E41F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgI3Isx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgI3Isw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:48:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56086C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:48:52 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w11so1174819lfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwsH4RNzM7M1YZuptel9pzVtCDIa+ZWwO2h5LWJGBOE=;
        b=WiP+6TbsCK2Y5YTT5RJHL4rQtHQ9Atapoj/vpKrfxYU4qy9/48B0y0IwPfJT2Spbfb
         4vpLswz7BfIvYDnM2tl4py33Wbu45yki8K6u2dmQi3IYnCoWBxxJh8Vi+cROnJW9bwuD
         TSezmy3VfFlrI25skDsudj2l71nrUDtQTWOTw3gmcXNqyHwjfziUK6sGQQR8HNZINSLA
         UAlo9M6y1StSHvcqHEC0IJ+NHNNOJSRN620b48DZxmSJeRxmK0vLD8KTCgJIOCoqLvaN
         wLzOJRvsENpsPuBe3E6aoXbrmUp/riajJly+8g6+CZv1xK5L6GP0idVMa6US7ZnjDvnh
         etaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwsH4RNzM7M1YZuptel9pzVtCDIa+ZWwO2h5LWJGBOE=;
        b=MNrqMXqcanfPwWDjIyqMo+gMeWuvUYHpjFHb0Awf0W/aHr90UsXF4F7/mgaLIGNRQD
         cV7BNGxwLsbwxc8l9XAx6hhzOYQADIOaINAMri+Vo8sItVGpId+5kD/T8iB4Ke+8qfEU
         YMNX5ixlrKXw22dzkA2scn1lyV7jNdcHzcZyN/epZmcsVlQZFeDXD2vkBu4uhcr+cfgt
         K6L9KGinLlFVaD1pra73WpWsWL+Z0wnuScPB3Dcc3kZ5gGAE9uzaXgtW9mCpq/HMu/7o
         48VrCbsTAp41ZKfzSM4mlm9VC6LLreP63tMM/0gEXdGl3BLZU6Kf1t+xIzljhCd1BCZo
         Ynlw==
X-Gm-Message-State: AOAM533nFPT/YFDyJ2ur0RHGNMLFoBVjAJg0Ir/K2M9DkYW8YyBBuYVR
        VBqW6NONcEkVPR0+ViXiyaQdzUiRCVi48E0kV6qMag==
X-Google-Smtp-Source: ABdhPJzwTQaHeKwf02xAiuAF5IJuYvnnkzJxA7qbMaCsOnrpapueh2yOo2TkZHTZ/fvDlwd2pS2bqGeQl2q/DBwNqkc=
X-Received: by 2002:a19:1c8:: with SMTP id 191mr478715lfb.585.1601455730766;
 Wed, 30 Sep 2020 01:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <1597922546-29633-1-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1597922546-29633-1-git-send-email-hanks.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 10:48:39 +0200
Message-ID: <CACRpkdZiaSQdtW8QmoxvVyA+RvZoTh7h6CjsTidZrm+YddcADQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: mediatek: check mtk_is_virt_gpio input parameter
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        sin_jieyang <sin_jieyang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 1:22 PM Hanks Chen <hanks.chen@mediatek.com> wrote:

> check mtk_is_virt_gpio input parameter,
> virtual gpio need to support eint mode.
>
> add error handler for the ko case
> to fix this boot fail:
> pc : mtk_is_virt_gpio+0x20/0x38 [pinctrl_mtk_common_v2]
> lr : mtk_gpio_get_direction+0x44/0xb0 [pinctrl_paris]
>
> Fixes: edd546465002 ("pinctrl: mediatek: avoid virtual gpio trying to set reg")
> Singed-off-by: Jie Yang <sin_jieyang@mediatek.com>
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
>
> ---
> Changes since v1:
> - update Singed-off-by
> - align with pinctrl/mediatek/pinctrl-mtk-mt*.h

Patch applied.

Yours,
Linus Walleij
