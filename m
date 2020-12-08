Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C462D2C9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgLHOFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgLHOFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:05:44 -0500
X-Gm-Message-State: AOAM531EkzPx7nb7JEQsYP/50EBqRsU5WvQpcPDHV8I6f8CWwRqj6Yxj
        iL8JPxD2KGK/ALbv6grRX5jJE/NyED3ZpoKp1GI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607436303;
        bh=mbsdbwKyczvLHvtpaeUbdE5uuehFNcjej12iuv54kM0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t5uiLAeQbxE76Z++9gWAPnbTDDysMrXRk28zPlRtfyuIO7KisYFV51C0+0vmKG/lx
         FDmoSG20CkOI9fWyjYdJ7NGaT7c19OkAKQBfG1TuQ9CJwvMmNBlcMpT9RBEokMdgTO
         JI+YOHY1RkGBEiRYOL4qRgyeMqtE0/y+yNFKHctLaLSULO5eeOojKUyFe08t+XqT8o
         ze7N/fAz5Rgpn5PaUxsuw2xcvh3TQgrsCIpR/wbTURPXqTdJiTR879ONxqAjHDlysJ
         5bXxC2JOCcuSb30yGAmqESn+giBCnwNguePZrZirB0JPDJIzcr2ah1ev9rj5hnQkst
         ZKoA2TyKqP7aw==
X-Google-Smtp-Source: ABdhPJwOOS2YE9U5ISalt8ZW6t5h5/7Imq5MdNE9kh6uYThwbWteRjZKRfIw8tfSJKviZjaCwjro3y+psb4Y2uBf6pY=
X-Received: by 2002:adf:b343:: with SMTP id k3mr22054883wrd.202.1607436301682;
 Tue, 08 Dec 2020 06:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20201203222922.1067522-1-arnd@kernel.org> <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
 <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com> <IVYYKQ.T5GFS8Z1QTP2@crapouillou.net>
In-Reply-To: <IVYYKQ.T5GFS8Z1QTP2@crapouillou.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 8 Dec 2020 15:04:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a21gkBsb3rcNvzH3XA_0GRRKPgnsrynTTO=EZVwy6DC+g@mail.gmail.com>
Message-ID: <CAK8P3a21gkBsb3rcNvzH3XA_0GRRKPgnsrynTTO=EZVwy6DC+g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 1:33 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le ven. 4 d=C3=A9c. 2020 =C3=A0 15:14, Arnd Bergmann <arnd@kernel.org> a =
=C3=A9crit

> By the way, as I'm ending up doing the same in a different context, I
> think it would be useful to have a IF_ENABLED() macro defined like this:
>
> #define IF_ENABLED(_cfg, _ptr) (IS_ENABLED(_cfg) ? (_ptr) : NULL)
>
> Then the pm_ptr(_ptr) macro could be defined like this:
>
> #define pm_ptr(_ptr) IF_ENABLED(CONFIG_PM, _ptr)

I like that. Do you just want to go ahead and start with adding
IF_ENABLED() to your own branch then?

    Arnd
