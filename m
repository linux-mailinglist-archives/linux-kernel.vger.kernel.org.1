Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880DA21AC97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 03:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGJBwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 21:52:22 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:32062 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgGJBwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:52:21 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 06A1psfq023143;
        Fri, 10 Jul 2020 10:51:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 06A1psfq023143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594345914;
        bh=lwtO+YteFWC3hSI68hErHvGPGspfsfJGjHY7OP1XhVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v/jvX2HdDhSQ29RdQnXobVuTD8glk2ZOefHqQ8CrIAdfQhGn7f2runbsCmz7i3Lmv
         +PndXg8dsor+LPLpGrPyybAyoNW2TNyf3V0IujDV0cT3M3n3xnRxNJcdECbRhF0+HS
         NsTrzmkdkUGxsCNkkO3DOjEc7no/BcCdoKcdw3WeLG2vaLvtAFj1fEioLABD1kiBec
         Szpqn1SThUmkDyUamHFun/O2s7CTSJ8Jlljqvf7PUGv9Vp3/PdMPleIbPNwD0PERoz
         ANRp5DuCh34FTbK9+s17pgM5HwmTqEb8y4JnEYuBhZGKITfB69qHWkUp7mcBkKSfVz
         PrvnkvnPHctyA==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id p6so1332858uaq.12;
        Thu, 09 Jul 2020 18:51:54 -0700 (PDT)
X-Gm-Message-State: AOAM532z5fyqvkOagRO4MiOaIddJclc1i+aKzEYeSoLHOMnk1svW1evD
        3iBlwzBro9fIHVSo1bcQV3o4xXo+wKIU/VBEGLc=
X-Google-Smtp-Source: ABdhPJw4nJ83scrLc9fxJuoZGx4SxQwt5Bs77y4srp2dNZlh25Nu/PabzQlL0eR7m47me/58vOAHzT0HJqlnEySjpuo=
X-Received: by 2002:ab0:48:: with SMTP id 66mr36765906uai.40.1594345913558;
 Thu, 09 Jul 2020 18:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <1594198451-29073-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1594198451-29073-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jul 2020 10:51:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWszx2N7ogBB0b4CDh0Q6G8wK0Li2eZD1eDgejH3TdOQ@mail.gmail.com>
Message-ID: <CAK7LNAQWszx2N7ogBB0b4CDh0Q6G8wK0Li2eZD1eDgejH3TdOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: uniphier: Rename ethphy node to ethernet-phy
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 5:54 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This renames the node name "ethphy" to "ethernet-phy" according to
> Documentation/devicetree/bindings/net/mdio.yaml.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Both, applied.



-- 
Best Regards
Masahiro Yamada
