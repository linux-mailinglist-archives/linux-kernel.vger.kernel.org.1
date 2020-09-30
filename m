Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C413427E569
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgI3JmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3JmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:42:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BFCC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:42:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u8so1353949lff.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNSx/XGWGsZi8+BpkDocBySvQFjLD1m5m8MaE/Ga7Zo=;
        b=cNEqP8uB66rMFsMmvN5GLINNhxGb01ntU6bg1O1RPiHcbjPrzUnV5CPLlvR4SB82AZ
         HVJCYmW/KKS75oMq7xYpAlyYgsglQyiwk6KVrlgqRp58eRqTNCP/T2CG4iRpUu/QcR/q
         bC5xA3JqyHaWe2imvP9S5FfWpwGAsX0zZejbU3/P8i1dPHfEUg+zhv68mGFHvnZIKv2C
         /64CR53om1R8U2DK2Rel+X5fj0WN4xwH1B2p8kPTQ1JTOAMj1u2sHe8x0UvyFRifL6/Z
         ZHtS+7+L7e+m4tFiTggU9pU5TsIxCNgLnLdxCHBReX/VgJvIleANP1dUy5WBDtcz/SH8
         saEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNSx/XGWGsZi8+BpkDocBySvQFjLD1m5m8MaE/Ga7Zo=;
        b=uDzhGzz9Lq1qzeumjs4ndxc8dUgYleXnyL13DQXo7UQRdaVOGYYuDdOu46LnfKs3jS
         /TTx7XNY0fQ1qhjzemGS0mc6cvmY9Gc8jDyWStrgqL64crtbpl1z+WvVMKtbfbSFB4am
         8NbGrLhUW9UNLi3J0Zf/67bchDcI+gow3RU0xNc2Sr8KS7j1ulaXYAAgzu6KnKnIBBdh
         pt3VIQIbOM66nL3R/8XXXuvRnbe+5rQYnT7yx4aks6g3Si4RzfM4dCcmq1+NE++TnMoR
         ogKmNAHI1Rw5HnZopBCTj9UHLOUhJEZ0szFFjRP5MSfH3x/ghlqa9oSfnUdHrFyfOT7R
         2Nag==
X-Gm-Message-State: AOAM530/YjZ9qKPTVqkDZTHfXSdszW3+TfAdA50GcmsEs1QJ8TZatACF
        v/YB4hnqiMkKt9NgWcUCcYu352jBqTkhlROgo8il3w==
X-Google-Smtp-Source: ABdhPJxxtR0OPGYVEO1/7vb7kbnBXMD+I/paJu6HkGuuGtYNqVTKZ9EOf7zEQWvfDhiN8YGLPygK/y8wp8RbQmBti50=
X-Received: by 2002:a19:7e92:: with SMTP id z140mr606891lfc.299.1601458931956;
 Wed, 30 Sep 2020 02:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200919200836.3218536-1-drew@beagleboard.org>
In-Reply-To: <20200919200836.3218536-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 11:42:00 +0200
Message-ID: <CACRpkdaA7uz+6307BAK91nLWF2qRVSQSkYs2MKjHCqDpDsXHPg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: document pinctrl-single,pins when
 #pinctrl-cells = 2
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Christina Quast <cquast@hanoverdisplays.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 10:10 PM Drew Fustini <drew@beagleboard.org> wrote:

> Document the values in pinctrl-single,pins when #pinctrl-cells = <2>
>
> Fixes: 27c90e5e48d0 ("ARM: dts: am33xx-l4: change #pinctrl-cells from 1 to 2")
> Reported-by: Trent Piepho <tpiepho@gmail.com>
> Link: https://lore.kernel.org/linux-omap/3139716.CMS8C0sQ7x@zen.local/
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> v2 change:
> - rephrase to make it clear that the pin conf value and pin mux value
>   are OR'd together with #pinctrl-cells = <2>

Patch applied with the ACKs.

Thanks for fixing this!

Yours,
Linus Walleij
