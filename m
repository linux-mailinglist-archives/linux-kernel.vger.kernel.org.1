Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0E2D3DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgLIInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgLIInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:43:16 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22276C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 00:42:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a12so2000305lfl.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 00:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFJqflg3adJFeN3Kytku+xyfIdshoH7ILfDIx/FbTe0=;
        b=p/fwR9lHVyHy6dWZd9GfVwh5Yoij+ymPwnY8f20sRhR6JWzC3bQSEZPxE/FnhG8V6+
         JXHBcJoi8O+mV2tBXLCDbKWRMuoTqzqURwhl53ZY7vzgmoyPkdxcOQZzR2uZy2Gwfkb5
         mQ2diz9Kig4I59jEUPhB1nVWTepPhTVfg4jBS5D/thmo/bJoHRt3oPvxJn3oh1LIMS0D
         rk7HvgL+D69hAJlSRjZvVNcuA4rW7OShkg+w3th48spb3wj9RIjYRkD6rfrI+zDL0C4a
         5ut5LOjeX14b1XhbhG3yA/zt7OGBv8qepFMdsCXbFRmT22k7x1lR4iDNp0G1AZ2KTw2j
         UwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFJqflg3adJFeN3Kytku+xyfIdshoH7ILfDIx/FbTe0=;
        b=GH70/3icCxL8mPe5XfMZQ1vKYtZ+23z1R4Gy1mtzzA4CMXqr000nHwCRITMZEcFbtE
         ArBu3c5l/Kj3BU9LHitREMGmklsj8iIEEzTMsuNI5Zr8/w4MXQkfwKVIMFElYeGxG/EY
         IHXCJFlcgWAaWWB/Ao7ODpPEf3SCA3NFW1mxEbK/GfLzu39EY7uVXMmBZf6jDkjdVc01
         fUVuqrG2/yjuWa/3dGSaFoLi0VZDjx7GfOiNMct3QZzTmjZU48UjIBfB1lOPRuyAEfCi
         UFoOblde9U1/uSyeZQSa3mDYEQ+uARzS6JzeWCd9o3SJe5AX2jMRONLBlWANJXh7KTWu
         1Hww==
X-Gm-Message-State: AOAM533Lrn4La604SDalZog58XDiZVTU40SUoHftl/jocYEmbnuR5QxY
        Nb6Halw4PKp4Ygv6ByWvaWnOBgqFF/0koFpT/BCF4Q==
X-Google-Smtp-Source: ABdhPJwFUsAoeMA8DaIqBEoEmSKEcEAz8QCn4SxhYXfB8gtURU7134qDvZyePL4+HrhnLZyfcmBazAkL6BQAK0vfcWw=
X-Received: by 2002:a19:8384:: with SMTP id f126mr600240lfd.649.1607503354685;
 Wed, 09 Dec 2020 00:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20201209055106.840100-1-zhang.lyra@gmail.com>
In-Reply-To: <20201209055106.840100-1-zhang.lyra@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Dec 2020 09:42:23 +0100
Message-ID: <CACRpkdZptM_n00mirKDkmJn5e+h4HdUrKAG8x6onep00bSegSQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: eic-sprd: break loop when getting NULL device resource
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 6:51 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:

> EIC controller have unfixed numbers of banks on different Spreadtrum SoCs,
> and each bank has its own base address, the loop of getting there base
> address in driver should break if the resource gotten via
> platform_get_resource() is NULL already. The later ones would be all NULL
> even if the loop continues.
>
> Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Patch applied for fixes!

Yours,
Linus Walleij
