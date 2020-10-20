Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25735293BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406427AbgJTMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:42:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39674 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406334AbgJTMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:42:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id d3so1706053wma.4;
        Tue, 20 Oct 2020 05:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gUEM5Ewn4S7jbDhIOaU3NNLK6s1Nw8nSBO1+FPUtvBg=;
        b=OP6dzNdP/sfCt0xdzIeO0csmUllew6Wn2SD/D7X/BJ+FQx6J9HZABjjcO38jS4jEhC
         H6eCuNZUgV1T53ShLo2idY1fDllB7XYiORuhkq07COzl3OXb/hFydQizug76afMkDfe2
         +p2AW12qVsh3RUQ1A+lIsrGIJJvSnSqkI4wxh1252cDVtqs8JQN/loKOepCQ0mMVGuZN
         va2g0LY9ljfG1eKFIr6rqWiRnUYIrw5FstJncQRaxUfpjVOjS4GFO2RRKzTY6yjgalgl
         GcGMD6kVivRXgzaDrHXJrGn1pfaON5GV7mvkZQSlIw+InYrq1ExW0S8OKMqKO425NoVk
         GFFA==
X-Gm-Message-State: AOAM532Vz2ZvKywspznqxiK4KLz5Z9f3yVTwPV93cBTn2r9GyqZtHTNB
        HfSOuo83sKRvV4BHZ64Hd88=
X-Google-Smtp-Source: ABdhPJw0DwJAKiQPvYKSNQoaAWLE34fWernjVUu3NHLcuVw14VDA6xEm5GQG0I4BBIIJqVGP2pFegg==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr2703129wmr.179.1603197730356;
        Tue, 20 Oct 2020 05:42:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id i9sm2580726wma.47.2020.10.20.05.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:42:09 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:42:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/29] arm64: dts: allwinner: h6: Harmonize DWC USB3 DT
 nodes name
Message-ID: <20201020124207.GS127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-25-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-25-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:54PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
