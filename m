Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC00B2BB4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbgKTTAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgKTTAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:00:41 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5982C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:00:40 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u2so5313893pls.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YFGbjMAixunjadRt/WNDu4Gi9oV8lPHMKlwpA1Dc+2Q=;
        b=PUrXRudevdfwpKTWyzcLGsmlLQ+wz4pg7i7qVoqSQahOJkZ1MCGJyGGp9lj8P7wqdQ
         1wZrDY7RKvl3i+FHco9AHnzpNRsv+WDmlo3LPJ9s4j/+tpdtTn8QAb7CO4+5lWRxPUoT
         SoBm7dYGx+lU8xiR3w6JHrhXtTDSHYonolxATY74JusyBcsFffiWb+1/eQSh1dOjG/QV
         vEgnnncEp9ekv7MSpTZmbXA8J0UZwBBJJ44KEVfrod/WDpwBaFz5iQNJd1N3YKVJ1z2s
         vp50zuzFn5tZ7/fxd6oHeGUafCLzdYdN1AjohJFDkM1rg9aleEo++CwhosC5jKkytdJJ
         A0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YFGbjMAixunjadRt/WNDu4Gi9oV8lPHMKlwpA1Dc+2Q=;
        b=fuMrqktYoME+y6QU27H0rSxjdMVgmQzUU3BERE93xKXmm2WLEiWHPRIpNQEJCPyzrw
         kju1qqWh1dz4puzbJLxxoLmAzW8ivLosHl9idvjMAMuUFmEzpa9Y43kGCvpM0mpMAbqN
         m3Yyk436FhJv5J9458I+AgupCm9yblq7n98zADi3HCpN0ovtYJBYDmXZs5axqCM00ibX
         OYz87YlRrtqWwZvqV+YBaLI/Vj+BFKOJ+LFIW4MMj7lcdjg++WEC/qvK+GYdji8TdBLH
         3mteYkP4LEaA2Hardoa9kc2+bli+Ab5eT/oV8Kt9WuL/XTf7044NU+WmKm2FlNEsoXZG
         HeBA==
X-Gm-Message-State: AOAM532Q7Nw2SjnV3K3bBDWu63kUSxaBGW/MifPDzf71BlbzSWOHcbfE
        vsiO9gJIOu2NlhZexVmTBrf8Vw==
X-Google-Smtp-Source: ABdhPJz6mX7mESKaTaoDQ0nba24kvRr492R62CY1RT35HX5Q2sHsihUhSg5mzAR/PiNRC/EMsYA2vQ==
X-Received: by 2002:a17:902:7b83:b029:d8:ff06:3184 with SMTP id w3-20020a1709027b83b02900d8ff063184mr14439746pll.37.1605898840189;
        Fri, 20 Nov 2020 11:00:40 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x28sm3845049pgk.21.2020.11.20.11.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:00:39 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] arm64: dts: meson-axg-s400: add support for Power Controller & MIPI-DSI PHY
In-Reply-To: <20201120152131.3918814-1-narmstrong@baylibre.com>
References: <20201120152131.3918814-1-narmstrong@baylibre.com>
Date:   Fri, 20 Nov 2020 11:00:39 -0800
Message-ID: <7hzh3bsvjc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This adds the Power Controller and MIPI DSI PHY nodes to AXG, since the corresponding
> driver and dt-bindings had been applied for next release.
>
> Dependencies:
> - Patch 1: [1] applied for 5.11 in meson-clk tree & [2] merged for 5.10
> - Patch 2: [3] & [4] both applied for 5.11 in phy tree

Thanks for describing the dependencies in detail.

Looks like only [1] is needed a build time.  Could you give me a
immutable tag from the clk tree (or clk-meson) I could use in my dt64
branch to ensure my dt64 branch is buildable.

Thanks,

Kevin


> [1] https://lore.kernel.org/r/20200915124553.8056-1-narmstrong@baylibre.com
> [2] https://lore.kernel.org/r/20200917064702.1459-1-narmstrong@baylibre.com
> [3] https://lore.kernel.org/r/20201116101315.71720-1-narmstrong@baylibre.com
> [4] https://lore.kernel.org/r/20201116101647.73448-1-narmstrong@baylibre.com
>
> Neil Armstrong (2):
>   arm64: dts: meson-axg: add PWRC node
>   arm64: dts: meson-axg: add MIPI DSI PHY nodes
>
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> -- 
> 2.25.1
