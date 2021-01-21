Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DB2FE503
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAUIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbhAUI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:29:49 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AD7C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:29:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id n8so1537728ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94ARZoLTOg3PIEqj982IupHjSVIhN+54lqPqjPiLAQg=;
        b=pbteentpmLVinNSMTJbXtQZq1Q8xKfoXfNCAsWgYw0VdswhWZj6DjqeH24HKanZxEC
         d26yPipruHvjEspqQKAhDubwmQ6/2jmAVhKA5IKoBKwuHypdBOyENAJMQqmOiE8qbXc+
         sE4Fuew7Lt3ZTq/tCWsMNclccMn7QRX/gbJAFdjnafUK52DsNBFRALInRRFwSixj8RZk
         bC92vwGGBI8tiTpcln1A2A3WeVzQV6cpFB3uHg7EKXo9hYzQFOGqbltm/FIb5Rwtc+lB
         rwVTNUO54TfclTPza4JMd5fZWA/5lI+wne5DSKVqHkdLtuzmLkDrkXY2VSNpymXARUuR
         Q3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94ARZoLTOg3PIEqj982IupHjSVIhN+54lqPqjPiLAQg=;
        b=TQePga4HBQfcDGvRH+6fAd67sbD3+IlkiEuJLlg3z86aahEyItpk/8ku3VtXa0GbK3
         PVOjJjnO9IqD8tnd/Y60CA3y7wh0wT5U+TkD4Lpwdl0p5RNVvvChPT/WuvIpJPy4/VsS
         67T7xhF32ixgs8wUQNqoKlB4EWDCFO3ZOTkdn3adqGPE0NxMAfATpJ2PAr5XXxR2Vq0s
         hNuE35z2Tq3VdU5/Ca6jN05BYzzbhREMgTfAWxetT04q5B4vYysg1UBt31TRVBBuiYSe
         Xx2C6+SGZaO/gTzVNdMf5fBL34PdFhtaauoRIZer9Y+1Ey5p9GvQ4F1Lku3g+8Rwn37R
         RmAA==
X-Gm-Message-State: AOAM533mzKm4YPsLi6nBCdilDDvko/WZ95XUJuTL7la4on70akG34EL9
        VOjjunhi5ZXO7UadFW7ZbK4hgscN7VK7VefOdzJ4AQ==
X-Google-Smtp-Source: ABdhPJzkvLjkXv7iaJcmu4t3BlaxWEHxuVyNEujNCVnRt1xCijuSHE2/rvgb7Uo7gWYYNhvsSpLWmGFsJT0i4Jm0Jj0=
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr6363598lja.200.1611217746646;
 Thu, 21 Jan 2021 00:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20210120200156.2782528-1-f.fainelli@gmail.com>
In-Reply-To: <20210120200156.2782528-1-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 09:28:56 +0100
Message-ID: <CACRpkdaaXEqQ4fg-Am1U=wAm3HwdCX77sit1ow6Z=08NWoA9uw@mail.gmail.com>
Subject: Re: [PATCH] ARM: brcmstb: Add debug UART entry for 72116
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 9:02 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> 72116 has the same memory map as 7255 and the same physical address for
> the UART, alias the definition accordingly.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
