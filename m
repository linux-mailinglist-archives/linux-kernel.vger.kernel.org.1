Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B532DAEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgLOO3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgLOO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:29:08 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1BCC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:28:27 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id x20so20294478lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdkxURvE+//a6vEq3auCmQiU3zCSIzJRBoLgXA2faA8=;
        b=FWWM+el3iG4jml/a/S8+cAleWrZFjQaUo9/89/8OOHAILBQChQhhLwO0CB4f//95L2
         J3sLnuHmmIy1Q0FjAPxlGaYjU7I/W5TktEpWaXkv9Tg8dvT6pUSajPhrAHwhvpwLISJN
         iPeBFgNSEBr1wZdVxEY6UdGkE5otR9R46ktQYGWGzCtNERafVoatwM7kQdTMHvB/ITVW
         AMKqr0OZNWjr4fgAzSxFdGYKzBD0xSeDkhTJNf/Reirluu9IOcljmt7I/edEoqcCd1r7
         XbnyutRlov1Q43UeUF0KUoR1FiCXpxWjJGUkGqCbViKkPAXQjaP/2mRFmAq2mcYiKXH4
         3VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdkxURvE+//a6vEq3auCmQiU3zCSIzJRBoLgXA2faA8=;
        b=FxtiCAYFGrN+O+4e++4LMbUgovVgfrd5CwowHPLHbGJzC3QTBSryoxHivtcBP4WC+K
         SfmM847UQryrzN/bj8otp4YECYNPiHN2HXBPGwPT7pcxJ2pRffCD21gE2CqXNeeO/th4
         H7KPNvLPbRUAUSw1x+IVXokWE786qE1555NTkWtVab3xkOEwzzbLxxudV61DEAPWkNwg
         vhRcnIFpD4C6WuczD5dUiLKeAgPWTkMIWBkaQ4y3j8/1hw0ysSbQdxnRzYNm7JypNewZ
         ZWCKNED8X+IqJ/fFRCm/sUMR3DaA6a8nSa8ppOwHX3KkK4QucPqYAK/E3QAEEkGWgzO+
         2Tbg==
X-Gm-Message-State: AOAM530u2mxUVl5VYOK9xICLQMaCPYlPAcLEsO5xSiKuLKNMMbSNhIxq
        F+3CN1+u4SDIvJVKwOcOk+D7zZr7vUPHYs57Z05NUw==
X-Google-Smtp-Source: ABdhPJyQeMgSaqYkewzCqMDu+KKRFvrpl5evPi12xUyQ3QG5+JJM4xJ/Zlq77mWSMw52kggUexMfs6//mDGt2F4cBgI=
X-Received: by 2002:a19:495d:: with SMTP id l29mr6969679lfj.465.1608042505945;
 Tue, 15 Dec 2020 06:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20201215135222.6899-1-digetx@gmail.com>
In-Reply-To: <20201215135222.6899-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Dec 2020 15:28:15 +0100
Message-ID: <CACRpkdaUW5E-vqiy6Qghmjx_u7Sde4G18b=AsWBLmn+ARZiD2Q@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: tegra: Fix misplaced tegra_uart_config in decompressor
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 2:53 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> The tegra_uart_config of the DEBUG_LL code is now placed right at the
> start of the .text section after commit which enabled debug output in the
> decompressor. Tegra devices are not booting anymore if DEBUG_LL is enabled
> since tegra_uart_config data is executes as a code. Fix the misplaced
> tegra_uart_config storage by embedding it into the code.
>
> Cc: stable@vger.kernel.org
> Fixes: 2596a72d3384 ("ARM: 9009/1: uncompress: Enable debug in head.S")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Aha I see the problem.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker as a fix!

Yours,
Linus Walleij
