Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930F7285A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgJGIdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJGIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:33:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBFC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 01:33:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i2so1126119ljg.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 01:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxByRzXtS14P4/kqXsVlalifhyVtmDWn1V/36Wva2yE=;
        b=zlkXAH7C+iLOICHOA8Pq+0jVGANDe3vr5yJxegEhyP9GdzD5Ro+DCLbvPEYzV9sXBV
         /2s8dUQa0i7Ctd5fV2h236vgbZzuI4gYBaNhs36z0Sl6ytH5y7kQ7XCDJnjJA6C3NS9y
         7EnnC85Ao0BTyqqyh5W2iy12XQ+uf/4ftN4Xt2x93y/eVG9jivjPnkUUD38bRb4HL4Ss
         l4cHCTq6BXq91NwKjXPPOpt5EwvbZxDFhXFz45rdtQe08/cONAesVyvwvRdNHczv0t/c
         oVS+Cj6qES4lDsBQsgpD6RTypDAZVbyjbOzaW85ZcHLvvdBRyrAjJBRhUdWTj1my/SwQ
         fIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxByRzXtS14P4/kqXsVlalifhyVtmDWn1V/36Wva2yE=;
        b=K0M15BNGoaK44h/iTeKls2bQqavncNg3AodRLV4khB0MT2+Qz/rgdDzi1oxDRoob5Z
         ktNKiFAwIn3QxRXsUq05LbsxspC9mDukJSA+nbWy3v5EZQ6ufBbpoD+XZM6Gi2RM6qPK
         4su5kwEK7Z5oL5UCt7K90Tv8rQuUjMHrf1ONpLrSwM3hUipKwPps39iskRxOlz9auwGL
         J8CBsFZUFomuqiW03Dvr7wfpHuiwyZxVNldvW5X/qGzCGIEImed0umWHF1DQ2uSL3AW9
         rYZyVk2ma2AxNnlBILyVIAhu1AUWqFvPLACNUrvxYvY24P4oKQXGfSvchZj8t5XflSTl
         k6BA==
X-Gm-Message-State: AOAM532e7u+OI1GGsU5vZ0H+gaUUKXQgOw1gG4JJmubm2zoNpvTn5Ob3
        sIdT0APSj5z0khAoHn/LMpOsNX9kYz48mbrLwi3H3Q==
X-Google-Smtp-Source: ABdhPJxRwSM+vB7wFf7q0lCzYpkrH6QvTnRgE3TO454T8PFfp63JkFd5ISVqjKk0EWNZk8om1x7APCPRrmErvWxIPaY=
X-Received: by 2002:a2e:3311:: with SMTP id d17mr830847ljc.293.1602059593872;
 Wed, 07 Oct 2020 01:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201001142511.3560143-1-enric.balletbo@collabora.com>
In-Reply-To: <20201001142511.3560143-1-enric.balletbo@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Oct 2020 10:33:02 +0200
Message-ID: <CACRpkdZ=WangdT-RA1qCO4BaN64dVhOcODrubPtk5b0C8cGaVQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: mediatek: Free eint data on failure
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>, hsinyi@chromium.org,
        Sean Wang <sean.wang@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 4:25 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:

> The pinctrl driver can work without the EINT resource, but, if it is
> expected to have this resource but the mtk_build_eint() function fails
> after allocating their data (because can't get the resource or can't map
> the irq), the data is not freed and you end with a NULL pointer
> dereference. Fix this by freeing the data if mtk_build_eint() fails, so
> pinctrl still works and doesn't hang.

Patch applied after rebasing it. It wasn't entirely trivial so
check the result.

This will not apply on elder kernels and is now targeted for
v5.10. Fixes for v5.9 and stable will have to be backported once this
is upstream.

Yours,
Linus Walleij
