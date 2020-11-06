Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6952A8E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKFE2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:28:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44551 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgKFE2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:28:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id b1so42135lfp.11;
        Thu, 05 Nov 2020 20:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CERvrJlC+TQNJo6snGdkL35sMbOGXywHtBhjsrxgyFA=;
        b=QXzy6gYnp8SsTb3RwR2/5rEpwbZJFZfuzIsvfSv+BELjkTFy4NAMtD1n2f2USs1RhV
         bAbYI33bgSyVNznCsOpaHWy/1R02ey0WfOX/NOK6CwHAq2JnQk2tpmBwjY2hkCO7fcHm
         tsWPFsFjMwdWQ8jFjLwyZTnGGaUa2z0+48pJqTbecLbOSaeU90gRSXoPw5APPJ+s7Rpb
         o2xewZABbFi8G59HzwlTUOwqNrV+xleksTqzBx4JCu6PReC0mEeG7WmDOYczmvqgKSrz
         SYlDLcNiVs8pcfwxdj2Za/aPgGDQ8qrJJFFMt9pRPZJp3Tnwahspm9kqPBsbhPw57J1b
         YzGQ==
X-Gm-Message-State: AOAM53378JxtOMYD9x0BGIQUsuBtrfM7PRsFYABQU4CAWksjlP3hBCUL
        qlzeMlvFG1S3KTHIFbpp6JfwbWpM6EmuCQ==
X-Google-Smtp-Source: ABdhPJwIIOwFvUSCFxqAVlkLt1XAFT7Jv9Bcvx3EtbcqPbmS5i9LBwfXla4d+nq9ZHqu7HX/XsVGRA==
X-Received: by 2002:ac2:4aca:: with SMTP id m10mr118271lfp.26.1604636896891;
        Thu, 05 Nov 2020 20:28:16 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id l6sm16661lfc.8.2020.11.05.20.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 20:28:16 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id m16so9630ljo.6;
        Thu, 05 Nov 2020 20:28:16 -0800 (PST)
X-Received: by 2002:a2e:9243:: with SMTP id v3mr48234ljg.47.1604636895947;
 Thu, 05 Nov 2020 20:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20201106041513.38481-1-samuel@sholland.org>
In-Reply-To: <20201106041513.38481-1-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 6 Nov 2020 12:28:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v67c-ywkh_s77f4sm3fmL9DuxeYMrAJAgp=_jKHBd6GdHA@mail.gmail.com>
Message-ID: <CAGb2v67c-ywkh_s77f4sm3fmL9DuxeYMrAJAgp=_jKHBd6GdHA@mail.gmail.com>
Subject: Re: [PATCH 0/7] PinePhone BT audio bringup
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 6, 2020 at 12:15 PM Samuel Holland <samuel@sholland.org> wrote:
>
> This series makes use of the additional DAIs recently added to the
> sun8i-codec driver to add hardware routing for BT SCO (headset) audio
> on the PinePhone.
>
> The BT audio connection is represented by the "dummy" bt-sco codec. The
> connection to the Quectel EG-25G modem via AIF2 works as well, but I do
> not include it here because there is no appropriate codec driver in
> tree. We have been using an out-of-tree "dummy" codec driver similar to
> bt-sco, and I'm not sure if such a driver would be desired upstream.
>
> The modem has a similar amount of configurability as the rtl8723cs BT
> chip. For the BT chip, the DAI format and PCM parameters are set in a
> configuration firmware file and loaded at driver load time. For the
> modem, the DAI format and PCM parameters are set by (and can be queried
> from) an AT command. However, this AT command requires a modem restart
> to take effect, so the parameters cannot feasibly be changed at runtime.
>
> With a dummy driver, we pick some "standard" set of PCM parameters, e.g.
> 16 bit mono at 8 or 16 kHz, and assume the hardware agrees. Similarly,
> we assume the DAI format pre-programmed in the remote hardware matches
> what is configured in the DAI link (in this case, in the device tree).
>
> Is that the right way to model this? Or does the modem (and maybe even
> the BT chip) deserve a more featureful driver that reads and/or programs
> the format and params at probe time?

FYI there's a "Bluetooth: Allow to use configure SCO socket codec parameters"
thread on the bluetooth mailing list which is still unresolved AFAICT.

You might want to take a look at it.

ChenYu

> Because of those unanswered questions, I'm sending BT SCO support
> first/only.
>
> Regards,
> Samuel
>
> Arnaud Ferraris (1):
>   arm64: dts: allwinner: pinephone: Set audio card name
>
> Samuel Holland (6):
>   ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
>   ARM: dts: sun8i-a33: Allow using multiple codec DAIs
>   arm64: dts: allwinner: a64: Allow using multiple codec DAIs
>   arm64: dts: allwinner: a64: Add pinmux nodes for AIF2/AIF3
>   arm64: dts: allwinner: a64: Allow multiple DAI links
>   arm64: dts: allwinner: pinephone: Add support for Bluetooth audio
>
>  .../sound/allwinner,sun8i-a33-codec.yaml      |  2 +-
>  arch/arm/boot/dts/sun8i-a33.dtsi              |  4 +-
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 25 +++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 ++++++++++++++-----
>  4 files changed, 55 insertions(+), 13 deletions(-)
>
> --
> 2.26.2
>
