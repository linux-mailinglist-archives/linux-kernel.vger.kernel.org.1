Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE627A014
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgI0JVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgI0JVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:21:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958AAC0613D4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 02:21:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so5918432ljk.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 02:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGGQySYw8x5K8mtOeM1SZ1tR4LeJUkuWrFy4NhZyY/w=;
        b=vzil5VrFY34NJoONQtPL/nYELXxhPOtPYRZqIQS6TjdYqGIBl+564t4RHy322T73df
         xb+Hm2TrtAGryotAam/5POHXsd3Wp2r6xmMTGo2YNVFpNAGObylnM6k7KBKKnrIgJqdw
         3L39CaUnFY7fADktI+0fGUD3gYlQg8yN4+p1m1MkgeqFJ0Q9DEzK6PBN/5QZnCxnsok4
         Dy5w5nDPkqoeYuOLE00dJ9UDBzFRyUA4sEeD4vUroneXPajV8vMg3X767XPQV+YHzi+P
         ZO/YHmUzvZs/5O7fwebLYz/wMJiWKT6dWTgKj/Q2hFJzlMqVk8KHtGD24y/NmgL3RtmY
         gwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGGQySYw8x5K8mtOeM1SZ1tR4LeJUkuWrFy4NhZyY/w=;
        b=hCDtVnjIlduO/tIrWAahqKe6xnNN+bMr5eXX67boZC5V9hf+4PLSu5Hm69f+V8D+lU
         /UAvGCVjUQpzXr1VKIJWdGhNGHA/16WdIWEEiCJxiRlBZlAUBKss/sifMSUM8i3MhLvi
         5NngHO+81tvx3FoNlhzlEtfKOFFbd4wwTiIkBt56VDiCzz7WR/TldMhDNfjXfeLhBUwL
         gjqkUvwQLkLWjZprEvZ6UT4OLk30mU7lI1Y01RWZvgXNMKKIs9V59V4GE+VfYkBOMl57
         qIwvL/5hAiM/K3zOV/YQLhBpP9ep5kg/cl37EFPpL70jD6YvYjlYDQMKRfk1jZvCJvTF
         gm4w==
X-Gm-Message-State: AOAM5302DxbTIrqbDAr5TwJuGDXMnDtjSOkH8QG+WYMwh2AVsPknKAuZ
        i7CRRy0RvoInf5u5tQ98Nvo8PtlpsgU6OhEBK/NpMA==
X-Google-Smtp-Source: ABdhPJzmJTMesMo36KW0yIQlJE605hbQVVOGBYNhbkPK1+4Pe0bOs0mJvDBCOCh5tMojSqrcInaLr7oEFgooll9kBPQ=
X-Received: by 2002:a05:651c:107b:: with SMTP id y27mr3197494ljm.338.1601198500091;
 Sun, 27 Sep 2020 02:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200907110221.1691168-1-fparent@baylibre.com> <20200907110221.1691168-2-fparent@baylibre.com>
In-Reply-To: <20200907110221.1691168-2-fparent@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Sep 2020 11:21:29 +0200
Message-ID: <CACRpkdYXHzrp0-4nhQnJHdhEpzkdSEn8+8AJnmFJhrvu8=Sbuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: mediatek: Add MT8167 Pinctrl driver
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 1:02 PM Fabien Parent <fparent@baylibre.com> wrote:

> This commit adds the pinctrl driver for the MediaTek's MT8167 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

No reaction from maintainers for 20 days so patch applied.

Yours,
Linus Walleij
