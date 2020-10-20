Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1E293C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406472AbgJTMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:44:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39193 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406461AbgJTMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:44:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id y12so1964601wrp.6;
        Tue, 20 Oct 2020 05:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZfFVXtkgyFqZCDC1wfmkpZrMPxTu9D0ZApuNq3SG78=;
        b=amq9WOaWEVvuu/vXfIEdYBFiK+IjY5xjeG/td55+7rUBLgtZgTiwQd9Xruu+hfDadr
         C38ZMSotyYQAejsep2iXJ7BC2WKjfOBy9nSby1zHowVpjr+ojoKojbZtoSgUhu6GRM0Z
         P0FujK3IzcihRiKhEcgNxsGezRFHCyucF6IxFR2UwoMpz6LxeQGBhRqlVlEG6K6LgvvD
         q28qRWCasYK/Oa6lXMTqUV5DunOqJ40TdWFj41GgfmENISMckCvFyBtXUTQIckxX7UsZ
         fks4qPqL1F63H1Lm1Ex1k+zpVO4Z09XuhJL3sJJOdUOxXuq+5w1xN5hIS/2KmhyapHEM
         ZTBA==
X-Gm-Message-State: AOAM532i1q8lPJcIuU6PEYGj8QmtozLVRN7Vh0Y88+5IZRVu2JP+oKXz
        iJiyg8Q6LpxN2HK6sFvWmKI=
X-Google-Smtp-Source: ABdhPJzREyn9OqIlw6xaXKpAB03qs+kirXa6tydCm3X+PU+S4b921+66yryaZpuxu6+NEZ6KtJV6rA==
X-Received: by 2002:adf:e650:: with SMTP id b16mr3433999wrn.350.1603197845584;
        Tue, 20 Oct 2020 05:44:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id a8sm2453549wmj.31.2020.10.20.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:44:04 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:44:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/29] arm64: dts: hi3660: Harmonize DWC USB3 DT nodes
 name
Message-ID: <20201020124402.GW127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-29-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-29-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:58PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
