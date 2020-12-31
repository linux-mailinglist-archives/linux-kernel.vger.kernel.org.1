Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AEF2E7D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 01:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgLaAYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 19:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgLaAYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 19:24:51 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC84C061573;
        Wed, 30 Dec 2020 16:24:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw4so23754268ejb.12;
        Wed, 30 Dec 2020 16:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aw/X/9HRdFlK3ENliYd8yhkSzevuBoqDvbJ7g1FREOk=;
        b=oBhDqrr7CNIeA+HEckZ/BoMozBaZ67j517MnLQNWF9HHpKlIqcbDi+KgYiPH7xi+KR
         dEROELyMEY9jwEJo/3g3xLv+DyU7iOcPMkKDvkL20U0bRwSpIKrvroIPmF2OiNgghdem
         qm57V4I4n57aM+wl6J7q7YFvzobYCcLOUUB/LKM5eraIJmEEDjqDa5PUzi6gbQXlpq2e
         6dlKXi9yGfxheRtTTszM9X+vWdFbrQB/Jl9vEm9xenlaeetoi8Uz0xL3EuEV832O5uiB
         JXVYJLF+sTpKw/qBfMAQGvpQG7GsXEp532hX0saFjthrMIympWIjO3iu2EYAmBnEbMOT
         3+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aw/X/9HRdFlK3ENliYd8yhkSzevuBoqDvbJ7g1FREOk=;
        b=EX6KyF+tanIEuwKvYrMuTG9KkGOBhFvFCIOZBn4z9RZXXhsp+azVUA2p98oF84f3Ii
         7DjmIFSBWslJS0ioh+UI7YkPJEYGjDXoEM2+71ffwfUCvo09JhaVISO5yRryA4oPlvpP
         OduGfOmWAWMatcYLg8CeDK2u8JCKmRELgQi3unnWOdofNAnB87ra4RF+pRCyFI3f3cbd
         3Q0jZ1Kv72s7+Es6vPiCelqD2l7wzaXYvJM5hg4Zs1aQL839jgFF/INrrB1/y5O3Yoml
         79xZ/58GB9IjjWdTjoDSCoKwE9AOLCy2Tk5X62WvaSN3kb1DelLikIZJdSecYLydtNkG
         uEAQ==
X-Gm-Message-State: AOAM533A4hYAb6wvmrNqxBuHRXRavz2qyaZTYedFmigOlqybbxAG1lYw
        6L+112jrVMcQ5KXOUDPHd2niy87CFm/P/vyxMcs=
X-Google-Smtp-Source: ABdhPJxrDxW07y8dLE5n+dcM/FUCVDaKSfs0FshgoV6zFzewudotaQBLzrHOOshSLszMCmD5zhQsLk6tRtwXHFx1Heg=
X-Received: by 2002:a17:906:447:: with SMTP id e7mr50750226eja.172.1609374250025;
 Wed, 30 Dec 2020 16:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20201230103729.2272-1-christianshewitt@gmail.com> <20201230103729.2272-3-christianshewitt@gmail.com>
In-Reply-To: <20201230103729.2272-3-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 31 Dec 2020 01:23:59 +0100
Message-ID: <CAFBinCCUV4piTy7n83GsV9Tny+JYA9_AXS0uiv5FeNPYejNR-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: add initial Beelink GS-King-X device-tree
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 11:38 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference
> board with an S922X-H chip.
>
> - 4GB LPDDR4 RAM
> - 64GB eMMC storage
> - 10/100/1000 Base-T Ethernet
> - AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
> - HDMI 2.1 video
> - S/PDIF optical output
are you planning to enable this also?

> - 2x ESS9018 audio DACs
> - 4x Ricor RT6862 audio amps
> - Analogue headphone output
there's no driver for that DAC so I think that's why you are not enabling them

> - 1x USB 2.0 OTG port
> - 3x USB 3.0 ports
> - IR receiver
> - 1x micro SD card slot (internal)
> - USB SATA controller with 2x 3.5" drive bays
> - 1x Power on/off button
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
I don't know/have this board but also I don't see anything problematic so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
