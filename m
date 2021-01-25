Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22D30365B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbhAZGPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbhAYNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:14:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F23FC06178C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:13:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b26so17618690lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkjGH+G3sbPs0AwBpKTZTNMo6PAnhVg3Vk9O+oPBcYo=;
        b=Jh7/FEpR91Kn0N8agvzoZbDt8Vo0Re5umfDss3QUmF1BVvSaj9lIq8UbWi6u8L58yZ
         DZA92Cn7qbWCqYz+j1NHBTG9c95BbJLfjZbNc+pHZqcNlBjqsl2f930JkVnnekbroya/
         Pan4OWOrhztzpXYSMxzPpkCTRDLqxWFcnqDGUIyMiYCLgt+7Sf2HKwR6WGphRoXg+IY7
         NioWkdeZjyDA17yR1tK0y8Ze1vyNNDByrWKrewGm+9VSIHFtkyCC+5uIrIwx/gNTBdKf
         4bYbf3cNy0fKzaUDFkIO1IUc3smoFFfFAop5sisWtetjF7iKYE4KGd/KvXhrF/aGLwoS
         3R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkjGH+G3sbPs0AwBpKTZTNMo6PAnhVg3Vk9O+oPBcYo=;
        b=dpVRpAem80WDPx3ERC58BaDmzb1UdQVoTpeS2xNKwm9TpUnQGYblLgWNOGCy5pmJEg
         pv90VrGQ+X7r5zN59gJlZi8jtNB1fd3yOEQ2sp+bu9LGHwstucwVaNVGEM+K8EdUjnWI
         3KTZQHOgGJE1nWyvXsugrucuNw0kBBMIFUwzHPWmgSFF613Yse2ReQgkPPCL7aGh9WqR
         MX+Xjo9oSZfM+kv2Eju5CmOj7QglUkkFVnk1m+mx4rjnz1HhhWLJlns8NmoPQKoLkAs/
         lOgtqIo92EKlRafFfNtwdVSy+76McCsH6J3qukSvWU9yafb9JAk9ImSmCfI9l1KgIS40
         jphA==
X-Gm-Message-State: AOAM531kheY+XkL4RM162Wy+/J7HPqrVihXiy46ae9G9s1KtBMKSzdqw
        h0QYjeSqPBx2ThxnUmm6j1Sss0oFr1fNsVPqJ9gOgpZIh/uylw==
X-Google-Smtp-Source: ABdhPJxb7i93hzji/0XqwZuGFblpA4aj5dMHr9srYEFMDhw8118iclkxarMinp3+461hMdPJxmB4BxSJZ/B8GxjDcRU=
X-Received: by 2002:ac2:5c45:: with SMTP id s5mr250905lfp.586.1611580395894;
 Mon, 25 Jan 2021 05:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20210125044322.6280-1-dqfext@gmail.com> <20210125044322.6280-2-dqfext@gmail.com>
In-Reply-To: <20210125044322.6280-2-dqfext@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Jan 2021 14:13:05 +0100
Message-ID: <CACRpkdag3P7yGVmzkcdi8zw=3WJFNDDTQDOWujBB54YgFZJ22g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dsa: add MT7530 GPIO
 controller binding
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

> Add device tree binding to support MT7530 GPIO controller.
>
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
