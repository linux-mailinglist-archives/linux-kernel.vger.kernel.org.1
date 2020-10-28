Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18EA29D942
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389589AbgJ1WuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbgJ1WuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:50:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC8DC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:50:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bn26so1206304ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrRlnhg/szGXJ+CqTv+QgypRguxwePuNcvzko2eNF90=;
        b=iuAxgqHLkaJPSxfJIECz48Mk4HqjEvaKw6exSc/dPtOPplsvx9/zMz5kQQfnj90PYs
         A7tDdsksEYUq3ePEFesJ3QZL/DTEc+nPxm1fPiCsHEU4vDoxsi/t3sBLRfMsyVUSu3xJ
         EzP9TIhV/2YVRocIgkrKZ/DjHL9zjRbdOQ6+Pz29qR54ppwN0FQMIxMEZ9xnKG3kCuro
         pfH7JV7vsODpk3n2DQ9sJmXM9maBdl3w/Y8jAxhryqcXu1jXVJeNG166qF3B3TIEC5v/
         knuiF9mHiMCNLapbLVyW1D9NlLGFu4sle8tXHZQ1BidCPjtm6c/OZ32fq/BQZ2S5u/wb
         SAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrRlnhg/szGXJ+CqTv+QgypRguxwePuNcvzko2eNF90=;
        b=h5JiXwd2y6zoha7XLjn2ubqHZaROx/Aty4FIKq/KHWz4vL2vHnJw7Wwt8eOP56LwYj
         1FJxm87STwEwXZAN2G06nVI5WYs8qCyTMUz6KBJgmHA8lhwJxMDgGrflaNXS2ewJ/mU/
         by8X9PzDm6d630eiEH8v2qa74DZmOB2ddl1ZydyT0w1trvuAbAiP1BQOQMXjm+0l4LC1
         cO+uWCBxUF9umDQDd0QsdvquaQCP8jsaTGhlPZvs9n4fTdBX6f8E1OxAnR6Wgpkma8+3
         VGsk6SqiVQ7QhGPYXagW1nhEH75yjZL+9+42hz4hGusfiOP1zQ/KkhT8d7lOxoUbex1D
         TYkg==
X-Gm-Message-State: AOAM5325l0/1zxw4bjBsaWS9L0nTfwGIulS1YTKSY3D6gLElOkofkhVs
        +Q6meiR4FDqw7lK6j+fXSU2jF1+kWzRwnJLHJ2PrVZCOYsN6Vg==
X-Google-Smtp-Source: ABdhPJwKVwR1CvYavirDMXZ0fgbvKeG/If31B/j9xpUc5tE4BcwJl2E9iG+PvZDYBYOtcz7m1HOT6sMXVSAn0X3/d8w=
X-Received: by 2002:a05:6512:322d:: with SMTP id f13mr2793562lfe.571.1603900485127;
 Wed, 28 Oct 2020 08:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201013063731.3618-1-jay.xu@rock-chips.com>
In-Reply-To: <20201013063731.3618-1-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Oct 2020 16:54:34 +0100
Message-ID: <CACRpkdbrGBJjOPBicQKAde-Y3NNARRcpvcK52Uu1Buu7sC8AvA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] rockchip-pinctrl fixes
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 8:37 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> These patches are required by GKI.
>
> Jianqun Xu (3):
>   pinctrl: rockchip: make driver be tristate module
>   pinctrl: rockchip: enable gpio pclk for rockchip_gpio_to_irq
>   pinctrl: rockchip: create irq mapping in gpio_to_irq

Patches applied for fixes.

Yours,
Linus Walleij
