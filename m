Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17321D475A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgEOHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 03:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgEOHtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:49:22 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F35206F4;
        Fri, 15 May 2020 07:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589528961;
        bh=hiG4bQ7MQyZN5lGrfPWrCEefiCNplXpHLb+0Mi5heto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSrx2nxFwOyF8wwohGG6EF+GEC9wVTV9KUxaxf7I1c4j01NtR8LS4aTdZoqnCjei2
         HKjNRzSBsxWneTImqZkq7o8gJcKnLLvaYWHg2S5jVqQeUySRTH3xWkcAn9rpQVZGMt
         AXfFn32m+rf8kyO/7GOGYzKYK+4brCLr3vGmPKuk=
Date:   Fri, 15 May 2020 13:19:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hexdump0815@googlemail.com
Subject: Re: [PATCH v2 0/6] phy: meson8b-usb2: small fixes and improvements
Message-ID: <20200515074917.GN333670@vkoul-mobl>
References: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-20, 00:24, Martin Blumenstingl wrote:
> This is a batch of fixes and improvements for the phy-meson8b-usb2
> driver:
> - convert the existing dt-bindings to json-schema and add a fallback
>   compatible string which is already in existing .dtsi files
> - differentiate between Meson8 and Meson8m2 using a new compatible
>   string for the latter
> - simplify the code by using a MMIO regmap
> - set / unset the IDDQ and ACA enable bits depending on the operating
>   mode (and for the latter also the compatible string)
> 
> I suggest that all of these are applied to -next because we will need a
> separate .dts patch (which I already have prepared) to use the new
> Meson8m2 compatible string in meson8m2.dtsi. Otherwise we will be
> changing behavior in patch #4, because meson8m2.dtsi currently inherits
> the Meson8 compatible string.
> The number of actual Meson8 users is very small (I only know one case),
> so keeping Meson8m2 working is more important to me (because I know
> several users with boards that have a Meson8m2 SoC).

Applied all, thanks

-- 
~Vinod
