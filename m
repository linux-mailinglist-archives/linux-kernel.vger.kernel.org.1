Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6A2A9734
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgKFNoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgKFNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:44:18 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 05:44:18 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id f9so2006237lfq.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 05:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wI0GK83QWCQ6vsZdrqG3V91Iy+WDOOvk22jyx24kjEs=;
        b=vMu5Ja7Cwh5pkYnlZwYu3DUXqEgu0S6PWP1gVg9/NM8I2i78iHgFVDYUUy3D4fkvyi
         NSEHeHNe4ptH50Jv2U7T0elNvzPri6+Cg5WK/nkvDE54WSyi4ocd11H8f8tAFWbTscVW
         rvzX1FIT7dot89fLnFf1/dwzFvYYOCzMQqJ9WPq1hPq353dv8HGC+qlJ5tCPKDAuQTM6
         g/iF4D3mFGSTASbTGJK2xMasE+HNybaFg3Yo5hP2RYhVZPL1i9YB4o1x/xvWVkS/Fsty
         A0O6QFFfoa7/cZJEJNohRQfG+ES0UbL6vmdOyEAPvHK7uRAHgC7peo8OLfx+J03mjs7o
         I6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wI0GK83QWCQ6vsZdrqG3V91Iy+WDOOvk22jyx24kjEs=;
        b=VJkwrghjcrQO70lhESe5iO1/DcS/E1wom5M6thpymBcUuGs7LHJ4jhjOdrp1ig1yW0
         nzeJbeg9voG7G++vvGkrLSSe3s3Ox0dNarSk5A5UPwNQwHB1XIG7+GdizIOesHLekqyo
         9CTFe7FAzERoM7AZB9b59Ymhbza7aYxx0qQ3conFDNYLwgSFZ/ZAIl0TWpfHaozDT8rl
         2iWb8CEGHuDikKdKlfIY5T+tkDEO/iq2xoTWvZ1WiXs2Hp5aU0vR5SV33Zm/BSqUW0bv
         OEKQ3PRz8583ssnfCFwsdXrC6BF5KNTUxrW8pv10NtagNM/iybTRDfqv/DO7+JB4dOIY
         9vUw==
X-Gm-Message-State: AOAM5316klz1dqHmudgzeL+/BimHXk45XM6/Rs+UjTmu8qJHS6D5zSKV
        nymS9Dq7PcGduDVc7pQoP/uZH6E4Hii2sMna8a2YnT790CPwIQ==
X-Google-Smtp-Source: ABdhPJygixdWhUfcyDNsGa2oGSEuadBYn2t4MmXNTxc7g+f0e+S6NHgZXcaPQGNq5wbaXC2ktaBv9Udb+dgkIYzb2Ic=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr1003402lfc.260.1604670256510;
 Fri, 06 Nov 2020 05:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20201101090104.5088-1-paul@crapouillou.net> <20201101090104.5088-2-paul@crapouillou.net>
In-Reply-To: <20201101090104.5088-2-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Nov 2020 14:44:05 +0100
Message-ID: <CACRpkdaZKxGBXXAXUd-gho4bnCRN+9HhX6OEsUG982xSDQgRFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: ingenic: Get rid of repetitive data
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 1, 2020 at 10:01 AM Paul Cercueil <paul@crapouillou.net> wrote:

> Abuse the pin function pointer to store the pin function value directly,
> when all the pins of a group have the same function value. Now when the
> pointer value is <= 3 (unsigned), the pointer value is used as the pin
> function; otherwise it is used as a regular pointer.
>
> This drastically reduces the number of pin function tables needed, and
> drops .data usage by about 2 KiB. Additionally, the few pin function
> tables that are still around now contain u8 instead of int, since the
> largest number that will be stored is 3.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Both patches applied.

Yours,
Linus Walleij
