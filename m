Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2808A2CE963
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbgLDITS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgLDITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:19:17 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC92C061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:18:37 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so6533725lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgQjS7gQq1hlMzOMWkicyzD5TPU/0rBQi3d50MpHvXk=;
        b=A6wS7fSiRdRqJh0w+C5baSJ8MXvSjxuAeExfPI1DffG3xon7jxq0d+MEH3O/Eapvyt
         0ZNhToGOQba6E+cpiw38iyPL7lrgWFZCJ9XHOxka6U8voWwgrcr4K0IT2LYqaFkSGKIM
         Jm45pRKTASUIsfVzGCrhHTRre/FHaGx0BfIcxqbG7noRjs5blbm1StuMVsByXPgv6pEY
         +EEcaGj7jLHi31tMJTJbzl9kNi3FQHjmiIWojKExhO8KpTsa17gsZGsdCr+nk9spcYuP
         WFXTVFIe7Lzt5sI/AsknJowOmfOABzrYJMb+5KFXv6O3QjA42CmJY+fZpd/fEWK38uKX
         F1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgQjS7gQq1hlMzOMWkicyzD5TPU/0rBQi3d50MpHvXk=;
        b=JfrPdMT8COkKtCRcKeDAvPjq352UWO0jZSzYroYorG0B5gEgJhXX1t1x2wmNRDZ6kP
         /uFeBF8SHbReQfpDkZKEUAsP7miMqxaJtjGAkkZikI/JDfoHqNqUqiRvc19CqH6AuYNS
         zawVra/Bjvsg4bE7H7W4Z+4rSJFwhZlUHMdeRp4nN1AgkhheMvzWLnBx3MxeJQja4s+c
         1dpB1ZeQNJDTHxXQBuSm5n3deTBrLN4SVpz+FraoJ4eP6rCY5IAcnpGtpCw/JDmmcEX1
         6Goj9XGfoiLs+anSwOX56yyrwidoOWNqVGnBM63xekb4/sVZhsOei2D5h73jDzELHpEq
         hF9A==
X-Gm-Message-State: AOAM533gTSIAC3OULeYBLgTINor47zgqS5ynjfgUakQzZTCmPDENJ0Vg
        sEdc41M8+M21ZpUAug1Y6dBHwzBAzA2nvTaGYi5amQ==
X-Google-Smtp-Source: ABdhPJzdwTxSgpoTuZSw7pbs08kjXuXmhNScBCoylbhnJkoaRGoCFiMID+kU2gmYDGtZErQtFSYTQ9ffazTisrPJH7Y=
X-Received: by 2002:a19:5f11:: with SMTP id t17mr2741438lfb.572.1607069915656;
 Fri, 04 Dec 2020 00:18:35 -0800 (PST)
MIME-Version: 1.0
References: <e6241dd2-9ce8-9334-93f7-a4f84b20834e@web.de> <20201119011219.2248232-1-yukuai3@huawei.com>
In-Reply-To: <20201119011219.2248232-1-yukuai3@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 09:18:24 +0100
Message-ID: <CACRpkdZ9aOTFF=vO8UdQYj0g+JABwx-78ipP3Qj38jop+whMkg@mail.gmail.com>
Subject: Re: [PATCH V2] pinctrl: falcon: add missing put_device() call in pinctrl_falcon_probe()
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Thomas Langer <thomas.langer@lantiq.com>,
        John Crispin <blogic@openwrt.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 2:08 AM Yu Kuai <yukuai3@huawei.com> wrote:

> if of_find_device_by_node() succeed, pinctrl_falcon_probe() doesn't have
> a corresponding put_device(). Thus add put_device() to fix the exception
> handling for this function implementation.
>
> Fixes: e316cb2b16bb ("OF: pinctrl: MIPS: lantiq: adds support for FALCON SoC")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Patch applied!

Yours,
Linus Walleij
