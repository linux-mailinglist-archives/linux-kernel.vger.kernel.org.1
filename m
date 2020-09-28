Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4427B67E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgI1Uly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1Ulx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:41:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B63C061755;
        Mon, 28 Sep 2020 13:41:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a22so2130464ljp.13;
        Mon, 28 Sep 2020 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zx0CfU3J1VJLQIPqhr3Tt9PxwDIrKT2oBCuJthUB07o=;
        b=MwEitxkMtu7a4LKCmc7FOTgRmpbIRPxCON2NnbgPAFnQQEqbMbB+XPd0FWK0nc0yKw
         FYYNEbiHHsJxrVjZnYWbp4LsmWvle/+Net4bLJ4IBtK1j85PZGtFSEjqDkQAa887AJ5S
         3hPYFtUXoqGi7YVlItiIRYXMzKpsr74N4pcaw3waF+Zz4eZm4YHIegmg7YJNqy9Os704
         5NaI2RPw3U7tHDX0libVtJHw+VZmqTPTLm4zoYnAGwcwcC7NhJ0dLcqRNvj36mUFF3at
         FrSUyVvIfma2dLx9FIMhgUiEqCpgbxeDC1fz/zSJLF7iyEzZEjH9XDV7PiQSodrJGZwS
         pzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zx0CfU3J1VJLQIPqhr3Tt9PxwDIrKT2oBCuJthUB07o=;
        b=bTUG5kYAbtxsbb45x1G5H2Kc/ObCosfkZwBJoQhZ5anh6ouGIYuRPUeruBjiAzQ5Pc
         NiwD6EkeMKGCofS/S4vxF1k405VQHipqc7qVZpbnx/V9xiGqNoyDOFxhDLkdCuXQTgqK
         ZcJ3ZBtm2R5Q7HpsALmMFYiof1TWABEhy9RHbtINFg4WtBk3SdKPR//eVedRs5yWiulI
         PQiTUDm6p5b4b9QgL0gbP1IrraMyO9WMbaCu7Wuy0zesaP2BCXe8gngp7DjKwZax2BST
         32l13Szc3iEEVb7yPqKjs6+9cEq6RY7bFnYcwM3jBqoLHEZCid36Oy86oKU90TyWBhQo
         a91A==
X-Gm-Message-State: AOAM5334LRSvSzzO1HNJalFB9CUkGK28SRr1SiPvzth8cAVldN3/JFeo
        KoY75/S5HLjlyEqr7RZSHfpt3ueFihPQYahQ6oQ=
X-Google-Smtp-Source: ABdhPJxMJ5nOOOYxuicR17q4pCezl1xZMe2K4xB5mxX0ik/kdZii5diCzfauXchgWdRQMoQMPuYNvIQ/9O4BIOjMeYM=
X-Received: by 2002:a2e:99d6:: with SMTP id l22mr100831ljj.195.1601325710449;
 Mon, 28 Sep 2020 13:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200925033017.1790973-1-art@khadas.com> <20200925033017.1790973-6-art@khadas.com>
 <CAFBinCAJ6svwiv9OM6EHz7468D9h+jW_ULiGrorgLetcODsAKQ@mail.gmail.com>
 <CAKaHn9+CWLJYN1Tt46VxBGNBEbVVJZWeL6ZJSf9w-5DmoxrvgQ@mail.gmail.com>
 <CAFBinCD0_QgKKcH+Kb2QbMWnx_csoXMEhSFYzmDscdTVB2TUJw@mail.gmail.com>
 <CAKaHn9K6O8u6Br84S63V0PDFBhiRbMdd4-bvC5FxFe6izj_Dvg@mail.gmail.com>
 <CAFBinCAb91M5Zyn8yM1Ww4KKPANM2uqvJB11=QGjMJ2fdU836w@mail.gmail.com> <CAKaHn9JxKBKW5AYvUNBAA+sNcHfNQNrx95NtLMnrfd0ypOaAoA@mail.gmail.com>
In-Reply-To: <CAKaHn9JxKBKW5AYvUNBAA+sNcHfNQNrx95NtLMnrfd0ypOaAoA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 28 Sep 2020 22:41:39 +0200
Message-ID: <CAFBinCDHbV2dT1KsXA6PukhsQXj+48Pes=gUeLGD9DFw7xJdYw@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: meson: remove reset-gpios from ethernet
 node for VIM2 meson-gxm-khadas-vim2
To:     Art Nikpal <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        robh+dt@kernel.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Artem Lapkin <art@khadas.com>, nick@khadas.com,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Mon, Sep 28, 2020 at 10:42 AM Art Nikpal <email2tema@gmail.com> wrote:
>
> OK today i can't reproduce it again on my new equipments ;-)
>
> may be its some specific problem we can try forget about this
uh, this is weird
please let me know if you can reproduce it on your new hardware

thanks for the update :-)


Best regards,
Martin
