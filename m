Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42832A2054
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 18:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgKARa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 12:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgKARa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:30:27 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E7C0617A6;
        Sun,  1 Nov 2020 09:30:26 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x20so10928824ilj.8;
        Sun, 01 Nov 2020 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8DJgmxtam0fsA7Yaz4RpCJCGI7oB/JrdHqZsXWywIlY=;
        b=TV07pa3Y1G1g/XHh05r1Dy+Y41sFN0Oxr9nk77p1vDpH4EJaByPgLmPNXzP+OcPRp9
         EFN3zDV8DHHYTT22Oz4zDjZ+Np1XXBE0lHHj3dte2/bjya/4Ke9OI9LCdZje4cmYyYMh
         0c3cbD/h86ktBEimEhqToyQQ+rK0FtmPHS3aSQbPqWM0tPCQAG5O33DAGCYD1ht8NXvf
         i+TfU7Svq8hUUXY1PRI97+ibgoYq3IyprX2X8WzjNytJVMVH/D8SgqfFCQHqmlZ9BL3u
         9EQ5TQ476wwweOifRSxRMH+7COh5KDHLzftFVNIDP3Q359cU+3kjfazPz1sWTCCTMpmY
         WXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8DJgmxtam0fsA7Yaz4RpCJCGI7oB/JrdHqZsXWywIlY=;
        b=rUPt/DR0yJXZ8RQ7tGsb53AEdBByjWZbo4pPfwk1Eymy270JCRQuaFLnQgSNUR5VWk
         AsCWauaO6KQTdh5jgRU+jqF7Q+mDJO56KAUmGcMFNFNQSLPPEuEuL2gHb2Lj7xHC4SMT
         nG9oDm8T6ZCqxXyVWnR3rwKcOyzAxFIkqXRvGzs8CIpGo6kGOb4mk6M2r3h+1WHEmmwn
         FLsieqoUGgqOnmxaBY5i7VjyFDS4ShUensfE6X8lTl5N31cJ7efEMNQDD0XTEMWLHGBR
         Fu/+33l6gIq5VjWNx3uEHZS+WTPAfwF0Aqima/bqx8ci5JSFHtbsYE1607iXlOHxs4Lk
         ioQA==
X-Gm-Message-State: AOAM530lyNH0FTWgD6IYSmRiMlhrA/EV37cAus0RCbMm9DbsoJ+CiNXN
        yttu5Zq+72fjLuWoIYXbp9kIKrUwCEQ5D8GrvHY=
X-Google-Smtp-Source: ABdhPJzidrcvd5thvWFkOensKbEmp0zDYFA8cU/rxYa76qQESK0Y3vy2MOVbpv5gbM1q/9gRKAziek25HvK154M2KCI=
X-Received: by 2002:a92:a14f:: with SMTP id v76mr8393365ili.293.1604251826058;
 Sun, 01 Nov 2020 09:30:26 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 1 Nov 2020 18:30:15 +0100
Message-ID: <CAJiuCcfBOHhniDQOaB8ixU0pY9u0GVivkj7po-kozBV8LqmB6A@mail.gmail.com>
Subject: ASoC: Question regarding device-tree multi-lane I2S for Allwinner SoC
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi device-tree and sound Maintainers,

I have a question regarding multi-lane i2S representation.

On the Allwinner SoC the I2S/PCM Interface can handle up to four lanes
as output or input.
For each lane we can enable up to sixteen slots.
And for each output slot we can choose which slot to map.

The only representation I found is for Amlogic device-tree they did
the following sound node :
/* 8ch hdmi interface */
dai-link-7 {
    sound-dai = <&tdmif_b>;
    dai-format = "i2s";
    dai-tdm-slot-tx-mask-0 = <1 1>;
    dai-tdm-slot-tx-mask-1 = <1 1>;
    dai-tdm-slot-tx-mask-2 = <1 1>;
    dai-tdm-slot-tx-mask-3 = <1 1>;
    mclk-fs = <256>;

    codec {
        sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
    };
};

This kind of representation gives the information that 2 slots should
be enabled as TX per lane but don't give which slot to map.
I was thinking about a representation per lane but maybe it's a bit
complicated  ?

    dai-format = "dsp_a";
    dai-tdm-slot-width = <32>;
    // Lane 0 : Output 8 channels 0-7 using TDM
    dai-tdm-slot-tx-mask-0 = <1 1 1 1 1 1 1 1>;
    dai-tdm-slot-chmap-0 = <0 1 2 3 4 5 6 7>;
    // Lane 1 : Output 3 channels 5-7 using TDM
    dai-tdm-slot-tx-mask-1 = <1 1 1>;
    dai-tdm-slot-chmap-1 = <5 6 7>;

I will only start to support HDMI, so 4 I2S lanes for now it should
look like this

    dai-format = "i2s";
    dai-tdm-slot-width = <32>;
    frame-inversion;
    // Lane 0 : Output channels 0,1
    dai-tdm-slot-tx-mask-0 = <1 1>;
    dai-tdm-slot-chmap-0 = <0 1>;
    // Lane 1: Output channels 2,3
    dai-tdm-slot-tx-mask-1 = <1 1>;
    dai-tdm-slot-chmap-1 = <2 3>;
    // Lane 2: Output channels 4,5
    dai-tdm-slot-tx-mask-2 = <1 1>;
    dai-tdm-slot-chmap-2 = <4 5>;
    // Lane 3: Output channels 6,7
    dai-tdm-slot-tx-mask-3 = <1 1>;
    dai-tdm-slot-chmap-3 = <6 7>;

What do you think? Do you have any remark / idea about this ?

Thanks for your help
Clement
