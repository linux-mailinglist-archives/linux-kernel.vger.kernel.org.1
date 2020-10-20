Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE35A293BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406293AbgJTMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:37:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45420 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406182AbgJTMhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:37:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id e17so1916719wru.12;
        Tue, 20 Oct 2020 05:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uI0sxWmkEQxazu/MK4wnmDwAYFskIMefNYHYBJ4Fljw=;
        b=tsnn6EiBvIHHVjMcPq2h3Fgk6ew19BiOl455HtkX70i23FQczhRjq0Z2W3dVrSOR0Q
         pfIB5NckMXJBWKWDArvw2Z/HQFwzbLGEUP3qGGUtrk9LVReLymM1pD0fT1asrjfe54zE
         yKakuRVx1SXhtywS1cABdcL6G+DCVBLjRkY2FSpuP+GqrU8hzI9eYewmidZkJl/ZP6Zj
         c50mpWgkatTWUkMtops2R7b2Ryi/DZnGjZCE/c5SXMAZ52Z2m89/jb3ISfP5iLegpdzW
         hbgActeHnhzEVflDwih62hSc58sFiC9ovppF8WFPdOilUidWcpMeg0i26Zkdf6xJojxK
         zq+A==
X-Gm-Message-State: AOAM531h1VJBYmZq+GyoMmQr2dI9TzeFNnxAPTb/x92pf5RLS9nD4YeU
        AhMhfwIkPwggmIFyfbMDZ5c=
X-Google-Smtp-Source: ABdhPJwSKNHUrLj4aeC51DrkXwFSbH+mdUBRe5IyiMej503hf5AVng/p1dQDdmfUICPW23d//SmJcg==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr3136136wrq.279.1603197452011;
        Tue, 20 Oct 2020 05:37:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id a2sm2884337wrs.55.2020.10.20.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:37:30 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:37:25 +0200
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
Subject: Re: [PATCH 11/29] arm64: dts: hisi: Harmonize EHCI/OHCI DT nodes name
Message-ID: <20201020123725.GI127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-12-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:41PM +0300, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi       | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
