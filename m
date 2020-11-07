Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E690F2AA54B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 14:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgKGNTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 08:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 08:19:23 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C9C0613CF;
        Sat,  7 Nov 2020 05:19:21 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id s24so4724958ioj.13;
        Sat, 07 Nov 2020 05:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUw/7enXuMl2kWAmoeO/sxFNNch7inlsIVrh4QZRQgY=;
        b=oKhkwPyzVZJmGs9VbwIW5hwtC3ptSw7PD8obL7zda9VwS0ak8ceQTZtUoCgDg0EDHm
         8J2wLWl+KwZpI2CDcQu2ZE7cElRhnXRO9Ulb/85K9sgSjjVmTlaX9QfjgSOly4FQCBEz
         HuhCN+Uvnz96tMz4LGGWg2YDZd3VeGrNt9G7QBi6spnDrNaxoyEmZJ6djYJhvV0eLTgj
         S89sOTFkVILYGmST2F4VOO38p+zS0aE6fxbl3c28GELqsWWItIyIbF6dNXuoeaCK6Gpj
         8JdJFshM9jpQfdPzsQ9coWkDCxy3J6DW8DzZ3qWolodx9B0HBtls1F7nQXpXSqFTBNic
         EcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUw/7enXuMl2kWAmoeO/sxFNNch7inlsIVrh4QZRQgY=;
        b=qQgJegJ4EFFx3gQbogtAvpKX1COFPNjOdXK9a2YpIHFLrJCsVGqXwDSZZdTDbWUrSV
         WCq8cjzAelaC4Vovx16VxmJpOj+pBpukMf6uhXIlG4mY7VLLEDj0tnq+dUTW3gJPPmVz
         gGuSbMY4Bmuk2tefM627fycqTa5EaY7rfocRlcjdfvfvIcS6BJllNIatcgUjQz/3YROX
         g5chS83cCX3Eb3E1/ePyHI5vC49EBv2lljg2VEEefg4/rZLP4sLISaEEPauX2vmaGdq7
         /iFJF8lbHR+1YjYYwbxbd5lD0SpdQYMCHIXYJiNCBfdtlPrbkaC8Gz/43qVqMimObxqD
         3Vog==
X-Gm-Message-State: AOAM531Wm0WHgG296goJ3kw9+ClQCvAPiq9+10At//gU2s5xCuU/Prrs
        IORtqWhoZfSawukMp4RxKmkvkhVXpPB/UusapZc=
X-Google-Smtp-Source: ABdhPJxwgS18ebarGHux91ApcaZoHzIl9I5BmeRqhhS+P8Cq38HHs0uBSRHXJVE8OSIbNvycVcvgEBthoSKEVcvyTZU=
X-Received: by 2002:a5d:8487:: with SMTP id t7mr4781739iom.35.1604755159436;
 Sat, 07 Nov 2020 05:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20201107123334.1868360-1-aford173@gmail.com> <20201107123334.1868360-2-aford173@gmail.com>
 <20201107131201.GB4761@kozik-lap>
In-Reply-To: <20201107131201.GB4761@kozik-lap>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 7 Nov 2020 07:19:08 -0600
Message-ID: <CAHCN7xJGR5kkweKGt+ncZCupW0vtbHMxH7LB2Oqq3zUw0n5f1Q@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] arm64: dts: imx: Add Beacon i.MX8M Nano
 development kit
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 7, 2020 at 7:12 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Nov 07, 2020 at 06:33:32AM -0600, Adam Ford wrote:
> > Beacon Embeddedworks is launching a development kit based on the
> > i.MX8M Nano SoC.  The kit consists of a System on Module (SOM)
> > + baseboard.  The SOM has the SoC, eMMC, and Ethernet. The baseboard
> > has an wm8962 audio CODEC, a PDM microphone, and a single USB OTG.
> >
> > The baseboard is capable of two different, mutually exclusive video
> > outputs, so the common items are in the baseboard file.  When
> > the video becomes available, LVDS output will be added to this kit
> > file, and a second kit file will be added to support HDMI.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> > V3:  Correct name
>
> I don't think you corrected the name. It's still there.

Ugh.  One more time.  :-(
Sorry for the noise.

adam
>
> Best regards,
> Krzysztof
