Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8E2DE300
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgLRM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:59:41 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34296 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgLRM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:59:40 -0500
Received: by mail-ot1-f48.google.com with SMTP id a109so1820668otc.1;
        Fri, 18 Dec 2020 04:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDDmWva6k+onru4ElOy7d/wNOJ87lqqkD8MjbWeXtwU=;
        b=h9l/5f8+VEgFrP0DwRt52uDcSr6FQMmcWo2QaEfEU/brQkGAK4D9HBbf9+f+1RAU0M
         FqEdTZIrD6er/0VJnvqkIFpn/WqhZoIj6tTniMY+i3xYrPdbUHx/9yGQdH+Qu/fOHzG9
         EiDc/RxeroC2hd0K+NW4GC/O/Ppx6gOWXmGsCS/5a+G0KxgkRf8KpQ73nDbtt7vDZ42a
         FWfqWpGvItnoJLTTTdDY1KA5gZdSziAOn6cen0RGA9xAjnDWCtP6EMUd7p1WLu5ab9m+
         db3gC8LHOUxLVyvsRh5YY+u8IqjS4G+G2FnJM9BuKJ4vCTMlzFQqJys0Flr3e6pNXSnN
         6+bQ==
X-Gm-Message-State: AOAM531iH3MAT7QXUbrw0z/uTAgqLk+Rz52Y7uTenqSwtVOgs6RcZyuX
        lywS8EsjmxLqnBQUO8UHyd7dohfVlRzXJFspnjo=
X-Google-Smtp-Source: ABdhPJyVnS44pT7s+1XMXMXLzgmkCPbXXe1tAtY16NLc5knQgn/2hErWmFmznw8uQihbNqN3+62Ky++aLOQYfTNMNNI=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr2667908oth.250.1608296339939;
 Fri, 18 Dec 2020 04:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20201217162740.1452000-1-aford173@gmail.com>
In-Reply-To: <20201217162740.1452000-1-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Dec 2020 13:58:48 +0100
Message-ID: <CAMuHMdV3WKFLPKf_6nVc0bX4wXe55GtKST9whiEKpG_8wq6t6w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Add optional mclk device tree binding
To:     Adam Ford <aford173@gmail.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 5:27 PM Adam Ford <aford173@gmail.com> wrote:
> The driver can request an optional clock for mclk.
> Update the txt file to reflect this.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/sound/wm8962.txt
> +++ b/Documentation/devicetree/bindings/sound/wm8962.txt
> @@ -9,6 +9,9 @@ Required properties:
>    - reg : the I2C address of the device.
>
>  Optional properties:
> +

This blank line is not needed (but it will probably be removed during a
future txt-to-yaml conversion ;-)

> +  - clocks : The clock source of the mclk
> +
>    - spk-mono: This is a boolean property. If present, the SPK_MONO bit
>      of R51 (Class D Control 2) gets set, indicating that the speaker is
>      in mono mode.
> @@ -27,6 +30,7 @@ Example:
>  wm8962: codec@1a {
>         compatible = "wlf,wm8962";
>         reg = <0x1a>;
> +       clocks = <&clks IMX6QDL_CLK_CKO>;
>
>         gpio-cfg = <
>                 0x0000 /* 0:Default */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
