Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8691D7189
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 09:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgERHLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 03:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgERHLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:11:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76FC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:11:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w10so8656811ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vabidfbMFc96pp/HPLlR3jZG3FkUzmqg2LVXthmSJ2M=;
        b=NfE56AHSj2+vxlz/6yUuJTa3t1IV7WenHpdNYEo7f95qJmJJ7+A+i4PfeTiCIrPiWQ
         uYSbSUg13aS4vfJaeyo4jtE6ZbrQ6PhWV2nsbkr+ogLPQ30ZHA1EqWD18NJP4hIn6G4P
         RwcbxQBrPzrrKZXVShOpZv+GAEPFygjSUkP+dLcRxv3Z1CxpQsJhhxVSr+jjv/o4AlLh
         wsC0H7Rt9LcPnL733Y458Bq+7fnwRXuqfAGhr/q0FVs1dT5VwHflTGdw7X1nGTXtt2Wz
         7rvUt/oAzPVBSBYkjjaUrZqOR4LyEYN+kZXN7YN1C1gpvVgr4O2aFpkfXBlHUDzpyk8T
         KNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vabidfbMFc96pp/HPLlR3jZG3FkUzmqg2LVXthmSJ2M=;
        b=nEbAw1Y1w3wI3GXUnjy9zNdJlufllotzaor/wA+dLRR4YWnK9tLC1cDNxxIvNm86vk
         T8+uyMxXC+UsYqqmQjXWqsx5Wz8xK63QBBfNcz6i8ucbpq7yLTU3CEbrH/dls1gFlCH9
         0QEJ3Sx/Jrly8UpbPofMZku04hbto628Z9eR4dfUqEGhGuVFln0WQuItTzgYhvB/1MvH
         XyD/qJHm8qcdkB7sp9KUOwuvrs7Lk855zTRryDnD8httbnui4Fsn7x3xaX9VzX5XCRm8
         VJgUWrqCghzDFNBQPHumfwqW+FHC5HdkhuyTpJzXKqUibHapWYxJN1CYOrsFWLcyKmTY
         QqoQ==
X-Gm-Message-State: AOAM533jtmPuJr6x72eubrYnuc8ywwLRxgWjbWLWGpks2UvHDWRtpLhy
        YUIZsKxhzJ5WVW/Iip5Q3JTLOV0kg58Jm7jCzl6y3w==
X-Google-Smtp-Source: ABdhPJw9hkh1xdtF0LAYyj2TI1WiZMc9QwdD8Q3PjEibbo2bM2I8adeqiZA3vX+G4exFdZvSrqFJyEySfS8r7g40xpc=
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr8865566ljd.99.1589785878126;
 Mon, 18 May 2020 00:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200508165821.GA14555@x1>
In-Reply-To: <20200508165821.GA14555@x1>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 May 2020 09:11:07 +0200
Message-ID: <CACRpkdb+ZP6rfjGg6Ef9_wYvNf6qmSc7LZyYBVKA3XWCtxPfqQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: am33xx-bone-common: add gpio-line-names
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 6:57 PM Drew Fustini <drew@beagleboard.org> wrote:

> Add gpio-line-names properties to the gpio controller nodes.
> BeagleBone boards have P8 and P9 headers [0] which expose many the
> AM3358 SoC balls to stacking expansion boards called "capes", or to
> other external connections like jumper wires to a breadboard.
>
> Many of the P8/P9 header pins can muxed to a gpio line.  The
> gpio-line-names describe which P8/P9 pin that line goes to and the
> default mux for that P8/P9 pin.  Some lines are not routed to the
> P8/P9 headers, but instead are dedicated to some functionality such as
> status LEDs.  The line name will indicate this.  Some line names are
> left empty as the corresponding AM3358 balls are not connected.
>
> The goal is to make it easier for a user viewing the output of gpioinfo
> to determine which P8/P9 pin is connected to a line.  The output of
> gpioinfo on a BeagleBone Black will now look like this:
>
> gpiochip0 - 32 lines:
>         line   0:   "ethernet"       unused   input  active-high
>         line   1:   "ethernet"       unused   input  active-high

Why are the ethernet lines not tagged with respective signal name
when right below the SPI lines are explicitly tagged with
sclk, cs0 etc?

Ethernet is usually RGMII and has signal names like
tx_clk, tx_d0, tx_en etc.

Also some lines seem to be tagged with the pin number
like P9_22, P2_21 below, it seems a bit inconsistent
to have much information on some pins and very sketchy
information on some.

>         line  18:        "usb"       unused   input  active-high
>         line  19:       "hdmi"       unused   input  active-high

Similar comments for these.

Yours,
Linus Walleij
