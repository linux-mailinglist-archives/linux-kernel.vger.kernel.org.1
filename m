Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDA1DEBC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgEVP1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgEVP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:27:11 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D57AC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:27:11 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v4so8580981qte.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SRsdOjWWL+ErLjyMojixNVl7s3eXgVVstDINvK3dtXg=;
        b=jfK/zDIFzAwRiPF5rSe1xq8YO+ZE0VL+EQPe6K4YPFRj9xXRozQLQi0tJM2zyK91BM
         w6Q6wyRRRq4Qq46NUYu/kcCX1f78ojBrzaVsc9LDiIYA/RuUiiX8vfA7GBkol9Finv11
         mQ7Ox5f4M3JlcOOKELjHlwqAPzd7yc/GQhYmlEdYOXV+xnBdH0/HrN2sD/BWNxqHT91u
         rAo5gUjweaCu8QoaGEUC5QVe8xt2NF2nAQIlJ5w++VFJJpSUf/6ig5/aEe3d+a7IVzuF
         82wUAcK7HdnhoZthoiL4FwdoJXIAvTjfiqfV6kii/d5yWsSktVexR4BbOAqcqg9hjBrg
         Vgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SRsdOjWWL+ErLjyMojixNVl7s3eXgVVstDINvK3dtXg=;
        b=JWA4M9S/BypIn3+9ec2qrTFddPvmB3isEZhj3jri9qsgZPjuG9EL77gjtKRucsi+Wx
         HX+3jHUM7NKaTBoLhLRv63NppIfqI3OO64vBZDmA58xozQEAqqxgHNJmjh8QK0DlYdUm
         0g3Lk/GGxmf2NhKGV3GnadLQ+CmwWwXDL5Ag0NDe1fYSBE9Ezd2BYKWBGjIp0qt7rJcU
         c2vhAyUw/JNjV2aa1L2ayZ+FMXIu2NRRRRdjhIq0Byx4WJxjL8iBvNL5aa+aFQjWTN3F
         k6xtP0TDioxlFX6Oz/QGz+krPWYRo+amDtGmofRGmzIQv1eVB8Szsw5De9ge8S0GIpaV
         Q18w==
X-Gm-Message-State: AOAM530iFS2KFxzCr0T60N/TME8SgsbeQx/Uu553DvBF7rLsbbZ/LT8B
        EbtS1q/rm6HHA9AS3aN0ZF77az2mTChncgzzCBXIqA==
X-Google-Smtp-Source: ABdhPJy8zE09hP3ssAEXIS8PrMxrdtczpkONJnriZwX1UvQjiBseW1fjfukwynTIX1jUsud00Bk+uIw6wPtBlxqVO3Q=
X-Received: by 2002:aed:37e7:: with SMTP id j94mr16165439qtb.57.1590161230357;
 Fri, 22 May 2020 08:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200522120700.838-1-brgl@bgdev.pl> <20200522120700.838-7-brgl@bgdev.pl>
 <5627e304-3463-9229-fa86-d7d31cad7a61@gmail.com>
In-Reply-To: <5627e304-3463-9229-fa86-d7d31cad7a61@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 22 May 2020 17:26:59 +0200
Message-ID: <CAMpxmJVCE0RBNqBQw03bT5uqnCk3vDi1ncbNeWj=VvcN1wEaZg@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] net: ethernet: mtk-star-emac: new driver
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 22 maj 2020 o 17:06 Matthias Brugger <matthias.bgg@gmail.com> napisa=
=C5=82(a):
>
> On 22/05/2020 14:06, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This adds the driver for the MediaTek STAR Ethernet MAC currently used
> > on the MT8* SoC family. For now we only support full-duplex.
>
> MT85** SoC family, AFAIU it's not used on MT81** devices. Correct?
>

MT81** and MT85** are very closely related. This IP is currently used
on MT85**, MT81** and MT83**. It may be used in new designs in the
future too.

Bart
