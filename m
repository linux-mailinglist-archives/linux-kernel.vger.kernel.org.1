Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B4F293BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406271AbgJTMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:36:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35300 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406260AbgJTMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:36:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so1944349wrq.2;
        Tue, 20 Oct 2020 05:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9E0XaHJUUaHIVQQLhbSv3W1m5lGWB1Z81RRGTj8SQgM=;
        b=rUH7C2NZ2uU2dtgX9YV4Eu6qyoooWj9keN9pWr2OT02052aPPOIHntjF4NVoUWHqeJ
         X7je8G8Mbhjg10b6SjnlfR4JXCuU50KlirTODdh+kD6XhWHrJDrPmpLoORib4ntXDGVK
         HwPETxAUzOV8M07ycewlRq0g094uRILioLS9ZOJ7thiSw2e5vSVarwGkp5qYHuLSnvm3
         hdxvYbtcB4muh2ZzF09rmlYrLxS6lKRD0Qb9DhnjR60kL8i58rdSCOYGmrERzosWlvb4
         taPlGeTDa+ST5ZgH8XrkUn+KJ2QrU/YPY/oMcfT867iKklrWYtJBWvLczHHxpaUcucir
         mprg==
X-Gm-Message-State: AOAM533UaNCyejI4/GRUYKQwc26/4nJgzJeP8Lc2XAWIlRn0Zm/H+Mbu
        h93e8jUrRv8IK+DQXL7gP8Q=
X-Google-Smtp-Source: ABdhPJySQ2bYIDKMxXNWGonvrg3VtWnutiZTJnpOXBv/JS//TqwJoxFk96jUN1VTZB5rWPOp0nDu/Q==
X-Received: by 2002:adf:9282:: with SMTP id 2mr3198032wrn.43.1603197379879;
        Tue, 20 Oct 2020 05:36:19 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id u133sm1037094wmb.6.2020.10.20.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:36:18 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:36:16 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 08/29] arm: dts: stm32: Harmonize EHCI/OHCI DT nodes name
Message-ID: <20201020123616.GF127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-9-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:38PM +0300, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
