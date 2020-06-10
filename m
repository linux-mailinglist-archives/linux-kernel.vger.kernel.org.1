Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03E1F518F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgFJJxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 05:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgFJJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:53:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6AEC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:53:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r125so1055842lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRh1o2eQq3dG1Zvvq6SPoPAkNUd6uKb8MY9HPcGIRes=;
        b=Nw3Qv6ZGCW9xzc0Npt6Hxvu7gTXEq++EwjUUbzdPJcG6Rmm2lnOsTgbc/7UMKErZ4F
         +d60EC7ezVyJwyo/Pzk1peeneGBaZ8vnz5rtahwqsdD/KUTlvXx5bjYirsjq4Xnsn3Rr
         uwnTl5GvuV4QptUDJfGI/8DCMBuxlIV+m5bnOiAthlKa8T0NE5IA5N9+2r1o2H9j+SZO
         6s7Tf/SPrb0jZG8425cAvfz7dNt4UNaIap+YX3Ht/RTNk5ok2uM1jLbYZc0irh/r0Ggv
         PntiBWTOV01xkayy/miHT2UwNllJSKy/nYnmMGcyJUNB4Gf9WJWJEX13zvf1sDxIwLRL
         FnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRh1o2eQq3dG1Zvvq6SPoPAkNUd6uKb8MY9HPcGIRes=;
        b=DMFlqoJ4QWDt0sWlYVKTugJAvHCGFOYMJq+6aM05U8vszQOxHwKyBHCKOqg99PyEBA
         8vsgGEVMgOkFY/LY0Zdu6lFdKvbtkH8OzDXBnK/VRWrftzZ+vtxZEuiZgaUjAmlwjt0Q
         sG+ewx4pv1sYv9qQz125GdrhK0qWrgM0LqcbKKWzQKUo27o0wXWpZFceo+HqtaDWUq0Q
         0GOmYD7m5MUBbKR8MjjWN274ShVBVlRqxn0+Wb61LZ2cua8n0VCXYHeeVFB1Y/QLs/sF
         7aQujeL10SqIN2ErQ7+G0+Y/qJWXv/xYCO1VMgtHZ4L706MC+CToVjpPS5Cpgw0dCQxe
         7lhw==
X-Gm-Message-State: AOAM531QTLaGpzQl/i4Mz3hfN2ecrSzj4Ef8TWxZtcKgLSq6B7NrUyUI
        HAalwuiOoIAd+oaFo7dIA8BWDIYFTE1o1TzVxD+G0g==
X-Google-Smtp-Source: ABdhPJzOMSuJGce69DNBlwY6+Eui820jOc7lQXp4MpPIfNmTvz1y18Agd0Fc44hqxES++vxVimhy/4mkOO9C2Qeirek=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr1273238lfn.21.1591782779579;
 Wed, 10 Jun 2020 02:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-5-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-5-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:52:48 +0200
Message-ID: <CACRpkdZWZ196LC8gBv_cUs2=h1Dvko_1Z4y2z571BaDu4jnWtQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/6] ARM: pxa: Use GPIO descriptor for gpio-charger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Provide AC detect GPIO via gpiod table instead of
> legacy platform data so that legacy GPIO support
> can be removed from the driver.
>
> Also remove useless IRQ resource, which is not
> used by the driver.
>
> Due to lack of hardware this has only been compile
> tested.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for going the extra mile and doing this deep clean-up.

Yours,
Linus Walleij
