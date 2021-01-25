Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8B30365A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbhAZGPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbhAYNN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:13:28 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE61C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:12:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i187so7370584lfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GG3vahY76s4SRL3M46lNCBCKQEIbcfJITvOyi7b/xaE=;
        b=ylsAFriX37XVbpLrF13WtDMR2c5hpD1ojpoIGrNq9XuUCJ+9ZI/nVndYmxlHicPxsr
         52qifpbb0+zInjIDkQ11DvZmSyXZJ/R20DjkOXxxkHnEABVBZbOzGkXPXPB4eqbOlL1h
         LEl0q7mHUumORmwisiHLCkLGZQmH9RHokoY+QyCc/hh+c6kNDGOTw67XXhAJgqmzTrBv
         hmTR9mbudnnkvVb467jCiWzmrVLL3g/sf29ebSobv0ehWnSe9b8HMIFV0j2oH/peWx4B
         J45aJxeAsuAfpcp/uKzeX5SN7xjHAkh2fNG+HCqz4spZ6FkSfx109zCghylojY/728lH
         /CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GG3vahY76s4SRL3M46lNCBCKQEIbcfJITvOyi7b/xaE=;
        b=WzP51HTiUs9qwQ0x8tRo6uMauNsks4kioQvSGRZnaZWz+MEIMNPg0HzuTlq/PxE4Md
         pb61zpVJVFKvVAAo0bsfirY11hzp4nHX10fZQuZ1uItVuyt3wBqaB/Lo9Fsr1zJjJgKs
         JV8axAZsm/CSLflESvIiLmYkwgjBCpNH72nhDJftISKTToP8XGk0/dKUa3yC5vZ6R9mu
         5uV7HvvPlFPThgq+SFmyBEU2VnUvhYsIf8l+e9AyS8KcpZ3p70sBXMPZtHb9hZIbiR8K
         LKn/PScN0UCeOOxBXfguY/1tXo3Pu7w9m/VxvQmtKP5szPS/CRN7gsHpEMgZaoh1OyP0
         4hdA==
X-Gm-Message-State: AOAM531sUf+O5GFLAjONzp2bjUVE8uM7jW8jQlyL3b/Mdab08ss4fRfs
        tJyzOmw+skAoNFW93vYTC0XeOkb0g7pUHyswtHEMyg==
X-Google-Smtp-Source: ABdhPJxDT3XMILf8kQD/47RjOiNlQdTecGrpgSBvjuTehZg5fGASxkkq8PKsR78LBS6XWePVlhcSeupwkL3gjJrh/18=
X-Received: by 2002:a19:b8e:: with SMTP id 136mr255455lfl.29.1611580364908;
 Mon, 25 Jan 2021 05:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20210125044322.6280-1-dqfext@gmail.com> <20210125044322.6280-3-dqfext@gmail.com>
In-Reply-To: <20210125044322.6280-3-dqfext@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Jan 2021 14:12:34 +0100
Message-ID: <CACRpkdZtgqABQc5qDZCLLJKXvAEugLKM2RCKia9hypS0A5GkDw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mt7530: MT7530 optional GPIO support
To:     DENG Qingfang <dqfext@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 5:43 AM DENG Qingfang <dqfext@gmail.com> wrote:

> MT7530's LED controller can drive up to 15 LED/GPIOs.
>
> Add support for GPIO control and allow users to use its GPIOs by
> setting gpio-controller property in device tree.
>
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
