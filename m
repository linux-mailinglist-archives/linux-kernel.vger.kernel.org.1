Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A92815DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgJBOzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBOzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:55:20 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54846C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:55:19 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so2372921ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=pDks6p78EBD7ss15qrLLTZCcCpPLA2YETzRFSCodWyo=;
        b=q/NornTt2eh3x4yoPtr/QjxWUZ2YMcknK7dAxDB+N5RmzQA4dWhmZyWx5jVdcCuG8E
         Yglw1CIOPe/A8+I5xu85MEFyzft7kKBfuTGQyopZPaTnltBYnqhAn8lNM1+9THbJkn9q
         JMR07CI+5Xl3TwCFT99/ikUuNKDQcuPa9AfEeStfjPTrjqSTVYDO7fj1u8iY7bZSg9oU
         sA9/47NW0gggg+6zu3DM074irN83HJDylN6I2UVFpnRQnK4HD8YMcpDkgr/NFRUN9RDF
         UaolQPYhm1V61C1X+X4jBGSRLRQQxqdCX0UtmgijuNAW6vm7OIxEKrTh2oY1VjNaXv0s
         aA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=pDks6p78EBD7ss15qrLLTZCcCpPLA2YETzRFSCodWyo=;
        b=aEkLPzjGnot864chnFKgO1F+Y/f1UiL+OJjLF2V2TU8PcOFJA4OHBu3DuKtjF+cpTV
         iSONc6MMaWJ2dLOZ+QD7wXvV8Vkq6akJR4jwa49Y5VRV4HpC3Mv0mkR/pOZ88OvSyYKG
         KrS2I+AanFpkkYzqTQ1Hn2RO2Aa1jP7lgJpMkcHT/atjTQkfnMUgGoE+wbjXWTzkDuzk
         AvQaEE1IVvFjHtarbr173bACIktW+LWaGQ0AN3btBBxBir+Jpid8Hthhy1pUCv9Y6FKJ
         nNNFuViOk5xROmhvI4uA+lqlFilG0k3tdxaGv/B2Z1Ay3ywlrTX0+vatSr4YPalaC3if
         e4eg==
X-Gm-Message-State: AOAM530+skYuFqpCZZq+nBLgKXwfEmy3ZWfTsJmDX+/FIo7Z5zGdzKg/
        chMIpk8HHMwBT2XNUJc0BTAwWg==
X-Google-Smtp-Source: ABdhPJxeWoIW2hk98lm8JxgeH6OqwPbzwaF2nR6YfVrAzo27GB7rxcfU1hjQOZwHmbzvboDD1SmiBg==
X-Received: by 2002:a17:906:a256:: with SMTP id bi22mr2629106ejb.375.1601650517967;
        Fri, 02 Oct 2020 07:55:17 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id p17sm1397771edw.10.2020.10.02.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:55:17 -0700 (PDT)
References: <20201002143141.14870-1-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] arm64: dts: meson: add more GX soundcards
In-reply-to: <20201002143141.14870-1-christianshewitt@gmail.com>
Date:   Fri, 02 Oct 2020 16:55:16 +0200
Message-ID: <1jy2koisob.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 02 Oct 2020 at 16:31, Christian Hewitt <christianshewitt@gmail.com> wrote:

> This series adds basic support for LPCM audio over HDMI and S/PDIF
> interfaces to GXBB/GXL/GXM devices without support. I'm sure audio
> support can be extended in places (some devices have internal DACs
> and headphone hardware) but this gets the basics working.
>
> I have personally tested with the khadas-vim2, odroid-c2, and both
> wetek devices as I have them, and there are positive forum reports
> from users with vega-s95 and some no-name P20X box devices.

It is fine to add what you have tested but I'm not confortable adding
untested stuff which will later give the false idea that they are
supposed to work.

Amplifiers and codec may require different settings and ressources
(such as GPIO and regulators) to actually operate properly.

As far the p200 and p201, like the g12 u200, those are reference design
with various sound card possibilities which usually don't apply to end
products.

For example the p200 is missing both input and output codecs, the sound
amplifier and, as it stands, is likely to be muted.

>
> Changes from v1
> - Drop nexbox-a1 and rbox-pro changes - the regulator changes are
> needed to get the dts to compile, but I do not have schematics to
> validate the changes or the hardware to test with.
>
> Christian Hewitt (10):
>   arm64: dts: meson: add audio playback to a95x
>   arm64: dts: meson: add audio playback to khadas-vim2
>   arm64: dts: meson: add audio playback to nanopi-k2
>   arm64: dts: meson: add audio playback to odroid-c2
>   arm64: dts: meson: add audio playback to p201
>   arm64: dts: meson: add audio playback to p200
>   arm64: dts: meson: add audio playback to p212-s905x dtsi
>   arm64: dts: meson: add audio playback to vega-s95 dtsi
>   arm64: dts: meson: add audio playback to wetek-hub
>   arm64: dts: meson: add audio playback to wetek-play2
>
>  .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 ++++++++++++
>  .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 ++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 ++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-p200.dts      | 61 +++++++++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-p201.dts      | 40 ++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 61 +++++++++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 ++++++++++++
>  .../dts/amlogic/meson-gxbb-wetek-play2.dts    | 61 +++++++++++++++++++
>  .../dts/amlogic/meson-gxl-s905x-p212.dtsi     | 40 ++++++++++++
>  .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 ++++++++++++-
>  10 files changed, 464 insertions(+), 3 deletions(-)

