Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA13278202
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgIYHv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgIYHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:51:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7512C0613CE;
        Fri, 25 Sep 2020 00:51:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so2379076eja.3;
        Fri, 25 Sep 2020 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3MDToKFnc8Ld4NhDNLDgxEU3GH0UiPaPFBJOq/aOu4=;
        b=AJrBx3ogTrvrwTHp8UAK7s96cQayIHUcNQjkM+3RUjLDeIO1LXL2B4vu+07JnYMYaO
         O7ox4sSIYIYxY/ML1lbDnMsonYado3Ku9rxKvfc3soBYOa/A/N6cm1XkI0dqZIYToY6T
         v6ajjHspnIX9OOjal2Og2Q7B9LnxdxboXDtY1LoZWqKJNHTv+u+cNW4qG8Yroi2bIYr4
         JpkJDN2zDN7Z97NiOZCQzgtBpGzqkqXX58wb/k6cq4d9DWb95lg3Pqyctt4uQzCedpOP
         vtB0JSlc/LnYuwFVidQPnUVz9Koi1UWBG2Jsp0zh/qcTLrh12KOf68/Z4HLkOu36ILpD
         aWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3MDToKFnc8Ld4NhDNLDgxEU3GH0UiPaPFBJOq/aOu4=;
        b=brbmr2t6PBgdLASK5Du4Ok1YotfkgY7F79SAhUkbQRXKqUDN73yuiWB0FPrghrJw6g
         Ab6J+PpFm2YmQEd1csi6CT2+fild0zhK/VAKEZbm6lwqIfRfPPjmAtRVFwi2L/z8XFmV
         3GMqBqvwL1VChs9KOigAnmw/RBaXPAGfCuEGlmdB1fylCBzc1lIg/WQZSQb0KkSfxbv2
         PKu35oHd8KSlk5JHAsiDYzyedG34AGxGz8AFjDCOHzdlEC+JsMK0kzM+2g9aArij924a
         0WARfAeDdLeW7J1tIEeHNyXNxNYWnx4FtYgoIsZxxUrEW7ul61SmieJI8Skh00gacFhn
         ZqyQ==
X-Gm-Message-State: AOAM532L5WOFUSN5RoITi+Tsbn20FOq6iSvaZEg3j4q6uiw8uOfOpD7D
        6enopm++1QytPVcfW/KePvj9PMenTmEBYNBH5Eg=
X-Google-Smtp-Source: ABdhPJz8LTTXIBSbijfWq+tPT8oZ+iOkpd7xsUuTf6dC+qoeeI/DTkVqkf5sikzIkMmvbBTf6C131zlVJFtLGVM8puo=
X-Received: by 2002:a17:906:16da:: with SMTP id t26mr1463323ejd.172.1601020285551;
 Fri, 25 Sep 2020 00:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200925033017.1790973-1-art@khadas.com> <20200925033017.1790973-2-art@khadas.com>
In-Reply-To: <20200925033017.1790973-2-art@khadas.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Sep 2020 09:51:14 +0200
Message-ID: <CAFBinCDcwHUJzK4HsvKxs1n4_jH9K47bNZcZobocLxKVj7+iNw@mail.gmail.com>
Subject: Re: [PATCH 1/8] arm64: dts: meson: update spifc node on Khadas VIM2 meson-gxm-khadas-vim2
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        robh+dt@kernel.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Fri, Sep 25, 2020 at 5:30 AM Artem Lapkin <email2tema@gmail.com> wrote:
>
> 1) The VIM2 Boards use w25q128 spi chip only not w25q32 or w25q16
>    it's not really seriously becouse have 'jedec,spi-nor' which
>    have auto chips identifications
according to the "VIM2 - Transitioning From v1.2 to v1.4" document [0]
(page 7) both board revisions are using different SPI flash sizes
for which board revision are your changes?

> 2) max-frequency is 104Mhz
(note to self: according to the w25q16 datasheet it supports a maximum
clock frequency of 104MHz, so this is fine)


Best regards,
Martin
