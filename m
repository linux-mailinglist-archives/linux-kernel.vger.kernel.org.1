Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459081ED861
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 00:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFCWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgFCWGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:06:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED3C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 15:06:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so4747854ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZqWRAwkoZGm0MT0LhnL1ITCWUWQqRFExLfdOqT2sHM=;
        b=ifeeWNzF4wAPFHd21i1T7hZ+XQ6kUW4qhTa1hOviPEAn2zLRmxrTk+PNyY6YzjnT0W
         wrZnnAVGSZDC/eVD9dmypYQTNtVP7cklzWMfI8aP1cmBXiCBALQKH6+NOZTaZgRtegxa
         Jur7UHc1fR6FnuJNg+Df8haSfvODK8uVx5mIDjKH9QZkWiSKhsEe+5K0y4f9tn1dlvBQ
         hVpSSx3uugyxrCir29UzLvNT3zb41Z2ALoA/SSslvhH5zGTlUpAuVwqZs7JdaF9+dhnl
         GbGo+7g3eL+Uxl3b6SOexC57gwx1Suz5jvxY0KLHuYBHcBLeTNtFhdDkkjcpv0pRigsT
         RpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZqWRAwkoZGm0MT0LhnL1ITCWUWQqRFExLfdOqT2sHM=;
        b=q694g0bavi9iif1VSeIGHp0fmc1zSeCiGrpbL5NeZB91NNpI9R/aJPBXpjh+TG5hhT
         xhWBWBNwxCP8x9oU/e/5XfzVasuHlBKf30yLqhsNH6CMcHlJatcrHqlmLfsHXCpi6NIz
         5uSVnPCg8yYaJTnW+4fytDjwLqNKwX1py1lz3Ac+kbquK7aT/QEgwyMVBPX9b6Go+OnA
         vxCaww4Aok6HC0gNjkcw5OddF9W60Nl/koVBZwIK3j9M3FY+5VME79Z3mQc1OiC97AEs
         L8De6S7jC3lFDIs+Rk+BXjquQFwhjEKUrZcVqvdcOehKG7q1oCihDeWC11gDlfhw/mjl
         0/yQ==
X-Gm-Message-State: AOAM533xtVTwJbU7ieU4EBj8fE041UkZnNDVoIf1SzQD8vCSnkebvauA
        8YeuWMIFcD2qfwE5JhIf6mQoh8K2HGmQVBehTGdPBw==
X-Google-Smtp-Source: ABdhPJxVc4P8kuV8rJARiopGCBcGT0QqtREKnWBawX5I9+sY0Q0Qd0KfCLEAs0rplFWBOdvE+GE+YbcX9BpW+DwedR8=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr665797ljn.286.1591221967893;
 Wed, 03 Jun 2020 15:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200531073716.593343-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200531073716.593343-1-christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jun 2020 00:05:56 +0200
Message-ID: <CACRpkdax2rFLnqY2pBEjfV6GH+wCHOrc4bQ7iYZEzWo=Fmi0NA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pxa: pxa2xx: Remove 'pxa2xx_pinctrl_exit()'
 which is unused and broken
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 9:37 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> Commit 6d33ee7a0534 ("pinctrl: pxa: Use devm_pinctrl_register() for pinctrl registration")
> has turned a 'pinctrl_register()' into 'devm_pinctrl_register()' in
> 'pxa2xx_pinctrl_init()'.
> However, the corresponding 'pinctrl_unregister()' call in
> 'pxa2xx_pinctrl_exit()' has not been removed.
>
> This is not an issue, because 'pxa2xx_pinctrl_exit()' is unused.
> Remove it now to avoid some wondering in the future and save a few LoC.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied.

Yours,
Linus Walleij
