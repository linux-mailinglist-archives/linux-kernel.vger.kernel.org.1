Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31CA1D68B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgEQPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQPvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:51:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93647C061A0C;
        Sun, 17 May 2020 08:51:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f13so6837811wmc.5;
        Sun, 17 May 2020 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Y2aFJKNUiFBLQvn2vvnEK/Ead8cU3LUw4bCLelXdS0=;
        b=UGGCy6TvvsLP2q0CxhmrvQHdIFIIbEfPAtgdI3IOIOuKhkTMRC/BC4WwPaymCW0tny
         iuA1xi7IXR+ab/Gx0dG3BMqyVmQg3Fi9qXVgYFFiVuTIAyRHolD+PSSvfjAT7fMiHAZj
         6nVTrrB4wq/zGBWaBB2eigVDmgqT/jlUuS3Q4d4L3pCviJGQ7AmJji+r28/hQCT+Qpzb
         LyygNaW6zHilFl/dki//YzSLiEU13nnIKpfjyb07vIDh9jBNsMzNlb2KHuPmWmoqqHPt
         +cHDt4W+xnFcnAzw5kDJxl5hjRkNZVI8s2trrxDWcCjhAXpW5WPXN/FXgCPGFfEx1bP4
         JirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Y2aFJKNUiFBLQvn2vvnEK/Ead8cU3LUw4bCLelXdS0=;
        b=R9IQa/P4HSmMjXJEDrkTm1sAwerEB17UNBTiIpuRoIkxFd842R6qO8uzcrWCXpr5iT
         Z5MB2aP0ciCTLtisgbQTzKaXqNbkUAKHOj6ITq4b7N6YWudDV26Jt2RgQ4CH4cn5gBFD
         RynXQh2LdCBo9GzMqqwJ/f3hkqm6FPEwquigufqRBREozDlCS8ITNAo0QPy9RCbyvX6P
         ML9WV+I4Jj2eyGKsN9kemd5ecbvt/NwkwCFomaZEeSr0aU0HUmjoY4kaO59pm8T1nh8H
         GTAHAe4kYPTcjGbaUaPyJTMDQQK7xEnWG0kL+s0KOkgNToaTLDuD/4aeWXPpSiGtXdWJ
         xaLg==
X-Gm-Message-State: AOAM53228y09W0qlrlFEtl39xPetmiomJArQkWYOUmn6l5fObNhCzh7H
        bnQUtl/WhfVnoGWXvqfuD8ST5eP0u851n0mMrXLahVaJB6c=
X-Google-Smtp-Source: ABdhPJw8gi9ZQ9b7ziDhHvd7AdBz6Ju+aZl0wFkN7BHXZ/1UxBruJsqKUGVLfoAJ0nQTpVk7cv98fXWPYNpz5Op4udc=
X-Received: by 2002:a1c:de05:: with SMTP id v5mr14097715wmg.1.1589730675709;
 Sun, 17 May 2020 08:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200409070448.3209-1-paweldembicki@gmail.com>
 <20200409070448.3209-2-paweldembicki@gmail.com> <87sgfyh9au.fsf@FE-laptop>
In-Reply-To: <87sgfyh9au.fsf@FE-laptop>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Sun, 17 May 2020 17:51:04 +0200
Message-ID: <CAJN1KkyhnG7qByXYP14ULTrUhYNbDt0AQ_Er=bnM-KymLz8bPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: kirkwood: Add Check Point L-50 board
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2020 at 17:26 Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>
> Hi Pawel Dembicki,
>

Hi Gregory,

>
> Applied on mvebu/dt. I think the first patch should be applied by the
> device tree maintainers.
>
> Thanks,
>
> Gregory
>

I sent v3 of this patch some time ago:
https://lkml.org/lkml/2020/4/22/1353

Is possible to use it instead v2?

Best Regards,
Pawel Dembicki
