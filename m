Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9526CB77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgIPU2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:28:11 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55670 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgIPRYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:24:18 -0400
Received: by mail-wm1-f49.google.com with SMTP id d4so3525616wmd.5;
        Wed, 16 Sep 2020 10:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=noOG7iKE5pa5+3YZdeRDrD4tO2/FQ7kbCWqQmQ5S6uY=;
        b=ElJz4y9RLbuiR954qXp+a72LW86nangN09/JeJzcTS5afy9DC3gwwwVx7PX/2GPwcf
         PtITg//M8FeNktx0Ho35OfL3tubZXs1FHnyDAzWeU+yoP8TIgNyDPpcr4zpvj2EVZdP8
         ghfj2dRM2r787KCYYujjuUEplXqEhTuvrj582lUoA1tgzFUwQ0SLQ0WwqdwAZatvPhE6
         y9+nUJSl8FyqWrnUAgGGDSF2FtJyCuYGHjFXbA2/njrGpk+ytgSCXhFjNJKCJkNXW0Fc
         UnM502hb14ZKfsXVchKlnsR4T54WyPLCaecMYUprPLX4talrea3OiJofxD6it+EQc7Rk
         lBuA==
X-Gm-Message-State: AOAM530pt6WansIsPHoX7uTrjy0Al8E9rn5h8mJxKDKtSrG7I2rx9rDr
        +f6/nqcQ92AiszYpiofTvh2lswxk5QuEmVqb
X-Google-Smtp-Source: ABdhPJyCVt6x7GbhkhXsna2T6JCs+t6G7plC2nLF+9+Y8stFEV5cmWuGlKE2ssBPhgwlHWqMHlG10Q==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr5767868wme.18.1600276630256;
        Wed, 16 Sep 2020 10:17:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id a17sm36932683wra.24.2020.09.16.10.17.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 10:17:09 -0700 (PDT)
Date:   Wed, 16 Sep 2020 19:17:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFT 22/25] ARM: dts: s5pv210: replace deprecated "gpios"
 i2c-gpio property in Aquila
Message-ID: <20200916171706.GG19427@kozik-lap>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-23-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-23-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:38PM +0200, Krzysztof Kozlowski wrote:
> "gpios" property is deprecated.  Update the Aquila DTS to fix
> dtbs_checks warnings like:
> 
>   i2c-pmic: 'sda-gpios' is a required property
>   i2c-pmic: 'scl-gpios' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-aquila.dts | 4 ++--

Applied.

Best regards,
Krzysztof

