Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454612E943F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbhADLoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbhADLoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:44:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A40C061795
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 03:43:29 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id p22so26980067edu.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=jsQiv7cqKQrSj23j2G0kt6dWNWQkHHnDW/6TeXSTB6Q=;
        b=vHbUmqWI85jcwU/YZBtf+CTTbe8UempEi5UCoJs0Ja1Q9sTILX4QZpqu0AdrImXUtL
         MDppO3UN6vFDSeERlmX+dvoCNHHbLp+5T4OPwv81x5ogJU+/U4QdWP6AlygXtQ/ohseW
         yCa+l5ewdXhkM4kVwz5N475I7feEFEVPfx5dbq3kfyh2SeAjkCQsWQuvfZ2bgZ3PNl4X
         7Ju/zcZSlVggCQItJEhW5GWud96kKs9fG0FfMpnVw5LK71p6X3Ny+Vf8Wz/J9QhQZG46
         U05gejwRXZePz83QiF9FEw0AC/A3snns++n+9hWMbaDqW6ugm+lJPLwjJJ5nAl8EjHeC
         194w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=jsQiv7cqKQrSj23j2G0kt6dWNWQkHHnDW/6TeXSTB6Q=;
        b=DI7H5tUYGVd0USSJv64YK8OY8NXYM/2Wwobyk1TxddQT7puX4TmQ8uJ665khWdZ6tw
         9Bx1Y6S9rFyxN/bR2RiJITMVTLMSqxURZ0tTlgpumYdc2h3oOXan8AhNS9IkcyrEZcqe
         nmw+N6efPIuDFml9eRfmGsUJqzE/47E9HBsGnd0T+OyalHqUish19ATnqiETkEsOIiO3
         bhQxYtw2K/+6MbPXUy8rScfwHPZ//1Cf5hltvIgnjFGNkB3qya0qG35GSxzQEgGS7zMb
         WQSaPAeqQqgVPn/KESc1FCngIkD8wdds1+uCYyn/7ViBpVB7dJUWW4u3nnmEZMiGWeGA
         hF9g==
X-Gm-Message-State: AOAM533NpQTgiqL/Zn7W/auq6FwXRr7u5BaiMdaqvNtjFNHgaiDbESnV
        Zyt1G27efzkJgG4L2H6ymV4IR28xd/Caug==
X-Google-Smtp-Source: ABdhPJzYKRRnB7KPDJCGg14sKuBusAL0e/wFDhro0DqKxc4vzJIBbCO1KQ8x6pq9q47v9j2Cc12bmg==
X-Received: by 2002:aa7:dc0d:: with SMTP id b13mr70450856edu.170.1609760608380;
        Mon, 04 Jan 2021 03:43:28 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id f13sm23221758ejf.42.2021.01.04.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 03:43:27 -0800 (PST)
References: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: meson: three small clk-pll fixes
In-reply-to: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
Message-ID: <1jzh1pvsf4.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 04 Jan 2021 12:43:27 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 26 Dec 2020 at 13:15, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> while working on some changes for the 32-bit SoCs I hit a corner-case
> in the HDMI PLL: there's some rate doubling going. The PLL only locks
> in a specific rate range but the M/N table is not aware of that. This
> means for now (I am planning to fix that) that we can end up in a 
> ituation where the PLL doesn't lock and meson_clk_pll_set_rate() is
> supposed to still behave in this case. So here's three small patches
> for that.
>
> For me it's fine to queue these patches for -next. I am not aware of
> any breakage upstream, only some of my pending patches prefer to have
> these fixes.
>
> Slightly unrelated: if you know anything about that clock doubling then
> please let me know!
>
>
> Best regards,
> Martin
>
>
> Martin Blumenstingl (3):
>   clk: meson: clk-pll: fix initializing the old rate (fallback) for a
>     PLL
>   clk: meson: clk-pll: make "ret" a signed integer
>   clk: meson: clk-pll: propagate the error from meson_clk_pll_set_rate()
>
>  drivers/clk/meson/clk-pll.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied, Thx
