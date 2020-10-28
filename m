Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1CE29E313
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404473AbgJ2Co5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Oct 2020 22:44:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34965 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgJ1VeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so637842wrq.2;
        Wed, 28 Oct 2020 14:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oyPjZfkw2bAQa4asQy4y5m52zTi3eSbWISDc1NRBIB0=;
        b=Xq93FrGUZsLtL8E26yqyThiJpAuVurVDX6/RcNdlAlE1cspIKzDFp4H9DaroGnOABj
         Uxc339YWgI9eKhHF+gU9kdnGMyTYkbsLAWwBOWzK1b+JRcF5lDJ1OF5Yfq2/+TyIqemt
         FM/x0BA5UC4nWh/UuRivXwguNI+pltdnB7YKak/VbxMhK9fYxgnwG8AtHdFj5uM2uZKj
         4yo8ZbuOCEYFw4P33uoIgjrnWEGiubNwD6J6Ld5Nvt8gvKN2/Rux/GVYj9SjB3yMKEO9
         qakOf4dYya0Pmb7VIBWAlmzCW259RlJassUYJ1PpN4jux/eS5P5sqRJawT/ocU43HZFt
         AUAg==
X-Gm-Message-State: AOAM5302lmzohNMmgrtr36gvh5MrQCBucgmZjbaqyyDhp5Xs1lyMxZJe
        xDRSjlHZ1ihteScC+v/pZ0IT8Vlac8me4Q==
X-Google-Smtp-Source: ABdhPJyhmhhANo5qYn0SlOmhSkZpcNgzKV5dR66IpvT+0SlDgRPp8SZ8eRZcH96AIm/MJ8NjK4WOJA==
X-Received: by 2002:a05:6512:402:: with SMTP id u2mr2253750lfk.221.1603880309982;
        Wed, 28 Oct 2020 03:18:29 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m14sm532174ljo.76.2020.10.28.03.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 03:18:29 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r127so6431067lff.12;
        Wed, 28 Oct 2020 03:18:29 -0700 (PDT)
X-Received: by 2002:ac2:4c10:: with SMTP id t16mr2279614lfq.193.1603880308979;
 Wed, 28 Oct 2020 03:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201027183149.145165-1-peron.clem@gmail.com> <20201027183149.145165-13-peron.clem@gmail.com>
In-Reply-To: <20201027183149.145165-13-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 28 Oct 2020 18:18:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v67dFMNjc4r1Lcyk396h=GqVivPJ64N-wy4AvjDABdVVhw@mail.gmail.com>
Message-ID: <CAGb2v67dFMNjc4r1Lcyk396h=GqVivPJ64N-wy4AvjDABdVVhw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v9 12/14] arm64: defconfig: Enable Allwinner
 i2s driver
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

On Wed, Oct 28, 2020 at 2:32 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> Enable Allwinner I2S driver for arm64 defconfig.
>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
