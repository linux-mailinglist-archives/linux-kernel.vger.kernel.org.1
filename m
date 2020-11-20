Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3D2BA7DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKTLA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:00:58 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43046 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgKTLA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:00:58 -0500
Received: by mail-ej1-f65.google.com with SMTP id k27so12240925ejs.10;
        Fri, 20 Nov 2020 03:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nAks2XnecKIV4A3av2th6mRYw3f1mAliyxLw1+NXRko=;
        b=g4w5E1Zgwz1g9K/Qv8fF2hUfAdy6ET6pSnssthr+2SFtZn+wg87P7b2Lo+xIWbXS/e
         6x6M6xBlksARVFniz+C3xT6rKl2hv6xQA/z1/2PW1VmkC5lRnPhaj91cd6PWGfrdi+Cf
         2FHrTM1wtbVcDVWa27Fq5dtAoH9DQeYXvpJc0ABdwfq7JSmIfnJEdiDhGwlt4QFHWraF
         UHU2qlc2IUBYDGThlb8nDjj9zsCWFl18yFGR54uwPZSnbnIYQHPeM7ugbu6Q52/yxnG9
         sXsb5JlIqsDlVuczagoyN9wI4+tZtk2KUdw2ZrqpDJF1Te01dkphyiWsBzYVDwgiZA6D
         wCnQ==
X-Gm-Message-State: AOAM5316FT4IDzIs2M/EyQjxhLii2d3rUkThYiNN3Nij/3HCnjEZAvUH
        AWwA1T6uXu2Hb42x84KJwWg=
X-Google-Smtp-Source: ABdhPJz9cad0dK9v8Bzg08JoVZCRoIQ59OHWv8Et2ehlg8QViIBBflkven0dCZQqipoAFOJvZEyNMw==
X-Received: by 2002:a17:906:17d1:: with SMTP id u17mr31208004eje.229.1605870055921;
        Fri, 20 Nov 2020 03:00:55 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p20sm970666ejd.78.2020.11.20.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:00:54 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:00:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>
Subject: Re: [PATCH 1/2] phy: samsung: Add support for the Exynos5420 variant
 of the USB2 PHY
Message-ID: <20201120110051.GA26836@kozik-lap>
References: <20201120085637.7299-1-m.szyprowski@samsung.com>
 <CGME20201120085651eucas1p1d30223968745e93e6177892b400a7773@eucas1p1.samsung.com>
 <20201120085637.7299-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120085637.7299-2-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:56:36AM +0100, Marek Szyprowski wrote:
> Exynos5420 differs a bit from Exynos5250 in USB2 PHY related registers in
> the PMU region. Add a variant for the Exynos5420 case. Till now, USB2 PHY
> worked only because the bootloader enabled the PHY, but then driver messed
> USB 3.0 DRD related registers during the suspend/resume cycle.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt   |  1 +
>  drivers/phy/samsung/Kconfig                   |  7 ++-
>  drivers/phy/samsung/phy-exynos5250-usb2.c     | 48 +++++++++++++------
>  drivers/phy/samsung/phy-samsung-usb2.c        |  6 +++
>  drivers/phy/samsung/phy-samsung-usb2.h        |  1 +
>  5 files changed, 48 insertions(+), 15 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
