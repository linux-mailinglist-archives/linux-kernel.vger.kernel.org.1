Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7162DB4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgLOUU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgLOUUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:20:52 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EC5C0611C5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:20:10 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id h19so15610934qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8ZGaSrR1BfUaJWas0Ys/1ejHT5BAdJYhFIQ4DVbHAQ=;
        b=WOekxWNcUDXH9d0xrrNdLIwgr7eTQf2BjBlxs1cY86mrh0cFUT3XozUrtugVygXSLh
         Paj7cDEFmqMmR2z6CGhKwYhnEJmUiBGWwfGT6p4jo5N4NTi2+cSod6rd057GBgyDhraH
         iI0cbCVcvWhFAYMKnmDDfjK4ZErypAxxJAGiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8ZGaSrR1BfUaJWas0Ys/1ejHT5BAdJYhFIQ4DVbHAQ=;
        b=dmEuY79Z7BUVhFqowcJsVv2u8QCbG0Dviv9I+cm7IypDrEYfPwd51ErkpRSvXY6XJe
         3yy8FhJ7RmzHx+1XR79gZc8HmOQo4xi4sZysD/Z/0jggTuR1/rJL/IMcZe089CZFTeGF
         lVFoPctwbaoM2vtCUxdCBSbNwDLyvmn4+Qmbk4HXFXlbqdQQCP5o8v5F+1HvWDeKrfiQ
         TpIpNvG/w9NXAUnbmQDzhfTV4doWLirs4VwsU2SGb6VV7FRL5CXbRNjZqj0l6zn8EqvE
         1sktUqJmTh8KUxU+26hIKiLaBs0qw06H0aniWwLgJHafTDcv+sTWs02U07kOf/PJ8s6y
         l45A==
X-Gm-Message-State: AOAM532XgwpygYk9g1XmOfO3su0wsiS05lXVC1KrHGIiSf0hnZh8VaZd
        3I3dOMD6rdvZiF3oKnU3mLyA0U9goST8p+lqbkuTuA==
X-Google-Smtp-Source: ABdhPJzOQqCtqr//vCV3NGWMhK5oN0kSJ7tiYFivZcl/0pwk6gVVGudHENRuV1PRjXQBhBjsLwynmU2D/ny3cDrLPh8=
X-Received: by 2002:ac8:1386:: with SMTP id h6mr39463029qtj.95.1608063609754;
 Tue, 15 Dec 2020 12:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20201215132024.13356-1-broonie@kernel.org>
In-Reply-To: <20201215132024.13356-1-broonie@kernel.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 16 Dec 2020 01:49:58 +0530
Message-ID: <CAMty3ZDBWAJG3cPYnYtZY4ReOEO6iF5gscs+BLJEQ5WftawmQw@mail.gmail.com>
Subject: Re: [PATCH] regulator: pf8x00: Use specific compatible strings for devices
To:     Mark Brown <broonie@kernel.org>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 6:50 PM Mark Brown <broonie@kernel.org> wrote:
>
> The pf8x00 driver supports three devices, the DT compatible strings
> and I2C IDs should enumerate these specifically rather than using a
> wildcard so that we don't collide with anything incompatible in the
> same ID range in the future and so that we can handle any software
> visible differences between the variants we find.

Thanks for the patch.

>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  .../bindings/regulator/nxp,pf8x00-regulator.yaml          | 6 ++++--
>  drivers/regulator/pf8x00-regulator.c                      | 8 ++++++--

I think the bindings patch would be separate? otherwise,

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
