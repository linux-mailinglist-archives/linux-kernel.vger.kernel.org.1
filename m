Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1A27A700
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgI1Fco convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 01:32:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37566 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgI1Fcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:32:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id z19so9621709lfr.4;
        Sun, 27 Sep 2020 22:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+x7QAn2uYVocNUkCVMeJdKDwZojnJ6iZ+Nm6GD4zjj8=;
        b=k/GXmRVaW+1Xim0yMEcRx9HW6PltmR7EO63SLbLpnZYsSzDuAnFucWOdhGniCeQAPd
         RmBkL5coOyyimkdPa+iphIGDeSrsMwylR5LxzPEoUialBFS4JNfoBPKfoyEt2PYfXqFP
         MvzDtFzct2jmtOtzgJ3aRAk2yh2okJOkSEEek6DQoGKKombxehWZEo/Ea5g2/Ug8uyLn
         Gos8AAXR9aOsAAWmfIi9enZG9fh06MS46OsJM1TbNLAq/PmVaXQB/UGN+NegLFP/u6d0
         r8NCZWp5EmwlK9UUIGYi6Xy4NbHQN1BTVNfeaICFWhGlt5Zd8xw35NTPo/R9piV/KGbl
         owXw==
X-Gm-Message-State: AOAM533Pq/+Y5W6OmVhLsk9ln5OMHdoldBsjjCmHvcDNNjoqMT+P90Vq
        G6C84fNzdlnQnTK6oO2pEnI8ZhcAb3//bg==
X-Google-Smtp-Source: ABdhPJy2Kz3pfcLiPdLaYPkBG4ZzLv7WHj4EwmgmksZcG3GPq8tq0cvHw4TBoTT4Dm/8DaYt6Z2ybg==
X-Received: by 2002:ac2:5299:: with SMTP id q25mr3049997lfm.198.1601271161340;
        Sun, 27 Sep 2020 22:32:41 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 138sm2708715lfl.241.2020.09.27.22.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 22:32:41 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y4so7223755ljk.8;
        Sun, 27 Sep 2020 22:32:41 -0700 (PDT)
X-Received: by 2002:a2e:760e:: with SMTP id r14mr4070333ljc.331.1601271160985;
 Sun, 27 Sep 2020 22:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-11-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-11-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 13:32:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v67_9phiOxDTDmCLwSuFzADDXqLwW+d48OUNZ_1m2vPCMQ@mail.gmail.com>
Message-ID: <CAGb2v67_9phiOxDTDmCLwSuFzADDXqLwW+d48OUNZ_1m2vPCMQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 10/20] arm64: dts: allwinner: h6: Enable
 HDMI sound for Beelink GS1
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> Now that HDMI sound node is available in the SoC dtsi.
> Enable it for this board.
>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
