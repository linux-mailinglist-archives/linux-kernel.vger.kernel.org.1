Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2A2AAD2C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgKHTNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:13:49 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B76C0613CF;
        Sun,  8 Nov 2020 11:13:49 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id g19so3038770qvy.2;
        Sun, 08 Nov 2020 11:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJ5RXvo1v3VSPSSAx4s/l/urAri8Yc/qdFDKhTM4mXU=;
        b=aYFvg6Irq5jtrIZ6vQUUJmvuEWeuBCehNS7mpNbS/VR4nHLXTpGUejqBjKhLZendce
         tjhdowTYZgqsmcGQ/TLQSnB0kfEhknsnwbo3zZhohTTEHuBvtDpkdHSkRjSNl63yvCWV
         3VaoUSG06kdc7V8Q4aXbyKfC1mLKp4h4i6GJSXFCAQVAUhAoXAHc9p47ZYCRuz/3Mi6X
         7Gd9A/rnZYISkt4BLGrrKND8bhoEsF2DVh5xbYVpp4SAEbjMa/lFyug/0sFFrN31TsbT
         G8elpcXET5aZASiS5MfEoRJ4CGqKqZ7qD+sYQK4WDI03hWQywW5Is3yyWk9AgwbAsBWe
         GKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJ5RXvo1v3VSPSSAx4s/l/urAri8Yc/qdFDKhTM4mXU=;
        b=NOZtjwieasXX4s7Qt4rrSXva94eCbGrFonQLj3ENzfueUiIY575Dy271uRm+r3tC/u
         6jkOdUmELt1SeoGQW6+6gomCjarYjYWqHLAq/bY9V247wCEpkz1RnND5NQb3OxseDX2H
         GaFtGd+wvSThm5uOXwNYFkQ4D9bWIsM4Ad3Nq89/uYUgxPTWEzjT+DkIFY9ZPEmUICY3
         MYu/Xlk4Jx5NonXLDM0fOi9VP82dsLZgofMnGO9k4exleEccbzwTfwZhjAaq+zOpEgGt
         BSQbajnHSYLcDAZ9VNBHXBOIjWmScmYEgIq5HBBMogRTfbO5HlaLiGDT1vKYFBKNsO3u
         XztQ==
X-Gm-Message-State: AOAM530zENS2awpSPxvd+EdeZau98AzY4i24EXoWYCY9+5YD8h3shnlV
        CsjkNgf5KMgaj83l6Bi5piw=
X-Google-Smtp-Source: ABdhPJyKS6GIi3iMAi6Nljy8HYW4MjqxIRxgj/L3D5IlMWdof2ZTrXFFbE21QTJ97MqgBvKS+RYPrA==
X-Received: by 2002:a0c:9ad9:: with SMTP id k25mr11096613qvf.57.1604862828737;
        Sun, 08 Nov 2020 11:13:48 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id a206sm4735810qkb.64.2020.11.08.11.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 11:13:48 -0800 (PST)
Date:   Sun, 8 Nov 2020 12:13:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx: Fix imx8mm-kontron-n801x-s.dtb target
Message-ID: <20201108191346.GA4061631@ubuntu-m3-large-x86>
References: <20201108022321.2114430-1-natechancellor@gmail.com>
 <CAJKOXPdVVgRMaCPfq3nPR232KQyKVVewm5LveUSuyfqE8sScQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPdVVgRMaCPfq3nPR232KQyKVVewm5LveUSuyfqE8sScQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Nov 08, 2020 at 10:31:10AM +0100, Krzysztof Kozlowski wrote:
> On Sun, 8 Nov 2020 at 03:23, Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> Hi,
> 
> Thanks for the fixes.
> 
> Please mark patches with versions, this should be v2. Otherwise
> maintainer might apply the older one,
> You also need to add versioning changelog after ---.

I have only sent this one patch. It looks like Anders Roxell sent an
identical patch though:

https://lore.kernel.org/linux-devicetree/20201105111823.1613337-1-anders.roxell@linaro.org/

> > $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- \
> > INSTALL_DTBS_PATH=rootfs distclean defconfig dtbs dtbs_install
> 
> All this is still irrelevant. Just: "make dtbs". Don't add unrelated
> details like how many processes you spawn, where do you want to
> install DTBS or even all other make targets.
> Everyone should know how to cross compile so simple: make dtbs

Sure, I will update it, my apologies.

> > ...
> > make[3]: *** No rule to make target
> > 'rootfs/freescale/imx8mm-kontron-n801x-s.dts', needed by
> > '__dtbs_install'
> 
> This should be joined with previous line. I mentioned it in your previous patch.

Sure, I usually just let my editor do the auto wrapping but I will put
it all onto one line!

> > ...
> 
> Also not needed dots. This is small change and should go with small
> and accurate description. Blowing the description does not help.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof

Thank you for the review, I will sent v2 along shortly.

Cheers,
Nathan
