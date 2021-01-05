Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7012EB56D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbhAEWgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbhAEWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:36:06 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03110C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:35:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x20so2137201lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahZlAn0+MJ2JO85Il4zqrFNJA3yrxvXOMtixl0o8ZDM=;
        b=xuV05iXPoA0k4FUH7uDKhum9x67A5+g0WrawAcxr+1nwNNKfzDFFhw6RcXhGVjrdAG
         DIPpNcT0tMeqTolY+1UHSqvl7wF97ndSycgqsK5KNZXYOFouXEAZcmV0db14uxPi/xTw
         fkiZrDeIfCVzxFPh/s6f5MjQjTE3FbzD//H1CaneHnQ65EKqNmVFIkbD/Q8s3qRbnfpF
         oeHplvWvkyArKkqqQjholOIaGROH0SMwCIhye89WnfvVn9lg7Rsy+dje5qrZY0xghJSO
         IVRZp+VQXtSVeFeCiWvHmfOs8HhPvx9IfbltAGF1/00sbuHYdVKbwxTKfWFe05h5vvVQ
         dbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahZlAn0+MJ2JO85Il4zqrFNJA3yrxvXOMtixl0o8ZDM=;
        b=Dy3/81r8GHyLhcBeC40vMMFDGKnMBUSOLmwOFtnJn/kmZUsflH57DewPdZPibJ6zDw
         4JcRJ5quggWDSmMSYuzC2B9cHUUa0i4Ws8FzjN1QZdsuRmtM4SHLX1DM2EU0zS89lVUW
         /XXZ3HpAk7Sr3u6n+oZhIHelnXFhvkuPYu47CG8PjNuyyWI0YqX9at5LcVuwVrAf9Ze2
         l99sGSlGR8UHNIDXwASiBHZTV76Bn6XAIcJYIBRX2Jk4L2bnumWI2SF0oxrVVgnQF2wA
         AcF3TVMpUwUKvbm6e1YFOXHUIC+SV5hpsPdGSyUJrywDmBjG2hN6Z5pHL9Sr7t6goYgS
         tXHA==
X-Gm-Message-State: AOAM532h/HCIWyuB//Yu/WEat6MWELnYZY8C8lUykJdlpPgOirsx1YLw
        8v3i8gBxFEeNX46v/vx2/thzbgP+YADPn8EiG7wFvw==
X-Google-Smtp-Source: ABdhPJzKIX1tyqxO7DBuxtMjhEds0Yt3Gvxf2kvrIu6dSu4kg7r3sapM7iAm3kjKr+iyrDzk5lF6EH5VLy/XUJEFifg=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr800336ljj.326.1609886124436;
 Tue, 05 Jan 2021 14:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20210103100007.32867-1-samuel@sholland.org> <20210103100007.32867-3-samuel@sholland.org>
In-Reply-To: <20210103100007.32867-3-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jan 2021 23:35:13 +0100
Message-ID: <CACRpkdZbNUxizfV5Oo8F8b0bsjNcBF6JfP=ufykNLeqErvU-ug@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pinctrl: sunxi: h6-r: Add s_rsb pin functions
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 11:00 AM Samuel Holland <samuel@sholland.org> wrote:

> As there is an RSB controller in the H6 SoC, there should be some pin
> configuration for it. While no such configuration is documented, the
> "s_i2c" pins are suspiciously on the "alternate" function 3, with no
> primary function 2 given. This suggests the primary function for these
> pins is actually RSB, and that is indeed the case.
>
> Add the "s_rsb" pin functions so the RSB controller can be used.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Is it OK if I just apply this patch to the pinctrl tree?

Yours,
Linus Walleij
