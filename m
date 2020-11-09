Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B02AB045
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 05:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgKIEoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 23:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgKIEn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:43:58 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F38C0613D4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 20:43:57 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so4120651plk.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 20:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VeSMAdUpVTWg5rlPdJVG8pxSdZtExYB1iM9sVnjYDNg=;
        b=eJHm3TiHV/0XNoAZ9ieRJhgkcSnJxiDmzQgtmuC631IsES0yYbO7cCylVd6eMw/FxM
         2w0vktpK/2bR+J/jtgktx+Gr2a5E4WIjVPPQB3qrivVht7W81PPT0kSZWbO/ezBP4oh3
         AFt2l3D8uFT0Of/uJ0JN25E9sZwm+T3B9NQeva8HaVvfnqFTqppTyoIAHyZfRITVb3Tk
         M+XSs405RTTGa0ZBepic36+ge8Bgo4FFga4GyIa7E9+utyyAeorXLVKT0/zgejtt2kbD
         UaAyk8u3UMl16KNlB69cPX6b6RoOVz7YMyNvMFsZ6hY2VeKwMUlf+tOPFXVnfhIgA/En
         +CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VeSMAdUpVTWg5rlPdJVG8pxSdZtExYB1iM9sVnjYDNg=;
        b=kIl62dadCPPNhQu1v/eYo3tfcLlBIgw6GWQHRluEseWsMRO7LabxkuTpPJB5dCyJYn
         dSw1i4Vlwuyvro+n6RPS8dhvYdVhp4YlDw1gechMVI0j6i1a3DS0+yWGxbRXB7B+Uib4
         EMDsKLhnv90jFMtek+Bu82z4LOB3Vbnkvm4a1rqiNvMzle4eMz6mshf8OcfRrpmA+XB5
         NZh8PChZo1Bt9hbeqPeVh67MysQfyhNR/cyhzJ+qRtUkyMZzy/vzb6Wcb3cjP3OQtpL7
         2Z9QzXLN3ZqQxL5a2L2kWABsOsqZyBN1VbL69m1sDf+B/KyhIZhSPVSYUbkx6W7KacSg
         xXwA==
X-Gm-Message-State: AOAM5321Rbxzl982XwFHPgDHOCJ1PhUuUfXJVUVVKPeDXYb8g00wK/JX
        qsQEO2r+7RGwPqM7Vrb9U+adVA==
X-Google-Smtp-Source: ABdhPJyHC9U/PvJR88Atd3LH5AQkxzAqN7kL/8313M8l8h0a50sg7VR+oZ4WDuMbbCMOzGA5AzJtTw==
X-Received: by 2002:a17:902:b58a:b029:d7:d45c:481c with SMTP id a10-20020a170902b58ab02900d7d45c481cmr6521527pls.55.1604897036736;
        Sun, 08 Nov 2020 20:43:56 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id m11sm8962236pgs.56.2020.11.08.20.43.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 20:43:55 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:13:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
Message-ID: <20201109044354.ljd5pomhob6b7u5v@vireshk-i7>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-20, 15:19, Dmitry Osipenko wrote:
> I took a detailed look at the GENPD and tried to implement it. Here is
> what was found:
> 
> 1. GENPD framework doesn't aggregate performance requests from the
> attached devices. This means that if deviceA requests performance state
> 10 and then deviceB requests state 3, then framework will set domain's
> state to 3 instead of 10.

It does. Look at _genpd_reeval_performance_state().

-- 
viresh
