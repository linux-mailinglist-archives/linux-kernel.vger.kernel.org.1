Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1789293BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406356AbgJTMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:39:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54339 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406331AbgJTMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:39:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id c77so1614810wmd.4;
        Tue, 20 Oct 2020 05:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MydGNu83RZlFbfutZs2HAPxrvheMvX+cy17l7KluHWQ=;
        b=ElFIxhh+ScSekbOJS8+SOlgekDds7h820oLkkF4SzpkHK8UrRnxfOX5NONH0n6hPxk
         oGtbeJhneKaBEexBPIWMUwnBLfPOz0xUqL0N1Uj3SGzIm8dXxASfDqbKuHj1eQNGYV3b
         CKS9zwRrTt0bH/OWu8a0bs5OnUrU2avF1X/yos7fbjVhZxO4rKgJ7p95TjNOA73fNw28
         eTy3hwELampOB1gNEFYXrct7iHK3lTiq+TONi8mrIV5vFL5kxhGDrKJLrrKToiwS1HN8
         F2KbynC1AGri+vsqOTG5ZRdJMNQfmoGW/2cM3E7XYlb4SFgnQhA47xTEUu/ZIYkWdKMC
         EhEQ==
X-Gm-Message-State: AOAM533jsLxZSsloXUdN1wdbr75Wt2J90AoumKTbuLnr6dKgcPYpTucG
        lVlTLmw9zjP3WAJ5cxfRZLw=
X-Google-Smtp-Source: ABdhPJwfVoNclKEoSnnor2/SuIAg0+vVdMtIt3/PbbJy91pB4+pctRvBwGM62MVaM9iN0UZx77xH3A==
X-Received: by 2002:a1c:9952:: with SMTP id b79mr2824971wme.144.1603197541529;
        Tue, 20 Oct 2020 05:39:01 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id c14sm2880880wrv.12.2020.10.20.05.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:39:00 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:38:57 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/29] arm: dts: bcm5301x: Harmonize xHCI DT nodes name
Message-ID: <20201020123857.GM127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-17-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:46PM +0300, Serge Semin wrote:
> In accordance with the Generic xHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-xhci"-compatible nodes are
> correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm/boot/dts/bcm5301x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
