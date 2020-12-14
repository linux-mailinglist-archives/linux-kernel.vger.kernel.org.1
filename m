Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E332D949D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439590AbgLNJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439585AbgLNJMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:12:19 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:11:36 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so28289766lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0T9WuDxp4z8u+0X1QQpYrnt9KBMRop6VWIdv68zxuXc=;
        b=IlIFBkppYMjUl1XpaV5iPaW7+eiJ4CFXLDYkHeu37m0vBaYK96CzYXYWbGTPLbJalY
         NLYgKscnaadGdCH+92ik3vRpwhv+kiCmg8NlW5j91yn0IHwYcWBE+X0RTYyQDJK09tAd
         zQlLYYMV449wpuAGIbVS/GceU1rLk16Fzi4U8UZNy2NQxof1kfbB9fDeJ8G6Vokvf939
         r6JKiHGno8tlrkK0viEEpz47MUf44cfyGjGcrJ1QDqDagyuqZY4ZE5XwjrfI2vZO1ZXl
         yf+j8XyHd7VCZpJLWRYlIBzvhKh9Ly7kQk45wg4/K2vItvGCwtT8GxobRDezOgY/BpDR
         Y4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0T9WuDxp4z8u+0X1QQpYrnt9KBMRop6VWIdv68zxuXc=;
        b=iZeO30PHap9lYVbFhGoxGqWQSLiy/KSaIEcHJpJlUId7DX4d8zHy38zl87fNKIrUTV
         r3eSctnREq3vOAXtx37+OJ2u1ioXeU10bOn9zZv66CyAQ5QrrJydrDctYxuZcJ5Ri+Mg
         WeW6NUY512fuUiB1IYeNRqbkCIb/N9XQk3x0PZMG0g6P+RGj16+uMoyfGtr+Db6WDcAW
         91iYQSs80kCNHS5o4GM5jFP8veF+MkU4tTVeBFYDvi2L3zpctlZbN/a3t92WsGs4e9+P
         D+aEWUJQ/sVqkM44Svu2jMli8csijGOOvDlElJFM5PpcXHI2pei08UDrTejatuG21t+3
         gBfg==
X-Gm-Message-State: AOAM532EqfQbfzdmv4O6zDKF0/zRKSR/LdrbLMw8kmNeUK+MQ0hp0F5L
        3RnCgpowobyM04o5lb34jtG5SnCkAjHeOwxoLZumcg==
X-Google-Smtp-Source: ABdhPJyxQ3ffqkK33uY3yPRoji9ZoPBl768Fl/wI2N724wAfLP8TLBjqVoNei97I1ZrYQ5/AJgpxZWycpGG1aXvrjUk=
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr9696933lfs.529.1607937095063;
 Mon, 14 Dec 2020 01:11:35 -0800 (PST)
MIME-Version: 1.0
References: <1607934255-52544-1-git-send-email-luojiaxing@huawei.com> <1607934255-52544-2-git-send-email-luojiaxing@huawei.com>
In-Reply-To: <1607934255-52544-2-git-send-email-luojiaxing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Dec 2020 10:11:23 +0100
Message-ID: <CACRpkdZSQSCO3dWcjUZtUMDK+Jjdnc9ORxpR9qiopgMk-o=Ryg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio: gpio-hisi: Add HiSilicon GPIO support
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:24 AM Luo Jiaxing <luojiaxing@huawei.com> wrote:

> This GPIO driver is for HiSilicon's ARM SoC.

Patch applied, any further issues can certainly be fixed in-tree.
Thanks for your excellent work on this driver!

Yours,
Linus Walleij
