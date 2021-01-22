Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912DE300403
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbhAVNUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbhAVNUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:20:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851D1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:19:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a8so7474312lfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hv8fAqotf/e/86aGAMKjDJpUZge+GjX7fvkC+0Ap6w4=;
        b=hAWzGtiCuspzhiOlOZbxkrrxE5+KHD+JugOHPkukc3HV9Tlgrz8gUyvM2ptxd/HL3L
         cHqGhE9fNB2FA3EgrJllReFLu+dZBnUPsPUdnWASi4bdgd5MH2+H41pq+FHQnGksH3P7
         8uY+mPRc69cuPlStb2SBkbBrbh7SgKi1lcpwaBlubykOHKvJ5VWVJ2XKfoxIdoflqLMS
         q5t/sMegcuqP+lnzMTVyUg6SxEUxZ1A+2hJqORSlsnaPfYhkrFsm9civoTsVt4egy90L
         sXnDnplopMoMXk1CDRGHXgD0zB7AnbsEgV8aMjA4UV0QXn8zx6zIFf6CbcSsi0D0nmP4
         jxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hv8fAqotf/e/86aGAMKjDJpUZge+GjX7fvkC+0Ap6w4=;
        b=qah7G6Ynt+DkZqI+1w8V7SdA7/SzZjxeUKO3Io4NoKsRN1QDYUB0ANKhKQK2X+9HDs
         dhEOFr0II+DCKzhZ22Z0fp1NaMIpjZ8yjEbLTU73gBpND13XX1ughpSMSnEvl9WwrNcO
         oFdiOiH9g6CDLuMi0z6brkOKRNNRhB3CKVB3CX8/5L07ybpfn6PHU6Zv89QH0R5teLFn
         4p5bSPN7MAdcol/DM+aKsOfXm2XO7mgSbeAtLTE5B/Iwh9P7fNd7Qti7xK5kKv6c68Dg
         kFkl6+bY0+GxtH1MygOsPS38uu6vrGw3tbPy5b3Qy4wwoBp3EZr4/QrKLAN2Hw3idMN/
         jbqw==
X-Gm-Message-State: AOAM5335cCDfTjmXapWLcx5DNVDvmqwfcc/x9PryCaRPR24paCGlC78F
        hNQz7O0UB3Kno89jNbDfqXjkwUjcTbwIRRMPtFUAYuL9pd7fngEH
X-Google-Smtp-Source: ABdhPJyyv+WZR6Jf2S5Vr6K7fvRzhXfD//kfIL52IN/NkmKrRq/fTu8WrTzWu0uc5YD52qBOqankWLsE3IChC1V+L2w=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr171828lfd.291.1611321558110;
 Fri, 22 Jan 2021 05:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20210121062547.27173-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20210121062547.27173-1-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 14:19:07 +0100
Message-ID: <CACRpkdYDB883r7RRa-i1T_aWvDW1n3c_LvScigQVnt5TsPbPCg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: actions: Add the platform dependency to drivers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 7:26 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> The Actions Semi pinctrl drivers are a mix of both ARM32 and ARM64
> platforms. So let's add the correct platform dependency to avoid them
> being selected on the other.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Are you not opting out of build tests when you do this?

What about:

depends on ARM64 || COMPILE_TEST
(etc)
?

Yours,
Linus Walleij

Yours,
Linus Walleij
