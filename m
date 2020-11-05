Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BBF2A7A24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgKEJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgKEJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:11:09 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79297C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:11:09 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v144so1186110lfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0y5gVIpn/AdoIrclQ35fvG8jExsjx9oUlGQ4SSdRvM=;
        b=OBDEBRw1XQC3TF3Ujh14Do4dSNZfC5XcJwZ3/bgFQ+sx4K3XUmiyLaQCtmaraJniD2
         dI4T8c1xdRCYc6hOieisMIn/BXIYYXXtbrCoXXUVcu/n+dNMu9HYYQeMgGgHgLzHavoN
         LVWiu97oelCd0Chcpw0NeQODveRSIQ3u2xOhva3fn5rWs41Uv4WPEsBnKriGOIqQzXaw
         F2ndncW0lLmvkp/UJuETbVOhB9Xu32Mzoac95D9wwg9vHDOuqEoFLTr3BRoVVNWUSiDY
         ZMKimJPPn31JOs76+XDZArTABgEXph3X4yOAOpezGHK0+DR1MN4bp/BbwS4ynjAbxx0E
         mN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0y5gVIpn/AdoIrclQ35fvG8jExsjx9oUlGQ4SSdRvM=;
        b=N4rU4UxkpitmzRFTxGK5y0z8D+BwcwL0Mzmi5vyGwNghAXLtMkG/ifiQws7JR4RVRY
         3hhPke5w4bAjgbQTRTZhOUKU4nLKbbephEpML46LBhEemkFEokblX6hy9bmmgWUmlE/T
         nuaK407LdbDla+aEV76oemP26NOv7eeRs0ZPO8mwMuJH2CqwY9Ni/1Z7+2cIpNzle1Lf
         di5kwc8MtYEhFXblldj6Ggs8H4JiBW0JmErsBRLXQGh0Qz4652lcMNtBHC0e/6/uCZ5h
         D1xwuijiY/cPAhkf+1L2+/AOl7k01UXj/VRGP6XQ+4ZTzCN8zHT1ZYQZY7ju4J+Ny88J
         88GQ==
X-Gm-Message-State: AOAM532RVFuwHakVEcQ7BDkIzGyRF50xGeX9W6VdeMTwoYz0M/8BV4tK
        aQdd6D34qyiuUsiFMUEBOHxRbu+zfOletpmUQ62612oa/7Icsw==
X-Google-Smtp-Source: ABdhPJzqB9jSOZSfJwAF6NxekJgcXcBnjncy+ksjyFQ9f8WPlYctN2Gs84q49hGyTJZnrCtPAjPxbSo30cnPWuokgKU=
X-Received: by 2002:a19:824f:: with SMTP id e76mr564699lfd.572.1604567467941;
 Thu, 05 Nov 2020 01:11:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603055402.git.syednwaris@gmail.com> <5e94ad3c156b98d2ed28617b2ca25bacadc189d5.1603055402.git.syednwaris@gmail.com>
In-Reply-To: <5e94ad3c156b98d2ed28617b2ca25bacadc189d5.1603055402.git.syednwaris@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 10:10:57 +0100
Message-ID: <CACRpkdbZ4US4Onhr-AmkPoqxQU0enrsicx775kLKdpEVtkTbhg@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] gpio: thunderx: Utilize for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 11:41 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> This patch reimplements the thunderx_gpio_set_multiple function in
> drivers/gpio/gpio-thunderx.c to use the new for_each_set_clump macro.
> Instead of looping for each bank in thunderx_gpio_set_multiple
> function, now we can skip bank which is not set and save cycles.
>
> Cc: Robert Richter <rrichter@marvell.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
> Changes in v12:
>  - No change.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

If Andrew merges this through his tree.

Yours,
Linus Walleij
