Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9584C293C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406560AbgJTMqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:46:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33962 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406425AbgJTMqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:46:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id k21so1106994wmi.1;
        Tue, 20 Oct 2020 05:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFgnG1vSkkyK/xq5Jk1boNhv0QfkAfDy/vvM6EOb0AY=;
        b=JVy8VE8q1+eXcT/H8lCARbBkRRtqKv5m1NMod6rNDRPPGKZL54lilSp7EGbcp2dd2g
         AkGKW3n+iwBNt66sjmXjBSsks1SztFsLyqJyAo6oN9PZ+J8PRDqTRq66j7fOPuSDFT0k
         SPnzfNXpYXEqfWvzrfM5GvP8/6UE56zZHHRpINb+LVkZvJXX3hvZhOuemkAjbHH+Rns4
         mM5/BJbK7nE8GZm6YnGxNw9nwbSzKFXXIj8IVaLShzkh4ybItlNV7DRnzk/PVm8BvTvT
         VZvn4IqDkQv56xbNBLaSimPoaqK+lgqXoeXtz7CP4EYmOIAW4Pzi6NqzS1LhBWJxdOYJ
         UMoA==
X-Gm-Message-State: AOAM532lspmgtQpEs7epepz0M0hV2jbq7kNX8LkqCAZHgaKcT5KKv7mU
        qu8nAqKHTaJJUTABM3Gkw8k=
X-Google-Smtp-Source: ABdhPJzR7mSRo+VV9fwmhBwtIWaxIafEvh7cEQ+kkSaj1XCjmEhrNlI9TkfVnE2EoMcdB3hGTRvZmA==
X-Received: by 2002:a1c:6289:: with SMTP id w131mr1908297wmb.109.1603197992217;
        Tue, 20 Oct 2020 05:46:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id 40sm3029489wrc.46.2020.10.20.05.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:46:30 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:46:28 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 05/29] arm64: dts: amlogic: meson-g12: Set FL-adj
 property value
Message-ID: <20201020124628.GY127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-6-Sergey.Semin@baikalelectronics.ru>
 <20201020123404.GC127386@kozik-lap>
 <20201020124404.by7skr6rvqrqwgbi@mobilestation.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020124404.by7skr6rvqrqwgbi@mobilestation.baikal.int>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 03:44:04PM +0300, Serge Semin wrote:
> On Tue, Oct 20, 2020 at 02:34:04PM +0200, Krzysztof Kozlowski wrote:
> > On Tue, Oct 20, 2020 at 02:59:35PM +0300, Serge Semin wrote:
> > > In accordance with the DWC USB3 bindings the property is supposed to have
> > > uint32 type. It's erroneous from the DT schema and driver points of view
> > > to declare it as boolean.
> > 
> 
> > I think the driver uses it as u32, so what do you mean by "declare" in
> > context of a driver?
> 
> I meant that both the driver and DT schema expects it to be uint32, while the
> dts has got the property as boolean, which is wrong. The same problem has
> been fixed in the Amlogic Meson-g12 DT schema example:
> https://lore.kernel.org/linux-usb/20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru/T/#m225585212162b9f5cccb1a7088850fab8792b7b3

Ah, I got it.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

