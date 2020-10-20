Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55CD293C09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406457AbgJTMnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:43:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38783 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406358AbgJTMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:43:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id b127so1712780wmb.3;
        Tue, 20 Oct 2020 05:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVXugoNIBfaBK3mqqkRt/ElBgPIgx7HbAbiAJzflr7U=;
        b=IC8kq+MOCFEqHxQTmqcLg28lGgf3/89BApnsSMTGMafA7Pk5hZnI3Ul5gHhMsNq+5d
         RhUNpVro9iFzfkeukqYZTbUZAH6x8HoRk+tiJx2WHzTRxdwjtaewL6Pz5KzPmiitDXkc
         crdTv2znLM0bpLcLed/kyKnJnHzEsMpd/WRbCrg1pTWPtJrdPNSUW+oeAOXQEv0Z/9jd
         1niHpl1jEilFucw6/Nk8F4QCgidaCuHCc5u8XxtyDwiW2tIvJQEXOd8IMHW77IFvKcqz
         +PZLEww5w63Mk02eABQyqEJpLnXHZ68jsU6VbL6uAQoZCB+16O5NMJ85rB6HXj6Uuiv0
         rCAw==
X-Gm-Message-State: AOAM532arfIo7tf9yiuI+iypWrOjgb8Hqdp9ybGTjDGQ5Yi1jTc9HBwz
        f+LMMbX0JTDb7mtqLnEpwJw=
X-Google-Smtp-Source: ABdhPJyH9bY0LYqtJFqh8WYPi3TBv4gy01EW5b+/2SmJOY7NKvGX/Tv1DjQGpUvP3OaQ+ckCkbmkTA==
X-Received: by 2002:a1c:6546:: with SMTP id z67mr2664160wmb.98.1603197831632;
        Tue, 20 Oct 2020 05:43:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id e5sm2773086wrw.93.2020.10.20.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:43:50 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:43:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/29] arm: dts: marvell: armada-375: Harmonize DWC USB3
 DT nodes name
Message-ID: <20201020124347.GV127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-19-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-19-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:48PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm/boot/dts/armada-375.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
