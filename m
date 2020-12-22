Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55B42E06AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgLVHXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:23:49 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17055 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLVHXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:23:49 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0BM7MrmD009582
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:22:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0BM7MrmD009582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608621773;
        bh=MdgXeZjPAoG2zgI/9PTUDD5lMHdp0LVzaQZKW55s0K8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbuEyMFceehMIfQ6+TGp1jlwAdr/PmfbjB2ZZOdKoMGLu46/jZZVSKYfxJxJb6jCF
         K7mZR71BMyGBqMfvxHGVxuwj9X4QaHBho4/c9jpW8PWAERygVFC0u2/NhcxPbNsv/5
         t3YSiuigBc/9NCRESaf7kqJPMB1f4qpsylR6zJu0T9U7iojyTWGcmWN2Hw22fIzssi
         uS0+sayk+Ui8WbC9CzHDBkvFzttZxof3ZHb7Px6mpJAnijg6CjHyKS7THeHmySBpc0
         uQeXP3zrtTDZX+MQo4JjPW4Jc77OQ6r+Fse2b5rcV59Q1DionMg0DE5LC1TjgzTShy
         xZpLYFNa9mJ3Q==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id d2so7945262pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:22:53 -0800 (PST)
X-Gm-Message-State: AOAM531ctb+R5Stl8OaBGDkRZ23Ox+Pv39Gugeaomk1qiFntemV5ukIl
        oJMiF5+OGGVRqI1UYHguwgO9ER/kT6AAb9adxK4=
X-Google-Smtp-Source: ABdhPJzIeir2iJm8v1W9WsUYckuHzNmooqeZY18Zn2T6uMlQt8USjCn1jMSlEheCXNwLC+uM60dUv6dwww6kOOuriZs=
X-Received: by 2002:a65:6a16:: with SMTP id m22mr18613405pgu.175.1608621772952;
 Mon, 21 Dec 2020 23:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20201222070731.491076-1-joel@jms.id.au>
In-Reply-To: <20201222070731.491076-1-joel@jms.id.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Dec 2020 16:22:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_+VTDspmBNXPZzMKDhzDz9+TyKjrOs_Xho-ZMEPGDKA@mail.gmail.com>
Message-ID: <CAK7LNAS_+VTDspmBNXPZzMKDhzDz9+TyKjrOs_Xho-ZMEPGDKA@mail.gmail.com>
Subject: Re: [PATCH v2] openrisc: Add vmlinux.bin target
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Karol Gugala <kgugala@antmicro.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 4:07 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Build it by default. This is commonly used by fpga targets.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Address review from Masahiro
>
>  - Add vmlinux.bin to phony target
>  - simplfy vmlinux.bin rule
>  - add cleanup rule
>  - add vmlinux.bin to targets
>  - Add gitignore


 Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

---
Best Regards
Masahiro Yamada
