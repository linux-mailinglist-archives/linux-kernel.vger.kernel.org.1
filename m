Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0C2F0835
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbhAJPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 10:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 10:52:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D34FC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 07:51:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r3so13888551wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 07:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+hdQCkiuUkkg/EucHFznVqAtMMSgXZ3ryvq34CwGExE=;
        b=IqNAsrnAm38lrDAx5cVUYsBWeJVcKZrfRsy8OmyPTGiiIWQBqGTm1kExK7BzPa9j1w
         Q6PIfqFWuScNtUeDD69jv88Ivl9Sm7Uq2LzNRTPx+AHXWzEO8E0eRkkh3wIdCMuu5S8a
         gzRxgdcmsgZRAZq8Ca7jyvcNCh51t4yGeme3hElqF5snxoMWopUxgAIQq/CI7/NGMCWo
         /fCRP0F6gwmGI4f0w4TBm6/dGiNtVi3jiNzelkOk/hmnXdxeHJKuIgIJayhrCj0okD+n
         PIBNGlhaLf48LdLY1ofzkaTxJx66PBvzvFhw+9X8bX29q5boe7KrXXeJBvpH9RsYxTS7
         CUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+hdQCkiuUkkg/EucHFznVqAtMMSgXZ3ryvq34CwGExE=;
        b=cDCnCxxvp4WBxlg2cark29mb9JfGJIJBnDfF3+91zS7JpN3xKEUANnulQhBYX14VkO
         5nAcB3WsVVgzNA2ACHeZE3QVidxWdvJh0PZzfyzaTVGq5ZYt763mAAYPSAA4XSw81u8I
         hsqd7bXIqAWXCVLqjUvjQ3YEz0l+D83FC+GR9JAeFp+aTqP5jkfjjYLleFfkCmZc0Y5z
         O2QmJuwC2EMs46BCkosrwnFB7qtlAEvNzlvNKeLUKAA5lV7ni43ov39H9Fp+WTqDJl41
         hiaqVBNuNVI5Y6rgNUrmO1CWSw4zRBTVCQHzgjYca39TwU6tDNvF9NPZnkPXi0fZYQEy
         EKnw==
X-Gm-Message-State: AOAM530ZqDNr0DR7fYDYCUMpW6BU9nvGuNHAPe1l1joYq8Tm1iV+oMUV
        LAW3C0GDGhEhs1ffB3gJ0a0feA==
X-Google-Smtp-Source: ABdhPJzMW5P9enjl6xkfKFal3rNLbrV0+Fk5ufriezfA+AiRm0naIWGfJpzPv2sv0x/QtWQ9M87v6Q==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr12511556wrv.93.1610293915198;
        Sun, 10 Jan 2021 07:51:55 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e35:2ec0:82b0:cce5:3f83:334e:d9a2])
        by smtp.gmail.com with ESMTPSA id x25sm18488628wmc.3.2021.01.10.07.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 07:51:54 -0800 (PST)
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Cc:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <bbeb01ba-c941-9237-0ee5-506d9c276e89@baylibre.com>
Date:   Sun, 10 Jan 2021 16:51:50 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Le 08/01/2021 à 23:55, Arnd Bergmann a écrit :
> After v5.10 was officially declared an LTS kernel, I had a look around
> the Arm platforms that look like they have not seen any patches from
> their maintainers or users that are actually running the hardware for
> at least five years (2015 or earlier). I made some statistics and lists
> for my lwn.net article last year [1], so I'd thought I'd share a summary
> here for discussion about what we should remove. As I found three
> years ago when I removed several CPU architectures, it makes sense
> to do this in bulk, to simplify a scripted search for device drivers, header
> files and Kconfig options that become unused in the process.

...

> * oxnas -- added in 2016, but already old then, few changes later

There is still active users in the openwrt community, so it would be goods to keep it for now.
And we have an OX820 board in KerneCI so it's still maintained & boot-tested.

Neil
