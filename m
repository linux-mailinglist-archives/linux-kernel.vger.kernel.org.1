Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEB7293BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406393AbgJTMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:40:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35401 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406255AbgJTMkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:40:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id q5so1703444wmq.0;
        Tue, 20 Oct 2020 05:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDLtrvuQEy+Y5vBZFJLsdLbnHYcFO15SHFGC/OVhzaI=;
        b=n+Szb+y00Xt6y5P3w8hXCv0l12uteB3Y03qFJUj110WDnkTenYwFuHZGz27CE9F5Vv
         ppARnhf/UqSNX1xs8LXHpX0/Dr4/r820kyW3KEn7asNiRqkNDc77u0FZSLqkA/TZ+/U+
         9GRl3gmyYN5ocLHc2ld/UC3CU7+wn6CVvSErkvVmhMsHo1OeWCETaARCh0VQ8xIZV+UV
         OV0hsm9kGUDNtlPUp00HUQVjtYvSuFsliHBDNSnPDK/0im55II7O1fMiL4YdPiBCwtb1
         hFSTuSF3SjDW4zjNFLwmjp+Py8/dqtEIsI48mY2s8xa95O11SblbQSXeXz4UMoUzM9hA
         k50A==
X-Gm-Message-State: AOAM533xrNr6DvIz6YsNveAzODHDDsV3pTkijqbzwS0dj1sSwvoRXkDp
        im/Tm6dj6i4/MvR1xXeZgv8=
X-Google-Smtp-Source: ABdhPJzCK1aj+gdIyHbPWwHsAL3TXai/Dqt2WdyEBWTUmWcUpEdt/R3XGScGtcqtG1Rx2eb4BaLb0g==
X-Received: by 2002:a1c:ac87:: with SMTP id v129mr1955508wme.119.1603197616364;
        Tue, 20 Oct 2020 05:40:16 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id n62sm2067210wmb.10.2020.10.20.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:40:15 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:40:12 +0200
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
Subject: Re: [PATCH 17/29] arm64: dts: marvell: cp11x: Harmonize xHCI DT
 nodes name
Message-ID: <20201020124012.GN127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-18-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:47PM +0300, Serge Semin wrote:
> In accordance with the Generic xHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-xhci"-compatible nodes are
> correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
