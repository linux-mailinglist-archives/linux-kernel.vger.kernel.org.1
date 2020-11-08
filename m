Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9082AAD2D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgKHTQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHTQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:16:38 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D40F20731;
        Sun,  8 Nov 2020 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604862997;
        bh=QEuj6gYhZ7TOziSGKJfu5C755NOyl9AcloOpdacc6IA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KFLraDMSIK7aQ3C9iKS6c6wjj3sNwzoqDDPfhirnm4/KKopASR0PxKHFUb46szf0x
         ABBc1RRUQ+0xyuMnCplYnZ62yB+/KevHeqQWAJq8v9xX0bAxXSljfZbBV1rh0mRo3n
         BKnsGV1A6ye8ZCcIzQiMbyJWENcNpyJ4BDWFQLKk=
Received: by mail-ej1-f52.google.com with SMTP id cw8so9209472ejb.8;
        Sun, 08 Nov 2020 11:16:37 -0800 (PST)
X-Gm-Message-State: AOAM530sqm8uaFB/IKgJTJd0U/K3hRcYaWAUY2LsRxBoa5rMwZQKnec2
        ct/UTUA5U9IH5uAUbXWHkhhoGoov3Kzr1KX7Iew=
X-Google-Smtp-Source: ABdhPJygARHEEEdUzXQEDuN8BvHclts3f5lMp40afIblxYzspHArmbtL8L/HK/GF/03Kns46096MGQc0Z9MNopO/JnE=
X-Received: by 2002:a17:906:a011:: with SMTP id p17mr11716674ejy.119.1604862995692;
 Sun, 08 Nov 2020 11:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20201108022321.2114430-1-natechancellor@gmail.com>
 <CAJKOXPdVVgRMaCPfq3nPR232KQyKVVewm5LveUSuyfqE8sScQg@mail.gmail.com> <20201108191346.GA4061631@ubuntu-m3-large-x86>
In-Reply-To: <20201108191346.GA4061631@ubuntu-m3-large-x86>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 8 Nov 2020 20:16:23 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfLr=jviF_kzYqC8r_SHxsC5CO38Z0tN57BSGkBz23RdQ@mail.gmail.com>
Message-ID: <CAJKOXPfLr=jviF_kzYqC8r_SHxsC5CO38Z0tN57BSGkBz23RdQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Fix imx8mm-kontron-n801x-s.dtb target
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Nov 2020 at 20:13, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Sun, Nov 08, 2020 at 10:31:10AM +0100, Krzysztof Kozlowski wrote:
> > On Sun, 8 Nov 2020 at 03:23, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > Hi,
> >
> > Thanks for the fixes.
> >
> > Please mark patches with versions, this should be v2. Otherwise
> > maintainer might apply the older one,
> > You also need to add versioning changelog after ---.
>
> I have only sent this one patch. It looks like Anders Roxell sent an
> identical patch though:
>
> https://lore.kernel.org/linux-devicetree/20201105111823.1613337-1-anders.roxell@linaro.org/

Oh, damn, I didn't check the authors and got kind of confused seeing a
v1. Nice timing. :)

Anyway, thanks for the patch!

Best regards,
Krzysztof
