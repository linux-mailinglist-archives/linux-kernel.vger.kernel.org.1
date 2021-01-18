Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159B82FA574
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406189AbhARQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:00:18 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:44019 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406153AbhARP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:56:25 -0500
Received: by mail-lf1-f50.google.com with SMTP id 23so24726357lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eG9WjyYerA7IMe+nqJfGvwMRUcLVhIdRjzA7l646S4=;
        b=gEebQfc77IYFzAn+yjOUV4cwGMvzz5WwkZzxhPzpP7PB0ezIUYZQMGFwgukkAXOr2K
         FXb3fLxQv61Y8+jYalI3H3YTaBIIcQxNrdYg1iw+npYFqKe/57kBMgFHE2oP7N90sA7v
         pPdm64lk/Yv6+iX03U6T9cPM4F030hZmc67q8vDat0cFfSYTCnfBRzFuciR9rAD76Ak3
         fdPSojEbKowzwsd8wAuAKGvcHiJHmJ5Yo2PSBLxSwIlUOgtlbcqfv31adj9Jrzb1Ruat
         JpvqcmcnZ9aWKvu+exK98jdDHoML3nmI8V8Gjqwrry9xtXqXvNuhYXOosTkL8ObK7rfL
         CT/g==
X-Gm-Message-State: AOAM533lrbJkC8BpmW0Udz5aI/EvE9D/4qw7wZ4UWsZMpVdOY1tTjkjV
        fSyOWlrpNL9lK/EvE9OK9pLZIuapba9Ckw==
X-Google-Smtp-Source: ABdhPJzZyaeRNj8YaKcr7UKTODBoworH6UaDS3QljD3RnSIEcI7S4JRgMacjDcXezXFVCUMKrvAm5A==
X-Received: by 2002:ac2:544d:: with SMTP id d13mr11158947lfn.397.1610985342052;
        Mon, 18 Jan 2021 07:55:42 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j26sm1935828lfh.251.2021.01.18.07.55.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:55:41 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id o13so24783789lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:55:41 -0800 (PST)
X-Received: by 2002:a19:810:: with SMTP id 16mr11942847lfi.233.1610985341262;
 Mon, 18 Jan 2021 07:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-3-andre.przywara@arm.com> <20210118132854.yiwn7rnvcyexgqim@gilmour>
 <20210118155228.3bd0e909@slackpad.fritz.box>
In-Reply-To: <20210118155228.3bd0e909@slackpad.fritz.box>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 18 Jan 2021 23:55:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v662hFdGe2H-m67whUURju=M=Pe8FM2PYfOndF0daT+6Sg@mail.gmail.com>
Message-ID: <CAGb2v662hFdGe2H-m67whUURju=M=Pe8FM2PYfOndF0daT+6Sg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 02/21] mmc: sunxi: add support for
 A100 mmc controller
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:53 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Mon, 18 Jan 2021 14:28:54 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Maxime,
>
> > On Mon, Jan 18, 2021 at 02:08:29AM +0000, Andre Przywara wrote:
> > > From: Yangtao Li <frank@allwinnertech.com>
> > >
> > > This patch adds support for A100 MMC controller, which use word
> > > address for internal dma.
> > >
> > > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >
> > We should also disable the timings setup in probe to derive them from
> > the DT. This is causing issues on some SoCs already, so it would be
> > best to not make the situation worse
>
> But only for those new SoCs, where we have the speed modes in the DT
> in every case (so only new ones)? And this disabling would be
> SoC/compatible string dependent? Happy to send a patch later if that is
> what you were thinking about.
>
> Also I was wondering about the voltage dependent speed modes: At the
> moment the driver declares both MMC_CAP_1_8V_DDR and MMC_CAP_3_3V_DDR,
> so I mimic this in the .dtsi. However in the eventual DTB this looks
> somewhat dodgy, since most boards only support one of those voltages. Do
> we ignore this, and rely on the vqmmc-supply to limit this choice?

IIRC the DDR flags for separate voltages was added after we (I) added
MMC DDR support to our driver.

And yes, the core also checks vqmmc-supply before actually selecting
the mode.

ChenYu

> Cheers,
> Andre
>
> Btw: This patch is already in Ulf's -next tree, I just included it here
> for the sake of completeness. Is that a problem? I don't think it
> affects the build, so we don't care too much?
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20210118155228.3bd0e909%40slackpad.fritz.box.
