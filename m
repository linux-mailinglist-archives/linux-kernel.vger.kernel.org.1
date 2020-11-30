Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78A2C8997
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgK3Qby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgK3Qbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:31:53 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2212C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:31:13 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id k3so11821620otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hE/RykPxxvl/iv2a/6hg4e3Nux+3/enSbEuVXiHjd4I=;
        b=U53O3VwxcbPvrPJFzb8pNUZEmg3TUSdiomEr5ogaD8CsjcEwwPGNviwMXfPlt9M1OL
         ShoTnh/rQKc122pkUlV+rNqnwP8GZHgB4KsFF+KrH50vFjFTnxdbX2zPFLwPCn9fJ/r5
         LC1ZViEZWw4IiDPsYL9Dp5rPGjogiNnmIMYWmCl333cEsruB3nWwwJRb11HVKczTsmzI
         6pYoA6sxyjL6QOJro402VZzjZMvkGMevkKQu5WHTDvfj5M/EwsnWnHUk9o30YAdPPaU/
         lA8zzvDSKqNy6cJpRBvTS6a80PKWpWK732p1euGAQt5lZO7iSWERSohHL+PJ1fTbZymB
         ARvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hE/RykPxxvl/iv2a/6hg4e3Nux+3/enSbEuVXiHjd4I=;
        b=Y7YlHQCE1DImQhWc9f69LbmbYBUK8oNxBAnd0t21W4VIrCJRLgTRjycCC/5bZQXTi8
         hOYS5kCf2DuR4zMy2A5UAr1EUnAJjIhjODCd/bf7kZE3yphME8UBft5e2Z158ok86lQy
         63Ewh76ndVfXjiPrce37N5KtkVLomVXy/W/QfrsCReFPHKy6dd9ytZ3pGdDNynUYVmbd
         7QOqOViSj0XO7/rRW9pCDhv5qyLNrLOYvCvLZKf8eWmzFvWszxfpjDljNndIE73zuAUG
         nCaPWDFNczy4ncFOA+NBH1NQz7rg4Wcax9sX8jwkYuS8JD00SV0il88zfu43ImFlzqbA
         yaCQ==
X-Gm-Message-State: AOAM532aGGb9D5Lyg8D+yXODSQpWYIyL3WMJdIQfTbG3zbAD1XEgw+hx
        5CJw2uLbkoGTo//XI5pp0+sjaA==
X-Google-Smtp-Source: ABdhPJwPyuRguA/X/VKNHhVYFWzFy5qDnAUzI10dqizuEOoo2ScaJs851E4cUEABtgdklHd5lcs1kQ==
X-Received: by 2002:a9d:2643:: with SMTP id a61mr16985554otb.353.1606753873063;
        Mon, 30 Nov 2020 08:31:13 -0800 (PST)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id q24sm9162363otm.22.2020.11.30.08.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 08:31:12 -0800 (PST)
Subject: Re: [PATCH] arm64: defconfig: Enable HID multitouch
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20201130162834.310282-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <b817652f-f3a6-1932-1614-4d99ceec4d73@kali.org>
Date:   Mon, 30 Nov 2020 10:31:11 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201130162834.310282-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/30/20 10:28 AM, Bjorn Andersson wrote:
> The Lenovo Yoga C630 relies on HID multitouch support for proper
> touchpad operation, so enable this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8e3ed05b655a..f4d0b3a61e41 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -737,6 +737,7 @@ CONFIG_SND_SOC_WM8904=m
>  CONFIG_SND_SOC_WSA881X=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
> +CONFIG_HID_MULTITOUCH=m
>  CONFIG_I2C_HID=m
>  CONFIG_USB_CONN_GPIO=m
>  CONFIG_USB=y

Tested-by: Steev Klimaszewski <steev@kali.org>


