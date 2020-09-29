Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC19C27CF36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgI2NcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgI2NcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:32:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7F6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:32:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so5529129lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiP2xLvE7su3A/3FbohxFPRtFwP7RAJmpP6Gapqry4I=;
        b=RBYVwF6a/VEJ2emfv0iKSm7f03uWBll6TI/Ihmggul87n6xJXwZu0n25FdDz6QgJcz
         BdJzD78O/nSe3aEKvFAv9aDtxHulrnUh4tx+o7zrlORi4FDh2Uvj4kP4oq2aYkGVIXmn
         7W1AF+8lTv09LNYvpoStdzCVsF3Qwjd5Il+4zRmHWAHSI3LNtiyK/DUttJ3Rp225401b
         9Sf0HAHsObntboFoCKqQlkw3oiowAFbwbEI9qKtf2D2Ol11N/TpjXu+o2bDSquAPLPq8
         Up2XdmkjZyKTqYeagrotyOF15pqeKXcLoc2P7gyx7VSa2kG4TLD1FsdO+eu3b4BVf/gK
         ktzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiP2xLvE7su3A/3FbohxFPRtFwP7RAJmpP6Gapqry4I=;
        b=NdQ0Q+uCsJEdoYMJz7vZEMUhUpcEw6Qs1YUVzQoj0gw0qMlWVEdITejIQYR044xuDN
         UU/TVYhUOL14tz3SKzf1bV/9D6GIXAo5Tkf4OXrzL/ZN8AL8tRtRXOe1B0ROBljF0+U8
         6xWdNegJECYgIH9iF3R21kTuME9luvhyXUvh8JMLiruiObGr5+Ir3tyuwPfQq14qRNP6
         pkZr9/MUxL/pdyfRTGyaK2e93KynndMzzASjyIHISNh0bU0PzluCT/p1/z4WhN8NBLu6
         7WTu6MJpI0pbTKPLYi8tym4Y0QEpu6cFw7Qp3N01bov1KtOmHtIm9X/cEk0SVLFqvuxD
         qvtg==
X-Gm-Message-State: AOAM530iL2ZVEkkTbeNfbex1DA/EBKSNMjxkxnVgt8wg5CGAZDF9xHbO
        ilSXS54XuciQ/zKypQ0H+zVGaxeqay32BZebTrv/oQ==
X-Google-Smtp-Source: ABdhPJxV6tzl4CoUKZUPVH5Q+lX2c9SMwKjF0vOjrfiQ6kGvPMd7WkrS3uyRYrORNbOEQpj+B7cXluO4Pny91ZJTCI8=
X-Received: by 2002:a19:1c8:: with SMTP id 191mr1146645lfb.585.1601386336170;
 Tue, 29 Sep 2020 06:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200922164159.120920-1-gch981213@gmail.com>
In-Reply-To: <20200922164159.120920-1-gch981213@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 15:32:05 +0200
Message-ID: <CACRpkdbL+d5cwNAk9YA8oMN27b9dzH3tkReh3yiuBmPeAJu3-w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: mt7622: add antsel pins/groups
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 6:42 PM Chuanhong Guo <gch981213@gmail.com> wrote:

> These pins are named ANTSEL[0~29] in datasheet and are used by wmac for
> various functions.
>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Not much replies from the MTK maintainers recently, so patch
applied.

Yours,
Linus Walleij
