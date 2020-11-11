Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA822AFC32
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgKLBdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgKKWvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:51:45 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D60EC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:23:40 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id r23so1232285uak.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnpRf3DpQZWPCc8K1L4I004+4MFqzM2ZdFbLNwwHnYw=;
        b=C9k51AwCxEhPRdeOTRakEQTuFFOQh4UZkwHCz1URxF01p2AOtXY84wjFUBZ43stsfn
         LYvn0PUhMDdNs4dwckpA3Hg6lINDOc2zIzXRILApPx9B4pT1moEvZ7weshsWRZf1CUEq
         W+7naCTDF4POLE2bhgaEEUARcAhnDvxf7N3Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnpRf3DpQZWPCc8K1L4I004+4MFqzM2ZdFbLNwwHnYw=;
        b=UvFSjoiUV2pCWLazPVkJMstovN/k2c6MkU4lW6qO5voRLylTHMaILbo0wQECTc96cZ
         z0FBJcmaJwrjBFIe86LaDRpbdrav5pSNF0I2Ad3wKYT9KAQWsXL4/Hjjgx69ZMn7aNWU
         p0V5VelV120ItFZUCYwkeLhf/hG4XihT5HtG5EtMzimPM1TtZrnYbVsWEzRlSXLSfffF
         ydwcVIFG0h7Yx0h5XC20bnevffk+vSuQuDV92CaT7wWkzUOHdu3Pkup/R8ZMUHxmC+ed
         I6y0GHlMhG1Etg7hyKPNCBd6KMOX8DNKLr6Jq1esW1qOPSTZ7ILDkKHz2zknWCNqW7Lq
         9clg==
X-Gm-Message-State: AOAM530lz1wOktWzja6NMTOyFbPWYaNfHX4i8TKJZfG7x1nQFeAfBXl2
        o/J6uRSi7IxtJEEtDIZrWSFotygKWv4D8A==
X-Google-Smtp-Source: ABdhPJydLm7sTEzv1y13WiVbeAhbHs14gnrXu9RcesUZa1H7iS6xLX+LYI1rL8x+MKRqYdXwghCKbw==
X-Received: by 2002:ab0:2259:: with SMTP id z25mr14072580uan.59.1605133419316;
        Wed, 11 Nov 2020 14:23:39 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id v76sm422345vkd.4.2020.11.11.14.23.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 14:23:38 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id w3so1237345uau.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:23:37 -0800 (PST)
X-Received: by 2002:a9f:24eb:: with SMTP id 98mr14362417uar.90.1605133417432;
 Wed, 11 Nov 2020 14:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20201111120334.1.Ifc04ea235c3c370e3b21ec3b4d5dead83cc403b4@changeid>
In-Reply-To: <20201111120334.1.Ifc04ea235c3c370e3b21ec3b4d5dead83cc403b4@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Nov 2020 14:23:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V6fFoEdj8bSQmz4fAJwLvzY0o8Vd+E0fknZaLTq4ZQnA@mail.gmail.com>
Message-ID: <CAD=FV=V6fFoEdj8bSQmz4fAJwLvzY0o8Vd+E0fknZaLTq4ZQnA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Set 'polling-delay-passive' for
 thermal zones back to 250 ms
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rajeshwari <rkambl@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 11, 2020 at 12:03 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Commit 22337b91022d ("arm64: dts: qcom: sc7180: Changed polling mode
> in Thermal-zones node") sets both 'polling-delay' and
> 'polling-delay-passive' to zero with the rationale that TSENS interrupts
> are enabled. A TSENS interrupt fires when the temperature of a thermal
> zone reaches a trip point, which makes regular polling below the passive
> trip point temperature unnecessary. However the situation is different
> when passive cooling is active, regular polling is still needed to
> trigger a periodic evaluation of the thermal zone by the thermal governor.
>
> Change 'polling-delay-passive' back to the original value of 250 ms.
> Commit 2315ae70af95 ("arm64: dts: qcom: sc7180: Add gpu cooling
> support") recently changed the value for the GPU thermal zones from
> zero to 100 ms, also set it to 250 ms for uniformity. If some zones
> really need different values these can be changed in dedicated patches.
>
> Fixes: 22337b91022d ("arm64: dts: qcom: sc7180: Changed polling mode in Thermal-zones node")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 50 ++++++++++++++--------------
>  1 file changed, 25 insertions(+), 25 deletions(-)

For further context:

https://lore.kernel.org/r/a4be2cf9e51e4f40aae3f9a56989a42f@codeaurora.org
https://lore.kernel.org/r/20201015221920.GA1657396@google.com

I didn't personally go dig through the code, but what's said in those
emails seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
