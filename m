Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95282C5969
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbgKZQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391290AbgKZQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:42:02 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0635C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 08:42:01 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so2998547wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 08:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=v5wyIhDUOH2agq/x4cg8x2Wwtde7ho+Gjeh3QXf9gbE=;
        b=WjDINmeAfuyLwhVMnUMkS63eEhCvuYmnexSvPb4HPPNCvT20gVuwNTlIooBUfimO0X
         DsC9VQn/Y2ppGj7a5WEco41limooaxAdrRHNy1q4wP201MMP64/GByUXXIK7qbVmmkeN
         YCAR5K/ToDAJ3ofKUysI5lo4zXywfAUr5n0tIf/l8iofsySPLzCmrXG7y6T+CDrt0r6H
         tusi/vo2AVKY3m6g66HQmWdCB3Lzi1RhYSCyrWBIKGSnI7nr8Wl5s8rbWpVrzFIM2CEf
         TYtc/9v7nNpI/S3xem7HSvh3Au7ejkLb7r7CSYlchdb9x12JPFOTyiF03a3dPfSCkKCY
         oLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=v5wyIhDUOH2agq/x4cg8x2Wwtde7ho+Gjeh3QXf9gbE=;
        b=CUKP/H2AjibGQC6qce8WTxjwkrhNE6dVQYK8O7vISwqLgD6GKinYfr+rrBzsd3GzmM
         /smnhFZrDUtSpZF9mfDuETt7gNGm6gLaLrEJH0PUgtJfIicV5Uavpj0ngAOpD34Rrvsf
         Xa3owRcmYC8Wv2QVBUuXi5Kp2tlhO5Zx8gQFdxrSk5OQVf0JV1uXGnwwh+CrWHvwK41U
         hzUsxsmPH29PGGLvnccSw0M0sEV8FC5zJoM80RZClskSvF+QFKBHrTgKLc79YQsIKo//
         X0Bk3hmkOXdrPIVuuXUPIURqCPs1OcS/Sp+UOQhYlBPUHPie7KIBCh6mtxJUjfVJyPwH
         RYKg==
X-Gm-Message-State: AOAM532rwRXktUxoBVfKTw+DXyM3mag3Qr5i1nxCtrg/qEf7kFeSpAvO
        t1EXufaNAhKI2hMbf1HN9Q8YQQ==
X-Google-Smtp-Source: ABdhPJzrDpc/4cZPXo1+i+uc6IDMIE98gACt8UkwYjpI0h+ejw9io3H5nFPd20XxRiMX9KO8y+04sQ==
X-Received: by 2002:a1c:b402:: with SMTP id d2mr4345453wmf.38.1606408920466;
        Thu, 26 Nov 2020 08:42:00 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id a14sm9596885wmj.40.2020.11.26.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 08:41:59 -0800 (PST)
References: <20201126141600.2084586-1-narmstrong@baylibre.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: meson: g12a: add MIPI DSI Host Pixel Clock
In-reply-to: <20201126141600.2084586-1-narmstrong@baylibre.com>
Message-ID: <1j5z5sysrt.fsf@starbuckisacylon.baylibre.com>
Date:   Thu, 26 Nov 2020 17:41:58 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 26 Nov 2020 at 15:15, Neil Armstrong <narmstrong@baylibre.com> wrote:

> This serie adss the MIPI DSI Host Pixel Clock used to feed the DSI pixel
> clock to the DSI Host controller.
>
> Unlike the AXG SoC, the DSI Pixel Clock has a supplementary mux, divider and gate
> stage before feeding the pixel clock to the MIPI DSI Host controller.
>
> Changes since v1 at [1]:
> - switch g12a_mipi_dsi_pxclk_sel flags to CLK_SET_RATE_NO_REPARENT
> - fix aligment of g12a_mipi_dsi_pxclk_div & g12a_mipi_dsi_pxclk parent_hws
>
> [1] https://lore.kernel.org/r/20201123163811.353444-1-narmstrong@baylibre.com
>
> Neil Armstrong (2):
>   dt-bindings: clk: g12a-clkc: add DSI Pixel clock bindings
>   clk: meson: g12a: add MIPI DSI Host Pixel Clock
>
>  drivers/clk/meson/g12a.c              | 74 +++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h              |  3 +-
>  include/dt-bindings/clock/g12a-clkc.h |  2 +
>  3 files changed, 78 insertions(+), 1 deletion(-)

Applied, Thx
