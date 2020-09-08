Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7642617E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbgIHRpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 13:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbgIHQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:04 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64174C0619D1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:53:58 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n7so4075195vkq.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+RHY61MbwHUN+JTzO3lIufg7DScFPibKdsAs2vpPFs=;
        b=OMZXE0ELFn/5UeXE5Sdyi+rvYzQOT2CKk2y0rX/WgCjXlf2C20yNbQQVRIFfPLSDcM
         Pw94LjX2xcoFi+vqpTAYDBBXcDW16UAM+bj9pWPL9VKZeZeOo938fNgbVpK9cpSOmA4/
         5LehJqqiksA6xb7P1tZNMtiWsNskWYBd/7MeKhpF3qTyRpPteIq5LwsiIQ69qb6tFzo1
         yk3VS0JKYpPjBrPiSIlWhin6wJmffPTsrwehlOxvcBP1IvdH5unTOrZEgOcvBl4mq2NC
         VG0mPKMzsPillvGRZXhkpyjMZtpMpKawTuXnAIGDd4JuM/892WGzcHTL2mVwz7LrsXx1
         SFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+RHY61MbwHUN+JTzO3lIufg7DScFPibKdsAs2vpPFs=;
        b=Xb0VGGg56ppkM4wyXASMZ/2QxkoR0HZwAvgK7EW1bwvz7cyaB/sl232b3CzN/51h7k
         p/Er4JVP1qenl9gsbfIi5evzZzz/KjIilWIDfinDA29LOYtM8m7ciQTtdy8Az2jiLxAE
         Cc6cy6rQfp/aBuz0x1nL8kUrlAe59tkDD/+pEa6gRYOUdEsXVLYl2Ll1t1A8JmUmzBVK
         Hrl7M+nOfQrbjurh9zfBA8nzPStUfZIDUyOQGkGZqlYQYDEYHvOwPYyWoHCgfarVlJ77
         OSLxZwbOGJyl/S0Z5Rr+vBQU61JemNXmwpA5+jTY8S+oQZM/FAB86arKcQeeJHmY/M9n
         NcJQ==
X-Gm-Message-State: AOAM5316Vkp4xZq2ILIF9wfE65BLG3M1LwdhuivgIFHELkdR8ISt9bGL
        0dds4frpaBCb0khDH/epBNgrBV2ikXOvEMQiCiNABQ==
X-Google-Smtp-Source: ABdhPJznQRp0A+wqCEqrqZaEDdoP2cDcKRmw10gXIH0FlDFfEfIEzvFyZJnfs4mTgdX4ERfy6dNeuBEXVvmpgROoMdQ=
X-Received: by 2002:a1f:16d1:: with SMTP id 200mr15128572vkw.31.1599573237594;
 Tue, 08 Sep 2020 06:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200907105254.31097-1-krzk@kernel.org>
In-Reply-To: <20200907105254.31097-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Sep 2020 15:53:21 +0200
Message-ID: <CAPDyKFowS-psoJqVUChU35Xp92nrvH5r5eY=_8bMKU0SVBxLcw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: host: Enable compile testing of multiple drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Arnd

On Mon, 7 Sep 2020 at 12:53, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Multiple MMC host controller driver can be compile tested as they do not
> depend on architecture specific headers.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

It seems like this is causing build errors for my next branch when
running allmod config [1].

[...]

>
>  config MMC_S3C
>         tristate "Samsung S3C SD/MMC Card Interface support"
> -       depends on ARCH_S3C24XX
> +       depends on ARCH_S3C24XX || COMPILE_TEST
>         depends on S3C24XX_DMAC
>         help
>           This selects a driver for the MCI interface found in

[...]

The problem doesn't exist in linux-next, since it has the
corresponding cleanup/rework patches for MMC_S3C from Arnd.

To fix the problem, we should probably remove COMPILE_TEST for
MMC_S3C, for now. Then we can add it again and send it as a fix for
v5.10-rc1.

What do you think?

Kind regards
Uffe

[1]
https://kernelci.org/build/id/5f57413db10918c9bad353a5/logs/
