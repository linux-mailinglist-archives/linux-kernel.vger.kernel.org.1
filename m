Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420121C4D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 07:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEEFG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 01:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEFG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 01:06:26 -0400
Received: from localhost (unknown [171.61.99.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD0A2206E6;
        Tue,  5 May 2020 05:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588655185;
        bh=e8VuXUN/uzQjDtcEKXPbNGAiXnGLHtDXeImNxpzII78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YB6AmbTa38GjMc7eliqreZ+dpQzlNmREktrgqMMyF+yMZbRhh6FVKFQrGsMR6yhzz
         KfgOtZEgzTbQM5+VCXglPTXTEvBrWAKJwrYTuuUuQhQPuS/sgyIk5S2+qL4EWR1zEB
         jSAPb5EhR65ZKTu8+6zgki6eksV7C0REvhS5p9SY=
Date:   Tue, 5 May 2020 10:36:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     hex dump <hexdump0815@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kishon@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: phy: meson8b-usb2: Convert to
 json-schema
Message-ID: <20200505050621.GU1375924@vkoul-mobl>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
 <20200502114752.1048500-2-martin.blumenstingl@googlemail.com>
 <CAKTihDVy6oSuQe4eP87hWO17tBu3=XZ-PM41YOqLVOtXJ8+YeQ@mail.gmail.com>
 <28790ee42242ecc0b0050943a27f569dd1aeec16.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28790ee42242ecc0b0050943a27f569dd1aeec16.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-20, 10:31, Joe Perches wrote:
> On Mon, 2020-05-04 at 12:55 +0200, hex dump wrote:
> > On Sat, May 2, 2020 at 1:48 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > > Now that we have the DT validation in place, let's convert the device
> > > tree bindings for the Amlogic Meson8, Meson8b, Meson8m2 and GXBB USB2
> > > PHY over to a YAML schema.
> > > 
> > > While here, also add the fallback compatible string
> > > "amlogic,meson-gxbb-usb2-phy" which is already used in
> > > arch/arm/boot/dts/meson{,8,8b}.dtsi.
> > > 
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > 
> > Tested-by: hexdump <hexdump0815@googlemail.com>
> 
> Is the kernel now accepting "Tested-by" lines from robots?

Should we not? bots have been given Reported-by...
> 
> If hexdump0815@googlemail.com is not a robot, can you please use
> your full legal name instead?

Looking at emails, this doesnt seem a bot, so I am asking for full legal
name for these to be added.

Thanks
-- 
~Vinod
