Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA282DFBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 13:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgLUMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 07:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 07:18:54 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA8C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 04:18:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 23so23088474lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 04:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8GIUvdJake4G0GbpUdw/v3KT65N1Elydx4DG8uLLNg=;
        b=V3ZMo0kMWdDIcf3Iv2YamlGAnGCuRo3sVmr7FZHRBuGjiktTMjkUwo7zFejIH7snuV
         QpnD9Sl4gm533GK7LJT6Lb3mrbkZokjzFxZ9py3RPoYyYSeR7Eqe+KUATwtkznF2dj/U
         qL87l2ukiiYLc1G5dXbDn7egjWw4QLUK1FYTPZys8Rm1XGEaNV46BUI/eY1P29S1KPsr
         LSL5MGZw1fsIPkiM3ge6vFElLb7pDaa7tYAg9KPV+qM0mFRgacyM6z2YpYv4lPRBcwdX
         om7NELMGAXed+sT2CpRKRXrUmI0m6uXQsdgdg/RLLRSyJ/L2gYVfkgnfV69S/doZL73z
         dWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8GIUvdJake4G0GbpUdw/v3KT65N1Elydx4DG8uLLNg=;
        b=jOHB36UrmgTy0sAWtTWn4AzzegvWjsw7XuSrlS1uz/hHpX2h+iId5ToQ07y6e3e2MX
         9P++K4R52TKujak37XZIQ/qKwGke5AC6z8Ti9u+ryaYNI1mdXrpbPWmvDxkQmOUhgC6o
         t3yUtG4y/MQ0se/C4zW0scjwpJjqA94bz1BHZ5L7yBEin4NZGmumylsXHaAIGt4wh/fR
         w4lIUaXXwYSgrQdtEZ9LUHpqgQRKUUBiFGu2Hvvv116v2h1wwTBm0fS1cqzUIS4RO2O5
         1MNq/9vGLHsRbREIIXvAOAkcyFBN+5XQXm4Gf8s1MoaU92PUtNStYhfx9kgg/6gXYr+V
         MQBw==
X-Gm-Message-State: AOAM533y7FNRxx/3LMny9SY7Nuk5IIyv8Zs33dhJpbkFgngKo3pvqPFV
        mDDanIIpLUvkZM45mziQzntNRRVgI3G5aYsO53SZuQ==
X-Google-Smtp-Source: ABdhPJwXr8Ac1/MblhevY4EuqX5/WUbMyfBZcQPEfvIJ4Y7jJa8HNHbpGR5pVhHUzmNVnt6LztIOkFhlusozSAe2Dg8=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr6964671ljl.467.1608553092185;
 Mon, 21 Dec 2020 04:18:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <f538c21de556c66390614bad778f7dc095222e8c.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201216101000.GD207743@dell> <20201217231731.GA104305@BV030612LT>
 <20201218132139.GR207743@dell> <20201218160710.GA134686@BV030612LT>
 <20201221081015.GA4825@dell> <20201221115713.GA155203@BV030612LT>
In-Reply-To: <20201221115713.GA155203@BV030612LT>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Dec 2020 13:18:01 +0100
Message-ID: <CACRpkdau=KfOeP5gM2bfLaAEa4U_GrCA=kNR0P6H5_Eov6B25g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mfd: Add MFD driver for ATC260x PMICs
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:59 PM Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:

> enum atc260x_ver {
>         ATC260X_A = 0,
>         ATC260X_B,
>         ATC260X_C,
>         ATC260X_D,
>         ATC260X_E,
>         ATC260X_F,
>         ATC260X_G,
>         ATC260X_H,
> };

This makes it look like the driver is actually so generic that it makes space
for all revisions back to ATC2603A which is in the Ainol Hero 10 tablet.

This is nice because there are millions of these devices (especially in
China) that people want to get to run the latest Linux.

I even wonder how much different the ATM7029 is from S500, I suspect
not super much apart from the ARM cores.

Good work overall! I'll be happy to deal with the GPIO
driver when you get there.

Yours,
Linus Walleij
