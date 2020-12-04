Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E645D2CEAB8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgLDJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgLDJUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:20:04 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535ACC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 01:19:24 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 142so5757389ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5d7QS+8aXm3Jo/dhQvPSPLMGlB6XfaOcQnDt/pos0Ws=;
        b=HFnTZWH6X1wkzC7QlBblqLyaQF9njYKqtCrrpWajz5RT570G7/SrSQv45Vn5VfcjQc
         B05CHty9taLOt4gHSyb5cFg48XKrJZOBNmNXFjasRAY9GJlvmEvpa17YSb1oDmvtnTox
         uOZ6bBMcYor/6pkM2ayA2O/csHCBT8kgTv9b0HwDHaatRGAMkchmiSUvNs/vcBwzzI8+
         F5vv3dwezRMPuiMFMKWY04gxUVehhymf+el4eB+e6fEvYppXeOi2nf9N1c2H0j7Jcyuf
         UgjlXVx2zFnAUiA2FrtYe+1O2RadiEX2bv+660peezhk+zcTwByWlUixsbI1MBT451a2
         gRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5d7QS+8aXm3Jo/dhQvPSPLMGlB6XfaOcQnDt/pos0Ws=;
        b=rxGA7ZyU9i2KYPePrz0ESSNs3QNq+TUDvDyAItw8zETsivzmRmL8Je3zk/ZsSA9Eh2
         9LhVoTvM+juMjx+DlqXDPtMuFNC6Y6aUDLmsFrPqtuI+Fp3NibYjpUAr1A63G0ME9m43
         lwt58MH0vc8CJ77zfeBM63T5VDg0WoFnVu6xeV8rBmSbQQxrxFCw5AS/TnOsZd2fxXDv
         GkwmJHtiGp1MEA2B0x9+3hwBv5nhF0AX3ZY8W1+nsBhDNWXzJzm0DuFAhK6nbUcVIyPE
         finCiZPOfn/Ntqzb0lSyC5rBvoR2eHHbM/hC2GVj3CsBF0aQXEfRYSSZKFEXh5YZntXz
         7oTw==
X-Gm-Message-State: AOAM530oA1oijUFUVmqDgASBMSqYEdQ0hxLtc+02GKSwEUPLN3PajAxO
        RU8ZI9jDVJrqL/T3z/NlG1p9JugER/UPuNhGgUhRAQ==
X-Google-Smtp-Source: ABdhPJyCHSQRv+nMAlK9tcmnaAQ4ep11WKxlvgFh3ha/z/I3+vuqYJ4dvzKMhQ06y79w9YwuAwbMAjz9xP74UEEWpoM=
X-Received: by 2002:a05:651c:39d:: with SMTP id e29mr2803768ljp.144.1607073562865;
 Fri, 04 Dec 2020 01:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20201126063337.489927-1-andrew@aj.id.au>
In-Reply-To: <20201126063337.489927-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 10:19:12 +0100
Message-ID: <CACRpkdbMoLXiSipDkmRXeWA_tcyDC8R1kuxHzzvfYaeqLU5deg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Fix GPIO requests on pass-through banks
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 7:34 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> Commit 6726fbff19bf ("pinctrl: aspeed: Fix GPI only function problem.")
> fixes access to GPIO banks T and U on the AST2600. Both banks contain
> input-only pins and the GPIO pin function is named GPITx and GPIUx
> respectively. Unfortunately the fix had a negative impact on GPIO banks
> D and E for the AST2400 and AST2500 where the GPIO pass-through
> functions take similar "GPI"-style names. The net effect on the older
> SoCs was that when the GPIO subsystem requested a pin in banks D or E be
> muxed for GPIO, they were instead muxed for pass-through mode.
> Mistakenly muxing pass-through mode e.g. breaks booting the host on
> IBM's Witherspoon (AC922) platform where GPIOE0 is used for FSI.
>
> Further exploit the names in the provided expression structure to
> differentiate pass-through from pin-specific GPIO modes.
>
> This follow-up fix gives the expected behaviour for the following tests:
>
> Witherspoon BMC (AST2500):
>
> 1. Power-on the Witherspoon host
> 2. Request GPIOD1 be muxed via /sys/class/gpio/export
> 3. Request GPIOE1 be muxed via /sys/class/gpio/export
> 4. Request the balls for GPIOs E2 and E3 be muxed as GPIO pass-through
>    ("GPIE2" mode) via a pinctrl hog in the devicetree
>
> Rainier BMC (AST2600):
>
> 5. Request GPIT0 be muxed via /sys/class/gpio/export
> 6. Request GPIU0 be muxed via /sys/class/gpio/export
>
> Together the tests demonstrate that all three pieces of functionality
> (general GPIOs via 1, 2 and 3, input-only GPIOs via 5 and 6, pass-through
> mode via 4) operate as desired across old and new SoCs.
>
> Fixes: 6726fbff19bf ("pinctrl: aspeed: Fix GPI only function problem.")
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied for fixes.

Yours,
Linus Walleij
