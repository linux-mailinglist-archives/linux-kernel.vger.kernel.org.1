Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1525EDEF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 15:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgIFNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 09:11:20 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:34575 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIFNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 09:11:01 -0400
Received: by mail-ej1-f68.google.com with SMTP id gr14so13261336ejb.1;
        Sun, 06 Sep 2020 06:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBl9UMlY1oWNy/GCwLn7tQTZrUz9EDW9e61eAlkzz9s=;
        b=Mc6KJ8gYmLC8mUFWbxctHqS43aZlTIIAFCrWMyyslT1vrs2z+L6JyRywj7y/XpZGvj
         t4W5ZStfOtXLFbFo7qvUrpMR9haOD3oSp+xSQnQBhT7pBcwoASs9i2jDoNfb8m2RywVt
         PqUOnp3/UAr3cd6TXsl/aH3jpYSJ+K0xWF5vApv2g18TwUvdvTSi2TcPPi88VUBdvXxs
         tdhZO00A88ZnpwviYTh0AktDkFnwh6v92w0kaNvCnkpsJXC4HMQyJHAOJ0vLtezjA8rj
         kTltBXrKxCaVVOLa/xNWpkC0Oes8EzhnRVbUgF1xjfnuuznqRWbNy/H7wH0tFMlbJ8tH
         Orrw==
X-Gm-Message-State: AOAM5303ROZVkZKH9WazRR6pIhke3VWh1plcA19/Jz3ziDDBHTHh6zf4
        ixsoBp9n3l/3xSm8YumiFkfIzMGOxIs=
X-Google-Smtp-Source: ABdhPJwZpwu8aMycqUKtCNZy10jlArz9SO9TZiCFOz4zSvKdisadZYItdzaDjgXG8etlrzDUL+bNmg==
X-Received: by 2002:a17:906:d9da:: with SMTP id qk26mr16261105ejb.435.1599397859698;
        Sun, 06 Sep 2020 06:10:59 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id v18sm11710019edb.26.2020.09.06.06.10.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Sep 2020 06:10:58 -0700 (PDT)
Date:   Sun, 6 Sep 2020 15:10:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: exynos: Remove I2C9
 samsung,i2c-slave-addr from Exynos5250 boards
Message-ID: <20200906131056.GA12691@kozik-lap>
References: <20200902155733.20271-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902155733.20271-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:57:32PM +0200, Krzysztof Kozlowski wrote:
> The property samsung,i2c-slave-addr in I2C9 controller on Exynos5250
> Arndale and SMDK5250 boards, is not actually needed.  There is only one
> master on this bus.  It's not clear why this property was added at first
> place.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch, Marek already tested the removal so I am adding his tag.
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts  | 1 -

Applied both.

Best regards,
Krzysztof

