Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6BC29916D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784406AbgJZPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:49:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45283 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773082AbgJZPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:49:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id j7so10913824oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZLcxZ2MnUfE2owgeO5H9FxVAp5GYsqgLY4ZhY+S9R8=;
        b=jtSGr9LazkMCJoDk/IxFFP4G5Qs+Y/9svdQos1NCXU8w7ehGZ1EUP/P/1qM5Zn8/Jo
         sdeFpgprcu3SWr7TpeAQolSe02ABLWQf+Pty2W6nb4JyLbLaeZn+PQi2twz5+iUeR+WL
         03CZsOTG45+8p7ykLyG/f2YL6cOKxOwa1DleYjm/yOQyV9F1o5xu8twZBHPHM6TMPbfi
         HZdDc6zw/913iaREkqY3fNRuLIv5jELnWoD25g/3dDPPvbzNVn/oVekUMoMNW7G+/Sjw
         kZ9nnGIUmmxoDjTd8cwh/QyFuWIVpvY47VBot6ALPeaPToOWxzeTVrSlIsJbWkdayyo5
         om6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZLcxZ2MnUfE2owgeO5H9FxVAp5GYsqgLY4ZhY+S9R8=;
        b=ZFSXE+lCCW7MrG/VukiA8F23+58qw/s+Be01VeZV0YTsWV4sVAWYVuY00n4f591/+U
         H2BdkCqkkw7R8Vhb5NuOp72bqUfVbRijRk1H95UhEj+Oe/6jeMAnyhPZDoge2FxjdSfe
         L9WlhR1SlXFf8nmRfJjJQxAg23Hq3h/oquL4ON+Kq3UGdBq6RiLXgsF6AP2oCdjgx5u9
         lHAZwNfMoVfEXHNuojZHOp7iwgY/vMKseeqm9rVi2VgzocaxCSZXSZ6KRVLEsTLK/hYY
         ncM3Nd8e0qVLe6YQuhx/7FRPP11xtwoF9Bjmxu0OavLwigPHmCSu+V1eqaThgEso/R9k
         J6kg==
X-Gm-Message-State: AOAM533WDs1uiBPX+ESAlv7/0T6B7HVMRG6e8BmtxTcaxjwr1YyCoKO0
        /8ZG1QJkyoytkTftQf0TSusavHQQbbYw1Q==
X-Google-Smtp-Source: ABdhPJy5vzb4gSulEItGq7NAbNpQx1Rk+qmcaxsk1uEPTY3pthSMzWWPWLeRubLs4nUV8lHjyEbN1w==
X-Received: by 2002:aca:4d06:: with SMTP id a6mr14494885oib.166.1603727379027;
        Mon, 26 Oct 2020 08:49:39 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a16sm3807833otk.39.2020.10.26.08.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:49:38 -0700 (PDT)
Date:   Mon, 26 Oct 2020 10:49:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v2 0/4] ARM: stm32: add DT properties for remote proc
 synchronisation
Message-ID: <20201026154936.GA178863@builder.lan>
References: <20201014125441.2457-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014125441.2457-1-arnaud.pouliquen@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Oct 07:54 CDT 2020, Arnaud Pouliquen wrote:

> This series implements the DT part associated to the commit 9276536f455b3
> ("remoteproc: stm32: Parse syscon that will manage M4 synchronisation")
> 
> Delta vs V1 [1]
> - add Rob acked-by on patch 1/4
> - simplify yaml descriptions and align other syscon descriptions
> 
> [1]https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=339339
> 
> Arnaud Pouliquen (4):
>   dt-bindings: arm: stm32: Add compatible for syscon tamp node
>   dt-bindings: remoteproc: stm32_rproc: update for firmware
>     synchronization
>   dt-bindings: remoteproc: stm32_rproc: update syscon descriptions

Applied the dt-bindings updates, expecting the dts change to go throught
he ST soc tree.

Thank you,
Bjorn

>   ARM: dts: stm32: update stm32mp151 for remote proc synchronization
>     support
> 
>  .../bindings/arm/stm32/st,stm32-syscon.yaml   |  1 +
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 21 +++++++++++++------
>  arch/arm/boot/dts/stm32mp151.dtsi             |  7 +++++++
>  3 files changed, 23 insertions(+), 6 deletions(-)
> 
> -- 
> 2.17.1
> 
