Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F04293BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406189AbgJTMex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:34:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38767 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406178AbgJTMew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:34:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id n18so1930038wrs.5;
        Tue, 20 Oct 2020 05:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EzhYPUdwTpekJ2zsw7haamkzlXbtKEq69o4o4bB7xkI=;
        b=ernRjXKlFQuucIV9bVH08TbjAHwpKcMZRLEoDb5sMnAZmMjXXWqGm2jS6iZzLv7q+L
         r00xhRwBV+a1lL5LgmUb/tF4n1Mty2djk0REYZu4iKz7s60Zj9zLzZ+4E0YRZ78FuOd1
         uRXCY2RU107KWOyJ+m7Pvdx755b+ReZyV4HIZxs3jzFAUJFoWGIdiSUlPQSgp8WDHoLB
         FAujKMDf8p1x8CVLrbfcrsZVpNcuXIELzJ7YTYoaBke3sv9p0V6V3/j5PCv4OdxXM7xo
         rN1Eryct7qP23j8OGtsKU2tlHV7hHosxC6xvJqZHserdhprHfQ/lLFrR5V/iZW/SfjBu
         rMIw==
X-Gm-Message-State: AOAM532VL7bVCCttaRep04HMp/9Mx9nRdh3RgNJWGKT6ZW+kybrkKmTf
        ruQJWcfN5WYdmYdRZ0cgVjw=
X-Google-Smtp-Source: ABdhPJzWCzcMNSO3BE4qxJu4ChjhMCwjDA39L1oCuXq1p8BjmT82IBBFy3kZTwCSqqH2MyFmJnuajQ==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr3178316wrt.137.1603197289250;
        Tue, 20 Oct 2020 05:34:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id s2sm2724354wmf.45.2020.10.20.05.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:34:48 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:34:46 +0200
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
Subject: Re: [PATCH 07/29] arm: dts: bcm53x: Harmonize EHCI/OHCI DT nodes name
Message-ID: <20201020123446.GD127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-8-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:37PM +0300, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/bcm5301x.dtsi | 4 ++--
>  arch/arm/boot/dts/bcm53573.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
