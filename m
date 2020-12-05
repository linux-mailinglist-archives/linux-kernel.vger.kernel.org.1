Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA22CFC8C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgLESYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLESYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:24:04 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9CAC094264;
        Sat,  5 Dec 2020 05:04:25 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so8745126edt.9;
        Sat, 05 Dec 2020 05:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0+StnkqPn0FaAVFCZ/bxC2Ra36MF1dYPlwQRpPH+bg=;
        b=CLthCZ+pBvNWkqEvKMCfFA5VvP7eqiRCZ/KPvbXYyk5Z8sqHZ1gvoybUnysll0JMkE
         upGyKe5ML91Y9fIgQliof/bk6nwo2H3Z8Z6B8iI2i0LhENGog3W6IJ0mxoAJMHEYOFWx
         8XNgrTTIPebZD8RRBeh4dRvd/+YOaHzXRt3Q5OdpZ1+4rri/XegtkeDjZG04BSk0TMJ8
         kPOtfYiibQxG5E3M2bI6UV4v+p5StlEWUxr9QEquuX0rw05znX+u7pIICqrLIrqNLJIC
         +P2rbBV4WEWEFE0fBrq0/QYPU2qkooWR5dJptaYoC1W4jhoTwvpOiluteQ02s/xBtz/s
         tOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0+StnkqPn0FaAVFCZ/bxC2Ra36MF1dYPlwQRpPH+bg=;
        b=YvMKaYAeTN1X0Wgy5g4+HGR/1htAUXcGjhuI8kSgrBok+KXVd1Bap6rGkJiAxwA7L4
         FSt5AxyvmBss9dV4mfxxmPoyaOqiFVHL7i6nozZeESUsAZMsWEsaTrwHBNZZUTw9OXt9
         VPY1pX2LoED4IRSa8N1N2iAaEzDnwlk4ooguIqRuBfZMNZJfNuAbAEcrEFiJ+G1nDmAk
         np/6x2zqr5onw3Ia3sxsFsY53lYJlsMDT9zBSsc7q/t6LP6Ep3WxLAUPjpn4toA4S/ZM
         inGgiDU2eyzm7/cP1WTyxJXuNuMGA+Nf4Pcz1KhN/IHX1ndI7VUjr5kTPUq8cnZQrq2F
         6Lcg==
X-Gm-Message-State: AOAM533HzY9QbFvuK0We6AMcid7A3+WbK3KXiinSueW2DtDUvcYKHRq4
        qFzm6X/iyy+6T75YgDVkwsoG9Wx76aB9TieGxPo=
X-Google-Smtp-Source: ABdhPJwg/aVelRzEkx8ct1h8p95ANrqs0EaGaYdA0P0CRPct189vE0MddExzvw8TCa/hBR2COLD3V7MnfUUo7l13fuA=
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr5747824edw.52.1607173464726;
 Sat, 05 Dec 2020 05:04:24 -0800 (PST)
MIME-Version: 1.0
References: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
 <6bfe17d86ead62c20d236e2ebbc7b7fe3354829d.1606828668.git.stefan@agner.ch>
In-Reply-To: <6bfe17d86ead62c20d236e2ebbc7b7fe3354829d.1606828668.git.stefan@agner.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 14:04:13 +0100
Message-ID: <CAFBinCA_eaJHv7e+8ZM=z=zUZ9uQY_JZ=618=LwJYM-Gi+OO+g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ARM: dts: meson: fix PHY deassert timing requirements
To:     Stefan Agner <stefan@agner.ch>
Cc:     khilman@baylibre.com, robh+dt@kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        christianshewitt@gmail.com, jian.hu@amlogic.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Tue, Dec 1, 2020 at 2:21 PM Stefan Agner <stefan@agner.ch> wrote:
>
> According to the datasheet (Rev. 1.9) the RTL8211F requires at least
> 72ms "for internal circuits settling time" before accessing the PHY
> egisters. On similar boards with the same PHY this fixes an issue where
there's a typo here: it should be "registers"
this is the same for the other four patches also

> Ethernet link would not come up when using ip link set down/up.
I have never experienced that myself but gotten a few reports about this.
thank you very much for coming up with info from the datasheet!

the following stmmac patch [0] has been added recently which may - or
may not - have any impact also.

> Fixes: a2c6e82e5341 ("ARM: dts: meson: switch to the generic Ethernet PHY reset bindings")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
with above typo fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
and also:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
on Odroid-C1+


Best regards,
Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ethernet/stmicro/stmmac?id=56311a315da7ebc668dbcc2f1c99689cc10796c4
