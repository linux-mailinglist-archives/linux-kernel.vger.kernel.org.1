Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E531D293BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406208AbgJTMfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:35:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38814 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406195AbgJTMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:35:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id n18so1931443wrs.5;
        Tue, 20 Oct 2020 05:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K0ziud5U7z2Be3d39hiZg1oazX3EmquJNPRbj25dtTg=;
        b=g6V0cJ6Oua1g4u25i2olzRt1GoT3WjExQ38v0s3ae2JpNhP2nb0RkiGHeWryynVaOS
         c/P3KG78/Y5KeUT0N3dnUm8+XMIjcHKboetTTQVVoOUISzoYx3Zvfm/QAtXsIxv+WvCj
         aR4o5JL2ukofrAu9OU4n2nyoDHzVberr1LDjIiK+TrbONV+8OWWCeR6LqtoEokumddb2
         rNZvC9wn2SIUXLeF5cxPJcu5oWrPE27R073meoB88Q4PWz+hYStdbjSb3ys8jBnhbClq
         BEveEmt47wpFgCf9wNzyYQG7aVmVs8pNQj5SUVcEboi2yHm0k63IJPCK9QtviE1rdXh2
         K8IQ==
X-Gm-Message-State: AOAM533qVuF7DTsr8qhE74luGHStchdRzywqnQUI6Nh4e0MoKCztiYcL
        vk1Qa7v5oGlriER5Yc+kziA=
X-Google-Smtp-Source: ABdhPJzItdVZsGvx1zFnzZFr5qmOriiBF1A5jL8niYXLbDo1Jr3pvxQ9WttgwmR+Hj9OE0w00JY/Zw==
X-Received: by 2002:adf:f246:: with SMTP id b6mr3280040wrp.111.1603197311141;
        Tue, 20 Oct 2020 05:35:11 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id a17sm3212629wra.29.2020.10.20.05.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:35:09 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:35:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH 06/29] arc: dts: Harmonize EHCI/OHCI DT nodes name
Message-ID: <20201020123506.GE127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-7-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:36PM +0300, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
> ---
>  arch/arc/boot/dts/axc003.dtsi        | 4 ++--
>  arch/arc/boot/dts/axc003_idu.dtsi    | 4 ++--
>  arch/arc/boot/dts/axs10x_mb.dtsi     | 4 ++--
>  arch/arc/boot/dts/hsdk.dts           | 4 ++--
>  arch/arc/boot/dts/vdk_axs10x_mb.dtsi | 2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
