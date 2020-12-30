Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892292E7781
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 10:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgL3Jjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 04:39:47 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:35456 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgL3Jjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 04:39:47 -0500
Received: by mail-vs1-f49.google.com with SMTP id s2so8333728vsk.2;
        Wed, 30 Dec 2020 01:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/NAoMC4juGnaAFwgnH9SSYWSCdJbRU69A34V2lsSW0=;
        b=W+PmxCchkxtf8PVi9oC693lKhm53luuu+mfxmP9gRyPQ/MQSuctYhVL8wla6yyUCCl
         Xzxqz42pNTQDBE0+wrVhv6f1rey6OK9OZOf8yGRjYSJUOqCEnfjp9cD0laz35hdOo/Km
         MBjuXoKdDSTNwcoutJzU01IT1KCeB2xfJQTHkUq+470aXn54zxPKuPCFWg6tyuDujINT
         TLaqYEgLk72dm/q/99gj3xTq2Q/k3tYKh4pSrfZQbM3tQ1t12wl40mhMciw9CLsg4l7S
         Np3W8R22xf+sxfECbEhnrI333pCNrTr9xeHDKB4qqkFDtvrl3WH4Z0VeNthXctrMZYhH
         CHHA==
X-Gm-Message-State: AOAM5328+9pIO64R8H8II2YHwIKypuNBo1OJPA5LSOcMjCHnvHQIJ4/C
        ynhZwME+IIf78+4mLNa3QvuKUejuuEO1rw==
X-Google-Smtp-Source: ABdhPJzufUI+2VOB50xp1xB2/fODV6F2oPYl8muxn4LrmKqhQ6c5PZOvaEf7/UvCWpxHBk85OH710g==
X-Received: by 2002:a67:1946:: with SMTP id 67mr30390431vsz.60.1609321145510;
        Wed, 30 Dec 2020 01:39:05 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id v65sm6295435vkb.31.2020.12.30.01.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 01:39:05 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id f29so5124704uab.0;
        Wed, 30 Dec 2020 01:39:04 -0800 (PST)
X-Received: by 2002:ab0:7654:: with SMTP id s20mr33015414uaq.23.1609321144661;
 Wed, 30 Dec 2020 01:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20201229154106.4867-1-me@dylanvanassche.be>
In-Reply-To: <20201229154106.4867-1-me@dylanvanassche.be>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 30 Dec 2020 17:38:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v67C+hQyqjrx9A9MiyjEQdeVv+9BgrzxcuiHwf2e8JTswg@mail.gmail.com>
Message-ID: <CAGb2v67C+hQyqjrx9A9MiyjEQdeVv+9BgrzxcuiHwf2e8JTswg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: add 'pine64, pinephone'
 to the compatible list
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:42 PM Dylan Van Assche <me@dylanvanassche.be> wrote:
>
> All revisions of the PinePhone share most of the hardware.
> This patch makes it easier to detect PinePhone hardware without
> having to check for each possible revision.

Sounds good.

> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts | 2 +-

Please also update the DT binding file:

    Documentation/devicetree/bindings/arm/sunxi.yaml

ChenYu
