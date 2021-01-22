Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEF630105D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbhAVWzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbhAVWyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:54:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902BC061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:54:11 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o13so9792139lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lK1Ztruj/7Ai7wfptRb6jTFj2OZIBvggRzmnF/iCjys=;
        b=dZb+LzStntWjq4Y1nmoakr+NRtwSsyQ3CYDuit/NJtX3SRbsWbPWrq8qvEBnzZsAV4
         6txTGxY34ZUpnssWeeL7VQ0d9/I9EuGbdiUXnpER6xVqtwXt9PyaQmBop44grcwHSr2b
         XP/v2WoiYCaeBJHeyo4GENx85lH7Eu24rwD92FI1tdUTCz9t7mArG8ksYtsmSKumQfyO
         XMKxs6OFcA1AD6QI2E5YvA/v4bXBN2UJFbgWAGNNoShTMV3CojNXsNHrbJBQKEP73bAL
         PS0BdxSshrGrksJkDdqdUcQKTkO2LIhyYx5f42esHSI+DWIdVhKZZ1ehAFEZ6cG3X3RK
         bxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lK1Ztruj/7Ai7wfptRb6jTFj2OZIBvggRzmnF/iCjys=;
        b=EKIvOdOTmtTsJtHd/djgVoORUPlkXTNFkuDfPQ3uoramik4aoPms2JIesgLuNwawH2
         8877pMYoG0g8aoBAFxgJg1Hy6t9Rwr36poO5CGvPSglEMXTxuTIzsGMGlOBwvJi+XuQQ
         AgQg/+VdjCWvckzHWk1JUSCyTFC7buR4wi4F/2zYNmZMbOS3tao68z9XlgudY7R0wvHn
         RSmxH982n47luY6rxwU5PEo3wJb5D+mn/aObAKiCt1g1YQUUne5WxeC3QKbrbCsScgDz
         oBHw5Tl/qPjEFUnEr1AeuKngn6uTlNcWuBx0no56WcQjR1TymMBwG6FMHNG9Du31PYH2
         lqrA==
X-Gm-Message-State: AOAM530tB+9uLhZoAoyM+7/FTw3x0QVwCwxAGMlgYoO3zj7S5xKq2EOT
        AorJtdHEXgYT2+esK3d94Y9MBETU2/45n89c9+CsPA==
X-Google-Smtp-Source: ABdhPJy6s+Z1cvTrVuvPnh27aMkITJYy3v+NBelFbox7MDmy1Eoa/Y5shcQQrjQej4BHKxcVr6WEb7OUaBLQ0xZrIN8=
X-Received: by 2002:a19:495d:: with SMTP id l29mr750255lfj.465.1611356049903;
 Fri, 22 Jan 2021 14:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20210119062908.20169-1-liu.xiang@zlingsmart.com> <20210121164013.cqfxvach4ugkohm7@gilmour>
In-Reply-To: <20210121164013.cqfxvach4ugkohm7@gilmour>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 23:53:59 +0100
Message-ID: <CACRpkdb1gn2e9=ip6ipAwW27vmf1FCs_y1Z=w-K8y8Z9MXVBMw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: fix use-after-free in sunxi_pmx_free()
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liu Xiang <liu.xiang@zlingsmart.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        liuxiang_1999@126.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 5:40 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Tue, Jan 19, 2021 at 02:29:08PM +0800, Liu Xiang wrote:
> > When CONFIG_REGULATOR is not set, sunxi_pmx_request() always return
> > success. Even a group of pins call sunxi_pmx_request(), the refcount
> > is only 1. This can cause a use-after-free warning in sunxi_pmx_free().
> > To solve this problem, go to err path if regulator_get() return NULL
> > or error.
> >
> > Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
>
> Is there any drawback to depending on CONFIG_REGULATOR?
>
> Given that we need those regulators enabled anyway, I guess we could
> just select or depends on it

I agree.

Liu can you make a patch to Kconfig to just select REGULATOR?
Possibly even the specific regulator driver this SoC is using
if it is very specific for this purpose.

Yours,
Linus Walleij
