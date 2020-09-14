Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA2D2699A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgINXYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgINXYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:24:33 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B550C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:24:33 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y190so897900vsy.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+7ayRJRVcL9E9FgaMmSHKBAwd3QZcH8/3SgPpQfdjs=;
        b=kwZbe8HoMejYOA2ogML+Pn1xAVwI02AXWR37EzjSYBVlQ7oo29ImB354b9HQnU7XSY
         ZTLs54/yF2Zn+vweEuWP86W3Kx1sFTeDFmm2EHHD2tMgRffqH6F6xCPoWAJSdjAsIUzw
         anRHI15T0f1Me495ok/562HIcQzrOtstQ/GAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+7ayRJRVcL9E9FgaMmSHKBAwd3QZcH8/3SgPpQfdjs=;
        b=RK/hSaM9zz6fZCfwchzxmI/vSHe1cjZ9F9MvNynDTrDXUVvC0v6k+J6ESS0zTpA37l
         PQiI0aWdUBJzjOS7jVP4cYwytTJMgM6SVNAHvXlW8g0nxrWnMks0rssXN6BlpfbBw/Lo
         Ukq2XdKWvhA+692WZOa4yOjp+y/ZXNSrLnJrHCAAowOGEozaVUXuVb0xS1/i6DrbXnOv
         Rl9ik1vR5Gxn+IC5WW3WairsmMOsZ7T736Rax3lcUPKGKw0//6WpOPeYc4N6ghDE0LVg
         W1odJ0vTlR7PSNIdj67SkGp/FFaiLnVZ3sRg858xK0RLtKKCUnI3iEPgO/eTXeA8n+oE
         ijRg==
X-Gm-Message-State: AOAM531CHXv7DOUgTRlLi23W31Cl3pQkayXTB05FHliNKJNY0QzqjZ/k
        Po99JbXuVfOGSmWSA+KJbdW8uOjsRCQUSw==
X-Google-Smtp-Source: ABdhPJxNiSI0nrqu7ej6VbQxiAOAcw1CE67mRObcWrZMA0yb4qU2pucqDn8LpQk0cy+WfGjfs4/V9Q==
X-Received: by 2002:a67:8041:: with SMTP id b62mr9378382vsd.19.1600125872657;
        Mon, 14 Sep 2020 16:24:32 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id y84sm1770256vsc.33.2020.09.14.16.24.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 16:24:32 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id i22so414321uat.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:24:32 -0700 (PDT)
X-Received: by 2002:ab0:5905:: with SMTP id n5mr8232516uad.90.1600125871797;
 Mon, 14 Sep 2020 16:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200914232218.658664-1-swboyd@chromium.org>
In-Reply-To: <20200914232218.658664-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Sep 2020 16:24:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W8_ERtKWLQzC_1ZBDeUJPR1+S_3Mt=mA-RCuUB8t0uGg@mail.gmail.com>
Message-ID: <CAD=FV=W8_ERtKWLQzC_1ZBDeUJPR1+S_3Mt=mA-RCuUB8t0uGg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: trogdor: Add labels for type-c ports
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 14, 2020 at 4:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some trogdor board variants only have one USB port, so add a couple
> labels to these ports so we can modify them later.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
