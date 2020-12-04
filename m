Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650AB2CEA52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgLDI5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgLDI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:57:16 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547FC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:56:36 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f24so5688220ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJ1fzSgokECotHkJqrqoEExwA9TcEVBR3NXKHiATO2k=;
        b=F25LgDPjFaoPG6Z/ATemnbUuP/kjWPbnEGqwOjyHQo/acXnkeeuM8cjCK5QrMUOkYh
         b5O+dla/oPbcOCpTfKP50n5QYlK7rVWmZILqvt6ri4S/iG8DHLvDg4vcH9eLyuU0unyZ
         yl2+ESuXjkamk8opnNNQaNTowDZ3C3T0HU0qALdXJmyGvX4dM9hNaKt+1e8mJj/yx2mZ
         yiOdYvnZ1tk2YlO8+UEWH73aJQ4XmTkgN6eIiweqCCcHIWCmuq5VxBNqoS3fBu+ED1SY
         gcu84AXBxNp/xnT9GUuaAcxIb5e7VIHxyJh1pcbeaXRT82zUm3XYjzhBiDviH5CQJ8JA
         +Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJ1fzSgokECotHkJqrqoEExwA9TcEVBR3NXKHiATO2k=;
        b=jOrYmVTPsMKktXBaCPSHA6mgvd6KAWzFrDwyAdF0+YKPM5B1ZihlO1MC/AfIvKYBX5
         SM1QQlCayuoKyw457EQ8XZqjQ17IuViMxTAjRkcWxLNmuzCBnd4WLNYhb7FtltyeHAO6
         U2Md8vUkdgaowpWS/eIRVusoOYgup8SDjF7Ca1bQpzjJeoIW6COLVp1SsabHPbETnKwu
         xo/W6UFB6A+FPybyBmLBZSVxaM1V3vuGDQqC41qeFAW9aMxrLjn5vkA5H7xVh/RGsYPR
         Ubuovp2/MxxIIfrLI0uaMxLPa/afpsxCXCqf9EvqMT5AO2nTp4Kgr6X7pP/hCu3008AG
         vPYw==
X-Gm-Message-State: AOAM531BAKHx/4oNZWi2EOXw5DJ4OXRuvEnWE+nMW2xsiR8NTfVaVfga
        Q38bT22CLfk9AMP48eo44RX4wO6sStW4ar34sZlmzQ==
X-Google-Smtp-Source: ABdhPJzwOIXqbjd3mo3m1e17lUbBTlUI2ugIW8XBv5tsxQTuR9KQvQsVsHqutrrxOg7M3ircCuppptyaGGVQ3OdIcsA=
X-Received: by 2002:a05:651c:39d:: with SMTP id e29mr2768490ljp.144.1607072194779;
 Fri, 04 Dec 2020 00:56:34 -0800 (PST)
MIME-Version: 1.0
References: <1606218173-3722-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1606218173-3722-1-git-send-email-zou_wei@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 09:56:23 +0100
Message-ID: <CACRpkdaOgK3d4taTP8j4trBsusEL5ceKYoxVMjshSGAG--QX4w@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: pinctrl-microchip-sgpio: Mark some symbols
 with static keyword
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:31 PM Zou Wei <zou_wei@huawei.com> wrote:

> Fix the following sparse warnings:
>
> drivers/pinctrl/pinctrl-microchip-sgpio.c:63:31: warning: symbol 'properties_luton' was not declared. Should it be static?
> drivers/pinctrl/pinctrl-microchip-sgpio.c:68:31: warning: symbol 'properties_ocelot' was not declared. Should it be static?
> drivers/pinctrl/pinctrl-microchip-sgpio.c:73:31: warning: symbol 'properties_sparx5' was not declared. Should it be static?
>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Patch applied, thanks Zou!

Yours,
Linus Walleij
