Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43662AD765
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgKJNV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbgKJNV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:21:27 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:21:26 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id l10so14636816lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvmdrHjEnYSfYwEFHbWu3E6GP9e3mtGxt3Sg0AJq41k=;
        b=V8VKUqNgVFUqdWj0+42YrvL6hxZqWLjsCSrmjSQhvcCwZYnxPYk9qfEQ+pPHhhOz2U
         NoUlNzAUt/LphmvmOLMy9/RdwM4rRa5NVHF8D5xcaR7waBPiCeNLDExsKCBVXqa84jwT
         mNqPHoiaJKIrjL4ETrIAlfhio3+ghFcJLx0e/SNPdhhJga9K07zBcQs53n2IfCTMWxJq
         ZiUd9lkEsk85xV35TNaFk64HBZdcMAvE55uDDyUi2p+c4a0xxh2pcqUegDViMCU7tfOB
         RS7xet0qQ8qfDBuuba4AGMSe2BUCZSRI7MN9AhBr65/zH09SJcpcbP3PCk1OaC1Ws9f0
         t12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvmdrHjEnYSfYwEFHbWu3E6GP9e3mtGxt3Sg0AJq41k=;
        b=E2o67QKXLZEHFYfbIguyjpG+UGd6d05HwnQdYyPkP9uXN5xnvNBg6iQgfvY6xm3SvD
         zQEtSY9Q9Y5phjAVqqIxvu374Dvq44L/7rsNUUyKUG9pEVELrxUoOZdpvBLuGhYGWz7X
         yLsThkasaUcZjB8VKyYkV4MZfGx5mtlFBUpkHLq+cnkfPyD2FSZRvWxkfFDnXu8Im0R/
         fE4obg9X3oiDBPJNX2K4IHLFj4pnun6WxzC0s4oAHDWmiQ1dC0F69itohEgL3XX1T/IS
         mdZQZB2eNMs4zN+ZzfVxq+D/dE1b9kDHAZof28fEFujikXfNhar8I7e6SwjpC4fyQVWB
         zpSw==
X-Gm-Message-State: AOAM533/XEvn6Qb3L6WxBYX8Dm2Pi6NVnIhQhuzWQNt95T0hatgoP/V4
        N77geUPN5eI3h3FFRuS14mBLZBf9DwvJhXqZbHxTbR+9d0sJdg==
X-Google-Smtp-Source: ABdhPJyqYfi9VXD1BdUg31+zuT2i/xWg1y18bAyC205h+GjlzHEpJ7dWgXgWGZL0nWrwyQlgl+CJIsjckM29Sj52uIc=
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr8893338lja.283.1605014484734;
 Tue, 10 Nov 2020 05:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20201105231912.69527-1-coiby.xu@gmail.com> <20201105231912.69527-4-coiby.xu@gmail.com>
In-Reply-To: <20201105231912.69527-4-coiby.xu@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 14:21:14 +0100
Message-ID: <CACRpkdZBo+kY_AMNADmj0uGRavb=HsJ8doJ170RJmopmA1c9Nw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] pinctrl: amd: print debounce filter info in debugfs
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 12:19 AM Coiby Xu <coiby.xu@gmail.com> wrote:

> Print the status of debounce filter as follows,
> $ cat /sys/kernel/debug/gpio
> pin129          interrupt is disabled| interrupt is masked| disable wakeup in S0i3 state| disable wakeup in S3 state|
>  disable wakeup in S4/S5 state| input is high|   pull-up is disabled| Pull-down is disabled|   output is disabled| debouncing filter disabled|   0x50000
>                                                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
> pin130          interrupt is disabled| interrupt is masked| disable wakeup in S0i3 state| disable wakeup in S3 state|
>  disable wakeup in S4/S5 state| input is high|   pull-up is disabled| Pull-down is disabled|   output is disabled| debouncing filter (high) enabled| debouncing timeout is 124800 (us)| 0x503c8
>                                                                                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

Patch applied for the next kernel (v5.11).

Yours,
Linus Walleij
