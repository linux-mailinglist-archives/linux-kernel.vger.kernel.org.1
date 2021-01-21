Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1942FE9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbhAUMRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730968AbhAUMOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:14:39 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2E2C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:13:54 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id q8so2173574lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Myx5eVNR3ui/ZOjCm1kbNmJ8TPZ/ps+O2zKImwlnNDw=;
        b=PptR/y8axGlQYN9TjYXCbMoAG0s9YFu7WBRrSDpGtB4PxYHLcMVlk118pM5qfOWW5v
         cdsHHzq+NzVA64vjIHoOaI2pG6eW0HyXMNYzJYXP6uQco7rmyZcHEkwoT8jjWFlhYlqQ
         nipubU0tuAlSnFeEwTuF8RA75WkX9zhciNVZ4PsafyU0QOwCNiU415fObnn5VMdigI8L
         NcM4rsveU9bue68MPHVSzYNsfivoQ1vUVpip0p7Mzt1t+VH33AwCo1h133ny0FjMzsBC
         Xvjb0PjGMSD8YoQdRLpTuH+hy/ssqyzVR8IrtRmcQTCI9W3sRRXbwgF+lXfp0h0a1Tu1
         j/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Myx5eVNR3ui/ZOjCm1kbNmJ8TPZ/ps+O2zKImwlnNDw=;
        b=nJcUfR8yWcpOACzEjVTwLAF8Z9p0RS+/lQpxIHXmciPYm64cm/5iQtF3Zi930XWwzI
         xZFtnaFFde9qKRM7tpZAKPu9KN3W0lT7WDwfQSGwPOr0a+WumFnKxpoKML5VJxiRILBr
         d06IDCe6xd4OvY3pGG3BdWwG7LkWfSEDGLArP8b6OxhYCejZkebDXSH1fY+exZ2i4q7f
         LTfD+zKn31ChyF75R77gfI6XEynigQ0cph/Lhj6fCYjbPfDvAR1oDDgQ5QESUlexB4tn
         KmppuL2uzC5MRTw/lRwt/Yf13wqTfxv+f7Ge6/XpJBpcm9nybVRB+7wxnBU78VmbPsKe
         4Z6A==
X-Gm-Message-State: AOAM530QYDzTJjbMdlCtvMxrX6AWq2AygbtxEgFgiSjpVhhXKLf3UxzK
        qxZhc1IVrfL2uD8fDczzDvdm1jDcC3uyDBNr2caNKw==
X-Google-Smtp-Source: ABdhPJy4ogC8cUFfatEuWax8vy3nRxBHlsEqavCD4L8Eh8EmBpIGmwwKufkZvlfvqgQZlGAbFOE1QSnK8tLR9sU608M=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr6311874lfd.291.1611231233107;
 Thu, 21 Jan 2021 04:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20210120132045.2127659-1-arnd@kernel.org> <20210120132045.2127659-3-arnd@kernel.org>
In-Reply-To: <20210120132045.2127659-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 13:13:42 +0100
Message-ID: <CACRpkdZWtGzLUnDg5G4CUnyc9NpSZoTu3Cf2qE-rNCNw6HXqag@mail.gmail.com>
Subject: Re: [PATCH 2/5] pinctrl: remove zte zx driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:20 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The zte zx platform is getting removed, so this driver is no
> longer needed.
>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
