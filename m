Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA3D27CECD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgI2NPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2NPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:15:45 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C67C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:15:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so5479491lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aot3ORIQWKklkoQf+YaVDp4V9gsCzqvPIkopUs4mX0=;
        b=xanrmt6FepPfgRB+SlJFm0QTo5+Zafpq23T63O5KZWRcpGym+JCTAzcx38vCZF0ySk
         SejiW125FwRP0oYhFQA3yBD6tU2djb0B1a5YVOAND8BwjLeexV1Iqiz2c+5QI+liURMh
         XeNcfKxfltVpsKHgm1tFPkX/VDfPxvXayhIIdZoy6rAyJCW+tSd/fdZNHC1Z9Tmx1i2j
         u33se6ZIN3Fm0yIQ9bgC69R9mgt5bjjXs1DbN8gyAuYYjtaV/cH1jbH/IVYwmwxGyVrX
         5COfS19yLpm44drV3QyHGrBpyTEwugOaXdHhehO84hnErzSPOY3OCDnL9CP2zdwI0ORg
         G8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aot3ORIQWKklkoQf+YaVDp4V9gsCzqvPIkopUs4mX0=;
        b=YxLbOsWu6VAVJDT6kamS54Atq0sJHVOBhRfZAMjFSAsskl+2p/Ak0VDm5BMnp8P3z7
         Dje4RVk6bi5TRPNloweInSlJj9W9cXX2u9opwXwH4EA0ez+829BQ1P7xjGtGiRwmgk9Y
         6E3YDQpiv38t0r07gSMjnVoxiGzLjInv3JDe9y4sLpFnAkOr1v2eiDeQe0rZm0UPgKOt
         qL7LepI9kFbQYYtOoiosj1LGmNi9N9leu4feB94P3OLxx8nY7ZW/FooLod746IVOte7c
         t1lcxTX4qlGUy+wMWjw78z0D2ZeEV20P2YiB0409gYdM6HCg7FZtQM8AuHnHpxZUxolx
         ZgCg==
X-Gm-Message-State: AOAM532VlmK6hTkEBiDlRxBFf4H68hIblZqD8CleWabhvSKIMlK+pqwC
        ymLjXDqcyyA4tdt0zv6v+p4FzBffbZVix/as1kYouA==
X-Google-Smtp-Source: ABdhPJwbvYAYNXpOY1vzTBjg4ro3tT/BVctJqlrA3wJmbqtiyS4kdAR4YOQG7gVAgrmHwV8Wa0M+MZ3kZ1ZzarCj5os=
X-Received: by 2002:a19:1c8:: with SMTP id 191mr1121422lfb.585.1601385342194;
 Tue, 29 Sep 2020 06:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200919021831.191077-1-miaoqinglang@huawei.com>
In-Reply-To: <20200919021831.191077-1-miaoqinglang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 15:15:31 +0200
Message-ID: <CACRpkdbBQDA3cqmswuS8-DBLgQrG86k4aHtPFiznzCLt0FMyhw@mail.gmail.com>
Subject: Re: [PATCH -next v2] mfd: ab3100-core: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 4:18 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
