Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A6C2CFD74
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgLESdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgLES2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:28:11 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BBEC094269;
        Sat,  5 Dec 2020 05:14:51 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id r5so8738736eda.12;
        Sat, 05 Dec 2020 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KanII/0c4hSypDA+mfldsnoEt0x4vv2WL2F1j4Ep7NM=;
        b=vdhGiWLxytc/tPUD3UFZ//syaVPUpl8uechirE2o1DO7LfwEW9WDQ8yHqrBXxkcPCZ
         vVuq0c2y3WWCrORe4epDzxjcZ8UHaNK2MkjsjIbNw0smBprgyAc0NqqBefKHYx8pLefl
         2Ta3okMaH/vRCBMhu4NOfsd3CspDpm1V7gg0fZS6FQa8uT44EAOdqWYZsWBzuEW+DhQp
         yHAjnE3VawVmbTRao51Vey9WrQ7ZLDS1XSlzoYbXL2dUwstGyWu3j1O8P580hZqpNkg+
         LXb9iSsFR6aNO3Bik4aEGP3fY+z8a7huOuUXX/JakGgdfbAy9utbYaeSr+weXt9PLDf1
         kx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KanII/0c4hSypDA+mfldsnoEt0x4vv2WL2F1j4Ep7NM=;
        b=JQ/ZUT5yDCzgLf8OeRTOlQxyCwBZZnokP7uUEqORkuzLnPvvTdRTZ61F9oZUFUABum
         RJ8UWRmuzCZkmzyhPSF9xiM7r9l8r6NV3/wxixeGUHFcsJ93Qh/nKQmssa9KP1nFh7Re
         Gukt7Zu/1fB9eg+825yc0yCoGLEqHVKbywPjY7T0W97/p4Yyq5QfNMeuyhkMZ5j7ZihQ
         8gKdAp6FlIdVbcUIir/udRaiDJK+WXm8L3KTeaPdafrJvBh9C5mfcb+GWerEa1lC+obR
         MuegyPO5bS3X0eqXWykjpOO8c/FC6MRy7TxcZ0izps0agXnpvgPjNnMojjSAmWYDiQaa
         dzjw==
X-Gm-Message-State: AOAM531QfEVHR5/zUcG7pN3lWQYf+ZuWbUlE/7AayUFMTbFwC/XRDE2M
        F8Wu4y5Y8voKpdQ4IYmoo6z8OKQ/9Vy4YM2xeqc=
X-Google-Smtp-Source: ABdhPJy6nnnEF5KZAZmesZ0lObpz1o2gF6l9j+Xie4EkvTKJLwx/M/Yvhmn1sLMhWT1ZI54reNRgZPc1fDjAv1tbguo=
X-Received: by 2002:aa7:de0f:: with SMTP id h15mr299636edv.110.1607174089920;
 Sat, 05 Dec 2020 05:14:49 -0800 (PST)
MIME-Version: 1.0
References: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
 <83c1a57cb99c04dc31098166f0c26073de5e7709.1606828668.git.stefan@agner.ch>
In-Reply-To: <83c1a57cb99c04dc31098166f0c26073de5e7709.1606828668.git.stefan@agner.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 14:14:39 +0100
Message-ID: <CAFBinCBnqHkpQ79PVfCqJPbC3qj6v6T-HsJehffYzfaDTPxUgw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: meson: g12a: x96-max: fix PHY deassert
 timing requirements
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
> egisters. On similar boards with the same PHY this fixes an issue where
> Ethernet link would not come up when using ip link set down/up.
>
> Fixes: ed5e8f689154 ("arm64: dts: meson: g12a: x96-max: fix the Ethernet PHY reset line")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
with the "registers" typo above fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
